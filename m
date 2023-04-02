Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC96D36B3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDBJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDBJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:51:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7347EDB;
        Sun,  2 Apr 2023 02:51:06 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA5BE660313D;
        Sun,  2 Apr 2023 10:51:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680429065;
        bh=otwKTZ+LUzkWr51HoDAAyTXvgoa041tRNRUmqfxmfo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpvJMONWIUvQWf/Pz9uUmvEgABMS/2S1rppOj3+jUUu39V/rxYeVArTa5QS46wSpd
         I0m6Lz60eeCxZ3/lP3LNl5lRLSEwa18qlhLe0NW/JiL+fIfREKsF6x/xrWcI7AsWHt
         ROV6ZYdp9OVgx8AN2hhdEneFJHqQ8X7tqHLNPkpNRZoMZUqBXevDS5Sw2e1il/LI3X
         rZyyHWa7zIzAVAXtYVTOMCpT0GvdutwRXbEw2wveUj7voH8ZTuE8SxCMHS/RMucY28
         wToN5ELgGariQp6SHSaT3874opD0gZUJ+WurAoZgYGLgR4iVYIO9nrpPt/46JrWB9s
         bj/fVoSisjGLA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 2/5] arm64: dts: rockchip: rk3588s: Assign PLL_PPLL clock rate to 1.1 GHz
Date:   Sun,  2 Apr 2023 12:50:51 +0300
Message-Id: <20230402095054.384739-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
References: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock rate for PLL_PPLL has been wrongly initialized to 100 MHz
instead of 1.1 GHz. Fix it.

Fixes: c9211fa2602b ("arm64: dts: rockchip: Add base DT for rk3588 SoC")
Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 028dc62f63ce..e3546cfacc88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -425,7 +425,7 @@ cru: clock-controller@fd7c0000 {
 			<&cru ACLK_BUS_ROOT>, <&cru CLK_150M_SRC>,
 			<&cru CLK_GPU>;
 		assigned-clock-rates =
-			<100000000>, <786432000>,
+			<1100000000>, <786432000>,
 			<850000000>, <1188000000>,
 			<702000000>,
 			<400000000>, <500000000>,
-- 
2.40.0

