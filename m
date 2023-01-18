Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7079672040
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjAROyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAROyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:54:00 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F4C847ED3;
        Wed, 18 Jan 2023 06:48:07 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,226,1669042800"; 
   d="scan'208";a="146745763"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jan 2023 23:48:06 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 227E1400B9E3;
        Wed, 18 Jan 2023 23:48:02 +0900 (JST)
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
Subject: [PATCH 2/3] arm64: dts: renesas: v2mevk2: Add PWC support
Date:   Wed, 18 Jan 2023 14:47:46 +0000
Message-Id: <20230118144747.24968-3-fabrizio.castro.jz@renesas.com>
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

The RZ/V2M EVK uses the PWC IP to control external power supplies
and the I/O voltage for the uSD card.

This patch enables the PWC node, and it also enables the poweroff
features since PWC is actually used to control the board power
rails.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index 11e1d51c7c0e..d6737395df67 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -80,6 +80,11 @@ i2c2_pins: i2c2 {
 	};
 };
 
+&pwc {
+	renesas,rzv2m-pwc-power;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.34.1

