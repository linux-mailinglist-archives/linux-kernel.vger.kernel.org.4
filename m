Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75270719E94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjFANox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjFANor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA7F13E;
        Thu,  1 Jun 2023 06:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F4463958;
        Thu,  1 Jun 2023 13:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DABC433A4;
        Thu,  1 Jun 2023 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685627085;
        bh=q6w4UUDjOmOOezIJ0otzADnOnzbMQRuEIJyRnoatvfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KL+9vHOICSZeUlx4L7ytO0wuNrH/rOWgGlc6ATUHpY9KIUFIRL9s5W/lB/1eRaVrk
         +G+YsHCFcUspFilEYonT5Vm4NHn1Wm5cOQmRUOm5qEZwFaUkrPH28pvPctqYWeuYtF
         XaLre8ws8zN1UAjO7VSiyakQ0j9Wcm02aK6ng7Fn1v0lW+os/XxyT+Lt7t4RClTV/W
         qZsM7Gibgru0dz2mNKn71IAPc3r//1kEzxqZkTKNXeeIBFYb7JU+34yZHl8tXQnluU
         8wl9V6Rp65gbjDXBJpB3X5FyI/tPnxFf/qH18ML6XcLoLPICXQOVUuaTUTAr4MFFZK
         URWzjzitA4caQ==
From:   matthias.bgg@kernel.org
To:     rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Update thermal node
Date:   Thu,  1 Jun 2023 15:44:25 +0200
Message-Id: <20230601134425.29499-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134425.29499-1-matthias.bgg@kernel.org>
References: <20230601134425.29499-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Following the binding description, update to use
thermal-sensor-cells = 1
While at it also fix the node name of the CPU critical trip point.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

Changes in v2:
- fix node name of CPU critical trip point

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..d760776e3daf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -270,7 +270,7 @@ cpu_thermal: cpu-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 
-			thermal-sensors = <&thermal>;
+			thermal-sensors = <&thermal 0>;
 			sustainable-power = <1500>; /* milliwatts */
 
 			trips {
@@ -286,7 +286,7 @@ target: trip-point1 {
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit0 {
+				cpu_crit: cpu-crit0 {
 					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -766,7 +766,7 @@ spi: spi@1100a000 {
 		};
 
 		thermal: thermal@1100b000 {
-			#thermal-sensor-cells = <0>;
+			#thermal-sensor-cells = <1>;
 			compatible = "mediatek,mt8173-thermal";
 			reg = <0 0x1100b000 0 0x1000>;
 			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
-- 
2.40.1

