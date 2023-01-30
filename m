Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4068043B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjA3DPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjA3DPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:15:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A091BF6;
        Sun, 29 Jan 2023 19:15:29 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30U3FAx7048529;
        Sun, 29 Jan 2023 21:15:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675048510;
        bh=TR1CxKzS2lEZabrt9Fmyh10P7iKJoWA2rNtNpq8RqM4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pkIdf++rgtDV55v/aF0mdDc7srAmC8CZHN1tUEdYw8DQOhGZEgWAuV2+XnuSRcUz1
         jNJZ8OXXPz5lBK2YJWh75z/bCF1uTaCMQRhz4j9yrgC0IGtsBcL9otUG0IGNfluVG8
         ewz7JNryX+X3Yncgyem4WC17gIgu8uU7yPFQwnYw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30U3FAr9091112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 29 Jan 2023 21:15:10 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 29
 Jan 2023 21:15:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 29 Jan 2023 21:15:09 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30U3F94c083498;
        Sun, 29 Jan 2023 21:15:09 -0600
Date:   Sun, 29 Jan 2023 21:15:09 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: ti: use "okay" for status
Message-ID: <20230130031509.qpsiuaaxhxwdhhwm@unwarlike>
References: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:18-20230127, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred for status property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/da850-evm.dts         | 2 +-
>  arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>  arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

[...]

> diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
> index 5d6d074011df..abd5aef8b87d 100644
> --- a/arch/arm/boot/dts/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
> @@ -159,7 +159,7 @@ partition@1 {
>  };
>  
>  &mdio {
> -	status = "ok";
> +	status = "okay";
>  	ethphy0: ethernet-phy@0 {
>  		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
> index 88be868cf71e..3a87b7943c70 100644
> --- a/arch/arm/boot/dts/keystone-k2g-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
> @@ -534,7 +534,7 @@ tlv320aic3106: tlv320aic3106@1b {
>  &dss {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&vout_pins>;
> -	status = "ok";
> +	status = "okay";
>  
>  	port {
>  		dpi_out: endpoint {
> diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> index 4352397b4f52..1f762af6f502 100644
> --- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> @@ -183,7 +183,7 @@ partition@1 {
>  };
>  
>  &mdio {
> -	status = "ok";
> +	status = "okay";
>  	ethphy0: ethernet-phy@0 {
>  		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
> index 1c880cf8fa91..3a69f65de81e 100644
> --- a/arch/arm/boot/dts/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
> @@ -132,7 +132,7 @@ partition@1 {
>  };
>  
>  &mdio {
> -	status = "ok";
> +	status = "okay";
>  	ethphy0: ethernet-phy@0 {
>  		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
>  		reg = <0>;
> -- 
> 2.34.1
> 

For keystone:
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
