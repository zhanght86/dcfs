package com.hx.cms.tags;

import hx.database.databean.Data;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: InfoPublishTimeTag.java
 * @Description: 文章发布时间<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoPublishTimeTag extends TagSupport {
    
    /**
     * 序列化
     */
    private static final long serialVersionUID = 330680087521827763L;

    /**
     * 日期格式化
     */
    private String dateFormat;
    
    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
        Tag tag = getParent();
        //输出内容
        String html = "";
        
        try {
            if(tag instanceof InfoListTag){
                InfoListTag infoListTag = (InfoListTag) tag;
                //得到当前循环到的Data元素
                Data data = infoListTag.getData();
                //时间
                String createTime = data.getString(Article.CREATE_TIME);
                if(dateFormat != null && !"".equals(dateFormat)){
                    Date createTime_ = (Date)new SimpleDateFormat(dateFormat).parse(createTime);
                    createTime = new SimpleDateFormat(dateFormat).format(createTime_);
                }
                html = createTime;
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    /**
     * @return Returns the dateFormat.
     */
    public String getDateFormat() {
        return dateFormat;
    }

    /**
     * @param dateFormat The dateFormat to set.
     */
    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }
}
