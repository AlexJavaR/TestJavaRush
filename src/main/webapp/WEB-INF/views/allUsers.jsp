<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>CRUD</title>
</head>
<body>
<table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tr>
        <td width="40%" valign="top" align="center">
            <h2>
                <c:if test= "${user.id != 0}">
                    Edit user
                </c:if>
                <c:if test= "${user.id == 0}">
                    Add new user
                </c:if>
            </h2>

            <%-- Add and edit users --%>
            <c:url var="addAction" value="/user/add" ></c:url>
            <form:form action="${addAction}" commandName="user">
                <c:if test= "${user.id != 0}">
                    <p style="font-size:20px" align="center"> Пользователь № ${user.id}</p>
                </c:if>
                <table>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="id"/>
                        </td>
                        <td style='vertical-align:middle'>
                            <form:hidden path="id" />
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="name">
                                <spring:message text="Name"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="name" />
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="age">
                                <spring:message text="Age"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="age" />
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="isAdmin">Admin rights</form:label>
                        <td>
                        <form:select path="isAdmin">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </form:select>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="createdDate">
                                <spring:message text="Date created"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="createdDate" />
                        </td>
                        <td>
                            <form:errors path="createdDate" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <c:if test="${user.id != 0}">
                                <input type="submit" name="action" value="Save" />
                                </c:if>
                                <c:if test="${user.id == 0}">
                                    <input type="submit" name="action" value="Add" />
                                </c:if>
                        </td>
                    </tr>
                </table>
            </form:form>
        </td>


        <%-- Search --%>
        <td valign="top" align="center">
            <c:if test= "${user.id == 0}">
                <h2> User list </h2>
                <c:url var="search" value="/users" ></c:url>
                <form:form action="/users" method ="POST" commandName="pageProperty" >
                    <table>
                        <tr>
                            <td style='text-align:right;vertical-align:middle'>
                                <form:label path="nameFilter">
                                    <spring:message text="Search by name:"/>
                                </form:label>
                            </td>
                            <td>
                                <form:input path="nameFilter" />
                            </td>
                            <td colspan="2">
                                <input type="submit" name="action" value="Search" />
                                        </td>
                        </tr>
                    </table>
                </form:form>
            </c:if>

            <%-- List of users --%>
            <c:if test= "${user.id == 0}">
                <c:if test="${empty listUsers}">
                    <h2>User is not found</h2>
                </c:if>
                <c:if test="${!empty listUsers}">
                    <table class="tg" border="1">
                            <tr>
                                <th>-------ID----------</th>
                                <th>Name------------</th>
                                <th>Age-----</th>
                                <th>Admin----</th>
                                <th>Date--------------------------</th>
                            </tr>
                    </table>
                        <table class="tg">
                            <c:forEach items="${listUsers}" var="user">
                                <tr>
                                    <td width="60" style='text-align:center'>${user.id}</td>
                                    <td width="120" style='text-align:center'>${user.name}</td>
                                    <td width="60" style='text-align:center'>${user.age}</td>
                                    <td width="60" style='text-align:center'>${user.isAdmin}</td>
                                    <td width="80" style='text-align:center'>${user.createdDate}</td>
                                    <td width="40" style='text-align:center'><a href="<c:url value='/edit/${user.id}' />" > <input type="submit" name="action" value="Edit" /></a></td>
                                    <td width="40" style='text-align:center'><a href="<c:url value='/remove/${user.id}' />" > <input type="submit" name="action" value="Delete" /></a></td>
                                </tr>
                            </c:forEach>
                        </table>

                        <%-- Paging --%>
                    <c:url var="search" value="/users" ></c:url>
                    <p>
                    <table>
                    <tr>
                        <td>
                            <form:form action="${search}" method ="POST" commandName="pageProperty" >
                                    <form:input path="pageNumber" type="hidden" value="${pageProperty.pageNumber-1}"/>
                        <td><input type="submit" name="action" value="Prev" /></td>
                        </form:form>
                        </td>

                        <td style='text-align:right;vertical-align:middle'>
                            <p style="font-size:20px">  Page  ${pageProperty.pageNumber}   of   ${pageProperty.size}</p>
                        </td>

                        <td vertical-align:sub>
                            <form:form action="${search}" method ="POST" commandName="pageProperty" >
                                    <form:input path="pageNumber" type="hidden" value="${pageProperty.pageNumber+1}"/>
                        <td><input type="submit" name="action" value="Next" /></td>
                        </form:form>
                        </td>
                    </tr>
                </table>
                    </p>
                </c:if>
            </c:if>
        </td>
    </tr>
</table>
</body>
</html>