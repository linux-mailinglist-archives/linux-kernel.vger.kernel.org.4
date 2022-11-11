Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B3625667
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiKKJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:16:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66026C18;
        Fri, 11 Nov 2022 01:16:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs21so5658397wrb.4;
        Fri, 11 Nov 2022 01:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jovw191tkqhEY/091trHnhlrx/URL9SGNNv7OLPeWTQ=;
        b=QZ4qUEYywU25+PgljwAk53ASLfWTPNIIJylvWVU4Y8JyQX9plUYn0ALvKbih/5RMPE
         GvSYY90MsMVyO4vtRwyieahWlG2iWiNESdeN572tvMSzNAOL8xKRoy1BbamgRnG/jblx
         Uy+x5C3JondEUg6F1GniqGmCeP/nKKXnXTKsBMlL6QRSyfSiA2yIjml1ZVWGdCb6r5t7
         gu4gLkxEXy4Rp9IFqrJjApbZmZMkMlMQV5rezaNZ+NHfSkfqwE1wMCsKb5fpRJtyk19v
         vo/RqVu0A7hEROSQdZaCsQw1bdLzFu3Pd3WgiSYbsCsId8CCP4M+Z64UlISJ0EuLvPkZ
         kCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jovw191tkqhEY/091trHnhlrx/URL9SGNNv7OLPeWTQ=;
        b=WWXKULgeveXiIFCpogs2T/bkWAnbRgEEOnYQ+XNUyheP/qXIqGT3ajlzBUp3d73lJA
         48lVOIzb+npzqBRBWh/q0RWz/jXtAP6l0FBKfmyppt+5zcAb2zpx/e015wk+BOTBKdJ9
         JxQkKDRRJaJnjhsGKie3U74cnnfRaKXMnhg7qSAENH8PA7v+i5Gyu57CL+Mz9NCVpaN1
         /ohcDnGOPP/7zSDAo3zNJOsPm1Gl09xlXlWRPfcgdyzke20B7PpjNIz4QEHnRFgOXY+z
         lPXwAP+j8DaskST6nUxfCmd+pTBwrN+yxPCe3+EJhtMY9smkdAtrGB27GOovxMNrdeym
         98Ig==
X-Gm-Message-State: ANoB5pmqOMbuY2ZESWL3WQGj3I11KJSYuLv6+30tOdYk0Mvi0eNPKbdD
        q1sxgPq3MYqD/w4Tt5Eior0=
X-Google-Smtp-Source: AA0mqf4WOo4GYRvJTD5FEYyn6wAGMohgHK1JIfF6SWmlWvK2hyBZhFpiw9mF2RR/u7NBQe9HXADfWA==
X-Received: by 2002:a05:6000:181c:b0:236:60ce:7c10 with SMTP id m28-20020a056000181c00b0023660ce7c10mr673951wrh.440.1668158205774;
        Fri, 11 Nov 2022 01:16:45 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003b49bd61b19sm8545557wmb.15.2022.11.11.01.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:16:44 -0800 (PST)
Message-ID: <5ece2b19-cbc7-5ecf-c29a-8f0258f260f4@gmail.com>
Date:   Fri, 11 Nov 2022 10:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-12-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RFC v3 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
In-Reply-To: <20221106085034.12582-12-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, Krzysztof,

On 06/11/2022 09:50, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add devicetree overlays for using nand and nor on BPI-R3.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>   .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts | 53 +++++++++++++++
>   .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  | 67 +++++++++++++++++++
>   3 files changed, 122 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index e8902f2cc58f..d42208c4090d 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo

Do we allow the inclusion of overlays in the kernel?
I don't think so. I see there are some dtbos for some freescale platforms, but I 
wasn't aware that we support that. I thought it is all about dtsi includes.

@frank In any case we would need to apply these overlays to some base board to 
create a valis dtb.

Regards,
Matthias

>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
> new file mode 100644
> index 000000000000..e12ff825bb50
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +//dtc -O dtb -o bpi-r3-nand.dtbo mt7986a-bananapi-bpi-r3-nand.dts
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	fragment@0 {
> +		target-path = "/soc/spi@1100a000";
> +		__overlay__ {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			spi_nand: spi_nand@0 {
> +				compatible = "spi-nand";
> +				reg = <0>;
> +				spi-max-frequency = <10000000>;
> +				spi-tx-buswidth = <4>;
> +				spi-rx-buswidth = <4>;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition@0 {
> +						label = "bl2";
> +						reg = <0x0 0x80000>;
> +						read-only;
> +					};
> +
> +					partition@80000 {
> +						label = "reserved";
> +						reg = <0x80000 0x300000>;
> +					};
> +
> +					partition@380000 {
> +						label = "fip";
> +						reg = <0x380000 0x200000>;
> +						read-only;
> +					};
> +
> +					partition@580000 {
> +						label = "ubi";
> +						reg = <0x580000 0x7a80000>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
> new file mode 100644
> index 000000000000..f11ffd9c4bce
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +//dtc -O dtb -o bpi-r3-nor.dtbo mt7986a-bananapi-bpi-r3-nor.dts
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	fragment@0 {
> +		target-path = "/soc/spi@1100a000";
> +		__overlay__ {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <10000000>;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition@0 {
> +						label = "bl2";
> +						reg = <0x0 0x20000>;
> +						read-only;
> +					};
> +
> +					partition@20000 {
> +						label = "reserved";
> +						reg = <0x20000 0x20000>;
> +					};
> +
> +					partition@40000 {
> +						label = "u-boot-env";
> +						reg = <0x40000 0x40000>;
> +					};
> +
> +					partition@80000 {
> +						label = "reserved2";
> +						reg = <0x80000 0x80000>;
> +					};
> +
> +					partition@100000 {
> +						label = "fip";
> +						reg = <0x100000 0x80000>;
> +						read-only;
> +					};
> +
> +					partition@180000 {
> +						label = "recovery";
> +						reg = <0x180000 0xa80000>;
> +					};
> +
> +					partition@c00000 {
> +						label = "fit";
> +						reg = <0xc00000 0x1400000>;
> +						compatible = "denx,fit";
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
