Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E356880AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjBBOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBBOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:52:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418974E52A;
        Thu,  2 Feb 2023 06:52:47 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312CkQmR005281;
        Thu, 2 Feb 2023 14:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+AhklooKfU3Fc/JmaSTVSvs/2kUU8BbPeM4j8NDW/VA=;
 b=SGZ61qJzlNZHisRtypGxl6jfjE9I4tea4aUPDRRgoAGa2RLnlp1ELsOS9ihFBx8k4byq
 YeTOVkiISmvykkR8DKemVvzZjMAd2dLaTBJv7howYHUgVmsVB7rfjZ43W0IZN3tPI67u
 9Jbzik94oQ5gb2x5XRXExhR6P94ElJaPbNhMqYTE6piHusiP1eOf+x614yfRTlkRwpWX
 Pcz5XXOltYLcdKKJgoYEgSlYflEtZldLE52aWnFWeppe+t9U8ITikxmgEwZBgUgR/iOG
 s4cmoKD0rhKKQ0xWMSoigM6DvErH2bxi8SStKePXW5CLKI7uuw6aW3zTSL12WOGxRhOB jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfm9g3cqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:52:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312EqZ0f029875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 14:52:35 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 06:52:31 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 2/6] dt-bindings: clock: qcom,a53pll: add IPQ5332 compatible
Date:   Thu, 2 Feb 2023 20:22:04 +0530
Message-ID: <20230202145208.2328032-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qSJyh6TxIMgvcMlO2_VPdeQtt3pj-vwe
X-Proofpoint-GUID: qSJyh6TxIMgvcMlO2_VPdeQtt3pj-vwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=953 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPQ5332 compatible to A53 PLL bindings.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index 525ebaa93c85..3b6169f30154 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,ipq5332-a53pll
       - qcom,ipq6018-a53pll
       - qcom,ipq8074-a53pll
       - qcom,msm8916-a53pll
-- 
2.34.1

