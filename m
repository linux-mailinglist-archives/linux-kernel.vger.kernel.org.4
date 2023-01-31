Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9F683217
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAaQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjAaQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:01:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC8521F1;
        Tue, 31 Jan 2023 08:01:49 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VCikqS028282;
        Tue, 31 Jan 2023 16:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=62OuHyosEYJ1cEOsXAgd/j7oZ9RaFGpVr3bJhayjsoo=;
 b=TxznM+SLJdgWVjodU4uvjvuaSzPZVpuyUX6IQ6SOYzPosQgIToSaawtTxAlp5+wuY2ZV
 WeEMBUWeWNr40sNdGXlsLfGtLU5PlwerwEk8C56+LS1UZfljLNTxspFDPTHn4N+aGrhi
 PJPc1aZTDj2L9H8dZzt1IYW6gL2DC9dKnzfUs6lF+O0S0mHl3hUSm64zHxy+QMgJMFDb
 9LlxQZ40IZdVCb+7P5lEod2yyiUtfE828dyYhS4SdQ8by7LbhMJv71nEnNJTqvdstLN/
 6WOA9/wIV7wcmbJ8QlfJIlCKYQuHUKY6ZJvslNu7tYu5hXjjHJFkRvhfIHN68A+N/hjV 7w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxapsbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:01:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30VG1ZO6029889
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:01:35 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 08:01:32 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] remoteproc: qcom: fix sparse warnings
Date:   Tue, 31 Jan 2023 21:31:06 +0530
Message-ID: <1675180866-16695-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jivvLcm3wu7xwPqOccHcB2vgxulpraP_
X-Proofpoint-GUID: jivvLcm3wu7xwPqOccHcB2vgxulpraP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=767 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to address below sparse warnings.

drivers/remoteproc/qcom_common.c:126:27: warning: restricted __le32 degrades to integer
drivers/remoteproc/qcom_common.c:133:32: warning: cast to restricted __le32
drivers/remoteproc/qcom_common.c:133:32: warning: cast from restricted __le64

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/qcom_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 020349f..7133c1f 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -123,14 +123,14 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 
 	for (i = 0; i < seg_cnt; i++) {
 		memcpy_fromio(&region, ptr + i, sizeof(region));
-		if (region.valid == MD_REGION_VALID) {
+		if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
 			name = kstrdup(region.name, GFP_KERNEL);
 			if (!name) {
 				iounmap(ptr);
 				return -ENOMEM;
 			}
 			da = le64_to_cpu(region.address);
-			size = le32_to_cpu(region.size);
+			size = le64_to_cpu(region.size);
 			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
 		}
 	}
-- 
2.7.4

