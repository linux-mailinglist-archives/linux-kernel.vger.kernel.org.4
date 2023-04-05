Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C756D852E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDERqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDERqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:46:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB040CC;
        Wed,  5 Apr 2023 10:46:11 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pk7Ct-0000Me-Pz; Wed, 05 Apr 2023 19:46:03 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/5] Enable I2S support for RK3588/RK3588S SoCs
Date:   Wed,  5 Apr 2023 19:45:58 +0200
Message-Id: <168071663560.3186456.4135827917323406842.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
References: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2023 12:50:49 +0300, Cristian Ciocaltea wrote:
> There are five I2S/PCM/TDM controllers and two I2S/PCM controllers embedded in
> the RK3588 and RK3588S SoCs. Furthermore, RK3588 provides four additional
> I2S/PCM/TDM controllers.
> 
> This patch series adds the required device tree nodes to support all the above.
> 
> Additionally, it enables analog audio support for the Rock 5B SBC, which has
> been used to test both audio playback and recording.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: rockchip: rk3588s: Fix SCMI assigned clocks
      commit: 87810bda8a8472a9a106c6de34a032fb6a4b425b
[2/5] arm64: dts: rockchip: rk3588s: Assign PLL_PPLL clock rate to 1.1 GHz
      commit: b46a22dea7530cf530a45c6b84c03300083b813d
[3/5] arm64: dts: rockchip: rk3588s: Add I2S nodes
      commit: 8ae112a5554fb1580fc5564f8610cef85f2e3f7b
[4/5] arm64: dts: rockchip: rk3588: Add I2S nodes
      commit: 6f48c6f5859296eaf54a55f436db3a248f772e4d
[5/5] arm64: dts: rockchip: rk3588-rock-5b: Add analog audio
      commit: 55529fe3f32d8c2fdb70981f2e151735e090a1e0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
