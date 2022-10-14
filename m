Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71A5FEBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJNJ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJNJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:29:21 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E11C69C3;
        Fri, 14 Oct 2022 02:29:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E8RvOT008870;
        Fri, 14 Oct 2022 11:29:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=2se13OJgjqc6mstx1UlgNzGBVKCreXyw+niB7+v7+Tg=;
 b=VNionGbiyiiIINDYmer920zUMaTsN2pEtSey9HxCUbYgs22SsItn62bTto/Kbn3efup4
 MqMtGQxp6+x9yMIviCfjhNQ6qsazzXxf8+reUh6qwV/r3KUZRmcBF75xCFtLuyLOEQh6
 isqXFRkfR5nNZuZwMagcTLC7AE/oxJtAqtMcSMKFlhEEfeab5sQU93cuDFu0qT0vwZdX
 wOf5cp4oEwQyzlLgnolDyl+CBHL4ZphlDCtsRxYCwG+lRrbW7DssRzfr/6xPOrKvYsqR
 ybLwYRB6KI1m+v3QyQwIW6z/HBXCCqxgLgnq6q0XDj0ch1f7rBymN0paeSkyArTTkv7B AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k6h7v7gtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 11:29:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79F9E100034;
        Fri, 14 Oct 2022 11:29:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 753A321A904;
        Fri, 14 Oct 2022 11:29:00 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 11:28:59 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 08/10] ARM: dts: stm32: add pins for stm32g0 typec controller on stm32mp13
Date:   Fri, 14 Oct 2022 11:26:49 +0200
Message-ID: <20221014092651.25202-9-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio pin configuration to be used with stm32g0 typec controller. Define
the PI2 to enable internal pull-up on stm32mp13, used as interrupt pin on
stm32mp135f-dk board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
index efdd163eba30..5c85c9fc583c 100644
--- a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
@@ -165,6 +165,13 @@ pins {
 		};
 	};
 
+	stm32g0_intn_pins_a: stm32g0-intn-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 2, GPIO)>;
+			bias-pull-up;
+		};
+	};
+
 	uart4_pins_a: uart4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('D', 6, AF8)>; /* UART4_TX */
-- 
2.25.1

