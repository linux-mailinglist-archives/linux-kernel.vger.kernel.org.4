Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFD6D0CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjC3Rbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC3Rbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:31:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C594DBF5;
        Thu, 30 Mar 2023 10:31:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l27so19890507wrb.2;
        Thu, 30 Mar 2023 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680197499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8C7GCDTGTEyH0AOHKmhfixymkIHQz9SRHOuIDmLbko=;
        b=N7u8QTWTvUqZGEVlZfqEizdpr5VUNBM+pV6CnqB/wrVeToff7amDfenDK3fKrdDtb8
         j347QbU+VvKBy+6f7x2UgbwXaH1utnycH4NNASNI8cjP3bMeN8vkxeYkyUX5Q736j+bU
         4MBV7bJpMRlkhUDdK8MDpR8046AaEJl94ZL8TMy2PGb2dGwLvApLMB+XlIE6vOGJYrXN
         dMf7JtFRMExcWGKRUEXpPWXPMzbNy7yqqBJjnN0kxY3XWNw3JJNe/eF7oAewaVuwemex
         VRM3cErDyKIynRzqjCV3Vo++AsyoqPQeScMoU1WZ+UgEo8x6Czs4TARY42tCaLznLh+3
         VIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8C7GCDTGTEyH0AOHKmhfixymkIHQz9SRHOuIDmLbko=;
        b=yLWhYdXnMMysKVPm/EguYdVIKLlez9C8ZdIe5UEoYEMZ9b0F7MGddSqePDxZOT2yFp
         +RmreqDVnf5yPEFjl6XlyhfM8JdbRGrLhbmjROqqW6kAMS2AEP3uKa2EfOoPg2GTfycs
         oC8W2DFbgUYb9NABMByggxM/uvXLZ2ENW+rF+mGmcCtgpIrV9DAEG4FMKMmYpop8UAGC
         Zfhh145O/svmAd7pTMIr1pUjkQDAkdQLEGxSTgiVtGvXgxnWKx+0EYrGBfUk37t0GXWg
         YA+vEX/nBoD6AtSTsXHeJbjIb2kprJUUkJ+6pRcU63K79/QF0b4B52C3qwAoQqY5auWi
         7PfA==
X-Gm-Message-State: AAQBX9coALg/M7U+UZPiYMUwDh0IwkatFVcMvombFw16QpTJXRrhilyK
        xZTg8SudWzOJMrIEUSnnisU=
X-Google-Smtp-Source: AKy350bTdpoUHIsagb+4BTrzzRfsNOzsybVTgw+GzV1DuXqyaLBQbEtimDuEJgScEaHe1uFKXxi+aQ==
X-Received: by 2002:a5d:6e90:0:b0:2e4:efd9:987a with SMTP id k16-20020a5d6e90000000b002e4efd9987amr2151856wrz.69.1680197499507;
        Thu, 30 Mar 2023 10:31:39 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600000c100b002e51195a3e2sm1408157wrx.79.2023.03.30.10.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:31:38 -0700 (PDT)
Message-ID: <fa3d3f99-59f4-7397-7a7b-e342ed39dd00@gmail.com>
Date:   Thu, 30 Mar 2023 19:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 12/17] arm64: dts: mediatek: add ethernet support for
 mt8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-12-0003e80e0095@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v3-12-0003e80e0095@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 10:54, Alexandre Mergnat wrote:
> This IP is a 10/100 MAC controller compliant with IEEE 802.3 standards.
> It supports power management with Energy Efficient Ethernet and Wake-on-LAN
> specification. Flow control is provided for half-duplex and full-duplex
> mode. For packet transmission and reception, the controller supports
> IPv4/UDP/TCP checksum offload and VLAN tag insertion.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index a67eeca28da5..394a5a61be59 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -438,6 +438,18 @@ mmc2: mmc@11250000 {
>   			status = "disabled";
>   		};
>   
> +		ethernet: ethernet@112a0000 {
> +			compatible = "mediatek,mt8365-eth";
> +			reg = <0 0x112a0000 0 0x1000>;
> +			mediatek,pericfg = <&infracfg>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_ETH_SEL>,
> +				 <&infracfg CLK_IFR_NIC_AXI>,
> +				 <&infracfg CLK_IFR_NIC_SLV_AXI>;
> +			clock-names = "core", "reg", "trans";
> +			status = "disabled";
> +		};
> +
>   		u3phy: t-phy@11cc0000 {
>   			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
>   			#address-cells = <1>;
> 
