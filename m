Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9A7069BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjEQNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjEQNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:23:18 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BC186;
        Wed, 17 May 2023 06:23:16 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HAbKZK031049;
        Wed, 17 May 2023 15:22:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=jTPH87Tb+bUx2BLBByX1fXA5aTkExn5jyfavMOnhUng=;
 b=YV/qsii8tngsHmq5gQh5thB9QDpKG2M5JZjIlK2mxIVQE7Rt/X+mL6CsP5C7iUEBg+YP
 9HAVmAwJOhBcEynPRc3WvFX5wXFOPq/Jn0V8YIYHCfABMaZ/B0U/TkVTBRvuQ2V3/NUS
 +u/09i3AiYeyL+fsI2IZ8W3CAWKGJ3YAj90x33oGGLMygqhV5eMu8UfCeAbB+92GOgly
 BrrO7ubLYjJ6PLR3kHH1zonvYXFnw2T1AmT93LdZSCbjvJChu1suD1PVr+vloN2vkd7U
 jpURCzp+o9Wgw09W1JJVyKmZ6Gb+FtXkkftrEooLx1SV4E5WS2tMeMZ/C0ZP4BWxEijf jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qmtepjn75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 15:22:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D86B410002A;
        Wed, 17 May 2023 15:22:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CB5C82309C3;
        Wed, 17 May 2023 15:22:46 +0200 (CEST)
Received: from localhost (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 17 May
 2023 15:22:46 +0200
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH 1/3] ARM: dts: stm32: fix warnings on stm32f469-disco board
Date:   Wed, 17 May 2023 15:22:12 +0200
Message-ID: <20230517132214.254757-2-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517132214.254757-1-raphael.gallais-pou@foss.st.com>
References: <20230517132214.254757-1-raphael.gallais-pou@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several warnings appear when building and checking stm32f429 device-tree:

arch/arm/boot/dts/stm32f469-disco.dts:182.28-184.5: Warning (unit_address_vs_reg): /soc/display-controller@40016800/port/endpoint@0: node has a unit name, but no reg or ranges property

.../arch/arm/boot/dts/stm32f469-disco.dtb: dsi@40016c00: Unevaluated properties are not allowed ('panel-dsi@0' was unexpected)
	From schema: .../Documentation/devicetree/bindings/display/st,stm32-dsi.yaml

Fix those.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 5a0daf8e8b11..cbbd521bf010 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -160,7 +160,7 @@ dsi_out: endpoint {
 		};
 	};
 
-	panel-dsi@0 {
+	panel@0 {
 		compatible = "orisetech,otm8009a";
 		reg = <0>; /* dsi virtual channel (0..3) */
 		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
@@ -179,7 +179,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint@0 {
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
-- 
2.25.1

