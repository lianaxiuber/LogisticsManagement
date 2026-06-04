package com.logistics.model;

import java.util.Date;

public class RepairOrder {
    // 属性与数据库表中的字段对应
    private int id;                 // 报修单ID
    private String title;          // 标题
    private String description;    // 问题描述
    private String room;           // 房间号
    private int submitterId;       // 报修人ID（外键）
    private String submitterName;  // 报修人姓名（用于显示，不存数据库）
    private int assigneeId;        // 指派的维修员ID（外键）
    private String assigneeName;   // 维修员姓名（用于显示）
    private String status;         // 状态：pending, processing, completed
    private Date submitTime;       // 提交时间
    private Date completeTime;     // 完成时间


    // 无参构造方法（必须）
    public RepairOrder() {
    }

    // 有参构造方法（可选，方便使用）
    public RepairOrder(String title, String description, String room, int submitterId) {
        this.title = title;
        this.description = description;
        this.room = room;
        this.submitterId = submitterId;
        this.status = "pending";
        this.submitTime = new Date();
    }

    // 以下是所有的 Getter 和 Setter 方法
    // 在 IDEA 中可以用快捷键 Alt+Insert 或 Code → Generate → Getter and Setter 自动生成
    // 为了不遗漏，这里手动列出，你也可以自己生成

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public int getSubmitterId() {
        return submitterId;
    }

    public void setSubmitterId(int submitterId) {
        this.submitterId = submitterId;
    }

    public String getSubmitterName() {
        return submitterName;
    }

    public void setSubmitterName(String submitterName) {
        this.submitterName = submitterName;
    }

    public int getAssigneeId() {
        return assigneeId;
    }

    public void setAssigneeId(int assigneeId) {
        this.assigneeId = assigneeId;
    }

    public String getAssigneeName() {
        return assigneeName;
    }

    public void setAssigneeName(String assigneeName) {
        this.assigneeName = assigneeName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Date getCompleteTime() {
        return completeTime;
    }

    public void setCompleteTime(Date completeTime) {
        this.completeTime = completeTime;
    }
}