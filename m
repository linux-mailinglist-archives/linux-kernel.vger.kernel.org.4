Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18B714CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjE2PQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjE2PQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:16:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C957F4;
        Mon, 29 May 2023 08:16:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so22240205e9.2;
        Mon, 29 May 2023 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685373376; x=1687965376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEDO+a+YPral4I5ZXkXL8wMMW0VCrN+c97/tzuL0GN8=;
        b=rAQIHkyW6IDpCq9889HHVKoSWyLk0Ibot+4kAvFIdt1TKrOvAdJD8DjDvzEZdTDnv8
         JmLjiDIqMF8Lh8mJUUPr0kX+vbhjKSKblSBI7mcPRXILPQx++M1ye46m+5KkPYmHnAKK
         ykNeSq7kGIzrmC50PoWgKB6qKI3Dag+1vhyyLVH4WFlvMFkBjDteW+JvUPZKPkU2szhi
         N6LnPlam4c6gTVrK9cx6KKFX5CJtUYPz1pICEqYlWcVYer7K1LeF73Pouec2YTQW3940
         ASPu8M/wOIVRTGuwpmY16aMLgxv8B9TUJqAH8JJisrFas/pFeSh89oQmRDfN3sp46jcH
         piGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373376; x=1687965376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEDO+a+YPral4I5ZXkXL8wMMW0VCrN+c97/tzuL0GN8=;
        b=jb67/i2yybdR7WT3GrJcC+XQDVKm73WAMgqDlbOFZg4RwsM2KfySNttcHv5TYwNjec
         TLt3UvQBNl3gK6avZXQa+uQwVywwTRrwQDxmbQBiVVZCUSgBDZaWPHkESzbdlZDoPDGm
         6Ah+p0cxbE/ZXkdkT6hTP/Dsmm7CQccOGa42t0UqhBLU1NbbWQEKLLXWpQxoNFBV4r08
         Tkqbc2pwVBboqgaMUbyltL/5+RZ6Ar3A1L08bpwMCRorB/3jqoj2exWNBmBGKqNgJjkD
         +CiK4QENR2LEZj1P4ZmKCIVfMBP9fJPUDDdhHZi1EeLf0hkbQq128bHr+XqO7mNtJ/rl
         60kg==
X-Gm-Message-State: AC+VfDz35YUj63hta7ao2KmiSfIHZum1slIBP/qlOtQNKAszzTDvKP+Z
        tBPKbQc47BKneyxKAQIo5KM=
X-Google-Smtp-Source: ACHHUZ50VJaTqxMFcaBPdgiY9mNb8sRIl+m7Dmc+x0Z3oYT5paV5NJfLUU/bUgMoDPmZDl1mpo+2bg==
X-Received: by 2002:a7b:cd15:0:b0:3f6:5cbf:a3a1 with SMTP id f21-20020a7bcd15000000b003f65cbfa3a1mr9093367wmj.14.1685373375676;
        Mon, 29 May 2023 08:16:15 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c028200b003f42cc3262asm18127550wmk.34.2023.05.29.08.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:16:14 -0700 (PDT)
Message-ID: <091dcf39-b186-056d-4bdf-d4ac5d24682e@gmail.com>
Date:   Mon, 29 May 2023 17:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: cherry: Enable PCI-Express
 ports for WiFi
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2023 13:25, AngeloGioacchino Del Regno wrote:
> On the Cherry platform, a MT7621 WiFi+Bluetooth combo is connected
> over PCI-Express (for WiFi) and USB (for BT): enable the PCIe ports
> to enable enumerating this chip.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thanks

> ---
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index adbda4dccdd5..eca5df85fe33 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -565,6 +565,13 @@ flash@0 {
>   	};
>   };
>   
> +&pcie1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_pins_default>;
> +};
> +
>   &pio {
>   	mediatek,rsel-resistance-in-si-unit;
>   	pinctrl-names = "default";
> @@ -959,6 +966,24 @@ pins-vreg-en {
>   		};
>   	};
>   
> +	pcie0_pins_default: pcie0-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
> +				 <PINMUX_GPIO20__FUNC_PERSTN>,
> +				 <PINMUX_GPIO21__FUNC_CLKREQN>;
> +				 bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_pins_default: pcie1-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO22__FUNC_PERSTN_1>,
> +				 <PINMUX_GPIO23__FUNC_CLKREQN_1>,
> +				 <PINMUX_GPIO24__FUNC_WAKEN_1>;
> +				 bias-pull-up;
> +		};
> +	};
> +
>   	pio_default: pio-default-pins {
>   		pins-wifi-enable {
>   			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
