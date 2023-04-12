Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767166DF9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDLPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjDLPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:19:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCDA8691;
        Wed, 12 Apr 2023 08:19:02 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CCb4GR001837;
        Wed, 12 Apr 2023 17:18:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xDGfgH0IVACI86pTdLBxzPG3hW0K++wCSS+2PKwBPTo=;
 b=h6u8spqVjmwGay8hebt7FLtZsDSk2xF0HVV0tTZxVYrrAEhbGZc4tq7mZgOL//ke5/xc
 GzGRzL5dAp8UC0c7AUXWll0doR+97Ipb/X0+EMHvke8LKawuBJUvA4Gar0hwg+QP3+JT
 DK6JrEY35hMQLt1CjdmzzRS6UN2xLr9gkM7sD2zIqmkQdQuDEkSHcjRvU6NZftGUXFVv
 aZWjORsCn5Irj2wB1yKP65tDJqIZqE53aV4fleoAuxkPJaSqyTi90txPAolorPenDqOM
 1S6TftQgTTmGeeS5tm3/ldYtNPsotQOq+Dgo7yLlFBrODs4NKQVP7gBNqrzl8BqUyug6 sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pw8b0qya5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:18:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F46410003A;
        Wed, 12 Apr 2023 17:18:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08335218611;
        Wed, 12 Apr 2023 17:18:43 +0200 (CEST)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 17:18:42 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH 4/4] ARM: dts: stm32: add USB OTG UTMI clock on stm32mp151
Date:   Wed, 12 Apr 2023 17:18:31 +0200
Message-ID: <20230412151831.3069211-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412151831.3069211-1-fabrice.gasnier@foss.st.com>
References: <20230412151831.3069211-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 4e437d3f2ed6..b71767125bf9 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1130,8 +1130,8 @@ sdmmc3: mmc@48004000 {
 		usbotg_hs: usb-otg@49000000 {
 			compatible = "st,stm32mp15-hsotg", "snps,dwc2";
 			reg = <0x49000000 0x10000>;
-			clocks = <&rcc USBO_K>;
-			clock-names = "otg";
+			clocks = <&rcc USBO_K>, <&usbphyc>;
+			clock-names = "otg", "utmi_clk";
 			resets = <&rcc USBO_R>;
 			reset-names = "dwc2";
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

