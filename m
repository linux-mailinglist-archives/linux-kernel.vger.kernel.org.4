Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C35EF577
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiI2M3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI2M3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:29:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6014A7A8;
        Thu, 29 Sep 2022 05:29:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E9B666022B2;
        Thu, 29 Sep 2022 13:29:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664454558;
        bh=zimh9DQh381qWK4MyyRtrNlPLzCtssF+BcWOFc+p2UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QySTqrCyqCBVBU4OFHxW7HKe0chZQhzYjyJ+XQycfcZcHI4nn+wxRJoq7j3z5gs6u
         1EgFpeqtIvuudLMYvz/SYuZz3yeAPxOVjmLhKb0KlVw+VImZ65mB0WtnKqZM7nCLpa
         8g37zC4czA+UabkChv7nMwvFe7JABszCjBRFNaMH4U14am6tugbO8oRB9IYpX0H4oR
         CG94SWLkP8EoMA8Ywa75CQG8q/Xy5FEwqB+97Ih5JXHfe7090j8zSV4tqw/QSVJuya
         QDe1si8t2/PSt/H/0pg1HjbcEqhYMbbRbN8/LBmlqdbumZG+dIh1lZwbHhNIXUrkBy
         tAsQNPKDkiDQA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] arm: dts: mt7629: Remove extra interrupt from timer node
Date:   Thu, 29 Sep 2022 14:29:00 +0200
Message-Id: <20220929122901.614315-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's only one system timer event interrupt.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm/boot/dts/mt7629.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 46fc236e1b89..acab0883a3bb 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -106,8 +106,7 @@ timer: timer@10009000 {
 			compatible = "mediatek,mt7629-timer",
 				     "mediatek,mt6765-timer";
 			reg = <0x10009000 0x60>;
-			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk20m>;
 			clock-names = "clk20m";
 		};
-- 
2.37.2

