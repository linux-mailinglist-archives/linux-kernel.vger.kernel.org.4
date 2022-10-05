Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9145F5071
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJEHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJEHsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:48:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0055BC36;
        Wed,  5 Oct 2022 00:48:38 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ofz8t-0007vf-3a; Wed, 05 Oct 2022 09:48:35 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux.amoon@gmail.com, Chukun Pan <amadeus@jmu.edu.cn>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        michael.riesch@wolfvision.net, robh+dt@kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Rename pinctrl label of pcie2x1 on rock-3a
Date:   Wed, 05 Oct 2022 09:48:34 +0200
Message-ID: <2128313.Icojqenx9y@diego>
In-Reply-To: <20220926180102.37614-3-amadeus@jmu.edu.cn>
References: <20220926061420.1248-1-linux.amoon@gmail.com> <20220926180102.37614-1-amadeus@jmu.edu.cn> <20220926180102.37614-3-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. September 2022, 20:01:01 CEST schrieb Chukun Pan:
> Distinguish it from the pinctrl label of pcie3x2 added later.
> Also added comments to the pcie2x1 node.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index 8adf672709e8..1b195355da2a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -539,8 +539,9 @@ rgmii_phy1: ethernet-phy@0 {
>  };
>  
>  &pcie2x1 {
> +	/* M.2 slot */
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_reset_h>;
> +	pinctrl-0 = <&ngffpcie_reset_h>;

please always try to use pin-names as they are in device-schematics.
I.e. if the reset-pin is named pcie_reset_h there, it should stay that way.
Following schematics names makes looking up things way easier.

Heiko

>  	reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie>;
>  	status = "okay";
> @@ -582,7 +583,7 @@ pcie_enable_h: pcie-enable-h {
>  			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  
> -		pcie_reset_h: pcie-reset-h {
> +		ngffpcie_reset_h: ngffpcie-reset-h {
>  			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> 




