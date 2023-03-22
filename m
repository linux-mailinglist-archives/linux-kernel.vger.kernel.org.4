Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF156C5AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCVXoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCVXnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:43:42 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3830EB0;
        Wed, 22 Mar 2023 16:43:14 -0700 (PDT)
Received: from p508fd58e.dip0.t-ipconnect.de ([80.143.213.142] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pf84R-0005ZV-7W; Thu, 23 Mar 2023 00:40:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Andy Yan <andyshrk@163.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/5] arm64: dts: rockchip: improve support for NanoPi R5 series
Date:   Thu, 23 Mar 2023 00:40:39 +0100
Message-Id: <167952842629.1588125.15840907021514918930.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230318083745.6181-1-cnsztl@gmail.com>
References: <20230318083745.6181-1-cnsztl@gmail.com>
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

On Sat, 18 Mar 2023 16:37:40 +0800, Tianling Shen wrote:
> (gmac, i2s1) for the NanoPi R5S.
> 
> Changes since v1:
> - https://lore.kernel.org/linux-rockchip/20230315160228.2362-1-cnsztl@gmail.com/
> - Added Fixes tag
> - Collected Acked-by tag
> - Fixed a typo error in dt-bindings (board -> boards)
> - Removed non-existent audio node for NanoPi R5 series
> - Updated my E-mail in NanoPi R5C dts
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: rockchip: create common dtsi for NanoPi R5 series
      commit: c8ec73b05a95d9f0969ae0f28dd8799a54fcdfc7
[2/5] dt-bindings: Add doc for FriendlyARM NanoPi R5C
      commit: 7d4fc70351d155699fe41949d16ce696885a4ca8
[3/5] arm64: dts: rockchip: Add FriendlyARM NanoPi R5C
      commit: 05620031408ac6cfc6d5c048431827e49aa0ade1
[4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
      commit: 31425b1fadb2040b359e52ffc24c049a78d56c96
[5/5] arm64: dts: rockchip: remove I2S1 TDM node for the NanoPi R5 series
      commit: 975e9bbad11950fc8276f1fa260d8bf2c341aa41

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
