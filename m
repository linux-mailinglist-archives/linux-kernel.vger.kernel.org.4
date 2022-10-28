Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F8611539
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJ1Oxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJ1Ox1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:53:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED51FB7A1;
        Fri, 28 Oct 2022 07:53:25 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDTjWe006843;
        Fri, 28 Oct 2022 16:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=1dFK6BhRh9rGt4YtoWjgXHrS1kbo/86Rt3Cu9/GTxX8=;
 b=3xPKGTJgcXva240kixr7RzNsYCkUFs0kKNCHXAInh+J8JDQsZruoLMdTlFHDJyOn9hWG
 Y9Qf73UyP8JGBb+rCEc1mdH5gi4yBk5Vg3TtWSuiVGtgjV9xpn3DMbdPQDRHIvLeG5HV
 UviHjzcX4ceCQg3scCOipVgUQpfxpGV7OQt7LrhYAqKqmpUhF5kFHOA9jMfC05fJtRq4
 LOzkXFFGkSMxuqBzwSNDvbP0OI4CYAgM1j0iiQqAVHBF3keSu9GBgVY8Jyl4k1oJwO13
 yC6msLyVzg8y6tnIluO0OqTl1isAD0kBhqTBl9zAFMCr+OfWHPkJlZO74cPNYnLHIMCV tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kfajfdjmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:53:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95E07100039;
        Fri, 28 Oct 2022 16:53:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90F84228A4E;
        Fri, 28 Oct 2022 16:53:00 +0200 (CEST)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 16:53:00 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/3] ARM: dts: stm32mp13: fix compatible for BSEC
Date:   Fri, 28 Oct 2022 16:52:50 +0200
Message-ID: <20221028165150.2.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct compatible for stm32mp13 support.

The BSEC driver for STM32MP15x is not compatible with STM32MP13x. For
example the proprietary's smc STM32_SMC_BSEC is not supported in
STM32MP13x OP-TEE, it is replaced by SM32MP BSEC Pseudo Trusted
Application in OP-TEE to access to the secured IP BSEC on STM32MP13X SoC.

The correct compatible is already used in U-Boot and in upstream is in
progress for OP-TEE device tree.

As the SoC STM32MP13X is not yet official and it is not available
outside STMicroelectronics, it is the good time to break the DTS
compatibility and to correct the error done in the introduction of
STM32MP131.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
This patch is already sent separately in:
https://lore.kernel.org/all/20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid/
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685815

I create a serie for more efficient review.

Patrick.

Changes in v1:
- update commit message to indicate DTS break reason.

 arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index dd35a607073d..89a027f894f9 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -398,7 +398,7 @@ rtc: rtc@5c004000 {
 		};
 
 		bsec: efuse@5c005000 {
-			compatible = "st,stm32mp15-bsec";
+			compatible = "st,stm32mp13-bsec";
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

