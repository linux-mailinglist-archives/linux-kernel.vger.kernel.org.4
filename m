Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC406C5ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCVXnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCVXnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:43:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825D31BD8;
        Wed, 22 Mar 2023 16:42:55 -0700 (PDT)
Received: from p508fd58e.dip0.t-ipconnect.de ([80.143.213.142] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pf84R-0005ZV-Td; Thu, 23 Mar 2023 00:40:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, jonas@kwiboo.se,
        neil.armstrong@linaro.org, alim.akhtar@samsung.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        sw0312.kim@samsung.com, philippe.cornu@foss.st.com,
        linux-rockchip@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, kyungmin.park@samsung.com,
        hjc@rock-chips.com, jernej.skrabec@gmail.com,
        linus.walleij@linaro.org, inki.dae@samsung.com, robh+dt@kernel.org,
        Laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        linux-usb@vger.kernel.org, airlied@gmail.com,
        andrzej.hajda@intel.com
Subject: Re: (subset) [PATCH v6 01/17] dt-bindings: display: rockchip: convert rockchip-lvds.txt to YAML
Date:   Thu, 23 Mar 2023 00:40:40 +0100
Message-Id: <167952842636.1588125.15379043637737791314.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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

On Thu, 22 Dec 2022 15:22:14 +0100, Johan Jonker wrote:
> Convert rockchip-lvds.txt to YAML.
> 
> Changed:
>   Add power-domains property.
>   Requirements between PX30 and RK3288
> 
> 
> [...]

Applied, thanks!

[09/17] ARM: dts: rockchip: rk3288: fix dsi node
        commit: ea2d16f90629e3158307d0183cad5c40aa55c995
[10/17] ARM: dts: rockchip: rk3288: fix lvds node
        commit: 8a19e4c74d17ed8d1e6bc06b32c5b7b7c3b9fcfb
[11/17] ARM: dts: rockchip: rk3288: fix dp node
        commit: 95e2ac6ae9f2330557a6aef70bf15173e1dd9714
[12/17] arm64: dts: rockchip: px30: fix lvds node
        commit: 0d5e24918976edffffee006e07730434a36d264a
[13/17] arm64: dts: rockchip: px30: fix dsi node
        commit: 30322f812d4e0e75e2488c1d45aba94e51dd19bb
[14/17] arm64: dts: rockchip: rk3399: fix dsi node
        commit: f82fe7ad31530b38d2f61aa6ae68bd35c33f4ad0
[15/17] arm64: dts: rockchip: rk3399: fix dp node
        commit: d94024bd6342c6f3e88c5fac785a685c1974d48e
[16/17] arm64: dts: rockchip: rename vbus-supply to phy-supply in rk3566-box-demo.dts
        commit: fc440ea1732abb714150bb8f3d90672ccc679e2d
[17/17] arm64: dts: rockchip: rk356x: remove hclk from dsi node
        commit: cadda005961cd6a202ae6f8ff99f2bba35a31dc8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
