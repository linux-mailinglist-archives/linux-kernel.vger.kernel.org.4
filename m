Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9B745842
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjGCJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjGCJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:20:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145051A1;
        Mon,  3 Jul 2023 02:20:47 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3638igWF024760;
        Mon, 3 Jul 2023 09:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=23NU6hBXNSSaD+ZlGgoiLhzx3KfHft2aiZNXw3ISVWA=;
 b=oIQBmQ66ZfFkwi5YjackxFv4lZatjdWhVH0snH8TzOwFhJ3DwDCcUDXxfLAkFzyOWZPz
 dQp/ETBh5/nFcgBv3l6yJaSiDPGGvcCDMwrHbGjAfRp3r2F220ZiX9WpAcXBMBfMRmgj
 ZVJx0bvhDvZ22GxM3kG8xKtQ4IItkkF6k7LUwY3po2M+eiQpCgUukefpZknxW0SAEoIi
 n0eb9nglUaaseuPhUju9vzAGXz5wvPnO4k2IlsuHL7cODekw2dz4WXohoOfBfHwmWir7
 czU99i5i3/6cUQ+MPg1QJC9j7fY06lo/dTEfy0WeP8DwtKgFh7Qthlp872xwixEks5Hu uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjbfqkn29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 09:20:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3639Kh57032721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 09:20:43 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Mon, 3 Jul 2023 02:20:39 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_lsrao@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: soc: qcom: stats: Update maintainer email
Date:   Mon, 3 Jul 2023 14:50:26 +0530
Message-ID: <20230703092026.4923-1-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Nn6vSZvJ15_GH-byhkv1mskJHeMSga94
X-Proofpoint-ORIG-GUID: Nn6vSZvJ15_GH-byhkv1mskJHeMSga94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=733 phishscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace my email.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
index 7ab8cfff18c1..96a7f1822022 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. (QTI) Stats
 
 maintainers:
-  - Maulik Shah <mkshah@codeaurora.org>
+  - Maulik Shah <quic_mkshah@quicinc.com>
 
 description:
   Always On Processor/Resource Power Manager maintains statistics of the SoC
-- 
2.17.1

