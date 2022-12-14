Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E946364C8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiLNMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiLNMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:21:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01056434;
        Wed, 14 Dec 2022 04:18:46 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEB8Jb7002827;
        Wed, 14 Dec 2022 12:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Egmllpt2UyN9IAHOZOSTcs5pT7E8UwSPc2rT9k6nNbI=;
 b=HO2tf17HfsFEiq9y433eS7nKSVqsituiacvSWnZDzh1OY+CDC0IuIo+mCkWVtnDpKqgA
 VxQBrGtWjCwvmLx9Rabil7COVn3Gl5UdXvi8RWniVNACR7J32CPRiXUvGwTI/u8TuOie
 mGqnpes9w80tNkWfFs1m3/o1vtgS705c52HkDodxYk0HtGeV7AlUJFXBB5+xFFprZ2Sm
 vUQMlvxOinDXEgnBCflgFTodcMQh0MvuaO/S962egy2ODhdctEiuAFpIyA6BE8ywOQuA
 q99ZWg7D7fsUq4bTEyMVsFMsAFC/UErTVK5KPij1DWKqXyTukdZAvggq45kno3cPnels Cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rkh25w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 12:18:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BECIg8Z008224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 12:18:43 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 04:18:40 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 1/2] dt: bindings: add dt entry for XO calibration support
Date:   Wed, 14 Dec 2022 17:48:17 +0530
Message-ID: <20221214121818.12928-2-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221214121818.12928-1-quic_youghand@quicinc.com>
References: <20221214121818.12928-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Suugf6ft3ZNri_ua_9WRjZ_MTG1c_Udf
X-Proofpoint-GUID: Suugf6ft3ZNri_ua_9WRjZ_MTG1c_Udf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_05,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding to get XO calibration data support for Wi-Fi RF clock.

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index f7cf135aa37f..205ee949daba 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -41,6 +41,10 @@ properties:
         * reg
         * reg-names
 
+  xo-cal-data:
+    description:
+      XO cal offset to be configured in XO trim register
+
   qcom,ath11k-calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
     description:
-- 
2.38.0

