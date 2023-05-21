Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312BD70ADAF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjEULqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjEUKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:46:38 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17319F;
        Sun, 21 May 2023 03:45:09 -0700 (PDT)
Received: from [91.65.34.120] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q0gYe-0008By-Qn; Sun, 21 May 2023 12:45:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 0/2] media: rockchip: rga: Add rk3568 support
Date:   Sun, 21 May 2023 12:44:58 +0200
Message-Id: <168466589373.900480.8086350880534437090.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 10:14:21 +0100, Michael Tretter wrote:
> The RGA2 on the Rockchip rk3568 is the same core as the RGA2 on the Rockchip
> rk3288.
> 
> This series adds the necessary device tree binding and node in the device tree
> to enable the RGA2 on the Rockchip rk3568.
> 
> I tested the driver with the GStreamer v4l2convert element on a Rock3 Model A
> board.
> 
> [...]

Applied, thanks!

[1/2] media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
      commit: 9b12ceb5a80d1fb45d293265de100e33b5843943
[2/2] arm64: dts: rockchip: Add RGA2 support to rk356x
      commit: 0c3391f8bb06b744df521651534cd99e3d77e0a8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
