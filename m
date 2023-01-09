Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E22663409
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjAIWiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbjAIWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:37:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA6F58C;
        Mon,  9 Jan 2023 14:37:55 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309MUwaX004997;
        Mon, 9 Jan 2023 22:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FXKWheEKsOqDLciNq8NL6PwL8zGg9RIgA0fkugOCKLQ=;
 b=Mn8V4AIE8m1jEaOcMhL8Mnn/QJEDTxVnS0+FozA58emSMcnw0tLsImRuP5a5ATR8bhd/
 vWb2m91R+us6lT+6JUu7XCG/FRrpQS4n26pUvg4QLLcHfezjwn9pHM6hukIA7U81x4w+
 obXG5M1jKBrwXZXgubKY1CaXtZY/wNntNz/1fFabsUFZUdwDxhc9Ht/f9EQFQRdV6mwq
 ULXeDHjoadM4CMNZxymosEfzAq8m4XEARJ8imaFy0HFZ9OxuUpiGPp6iX1AD/Af3j+Fz
 YmPwdRi3ifT+jUvkc14R4A0QPm6RgZkMwE/qYNaynbPeNVSe5X9FlGQW8I0d7svhyP+K GQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0u147cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:37:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309MbpqU023826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:37:51 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:37:50 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Chris Lew <quic_clew@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rpmsg: glink: Include types in qcom_glink_native.h
Date:   Mon, 9 Jan 2023 14:37:45 -0800
Message-ID: <20230109223745.1706152-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zDIFjFwK5AEcKKT2OC1QcyzOoPL6xU2p
X-Proofpoint-ORIG-GUID: zDIFjFwK5AEcKKT2OC1QcyzOoPL6xU2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the used data types are available in qcom_glink_native.h, to
silence LSP warnings.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
index 624184fc458e..e9a8671616c7 100644
--- a/drivers/rpmsg/qcom_glink_native.h
+++ b/drivers/rpmsg/qcom_glink_native.h
@@ -6,6 +6,8 @@
 #ifndef __QCOM_GLINK_NATIVE_H__
 #define __QCOM_GLINK_NATIVE_H__
 
+#include <linux/types.h>
+
 #define GLINK_FEATURE_INTENT_REUSE	BIT(0)
 #define GLINK_FEATURE_MIGRATION		BIT(1)
 #define GLINK_FEATURE_TRACER_PKT	BIT(2)
@@ -24,6 +26,7 @@ struct qcom_glink_pipe {
 		      const void *data, size_t dlen);
 };
 
+struct device;
 struct qcom_glink;
 
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
-- 
2.37.3

