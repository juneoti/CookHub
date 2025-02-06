package com.dishcovery.project.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUploadUtil {

    /**
     * 파일 이름에서 확장자를 제외한 실제 파일 이름을 추출
     *
     * @param fileName 파일 이름
     * @return 실제 파일 이름
     */
    public static String subStrName(String fileName) {
        // FilenameUtils.normalize() : 파일 이름 정규화 메서드
        String normalizeName = FilenameUtils.normalize(fileName);
        int dotIndex = normalizeName.lastIndexOf('.');

        String realName = normalizeName.substring(0, dotIndex);
        return realName;
    }

    /**
     * 파일 이름에서 확장자를 추출
     *
     * @param fileName 파일 이름
     * @return 확장자
     */
    public static String subStrExtension(String fileName) {
        // 파일 이름에서 마지막 '.'의 인덱스를 찾습니다.
        int dotIndex = fileName.lastIndexOf('.');

        // '.' 이후의 문자열을 확장자로 추출합니다.
        String extension = fileName.substring(dotIndex + 1);

        return extension;
    }

    /**
     * 파일이 저장되는 폴더 이름을 날짜 형식(yyyy/MM/dd)으로 생성
     *
     * @return 날짜 형식의 폴더 이름
     */
    public static String makeDatePath() {
        Calendar calendar = Calendar.getInstance();

        String yearPath = String.valueOf(calendar.get(Calendar.YEAR));
        log.info("yearPath: " + yearPath);

        String monthPath = yearPath
                + File.separator
                + new DecimalFormat("00")
                .format(calendar.get(Calendar.MONTH) + 1);
        log.info("monthPath: " + monthPath);


        String datePath = monthPath
                + File.separator
                + new DecimalFormat("00")
                .format(calendar.get(Calendar.DATE));
        log.info("datePath: " + datePath);

        return datePath;
    }

    /**
     * 파일을 저장
     *
     * @param uploadPath 파일 업로드 경로
     * @param file       업로드된 파일
     * @param uuid       저장할 파일 이름
     */
    public static String saveFile(String uploadPath, MultipartFile file, String uuid) {

        String datePath = makeDatePath();
        File realUploadPath = new File(uploadPath, datePath);

        if (!realUploadPath.exists()) {
            realUploadPath.mkdirs();
            log.info(realUploadPath.getPath() + " successfully created.");
        } else {
            log.info(realUploadPath.getPath() + " already exists.");
        }

         File saveFile = new File(realUploadPath, uuid);
        try {
            file.transferTo(saveFile);
            log.info("file upload success: " + saveFile.getAbsolutePath());
        } catch (IllegalStateException e) {
            log.error(e.getMessage());
        } catch (IOException e) {
            log.error(e.getMessage());
        }

       return datePath + "/" + uuid;
    }

    /**
     * 파일을 삭제
     *
     * @param uploadPath   파일 업로드 경로
     * @param thumbnailPath 파일이 저장된 날짜 경로와 파일 이름
     */
    public static void deleteFile(String uploadPath, String thumbnailPath) {
        if (thumbnailPath == null || thumbnailPath.isEmpty()) {
            System.out.println("Thumbnail path is null or empty.");
            return;
        }


        String fullPath = uploadPath + "/" + thumbnailPath.replace("\\", "/");
        File file = new File(fullPath);

        if (file.exists()) {
            if (file.delete()) {
                System.out.println(fullPath + " file delete success.");
            } else {
                System.out.println(fullPath + " file delete failed.");
            }
        } else {
            System.out.println(fullPath + " file not found.");
        }
    }

    /**
     * 파일을 저장 (파일 이름 자동 생성)
     *
     * @param uploadPath 파일 업로드 경로
     * @param file       업로드된 파일
     */
    public static String saveFile(String uploadPath, MultipartFile file) {
        String uuid = UUID.randomUUID().toString();
        String extension = subStrExtension(file.getOriginalFilename());
        String savedFileName = uuid + "." + extension;

        String datePath = makeDatePath().replace("\\", "/");
        File realUploadPath = new File(uploadPath, datePath);

        if (!realUploadPath.exists()) {
            realUploadPath.mkdirs();
            log.info(realUploadPath.getPath() + " successfully created.");
        } else {
            log.info(realUploadPath.getPath() + " already exists.");
        }

       File saveFile = new File(realUploadPath, savedFileName);
        try {
            file.transferTo(saveFile);
            log.info("file upload success: " + saveFile.getAbsolutePath());
         } catch (IllegalStateException e) {
            log.error(e.getMessage());
        } catch (IOException e) {
            log.error(e.getMessage());
         }
          return datePath + "/" + savedFileName;

    }

	
}