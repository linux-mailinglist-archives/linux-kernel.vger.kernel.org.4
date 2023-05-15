Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA672702BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjEOLzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbjEOLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:55:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5104198C;
        Mon, 15 May 2023 04:47:53 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6C2066031D7;
        Mon, 15 May 2023 12:47:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684151272;
        bh=gC9khueYFVlcT6fg7HFJBZZwpElbVhh1z3v4MU1CT/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NKbuU6L7Uz+jyOotfNx5+vzlXJriCbWSdbDVU+1C0lAtivWSdCUF4JqhsYruos4Jx
         YkJLbqJeQUpv3sVftOzVv7KQgVYTlxw4EksOioiVW+ECdU5okiXXnJPQkKRDjbyqiv
         OtMF7l86XnSFFNGtV5oR9iHr4OeBrYh67crJU6MmPIbsPADEk92MxzGHSVfQQ4wjXp
         nOoaam388J03D/qMC01QClwDppFHvjKJTFVPvB0NoIZCPPy69HCRVs9JMxNDB0ZkWt
         py1thIMwkC2PDGaOPPw4f/ST3a5eMmOQXQ5+uEmJppLSYtq6kM2Un/JJHGPh0uC11s
         xVFlulKkVJHDA==
Message-ID: <c6ea1360-9ca7-783e-0d0f-f5100fd8d024@collabora.com>
Date:   Mon, 15 May 2023 13:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 08/11] arm64: dts: mediatek: add ethernet support for
 mt8365-evk
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
 <20230203-evk-board-support-v7-8-98cbdfac656e@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v7-8-98cbdfac656e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/05/23 18:29, Alexandre Mergnat ha scritto:
> - Enable "vibr" and "vsim2" regulators to power the ethernet chip.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 57 +++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index 3a472f620ac0..cf81dace466a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -88,6 +88,28 @@ optee_reserved: optee@43200000 {
>   	};
>   };
>   
> +&ethernet {
> +	pinctrl-0 = <&ethernet_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&eth_phy>;
> +	phy-mode = "rmii";
> +	/*
> +	 * Ethernet and HDMI (DSI0) are sharing pins.
> +	 * Only one can be enabled at a time and require the physical switch
> +	 * SW2101 to be set on LAN position
> +	 */
> +	status = "disabled";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
>   &i2c0 {
>   	clock-frequency = <100000>;
>   	pinctrl-0 = <&i2c0_pins>;
> @@ -137,12 +159,47 @@ &mt6357_pmic {
>   	#interrupt-cells = <2>;
>   };
>   
> +/* Needed by analog switch (multiplexer), HDMI and ethernet */

What part of the ethernet HW needs this regulator?

> +&mt6357_vibr_reg {
> +	regulator-always-on;
> +};
> +
>   /* Needed by MSDC IP */
>   &mt6357_vmc_reg {
>   	regulator-always-on;
>   };
>   
> +/* Needed by ethernet */

Same question for this one. If a device needs us to turn on a regulator in
order for it to be powered (read: if the supply is not fixed-on), setting
that supply as always-on is not beneficial for anyone, as eventually in a
power-off sleep/idle/whatever-pm state, this device (whole chip or IP) *will*
leak some amount of power.

If hardware engineers decided to connect a device to a supply that *can be*
shut down entirely there must be a reason, right? :-)

Regards,
Angelo

