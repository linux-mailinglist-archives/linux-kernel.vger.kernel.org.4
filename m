Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41366442E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjAJPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbjAJPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:09:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96468CAB;
        Tue, 10 Jan 2023 07:09:09 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFGFL-0005Qm-Pj; Tue, 10 Jan 2023 16:09:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv8 0/7] Initial rk3588 DT
Date:   Tue, 10 Jan 2023 16:09:01 +0100
Message-Id: <167336332945.2556072.3953350646920815870.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109155801.51642-1-sebastian.reichel@collabora.com>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 16:57:54 +0100, Sebastian Reichel wrote:
> This adds initial rk3588(s) DT including three different board
> devicetrees. All required driver changes have been merged into
> Linus tree already. To avoid warnings from
> 
> $ make CHECK_DTBS=y rockchip/rk3588-evb1-v10.dtb \
>   rockchip/rk3588-rock-5b.dtb rockchip/rk3588s-rock-5a.dtb
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
      commit: 1d8d24f725b4bd2c8900ce338e522351cb42b34d
[2/7] arm64: dts: rockchip: Add rk3588 pinctrl data
      commit: d68a97d501f882cb8326d63f972fd6582a6411f0
[3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
      commit: 9fb232e9911f37416228468e6d1760c5ed82a4c8
[4/7] dt-bindings: arm: rockchip: add initial rk3588 boards
      commit: 4e522fea0798fce61e45d7a2e2ec7ab91fe31b79
[5/7] arm64: dts: rockchip: Add rk3588-evb1 board
      commit: 4159826f7c3d87b63f2e7e5b56d8a823542b5fff
[6/7] arm64: dts: rockchip: Add rock-5a board
      commit: a4a8f1afb36057765792349318ae848b9680c2b9
[7/7] arm64: dts: rockchip: Add rock-5b board
      commit: 6fb2d15497867da9a67687735e51d1add0a1486e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
