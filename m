Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC49071661C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjE3PFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjE3PEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC34118;
        Tue, 30 May 2023 08:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B98630FF;
        Tue, 30 May 2023 15:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181E2C433AE;
        Tue, 30 May 2023 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685459067;
        bh=QnEoh+X+SgNcIBxD5KzNnV5xmRN1TrKhb2ZElCWGT+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3jWOhPweOzR2ItjP8ZU+908Aay1KcouvnvGiVgboQaHDLkc0/4LNgMeFKx4X94T/
         Gp4aM6Fv0bxhFIuCsdWeqHbtcuIBymKu4iv0saqyg7A7J4Dx4hypkXKRKe9/nPQU3e
         ZZ0WCXNWC8FHoTBGTALmgCKcCrhhuZcRKuhNGjzMBkbkMpRyuGofpNZQTjMnaA3rql
         UAwIsY/DFwamgl6nb2/h0D7KwTV5axTLimNDik/dAq3qkq4OgmUOykOmxkl0/qoFqh
         7Hsmo23aIkJ7CQgMwh/CqLsFhKR3IZwEx+EwjRBA0eDRUt8kRy4dODFixGHdZ07yrx
         BsTXkPms8MBsg==
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
Subject: [PATCH 2/2] arm64: dts: mt8173: Update thermal node
Date:   Tue, 30 May 2023 17:04:13 +0200
Message-Id: <20230530150413.12918-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530150413.12918-1-matthias.bgg@kernel.org>
References: <20230530150413.12918-1-matthias.bgg@kernel.org>
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

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..44c553bddd46 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -270,7 +270,7 @@ cpu_thermal: cpu-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 
-			thermal-sensors = <&thermal>;
+			thermal-sensors = <&thermal 0>;
 			sustainable-power = <1500>; /* milliwatts */
 
 			trips {
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

