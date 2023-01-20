Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8A675072
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjATJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjATJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:15:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E1917E9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:14:48 -0800 (PST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1pInTf-0001QK-8T; Fri, 20 Jan 2023 10:14:27 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH RESEND 0/2] media: rockchip: rga: Add rk3568 support
Date:   Fri, 20 Jan 2023 10:14:21 +0100
Message-Id: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1bymMC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDQ0NL3aJsY1MzC92i9ETdFMMkg2QgME+yMFICakhKLE7VTSpKzEvOAGnJ
 TSwuSS0CSRQUpaZlVoBtiVYKcg129XNRiq2tBQC8oywVfQAAAA==
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.11.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RGA2 on the Rockchip rk3568 is the same core as the RGA2 on the Rockchip
rk3288.

This series adds the necessary device tree binding and node in the device tree
to enable the RGA2 on the Rockchip rk3568.

I tested the driver with the GStreamer v4l2convert element on a Rock3 Model A
board.

This is a RESEND including the linux-media list, as Heiko asked for an
Acked-by from someone from media.

Michael

To: Jacob Chen <jacob-chen@iotwrt.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

---
Michael Tretter (2):
      media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
      arm64: dts: rockchip: Add RGA2 support to rk356x

 Documentation/devicetree/bindings/media/rockchip-rga.yaml |  4 +++-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                  | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
change-id: 20230119-rk3568-rga-d1b0cccc7b82

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>
