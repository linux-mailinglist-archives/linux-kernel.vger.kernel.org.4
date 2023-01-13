Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC0669AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjAMOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjAMOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:52:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD92563F74;
        Fri, 13 Jan 2023 06:38:22 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DC3OrM015364;
        Fri, 13 Jan 2023 14:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SEd8EyVqHx/70vZjdhFCAeNeVfCo+EEUm2HhzU4QjUQ=;
 b=o3xTZlll+zc+IsBmPHP+h51yiyHbBnyHAfwp4FwyoiplcNnANUcNzRtwrjtWhKyaG5es
 Rdr5u9BknI5ZFK2dGOkr84/gIbdbRlNomcb+jxw//eIt49eHdUnDIdmiPqnCjjOM4BFV
 JrcdC40b2cbmu35iBt7l8Suj4RGr60LORdIfEnmpCm1ZBdghZgOb4s/798dYMUj0hG6x
 TxQtKrX2AX/4QeTKCbCmq4bIqhWiIg3HijELfDq3O57AYjAPu0q+mi01ulb2FzgUcAH6
 +7G9Ma+CnGzDtzUseHOKFp+r/YtGL6VSAXbYswC+zHWQQ1hTRC6mGp0C33L2AaYOJKJz /g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2d75404v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DEbnlR011392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:49 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 06:37:42 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 5/6] dt-bindings: mailbox: Add compatible for IPQ9574
Date:   Fri, 13 Jan 2023 20:06:46 +0530
Message-ID: <20230113143647.14961-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113143647.14961-1-quic_devipriy@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ONMkcqGJQAoUOW1N3a5ZO2kTIBHRVEKc
X-Proofpoint-GUID: ONMkcqGJQAoUOW1N3a5ZO2kTIBHRVEKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=974 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130096
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mailbox compatible string for IPQ9574 SoC

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 943f9472ae10..9e076758a58a 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - qcom,ipq6018-apcs-apps-global
               - qcom,ipq8074-apcs-apps-global
+              - qcom,ipq9574-apcs-apps-global
               - qcom,msm8976-apcs-kpss-global
               - qcom,msm8996-apcs-hmss-global
               - qcom,msm8998-apcs-hmss-global
@@ -113,6 +114,7 @@ allOf:
           enum:
             - qcom,ipq6018-apcs-apps-global
             - qcom,ipq8074-apcs-apps-global
+            - qcom,ipq9574-apcs-apps-global
     then:
       properties:
         clocks:
@@ -129,6 +131,7 @@ allOf:
           enum:
             - qcom,ipq6018-apcs-apps-global
             - qcom,ipq8074-apcs-apps-global
+            - qcom,ipq9574-apcs-apps-global
     then:
       properties:
         '#clock-cells':
-- 
2.17.1

