Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D163678F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjAXFF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjAXFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:05:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF730E80;
        Mon, 23 Jan 2023 21:05:41 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O4oki9020350;
        Tue, 24 Jan 2023 05:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zJ8nHVQUcPvogFrQOP+nH8HDhiQnoCZtyrQjGB8/elw=;
 b=Jz/OLV8Awr2tPqCqgGV8PbwHBXkEvTJ6pk6yDvmZU/NOvIpOWh1ILnkVZlde0LkOyfO0
 7gmTcHl8E0XBRq9tr/3gNBx8BQpLvSYjpU7npICQE7pckII88Wivnk0oEcg5BWm++ZmR
 v1S1mWSGN5mlfiJIB49rm8CX5pPvqNIlt2Is8LA2U3YouXVMj4ZfTZbN3IgxMURlUtn7
 SIVjeUWanGZWTBu5GDEdtKZGwjcM1tWLCP/odA1hT9/6bPBr1atETXDJH734sigqjOfW
 Cr9Mx+JyrqQSODnthr8N8KEwy0KGwprJbdIp0OiQnFRkks2SYU+SLUSz88vIDZExuOFc XQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk4bm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 05:05:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O55YDI013864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 05:05:34 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 23 Jan 2023 21:05:31 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1] bootconfig: Increase max nodes of bootconfig from 1024 to 8192 for DCC support
Date:   Tue, 24 Jan 2023 10:34:42 +0530
Message-ID: <1674536682-18404-1-git-send-email-quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FMtINRHu4VrLcyHweuK0GAjJ0eLNkNw_
X-Proofpoint-ORIG-GUID: FMtINRHu4VrLcyHweuK0GAjJ0eLNkNw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=857 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Data Capture and Compare(DCC) is a debugging tool that uses the bootconfig
for configuring the register values during boot-time. Increase the max nodes
supported by bootconfig to cater to the requirements of the Data Capture and
Compare Driver.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 include/linux/bootconfig.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 1611f9d..ca73940 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -59,7 +59,7 @@ struct xbc_node {
 /* Maximum size of boot config is 32KB - 1 */
 #define XBC_DATA_MAX	(XBC_VALUE - 1)

-#define XBC_NODE_MAX	1024
+#define XBC_NODE_MAX	8192
 #define XBC_KEYLEN_MAX	256
 #define XBC_DEPTH_MAX	16

--
2.7.4

