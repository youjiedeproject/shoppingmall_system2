package com.qianfeng.model;

import java.util.List;
public class PageBean<T> {
	/*
	 * 要想实现分页的功能，就必须获得这五项数据
	 * 当前页	   currentPage
	 * 每页显示的条数    currentCount
	 * 数据总条数	totalCount
	 * 总页数		totalPage
	 * 当前页上的数据     PageData
	 */
	private int currentPage;
	private int currentCount;
	private int totalCount;
	private int totalPage;
	private List<T> pageData;
	public synchronized int getCurrentPage() {
		return currentPage;
	}
	public synchronized void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public synchronized int getCurrentCount() {
		return currentCount;
	}
	public synchronized void setCurrentCount(int currentCount) {
		this.currentCount = currentCount;
	}
	public synchronized int getTotalCount() {
		return totalCount;
	}
	public synchronized void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public synchronized int getTotalPage() {
		return totalPage;
	}
	public synchronized void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public synchronized List<T> getPageData() {
		return pageData;
	}
	public synchronized void setPageData(List<T> pageData) {
		this.pageData = pageData;
	}
	public PageBean() {
		super();
	}
	
}
