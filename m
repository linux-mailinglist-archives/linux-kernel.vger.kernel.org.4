Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60467203B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAROyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjAROx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:53:58 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC5AB4DCEF;
        Wed, 18 Jan 2023 06:48:02 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,226,1669042800"; 
   d="scan'208";a="149830468"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jan 2023 23:48:02 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id ED3A44007209;
        Wed, 18 Jan 2023 23:47:58 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 1/3] arm64: dts: renesas: r9a09g011: Add PWC support
Date:   Wed, 18 Jan 2023 14:47:45 +0000
Message-Id: <20230118144747.24968-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com>
References: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M SoC contains an External Power Sequence Controller (PWC)
module. This module provides an external power supply on/off
sequence, on/off signal for the LPDDR4 core power supply, General
Purpose Outputs, and key input signals.

This patch adds PWC support to the SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index b0c066c5e0ba..b5d6f7701ef1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -178,6 +178,14 @@ cpg: clock-controller@a3500000 {
 			#power-domain-cells = <0>;
 		};
 
+		pwc: pwc@a3700000 {
+			compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc";
+			reg = <0 0xa3700000 0 0x800>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+		};
+
 		sys: system-controller@a3f03000 {
 			compatible = "renesas,r9a09g011-sys";
 			reg = <0 0xa3f03000 0 0x400>;
-- 
2.34.1

