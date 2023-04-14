Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1806E1E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDNInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDNIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:43:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA765FC2;
        Fri, 14 Apr 2023 01:43:10 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E7hfNq006573;
        Fri, 14 Apr 2023 10:42:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=QpPXBtsHkQMuvY0n+wqW+FRbWvmIB4mawMzRJpA2Fyc=;
 b=QpH6BKok8SHoDwYCoSNTKCRyI601Ah8gxDv1zfAoLQXiyEyu3E3DC8a8h+JW4vTh69i3
 lm4+8+OVs6YJxXL8fMOqb4H4+aj9wXj35HMzQ/Ul+K8MN4BRyaLWjVMOfn01racUb23+
 2T5JmyCNbJxdQy9Ox68N4Y4Vd6mfhOPnmgcDlvu9FHerrGKNcbzzCwfUGCZ6XYawrsH5
 ekWDOOw9mK0h8Im42t9Qi9ddDjK9hfpo6GRKGBSiV+HnVK6tAGl7aNaXlyDcGpcev9Yf
 X3OS91Q7t03VG+uUG9qDLhl04e0sJajjoc2L6+oTeiilCwxXK1DWWEjtZ80FtjSciTW/ gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pwsgpq3qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:42:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 286A7100034;
        Fri, 14 Apr 2023 10:42:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10B8720BE6D;
        Fri, 14 Apr 2023 10:42:13 +0200 (CEST)
Received: from localhost (10.252.1.127) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 14 Apr
 2023 10:42:11 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 4/4] ARM: dts: stm32: add USB OTG UTMI clock on stm32mp151
Date:   Fri, 14 Apr 2023 10:41:37 +0200
Message-ID: <20230414084137.1050487-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
References: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.127]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_03,2023-04-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needed on STM32MP15, when using the integrated full-speed PHY. This
clock is an output of USBPHYC, and the HS USBPHYC is not attached as PHY
in this case (managed directly by dwc2 ggpio glue):

    &usbotg_hs {
    	compatible = "st,stm32mp15-fsotg", "snps,dwc2";
    	pinctrl-names = "default";
    	pinctrl-0 = <&usbotg_hs_pins_a &usbotg_fs_dp_dm_pins_a>;
    	vbus-supply = <&vbus_otg>;
    	status = "okay";
    };

USBPHYC clock output must be used, so it can be properly enabled as a
clock provider.

Without this, currently, when the dualport High-Speed USBPHYC isn't
requested by either USBH or OTG, it remains uninitialized when probing
OTG: OTG configured with full-speed PHY isn't properly clocked, resulting
in error log like:
[    2.383138] dwc2 49000000.usb-otg: dwc2_core_reset: HANG! Soft Reset
timeout GRSTCTL_CSFTRST.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- "utmi_clk" renamed "utmi" as per Krzysztof comment on dt-bindings
---
 arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 4e437d3f2ed6..63f4c78fcc1d 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1130,8 +1130,8 @@ sdmmc3: mmc@48004000 {
 		usbotg_hs: usb-otg@49000000 {
 			compatible = "st,stm32mp15-hsotg", "snps,dwc2";
 			reg = <0x49000000 0x10000>;
-			clocks = <&rcc USBO_K>;
-			clock-names = "otg";
+			clocks = <&rcc USBO_K>, <&usbphyc>;
+			clock-names = "otg", "utmi";
 			resets = <&rcc USBO_R>;
 			reset-names = "dwc2";
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

