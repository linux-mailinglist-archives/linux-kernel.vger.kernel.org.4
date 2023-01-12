Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C1667040
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjALKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjALKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:54:23 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715C5D42E;
        Thu, 12 Jan 2023 02:45:50 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C7tWiD003642;
        Thu, 12 Jan 2023 11:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=qbOSelrgo9ly75B1lL3nGqofuIGQTzSwK46itLRhY8Q=;
 b=YrU5GeLY1ekJUP8XoXw0SUa06tUY9KT9xrim9N8l3WcDarGrGsUodfsuKjE3j8jZBGjg
 egMqtvr+4yuNojbzzOpdOs4rjxpB2eMtHHUZx4JcwU34+WepF8UU3KMxxJZCcarnaw6m
 BIYsCUPRtH7RupMem5woeCSRfy8Z157EP3uhs71DYLwryppqYnj8Rx9R5HYdsn8AZWTW
 w8gQvnENoKkMvRiacq5d8AAWJt8lEFBlMv5Q+n9rHXI+omU3EyxJEaPcGWwv1cHhgEGS
 mns+P2coGHbv034OoEYYyTGoTUkXE49eoV8FCrtPN4HmNcADHQtBoHkN1KZT4btzAeaG iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n1k64j6xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:45:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1043C100034;
        Thu, 12 Jan 2023 11:45:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08651214B12;
        Thu, 12 Jan 2023 11:45:05 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 12 Jan
 2023 11:45:04 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/10] ARM: dts: stm32: add adc internal channels to stm32mp15
Date:   Thu, 12 Jan 2023 11:44:36 +0100
Message-ID: <20230112104446.1140551-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
References: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 ADC2 internal channels VREFINT and VDDCORE to STM32MP15x SoCs.
VBAT internal channel is not defined by default in SoC DT, and
has be defined in board DT when needed, instead. This avoids unwanted
current consumption on battery, when ADC conversions are performed
on any other channels.

The internal channels are defined in STM32MP15 SoC DT according to the
generic IIO channel bindings. The STM32 driver does not support a mixed
use of legacy and generic channels. When generic channels are defined,
legacy channels are ignored. This involves that the board device trees
using legacy bindings for ADC2, have to be reworked.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 4e437d3f2ed6..dea1c53f2b1d 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1093,6 +1093,8 @@ adc: adc@48003000 {
 			adc1: adc@0 {
 				compatible = "st,stm32mp1-adc";
 				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x0>;
 				interrupt-parent = <&adc>;
 				interrupts = <0>;
@@ -1104,12 +1106,22 @@ adc1: adc@0 {
 			adc2: adc@100 {
 				compatible = "st,stm32mp1-adc";
 				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x100>;
 				interrupt-parent = <&adc>;
 				interrupts = <1>;
 				dmas = <&dmamux1 10 0x400 0x01>;
 				dma-names = "rx";
 				status = "disabled";
+				channel@13 {
+					reg = <13>;
+					label = "vrefint";
+				};
+				channel@14 {
+					reg = <14>;
+					label = "vddcore";
+				};
 			};
 		};
 
-- 
2.25.1

