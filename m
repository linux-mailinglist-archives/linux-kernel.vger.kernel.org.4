Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A956F176E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjD1MQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbjD1MQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:16:38 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5A5244;
        Fri, 28 Apr 2023 05:16:35 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SA7T4n030488;
        Fri, 28 Apr 2023 14:16:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=+hQ1SVkd3GWosyQHpiiz2/BXe0lh3n2EhvFzWJWkxws=;
 b=Ffzqt9Hrc9CGzNT6hDe6BpO2AsUqsFs/4LL1+USgHBG3dw1eN2k0wxZgfpCyeSfuL1Cr
 vEtpswEG6KIXCPVcaQYxtjtOpYIhOhBt1IpJjyORE297TStQz7qEeO+xlYpanP8YsXAG
 nz09ma2b9pkZeidgZDEybZztvpNsIBGznXRRwhPw8I0OXHnFm85EAyLde5unWwpUM4DL
 KMsofkLC4QcBgGS6jZIDhc6w2rfxibjp9H9/eGczBd62BQXhU2FBQxFQixWOdOobrQu0
 Zq0G4p/J7+7/cMoHxwhkl3uGR22OfgIZe6P4bKzVaam4zsmV8nw79pjtDb2BzCJNyezh /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q7x8dduhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:16:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A88AB100034;
        Fri, 28 Apr 2023 14:16:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A04C4227EE3;
        Fri, 28 Apr 2023 14:16:14 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 28 Apr
 2023 14:16:14 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 4/7] dt-bindings: spi: stm32: add bindings regarding stm32h7 spi slave
Date:   Fri, 28 Apr 2023 14:15:21 +0200
Message-ID: <20230428121524.2125832-5-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428121524.2125832-1-valentin.caron@foss.st.com>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

Update the spi-stm32 binding yaml regarding to the SPI slave support.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index c599eb359d56..1d26fa2658c5 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -27,6 +27,7 @@ allOf:
     then:
       properties:
         st,spi-midi-ns: false
+        spi-slave: false
 
 properties:
   "#address-cells": true
@@ -62,6 +63,13 @@ properties:
       - const: rx
       - const: tx
 
+  cs-gpios:
+    description:
+      In case of spi-slave not defined, cs-gpios behave as defined in
+      spi-controller.yaml.
+      In case of spi-slave defined, if <0>, indicate that SS should be
+      detected via the dedicated HW pin
+
 patternProperties:
   "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
     type: object
-- 
2.25.1

