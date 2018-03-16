package com.qianfeng.model;

public class Page {
    private int page;
    private int limit;

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getLimit() {
        return limit;
    }
    public int getOffset() {
        return (page-1)*limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }
}
