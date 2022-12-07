Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785786461B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLGT1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLGT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:27:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EE02641;
        Wed,  7 Dec 2022 11:27:37 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GldIf026815;
        Wed, 7 Dec 2022 19:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=OwRMRJb+7c5gqaDyHQE7ipnl64XWdQ3NjzWLz62hDzc=;
 b=niQn/KSAucucb7VnGASXwuQd/9hdeaICtEBourqlq03rlkRBE590OjlSW+jrW/fbLwQy
 CHoomo2MWNGFqY0Zab08L0E4IvbdnGpWAvf3IKTg4Vr3dXKobT6Kxjmz//BxXqIFdMM4
 EIHCDtZdXdob5H4uICtUh6nxVFQ6qvBqaM3PmEEjGQJkWA6el+RDMzYPnoWBV5ukSyk/
 U1Cu5ErJWdRBSmVKfN/j40wYl8lHGTifwPHj95l/zY1RoqDwcaAQVcZtJAMbJ/n4M/Cw
 o3RSr0C3YPwrM5jMjpHTuF8aCr+gUdFMP3vGdYMcPt/UF6J5aCuJFZ9+Y/ycTEJSZSLc nQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3man0k9uxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 19:27:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B7JRQpm007941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 19:27:26 GMT
Received: from carlv-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 11:27:26 -0800
From:   Carl Vanderlip <quic_carlv@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>
CC:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mhi: Update Makefile to used Kconfig flags
Date:   Wed, 7 Dec 2022 11:26:13 -0800
Message-ID: <20221207192613.2098614-1-quic_carlv@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6liTA3p1_TSbQq8eDgr8GO49hyW_BrRQ
X-Proofpoint-ORIG-GUID: 6liTA3p1_TSbQq8eDgr8GO49hyW_BrRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=823
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile was always suggesting to build subdirectories regardless of
Kconfig. Use the Kconfig flags as intended.

Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
---
 drivers/bus/mhi/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 46981331b38f..354204b0ef3a 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -1,5 +1,5 @@
 # Host MHI stack
-obj-y += host/
+obj-$(CONFIG_MHI_BUS) += host/
 
 # Endpoint MHI stack
-obj-y += ep/
+obj-$(CONFIG_MHI_BUS_EP) += ep/
-- 
2.25.1

