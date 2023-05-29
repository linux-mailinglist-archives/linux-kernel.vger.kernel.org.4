Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7C714C14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjE2O30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjE2O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:29:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C30B5;
        Mon, 29 May 2023 07:29:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3063433fa66so2054587f8f.3;
        Mon, 29 May 2023 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370544; x=1687962544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTTEEvnfaaPFDLZtelR+S5p0shdfiorMDHxF6386O5A=;
        b=bM6ehbQSDwSwxlR9EoZFk1dUdftpBXWcd7WNMJZNrCoh0YijQyz9JywwmLuYzlDYg2
         Tu9hqXUyqkQ3vZjjen8xAJLtMmwOT41YE5M9uPIWu7G3HLqVtu3Z0S75m9G37YBowiSX
         7uVcoJYvkh/YFyOPTtz6R5i6ywywObtF9kUg1fi7JdXWW/2kHce/vq4ibtLyiLLYBBbS
         10H25x/5qeZa18CUecinpUrBvfWgWE+SNd1GkXTpkBcwzDosTTmhfb8tWx8ky+6lYyKY
         pVvjOPmlMdvFZyiiaoqVJVCyf3Oo05ZhlR5ehF2iF0J/wGaS/WA9Quop/LVq3pSW6zv0
         ihvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370544; x=1687962544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTTEEvnfaaPFDLZtelR+S5p0shdfiorMDHxF6386O5A=;
        b=HyFmXRLXdYVWyNMP4rQbfo2YL5DHI/sqB6vd3NuPB3j6vqoC6AWe5+ZAnCOipqxNcy
         Ez/ziT5sjkA//0quIXvfH7uPvzq4rDEX2+kT82aZYALJfbRPC7biLgLATt4H3eU7yVHH
         FD9PVKR4BPCcaSksz15JH1sAQSJw6Oet6G9ZsLw3EaIdISWv+xI7tJyb2J5H+7cXJ1VI
         BKapHgt9YhYwOVt/YY74/VdXtdmxn9o8EFdRyE5cPxHUMUDNBbm+Jo1IqblJjDRa+uch
         xiO79rY4fXBPiQeY+ZmKRfpOYmcvYAau7bs5ynQ1bWCs/aPlJlYNG0ddc5jX0rWZiCIP
         u4bQ==
X-Gm-Message-State: AC+VfDwy2ecO636Vp6zSlU76CsZXlj7L6ootRhuRYNEA5DkBByY1gxjh
        hz+9yNrFOKXPPfRpHjru/wg=
X-Google-Smtp-Source: ACHHUZ6EsftGeGHUcet6VG2Mv98sUSBFG3Qk0gYDcKo3tTcpdr+/G0DaclFN6AwdSdqFJmkpU95GIw==
X-Received: by 2002:adf:f412:0:b0:306:2d3d:a108 with SMTP id g18-20020adff412000000b003062d3da108mr7632655wro.11.1685370544323;
        Mon, 29 May 2023 07:29:04 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bf3-20020a0560001cc300b00307b5376b2csm100309wrb.90.2023.05.29.07.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:29:03 -0700 (PDT)
Message-ID: <9125e52a-614c-5ca2-ca29-654b79ab52c7@gmail.com>
Date:   Mon, 29 May 2023 16:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8192-asurada-hayato: Enable
 Bluetooth
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230424100409.2992418-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230424100409.2992418-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2023 12:04, Chen-Yu Tsai wrote:
> Hayato's Realtek WiFi/BT module has it's Bluetooth function wired to
> UART1.
> 
> Add and enable the relevant device nodes for it.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Applied, thanks

> ---
> Changes since v1:
> - Dropped unreferenced labels
> - Dropped GPIO line name comments
> - Fixed pinctrl node names
> - Dropped "output-enable" property
> - Added spacing between device nodes for consistency
> 
>   .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 81 +++++++++++++++++++
>   1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> index 43a823990a92..6e23428a3ed2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> @@ -40,9 +40,90 @@ CROS_STD_MAIN_KEYMAP
>   	>;
>   };
>   
> +&pio {
> +	bt_pins: bt-pins {
> +		pins-bt-kill {
> +			pinmux = <PINMUX_GPIO144__FUNC_GPIO144>;
> +			output-low;
> +		};
> +
> +		pins-bt-wake {
> +			pinmux = <PINMUX_GPIO22__FUNC_GPIO22>;
> +			bias-pull-up;
> +		};
> +
> +		pins-ap-wake-bt {
> +			pinmux = <PINMUX_GPIO168__FUNC_GPIO168>;
> +			output-low;
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		pins-rx {
> +			pinmux = <PINMUX_GPIO94__FUNC_URXD1>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-tx {
> +			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
> +		};
> +
> +		pins-cts {
> +			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
> +			input-enable;
> +		};
> +
> +		pins-rts {
> +			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
> +		};
> +	};
> +
> +	uart1_pins_sleep: uart1-sleep-pins {
> +		pins-rx {
> +			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-tx {
> +			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
> +		};
> +
> +		pins-cts {
> +			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
> +			input-enable;
> +		};
> +
> +		pins-rts {
> +			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
> +		};
> +	};
> +};
> +
>   &touchscreen {
>   	compatible = "hid-over-i2c";
>   	post-power-on-delay-ms = <10>;
>   	hid-descr-addr = <0x0001>;
>   	vdd-supply = <&pp3300_u>;
>   };
> +
> +&uart1 {
> +	status = "okay";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-1 = <&uart1_pins_sleep>;
> +	/delete-property/ interrupts;
> +	interrupts-extended = <&gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&pio 94 IRQ_TYPE_EDGE_FALLING>;
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8822cs-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_pins>;
> +
> +		enable-gpios = <&pio 144 GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios = <&pio 168 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&pio 22 GPIO_ACTIVE_LOW>;
> +	};
> +};
