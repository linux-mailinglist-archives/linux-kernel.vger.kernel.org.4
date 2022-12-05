Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C495564283C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiLEMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLEMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:16:52 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC32F6;
        Mon,  5 Dec 2022 04:16:50 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B594s1A015968;
        Mon, 5 Dec 2022 13:16:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Hk0qo1XRLFhMLS/W/NChuc+KR14nw7WA60tebfIgFrE=;
 b=wgQm86HJun4Er+xLx3GsDYCCtyvYi+jnhwiE6z5Vb5Edv2uIDmzQkk1AqlIlZfXEioSX
 QGNj4+NSWz9yUvw6zeW2Wdh5IrKtkotwNdkT+0dtN3ebzV1Czu4grbUdToTV93vlaPV3
 +FG6W5EB2p00ImZlYdto6CzlOOwWJ7cMAmX5R75o/hmMGKACCehQNIa6yYYoLVla4BKr
 f5g78K+bEjxzQ2uEYrAf6lLzmmoUtySGoMNmHPGfn4mfrYaHFE4RVx6l+tLNilIg65yi
 a37mtnHrtG4daSs9kISmxncSLvyDFZQZC/TIl8ZgixDE3EB0LE0xuwuJgLpSZy864TrY TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m7vfejdb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:16:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3A9B100034;
        Mon,  5 Dec 2022 13:16:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9DF3021ED31;
        Mon,  5 Dec 2022 13:16:28 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 5 Dec
 2022 13:16:28 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: dts: stm32: remove sai kernel clock on stm32mp15xx-dkx
Date:   Mon, 5 Dec 2022 13:16:01 +0100
Message-ID: <20221205121602.17187-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205121602.17187-1-olivier.moysan@foss.st.com>
References: <20221205121602.17187-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove clocks property in the SAI2A subblock node as this property
is already defined in the SoC DT.
Keep only this property when the master clock is added in the node.

Fixes: 144d1ba70548 ("ARM: dts: stm32: Adapt STM32MP157 DK boards to stm32 DT diversity")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 7798a2e17c5c..8b9a39cd2698 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -501,8 +501,6 @@ &sai2 {
 	sai2a: audio-controller@4400b004 {
 		#clock-cells = <0>;
 		dma-names = "tx";
-		clocks = <&rcc SAI2_K>;
-		clock-names = "sai_ck";
 		status = "okay";
 
 		sai2a_port: port {
-- 
2.25.1

