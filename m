Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D56748846
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGEPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGEPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:45:29 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B11723;
        Wed,  5 Jul 2023 08:45:28 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365CFucx003266;
        Wed, 5 Jul 2023 17:45:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=XyC5FyMVMPnTU1hmmczheNZBiuJQrxdm92Tn12ZD3T4=;
 b=fDWc4J/Azt50qwdGhGJdZg+PxoYFohoGvQWcCISV+JgQ5nCtXh7kFN+Udw0oyjnNDIP0
 GeevSuOuD1YFjLMFZ3vecEdtvRAY22HXmnJfoSidXyqL4+ZeLOiMKRKpKLMLKgH28bpV
 CQF441ZjSZHfw9oXEatN62J3nMP0kBTrn0wjaM4RvUh8jW9W2ucHH3+C3WxDWSCo74YX
 9fTzXOnX3TBfiUPR1wskqP+GjzA38e/HzDocYxC80VKO3aKq9D3Yj/ZhxVcrHzDs/FKe
 WKFsei+6w4uvD6sbbgx3FY5qS+7WCudFv4sU6BYLRCwMXQCDvSGeM+OAtgFucaIv4TN0 ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rn8c9shar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 17:45:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 797FB100057;
        Wed,  5 Jul 2023 17:45:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 713B3236948;
        Wed,  5 Jul 2023 17:45:07 +0200 (CEST)
Received: from localhost (10.48.1.0) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 17:45:07 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     Christophe PRIOUZEAU <christophe.priouzeau@st.com>,
        Etienne CARRIERE <etienne.carriere@foss.st.com>,
        Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/2] ARM: dts: sm32mp: remove shmem for scmi-optee on stm32mp13
Date:   Wed, 5 Jul 2023 17:44:59 +0200
Message-ID: <20230705174358.2.Icb84b08e0e668cd81dddb8d206e9bcd33af9aea8@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230705154459.1194895-1-patrick.delaunay@foss.st.com>
References: <20230705154459.1194895-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.0]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_07,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFG_STM32MP1_SCMI_SHM_SYSRAM will be disabled by default for STM32MP13x
SoCs in future OP-TEE version and the OP-TEE SMCI server uses only
the OP-TEE native shared memory registered by clients.

To be compatible by default with this configuration this patch removes
the shared memory in the SCMI configuration and the associated reserved
memory in SRAM.

Fixes: 9005aeddd9fc ("ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP13")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/boot/dts/st/stm32mp131.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index d163c267e34c..d23bbc3639df 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -40,7 +40,6 @@ scmi: scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			linaro,optee-channel-id = <0>;
-			shmem = <&scmi_shm>;
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
@@ -106,19 +105,6 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		scmi_sram: sram@2ffff000 {
-			compatible = "mmio-sram";
-			reg = <0x2ffff000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x2ffff000 0x1000>;
-
-			scmi_shm: scmi-sram@0 {
-				compatible = "arm,scmi-shmem";
-				reg = <0 0x80>;
-			};
-		};
-
 		timers2: timer@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.25.1

