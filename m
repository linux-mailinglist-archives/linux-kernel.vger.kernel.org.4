Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126785B67E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIMG2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIMG1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:27:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E9CE2B;
        Mon, 12 Sep 2022 23:27:52 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D5Dhom001855;
        Tue, 13 Sep 2022 06:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=C+4it0DmVQbswpnSX/olWD/88Nw19wtLp+OFTkMLNSI=;
 b=BXgji06UjzZ4YYbTGJs/wTSTE0Yrl/32rZGWs4apDrQEFm5iaB9EYLX45h5q0uctfGif
 pEFUnerJutSAiXl3AQIDI/8U2Vbkk6LAhgyhihUEnPbd7HntJoyrBVFgvsJPyDdG7P7r
 SSqYy/xAvV71oosoawJEiGS6FsQ9CNTh7WvEAfgQYoQ3MLR5Z2fBjrrCjGNASmOapQ3K
 e0RH6tMVTnCrWkQb75kG6obnfCTITrrFybfXkMWqMow9todcC7ZXIGU5Bd1nOjfvfPNp
 +NLXOCloaqWFakt1RD7PJ+fiuk1cxwGsVfGVVkbOOI7m5hSO02LgW+C4icAqZgIY05mW +A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjbh196wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 06:27:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D6RgqF026477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 06:27:42 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 23:27:39 -0700
From:   Huang Yiwei <quic_hyiwei@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>
CC:     <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <leo.yan@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Huang Yiwei <quic_hyiwei@quicinc.com>
Subject: [PATCH] interconnect: qcom: Add the missing MODULE_LICENSE
Date:   Tue, 13 Sep 2022 14:27:21 +0800
Message-ID: <20220913062721.5986-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7GURRqOwL6WKteQywu6wrGBuT4zmN2LW
X-Proofpoint-ORIG-GUID: 7GURRqOwL6WKteQywu6wrGBuT4zmN2LW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since icc-common.c can be compiled as module, add the missing
MODULE_LICENSE to avoid compile errors.

Fixes: cb4805b5a5e4 ("interconnect: qcom: Move qcom_icc_xlate_extended() to a common file")
Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
 drivers/interconnect/qcom/icc-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
index 0822ce207b5d..f27f4fdc4531 100644
--- a/drivers/interconnect/qcom/icc-common.c
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -5,6 +5,7 @@
 
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "icc-common.h"
 
@@ -32,3 +33,5 @@ struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void
 	return ndata;
 }
 EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1

