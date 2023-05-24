Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13070F7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjEXNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjEXNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:40:14 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BAEA7;
        Wed, 24 May 2023 06:40:13 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCgVK1015625;
        Wed, 24 May 2023 15:39:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=G9vvnWSLJsuNooiWQS7kP00jY9mJ1HLWlugGthqt8l8=;
 b=kw38mBeXe5RHnnD2GdW+CYW/6+IGkURLioYttckPR+MDBW3baW8s3rkZXsoFR8UxVMKe
 bVhZVgDacecLIR1WAHvz22378NEpOLJKkSRIz46JHkhpgVCMnYpYW4cpfxVdgOtIdb4l
 fZy+Qh/MRx7705ZBhsAzXHsg13WAcJNUaNIbPMh7yjxFtHXh0PnuE92PoJ2ljyBXnJRM
 J8kz2T9/XI6OL5aPlrvRFU1SW+4FQFxdXlSiArbdQhtzXdyiMqZ1DeWPkDMWyeAVmhC/
 fmdnjVjuIXFnlkI97++n7159L5+eHXV/II6JjECwjvOqwS77RzWpYJjtDNM141rLXJ8N sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qrthk930g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 15:39:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B539100034;
        Wed, 24 May 2023 15:39:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 759CE229A97;
        Wed, 24 May 2023 15:39:49 +0200 (CEST)
Received: from localhost (10.252.20.36) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 24 May
 2023 15:39:49 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] ARM: dts: stm32: add adc internal channels to stm32mp15
Date:   Wed, 24 May 2023 15:39:10 +0200
Message-ID: <20230524133918.1439516-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
References: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.20.36]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index a98ae58e2c1c..9c40b5e679f8 100644
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

