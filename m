Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245B60E9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiJZUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiJZUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:04:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D2134DF8;
        Wed, 26 Oct 2022 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666814682; x=1698350682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDosjeGjGHK2UYHOmIaxl4hBmdnpZ/nBZe3ArKUemP4=;
  b=N9Kie64lp0NIOehlfweN4gz3M7tr1+3HPpfLfqA2Ld1PszoNooz2eNEZ
   3O9XCu/Z1UxJcKODs/5IxLWu0aJ0E+Yv2x2sSvfVY8xuwLTO2bLAnu1Jv
   k9UxH6UQk+LbgicNZ1znR2X5BrwtMZNHDAcpYQXUlG3l5LX1eli+Pqkux
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Oct 2022 13:04:41 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:04:41 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 13:04:41 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 2/4] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
Date:   Wed, 26 Oct 2022 13:04:27 -0700
Message-ID: <20221026200429.162212-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026200429.162212-1-quic_molvera@quicinc.com>
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QDU1000 and QRU1000 SoC bindings and the boards that use
them.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..410df0bbae70 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -40,6 +40,8 @@ description: |
         msm8996
         msm8998
         qcs404
+        qdu1000
+        qru1000
         sa8155p
         sa8540p
         sc7180
@@ -76,6 +78,7 @@ description: |
         mtp
         qrd
         sbc
+        x100
 
   The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
   where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
@@ -271,6 +274,19 @@ properties:
               - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
+      - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
+        items:
+          - enum:
+              - qcom,qdu1000-idp
+              - qcom,qdu1000-x100
+          - const: qcom,qdu1000
+
+      - description: Qualcomm Technologies, Inc. Radio Unit 1000 platform
+        items:
+          - enum:
+              - qcom,qru1000-idp
+          - const: qcom,qru1000
+
       - description: Qualcomm Technologies, Inc. SC7180 IDP
         items:
           - enum:
-- 
2.25.1

