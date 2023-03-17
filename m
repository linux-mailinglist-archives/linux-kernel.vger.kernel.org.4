Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3CC6BE92E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCQM2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCQM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:28:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D183B21D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:28:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so19554531edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679056084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4NJZTZucxQIhmv+yhQCHkUP4VMj8aSUUr6DI8AUneE=;
        b=l3HbbDmGhWJkfrjdeVRql3v6S18wD3xSANEHfyxftEs99S0h1gdT4hA2xMdVFe04f0
         GdpH+F77m2VruQr7DBdj9iphFo/oK3n3KN/tpIHMXOEdIs21miF+chuVuGQBqj32B7ym
         mcQk7e9I44HH9wgpZyV4R1bjc57w1HCnYtK38NQAldVN2NjPvGMzRNm/m5PLnlYMysHu
         VOhb34OheGo7T3hFViX3Dl6be3FSj0HLF539spYWEQU0KihI5Xje3+iBjO32mLXTtaoq
         FICKqui1l3X2IOOslxWckIWWKfCFFIPoQIYPyvG507Ir6hx20nDUS8OrZp/fAEeLflmq
         8JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4NJZTZucxQIhmv+yhQCHkUP4VMj8aSUUr6DI8AUneE=;
        b=HQs4L+yEXCeNzts0Yl1faR0yR3yRQM+Pop4wbGo+6Vn66bjs//p/WmGY9Zj9k1peoB
         zJkO4HVVY/UFgjQw9IdCAMnUDaaGms+9MEP4zwfctFAmQs1iecqa5MT1HEIM1qsbrKut
         GBOuAGfiJLYXsEH7Jf+cx7sGdQM6UNvl/IDTrRY66Oxs8wdB9r9JINLf+kDrlaGH5ZHU
         NUpwarb1BDiC5aY5mKTkvV5RQm+LDurKWSaG2eWKbyLT5yq5LcnLanMt3AMhTB9QrK3P
         C4pW7x12pV6HC2zhjAvb6nkY7ISwU+iq79rFM1AR6LFXiHP5Q0hQPOQTP8KhdrWD2M8o
         A+dQ==
X-Gm-Message-State: AO0yUKU4KJ5C3uZbXcI5OigKC13wZ6bNElvgyrKvjllRv4LVvZqrFc4D
        rWIX8aEHGNAOyEFy4zQfVNbUdQ==
X-Google-Smtp-Source: AK7set9t/UoX9hFHOcngKEhZnhSWZjQqE2c9vms2p3PISVzTQWVOpgxYc5pqcHwBaTzITEMiLULNzw==
X-Received: by 2002:aa7:dbd8:0:b0:4ae:e5ab:46d7 with SMTP id v24-20020aa7dbd8000000b004aee5ab46d7mr2667687edt.8.1679056084346;
        Fri, 17 Mar 2023 05:28:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id u20-20020a50a414000000b004fd1ee3f723sm1002701edb.67.2023.03.17.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:28:03 -0700 (PDT)
Message-ID: <216262b8-fe48-6696-17a4-eaa82e776db7@linaro.org>
Date:   Fri, 17 Mar 2023 13:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] ARM: dts: exynos: add mmc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Valentine Iourine <iourine@iourine.msk.su>
References: <20230316211558.8526-1-henrik@grimler.se>
 <20230316211558.8526-3-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316211558.8526-3-henrik@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 22:15, Henrik Grimler wrote:
> Add aliases for eMMC, SD card and WiFi where applicable, so that
> assigned mmc indeces are always the same.
> 
> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> [ Tested on exynos5800-peach-pi ]
> Tested-by: Valentine Iourine <iourine@iourine.msk.su>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 



>  	chosen {
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index bba85011ecc9..7051e2c4b391 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -25,6 +25,12 @@ memory@40000000 {
>  		reg = <0x40000000 0x40000000>;
>  	};
>  
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;

Here...

> +	};
> +
>  	chosen {
>  		stdout-path = "serial2:115200n8";
>  	};
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 1103e7f92b57..1970c31410e5 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -30,6 +30,11 @@ memory@40000000 {
>  		       0x70000000 0x10000000>;
>  	};
>  
> +	aliases {
> +		mmc0 = &sdhci_0;

here ....

> +		mmc2 = &sdhci_2;
> +	};
> +
>  	chosen {
>  		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>  		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> index 181c99eca675..cb74af41e17c 100644
> --- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
> +++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> @@ -25,6 +25,10 @@ memory@40000000 {
>  		reg = <0x40000000 0x80000000>;
>  	};
>  
> +	aliases {
> +		mmc2 = &sdhci_2;
> +	};
> +
>  	chosen {
>  		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>  		stdout-path = "serial1:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index b8e9dd23fc51..b6b0c116016c 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -26,6 +26,12 @@ memory@40000000 {
>  			0x70000000 0x10000000>;
>  	};
>  
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;
> +	};
> +
>  	chosen {
>  		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
>  		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 140abfb38e1d..f42cfcbcdcfa 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -24,6 +24,12 @@ memory@40000000 {
>  			0x50000000 0x10000000>;
>  	};
>  
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;


Why this is 2? Aliases are continues and match the board. For example
Universal calls this mmc1 and the next mmc2, not 3.

I bet it is the same on Trats and all other boards.

> +		mmc3 = &sdhci_3;
> +	};
> +
>  	chosen {
>  		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>  		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> index 6260da187e92..0e5419c0eaff 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -20,6 +20,10 @@ / {
>  	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
>  	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
>  
> +	aliases {
> +		mmc2 = &sdhci_2;

mmc1

> +	};
> +
>  	chosen {
>  		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
>  		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> index ca8d42b2ce3b..7bc6968af9c3 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> @@ -23,6 +23,10 @@ memory@40000000 {
>  		reg = <0x40000000 0x40000000>;
>  	};
>  
> +	aliases {
> +		mmc0 = &mshc_0;
> +	};
> +
>  	firmware@203f000 {
>  		compatible = "samsung,secure-firmware";
>  		reg = <0x0203f000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index 82aed59cba7c..e6b949c1a00f 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -25,6 +25,9 @@ / {
>  	aliases {
>  		i2c11 = &i2c_max77693;
>  		i2c12 = &i2c_max77693_fuel;
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;

This is actually correct.

>  	};
>  
>  	chosen {
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 25e082fda955..45ef7b7ba7e0 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -13,6 +13,11 @@
>  #include "exynos-mfc-reserved-memory.dtsi"
>  
>  / {
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;

This is also correct.

> +	};

For all other cases, where schematics are missing, just make them linear.

Krzysztof

