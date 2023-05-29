Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6538A714BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjE2OXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE2OXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:23:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5B1A7;
        Mon, 29 May 2023 07:23:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f623adec61so34625365e9.0;
        Mon, 29 May 2023 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370196; x=1687962196;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bhf+dGpQh+ihyXe3XoXHHkBL1Gb6jd21i/gahvLFjMw=;
        b=F4NVhqLpqy0ymn9TqPQDAV8TTMtXMZWrO0bmMg7bbOwxqlahco0kddrAEqh4PD9Lx1
         hfieb5Nvcw01NXhOHu3235hE0MDhCaAabAVUtD6yaXYyS26PAh2pl2O5U/rJLFG6y2bl
         vk8OYgNQLT7sA7zhjWgS3ORF1XoJn5fUDRYjvPVvAUC9hmbrZwb6JTDATzLSbP1UqjRl
         0xqCV3JZIySH7+PTHwa5kdU45sO+3sKEImTz2TxgGK8YM0L+9DYG9qURJKKygWYXqBtI
         3t6+E6XR+Wi1AvhwdVtIuFipJEUwaUfRQolh2bFRjC27AFATwycUmwpIp/0O58Eplirp
         NRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370196; x=1687962196;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhf+dGpQh+ihyXe3XoXHHkBL1Gb6jd21i/gahvLFjMw=;
        b=lvBBYn0940551p5N/GeYugLDcD05QM/R4ZGviYCTOjHfUehUGW873GFwS+xYmfzwso
         nEb9eDlDlHv1FPjXXmmihDy9QzeJQrU/O9cQBV9i2cxNvA0ux0n+xHnbsI+PAAmE8tIN
         kffnd7EDQyUgWt/PUpR9utHE224/kWu7YmpTX5FwehR26X6CBrJwTIsb2a9cF2N8girS
         3XwxrQQhY63zf9poIxzgwp7TYglI/Se1F6foqUBP3zJpywL+t+WHElREdP4+0KkbBgXA
         ywmmilFiN5npW2/9U6qbN8GHtU/pe2y4zDRDZdWYIEndS/qU5441VyQ3/hbAn+cli9Zx
         3qjg==
X-Gm-Message-State: AC+VfDwL0K4VUai1drzIlWsAxHnqOT/vkIFvWvFVkjC9zufe2Gv71crN
        ebJ0BTYrmJl14psxHuzFB1g=
X-Google-Smtp-Source: ACHHUZ5nwRk8NJZ4CqJmbHbZwW+mE2Fld12sMvifhdfTJBxdSDT+RaNQcnm4R3EJqXtTfjM30+ty7Q==
X-Received: by 2002:a05:600c:284a:b0:3f6:3d8:aabb with SMTP id r10-20020a05600c284a00b003f603d8aabbmr9133115wmb.38.1685370196332;
        Mon, 29 May 2023 07:23:16 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003f42d8dd7ffsm14441605wmd.19.2023.05.29.07.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:23:15 -0700 (PDT)
Message-ID: <64b7c2ed-ccbe-8313-8a46-1adf57deb0df@gmail.com>
Date:   Mon, 29 May 2023 16:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] arm64: dts: mt7622: declare SPI-NAND present on
 BPI-R64
Content-Language: en-US, ca-ES, es-ES
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <ZEA96dmaXqTpk8u8@makrotopia.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ZEA96dmaXqTpk8u8@makrotopia.org>
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



On 19/04/2023 21:15, Daniel Golle wrote:
> The SPI-NOR node in the device tree of the BananaPi R64 has most likely
> been copied from the reference board's device tree even though the R64
> comes with an SPI-NAND chip rather than SPI-NOR.
> 
> Setup the Serial NAND Flash Interface (SNFI) controller, enable
> hardware BCH error detection and correction engine and add the SPI-NAND
> chip including basic partitions,
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Applied, thanks

> ---
>   .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 39 ++++++++++++++++---
>   1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index af3fe61e40938..d583e816684cf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -248,14 +248,42 @@ &nandc {
>   	status = "disabled";
>   };
>   
> -&nor_flash {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi_nor_pins>;
> -	status = "disabled";
> +&bch {
> +	status = "okay";
> +};
>   
> +&snfi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&serial_nand_pins>;
> +	status = "okay";
>   	flash@0 {
> -		compatible = "jedec,spi-nor";
> +		compatible = "spi-nand";
>   		reg = <0>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		nand-ecc-engine = <&snfi>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "bl2";
> +				reg = <0x0 0x80000>;
> +				read-only;
> +			};
> +
> +			partition@80000 {
> +				label = "fip";
> +				reg = <0x80000 0x200000>;
> +				read-only;
> +			};
> +
> +			ubi: partition@280000 {
> +				label = "ubi";
> +				reg = <0x280000 0x7d80000>;
> +			};
> +		};
>   	};
>   };
>   
> 
> base-commit: 13961ef828cbc254cc272221b7fc54851caa39a7
