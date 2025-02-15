package com.dishcovery.project.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dishcovery.project.domain.NoticeBoardVO;

@Mapper
public interface NoticeBoardMapper {

    // ��� ���������� ��ȸ�ϴ� �޼���
    List<NoticeBoardVO> selectAllNoticeBoards();

    // Ư�� ���������� ��ȸ�ϴ� �޼���
    NoticeBoardVO selectNoticeBoardById(int noticeBoardId);

    // ���ο� ���������� ����ϴ� �޼���
    void insertNoticeBoard(NoticeBoardVO noticeBoard);

    // ���� ���������� �����ϴ� �޼���
    void updateNoticeBoard(NoticeBoardVO noticeBoard);

    // ���������� �����ϴ� �޼���
    void deleteNoticeBoard(int noticeBoardId);
}
