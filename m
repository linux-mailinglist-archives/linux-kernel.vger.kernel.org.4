Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E662E3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiKQSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbiKQSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:10:25 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E6D07FC37
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:10:18 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vjL5ohRGp6OFPvjL7oOWCi; Thu, 17 Nov 2022 19:10:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668708617; bh=TunP+sNI/iwJaqSthpPKk5YqWTsD/jwLXjblNZmP/zg=;
        h=From:To:Subject:Date:MIME-Version;
        b=IvWz/2BcnY2cLPL21+XHUtsxM/5eaLcvfp9e4RnIohPvN+XLBpY9buR7QTrjoqolR
         Vv8Al24j3uyMr3wkUtIQXS0GLD02BnPz0VEMc4s7XYjbIBvX5xeeUchavoxfHrUQrE
         /BCwKr97dghfLx/kdW6t4HEY/0GAO+31SXvHpXG7mp0f0B59XNPWWbQhWkHH52uEew
         OAro44LkLc3EHlGR16xkL5VtQz8h185dXjtkPswQqqQmVOqA7oFlDpis11Wn8LSoo8
         U6qRKyN2PS68G+GUp9NymWNKJpLlvkhMVcdkSOIiREX3G1Bxrr5oTCzzQnvUgQ+b0T
         biFtszRHD2zSg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Bough Chen <haibo.chen@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 3/4] ARM: dts: imxrt1050: increase mmc max-frequency property
Date:   Thu, 17 Nov 2022 19:10:13 +0100
Message-Id: <20221117181014.851505-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
References: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEE49uSxiBV+RGJO+gQCg6h7mt/LyknWLfUC6aIGaUyVvKOBQHPfG+wBs7BhUwq0fZdbLBURrhtwH5Qee+u3UASwgMH7q2Bg2uJFXthwNn56WoQSB48l
 ph49s3hRTGxhGlP1n20qrzaFGbHWNlD397RNfHjN4Snf8cbdON7Ak84kntWX2//tKgoh3AyLVW25DbTDE3zAXPcMBttvbNcg6ganmTHaXiPw0GIHpL6pemuo
 TMMxMw2ZQGoAJliEMGo+Y3R4spKXnoNyNRsDqq6hgKthU4Hus8o2exwoQfAWEgOmm7th9yzywciWYudvJZLH0iudW+3tvTJH2/pqgZGNwW8RlSrFCu0WS2g2
 hoOwHgRtdRxLZs16RqY0vwC4Daxe4JnRy/6XwkLUzwqlJiyPx99t9UlRjybb7D7kna2Ji4TLdJRBqk7zqXCenvWERvXOd7GkrLkU8oz0wP/FoUt8mo1u5lyW
 1VAM4Vb7O9U8IJhgiTWKWPHO6/W2C5Y+nE5GAMrhm08j6V9/58rGfQxJYKWhOau4r9yjXPYX1YBEj8NFuhxvnlVK1hpbv+6TJyZAkR4uHrF9+GY5OhQz1oS0
 mD7qDGJ85e9O95kEtot3dFkr8rv0ykmxxOzVrBrE64oBMKI+dymFBHNvKxh0lyikSn/xA7+CLCkwJiTsxLQ9Q8FJn9GOEc1xOZwacf/xbpP0QI0WWObZ39nU
 6RcNBuWoE1QyHp2oAsUwMS1DQd2QkbJnxTq2p9z5QWa+uq4Mtqv9NBxR1so2iXyKhQO0l/Rkd5wnL5i0+s8zzxYEZqoi2GbWX0Ns+7514yaLn+rwZP/7BA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
let's increase max-frequency property to 200Mhz.

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Jesse Taube <mr.bossman075@gmail.com>
---
V1->V2:
* set max-frequency to 200Mhz instead of removing it as suggested by
  Bough Chen
V2->V3:
* added Jesse Taube's Acked-by:
V3->V4:
* nothing done
---
 arch/arm/boot/dts/imxrt1050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 114465e4dde6..5b1991c32748 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -93,7 +93,7 @@ usdhc1: mmc@402c0000 {
 			bus-width = <4>;
 			fsl,wp-controller;
 			no-1-8-v;
-			max-frequency = <4000000>;
+			max-frequency = <200000000>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step = <2>;
 			status = "disabled";
-- 
2.34.1

