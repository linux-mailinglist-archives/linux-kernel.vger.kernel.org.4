Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE7609E45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJXJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJXJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:47:18 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D382DABF;
        Mon, 24 Oct 2022 02:47:15 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O8oZjT001299;
        Mon, 24 Oct 2022 11:47:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=WAazJOXTmTrFiYKklIJdUFWRgJ9uUsRwSbws5zGLLRE=;
 b=Rye6SzTFAW/ln+r0rvNLltV3ZE+SaPQDfeO9mv7oxQ05Jo9Wm4wCSdEUVSUOc+PoW5WB
 zOu6pCQLhFFzzyAhuCES9sKf8yTXSGqUCKjp6PIVPG4gimD00D1hKqEjcPOwNJ6AzgWa
 aYPBEp3BC4WEcLz5cBxjabQjBJF3Ne8IhYtUztohBYRLBmabRYQeFnfesbo4y0Fgrn+W
 TJXMmQJnMO8yQW2lSVjJXLCMlhdE11wPZB8OCzo/KJ2h9yPvuAjk2xeyRDyl8iblUIwg
 HW3bckAWkGLUXh0JOOmLFVArakP0aL4Z4DI3+zPF5kKuZhyg28ZIbGTzwsSjjSsgz7xw tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc7dk2cnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 11:47:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C72F410002A;
        Mon, 24 Oct 2022 11:46:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2D2C2194CD;
        Mon, 24 Oct 2022 11:46:57 +0200 (CEST)
Received: from localhost (10.201.20.208) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 11:46:57 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ARM: dts: stm32: add mcp23017 IO expander on I2C1 on stm32mp135f-dk
Date:   Mon, 24 Oct 2022 11:46:48 +0200
Message-ID: <20221024094648.145251-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024094648.145251-2-amelie.delaunay@foss.st.com>
References: <20221024094648.145251-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.208]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP23017 is an IO expander offering 16 input/output port expander with
interrupt output.
On stm32mp135f-dk, only INTA is routed (on PG12), but MCP23017 can mirror
the bank B interrupts on INTA, that's why the property microchip,irq-mirror
is used.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index a87ab067c955..d5fc6462ba33 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -112,6 +112,20 @@ &i2c1 {
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
+
+	mcp23017: pinctrl@21 {
+		compatible = "microchip,mcp23017";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpiog>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcp23017_pins_a>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		microchip,irq-mirror;
+	};
 };
 
 &i2c5 {
-- 
2.25.1

