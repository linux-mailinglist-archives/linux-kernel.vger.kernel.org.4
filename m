Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE7649A76
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiLLIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiLLIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:52:47 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E4E7E;
        Mon, 12 Dec 2022 00:52:39 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC6swg9015518;
        Mon, 12 Dec 2022 09:51:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=TOqkRcZbErIyjJAEojm5hJoAPzhWY8z4HpiNr4YtaeE=;
 b=65pdX6utYSb9dmm6IXVMhfUE3i7iITWCx9zmzVqcdV4/ld4BjsJjVQ1aidOUmV6x+PMt
 UZbXrXdcXuNVl2SugzcadPwVENPovnzcoB57MV45uNGY/l9QGk6yeS1WfL3XFAR9x31H
 QkZ1LNkp7Re4cC88NwCJ/PM+Bsf8Pvn2XTHSdWXpu4FLOH6OQkV2/VdcCDorprK5WaXr
 chNMfNMb4iNiyiD1R3FdjVwXbeUj/h/r/4rKnNrku3p0iEcvHrAmyyk3z3xgXcklUAYd
 CODb/hR+WmNLdHlevYIdxz97PP/QKTr9uLthGE+BcAkdCuKLgRbDKz8irSOWDu1SjiEH tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mchvp231q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 09:51:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CC0310003A;
        Mon, 12 Dec 2022 09:51:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7394F217B6F;
        Mon, 12 Dec 2022 09:51:48 +0100 (CET)
Received: from localhost (10.201.20.130) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 12 Dec
 2022 09:51:48 +0100
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcom-som
Date:   Mon, 12 Dec 2022 09:51:40 +0100
Message-ID: <20221212085142.3944367-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
References: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.130]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_01,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Chip select pinctrl phandle was missing in several stm32mp15x based boards.

Fixes: ea99a5a02ebc ("ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi)

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
index 238a611192e7..d3b85a8764d7 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
@@ -428,8 +428,12 @@ &pwr_regulators {
 
 &qspi {
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a>;
-	pinctrl-1 = <&qspi_clk_sleep_pins_a &qspi_bk1_sleep_pins_a>;
+	pinctrl-0 = <&qspi_clk_pins_a
+		     &qspi_bk1_pins_a
+		     &qspi_cs1_pins_a>;
+	pinctrl-1 = <&qspi_clk_sleep_pins_a
+		     &qspi_bk1_sleep_pins_a
+		     &qspi_cs1_sleep_pins_a>;
 	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.25.1

