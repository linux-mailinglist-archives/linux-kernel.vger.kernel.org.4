Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5B6F7EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjEEIXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjEEIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:22:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480221892A;
        Fri,  5 May 2023 01:22:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3458LmUV028048;
        Fri, 5 May 2023 08:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JZQ3+O8SUdOc+nTxQWYiFuvwz2MSIJTyx1Se9DSUYTc=;
 b=MVK02hFbHXvDF+/mwr9OnULsIfIuQCR4a5rgJKkpffECFp3tzJ1bblqDvu1u+zKo52tk
 edhicwfhXtg68jeeGvXBAHsxoY8FV4MQXh+hDlHZFnZTOwk7I0bnUXtPa0jywlncpbzw
 MO7D7T0H/kLWGay0/S1dfk3FMDab0Lbmk4MwCRsyfjadzf/hDPK6gNxw4UekWCjEOC7y
 lrBlRlz68/z6whuBLKa15PnXSaGI5sRQl/CNoMG9PDqW2ef8nAde5biTVgAtnvcmRnbT
 LAAZnLBt9YyWuO0IMT8xuMq26RkGcRs0t9bRr6dJWEY9tNBeTt2GDkpYWAzHwxoIG4vk Sw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcf24htyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 08:22:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3458MMT1016114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 08:22:22 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 01:22:16 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v10 3/9] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Date:   Fri, 5 May 2023 13:05:04 +0530
Message-ID: <5f7e77b715ed93e4ece624988822f7bd0e2db03c.1683183860.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683183860.git.quic_varada@quicinc.com>
References: <cover.1683183860.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JIfoL_n8B4rfnovvCQYXvzyf4Amae7jd
X-Proofpoint-GUID: JIfoL_n8B4rfnovvCQYXvzyf4Amae7jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=894
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Document the IPQ9574 dwc3 compatible.

* Make power-domains as optional since IPQ9574 doesn't have GDSCs

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v9:
	- Place ipq9574 alongwith similar SoCs instead of new entry
	- Make power-domains as optional since IPQ9574 doesn't have GDSCs

 Changes in v6:
	- Made power-domains as optional
	- Resolved all 'make dtbs_check' messages

 Changes in v5:
	- Restore removed constraints

 Changes in v4:
	- Update other relevant sections
	- Remove constraints not applicable to IPQ9574
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index d842819..5c13229 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -17,6 +17,7 @@ properties:
           - qcom,ipq6018-dwc3
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
+          - qcom,ipq9574-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
@@ -133,7 +134,6 @@ required:
   - "#address-cells"
   - "#size-cells"
   - ranges
-  - power-domains
   - clocks
   - clock-names
   - interrupts
@@ -177,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq9574-dwc3
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
-- 
2.7.4

