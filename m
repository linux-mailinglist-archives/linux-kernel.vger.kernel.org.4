Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CE741899
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjF1TFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:05:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:28474 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232425AbjF1TE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:04:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SIWjSQ011106;
        Wed, 28 Jun 2023 19:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=c6gV6DUPeseuoyeesDk6z1v7bVxPu3Jz3kaPMY40MHk=;
 b=I/cJGUyUaSM4ghy8E/vjJl5Zpipgl73Ts1E2EWBRa8aTr7TDyJ20AFOuzhUIgyiVkL+r
 4sf9fPcWA8gCUoixYw1r3o+U17VXxMqPrtWZ9EE2HZEmT9Y52YEunjcvGG/K1s1icXdJ
 0ynQ+aLYBkcruYIFE3qosrlsunHZ1JEiG9KT1Z1zCmw6a21BPb9yE+BzFB6nJu0GzxyW
 +sWjZCwYEdVtZsygVUzvyPXwc37GzITZzzZtZZB1liDTVGI0mpXlTQOuDHMiSAjVH5hQ
 oyB/zYBYJUSYqe5Ot9HGGR519nyB/2VIjqN2gdNGxdPjNWlsXVpKk69Egx9tEiXAH5HY Fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg9pb29c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:04:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SJ4rl6023926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:04:53 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 12:04:51 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <rfoss@kernel.org>, <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, <mchehab@kernel.org>,
        <andersson@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeffrey Hugo" <quic_jhugo@quicinc.com>
Subject: [PATCH] media: docs: qcom_camss: Update Code Aurora references
Date:   Wed, 28 Jun 2023 13:04:33 -0600
Message-ID: <20230628190433.19050-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VkRIRPim3zEAWN_ijA4XA-4P8A6veG3I
X-Proofpoint-ORIG-GUID: VkRIRPim3zEAWN_ijA4XA-4P8A6veG3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=880 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

source.codeaurora.org is no longer accessible and so the reference links
in the documentation are not useful.  The content was mirrored over to
Code Linaro so lets update the references to point there instead.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/admin-guide/media/qcom_camss.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/media/qcom_camss.rst b/Documentation/admin-guide/media/qcom_camss.rst
index a72e17d09cb7..8a8f3ff40105 100644
--- a/Documentation/admin-guide/media/qcom_camss.rst
+++ b/Documentation/admin-guide/media/qcom_camss.rst
@@ -18,7 +18,7 @@ The driver implements V4L2, Media controller and V4L2 subdev interfaces.
 Camera sensor using V4L2 subdev interface in the kernel is supported.
 
 The driver is implemented using as a reference the Qualcomm Camera Subsystem
-driver for Android as found in Code Aurora [#f1]_ [#f2]_.
+driver for Android as found in Code Linaro [#f1]_ [#f2]_.
 
 
 Qualcomm Camera Subsystem hardware
@@ -181,5 +181,5 @@ Referenced 2018-06-22.
 References
 ----------
 
-.. [#f1] https://source.codeaurora.org/quic/la/kernel/msm-3.10/
-.. [#f2] https://source.codeaurora.org/quic/la/kernel/msm-3.18/
+.. [#f1] https://git.codelinaro.org/clo/la/kernel/msm-3.10/
+.. [#f2] https://git.codelinaro.org/clo/la/kernel/msm-3.18/
-- 
2.40.1

