Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92E6A7922
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCBBn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCBBnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:43:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3869BBB90;
        Wed,  1 Mar 2023 17:43:25 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321H24d1022065;
        Thu, 2 Mar 2023 01:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WEt31C4rymQvGAxgTYp0HLRd/rePdGjn7Im2OeBw7/c=;
 b=cAOIPUm1srXoxZXh0SIX3iZPMKn6PyjMMXrC1msyGY+UKEYFugYbwX0Q+qlme3QUxK0l
 6Dw7wPciEUL0EtFlZeC7d0sjChW9omQhFNL9VpC5XqYTemZCb994akaQ0U5DLmkOA/st
 NpONBZf9kRGWcUBG1g+IfdquYTpcN9Sh7GyaVdyTX9MALD9/uknyT9TdNGJ9QQtkX6lv
 xvEKoRq1YmMX/bDUBxWLxFrWGZe8xN5ZB0UcifkIo8OSdFQIX/WRlDZPY9nvcKrhPy0i
 +MOt0dXalobLvzsN/6Bl1xNhsIufazQ6KJon1DoMapk/OjWC7zc3r9sUn9DU0sdxGkGB tA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2ar115w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 01:43:05 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3221h4xs026549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 01:43:04 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 17:43:04 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] ufs: mcq: qcom: Clean the return path of ufs_qcom_mcq_config_resource
Date:   Wed, 1 Mar 2023 17:42:56 -0800
Message-ID: <3ebd2582af74b81ef7b57149f57c6a3bf0963953.1677721229.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BcByXsSkGPPWTm1gUwOvYFj50264dzvy
X-Proofpoint-ORIG-GUID: BcByXsSkGPPWTm1gUwOvYFj50264dzvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020011
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch static checker reported:
drivers/ufs/host/ufs-qcom.c:1469
ufs_qcom_mcq_config_resource() info: returning a literal zero is
cleaner

Fix the above warning by returning in place instead of a jump to a
label.
Also remove the usage of devm_kfree() as it's unnecessary in this
function.

Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 43b1fc1ad33e..cb20c7136c2c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1466,7 +1466,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	/* Explicitly allocate MCQ resource from ufs_mem */
 	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
 	if (!res_mcq)
-		return ret;
+		return -ENOMEM;
 
 	res_mcq->start = res_mem->start +
 			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
@@ -1478,7 +1478,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	if (ret) {
 		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
 			ret);
-		goto insert_res_err;
+		return ret;
 	}
 
 	res->base = devm_ioremap_resource(hba->dev, res_mcq);
@@ -1495,8 +1495,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 ioremap_err:
 	res->base = NULL;
 	remove_resource(res_mcq);
-insert_res_err:
-	devm_kfree(hba->dev, res_mcq);
 	return ret;
 }
 
-- 
2.7.4

