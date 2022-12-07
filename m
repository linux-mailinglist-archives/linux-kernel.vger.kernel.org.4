Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B4645D63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLGPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLGPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:14:58 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9C61517
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:14:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so29212475lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/NtXR99YY/YnD6oXE1Csk2UNFUAjboD1pCOokVrfPfA=;
        b=fnwxWVsZQarOW1g820iNU+J4Hfp4bvS/sVpkweWbQfS0GISHHYMqRhJSq15oSaBsTQ
         7nswqkdmM01rF5SmW55qYHdVK/HTsrrin66Wh3jEL69myZXFH7ebBnRWTN+IveYfSfY5
         ELrg3kdK1l+N86IMI8fbKGj0VjgvZkeYO4trktUIw0IkUj2r9rjrS6uwse6Vp2Bp7xHV
         KnFrzkv6Inp0lj3L+fbvHLiBbszVxxc61m67g2TCjdD2qybaXvstb601hH7T57iQJbUj
         WCGYbE42nm0e2Z+oCjmujlYTVPByZJZCiJ1IYRyVftVYTEB7C8B4GsTDTt0G/5KclvGF
         oxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NtXR99YY/YnD6oXE1Csk2UNFUAjboD1pCOokVrfPfA=;
        b=RQuQlxW2Ya+Xj+HdvCnxWa+sKdrLMiE07WXvHr0idwZgn2zdiSNNTRNZcApluxRaBO
         nHKawu5KRU6D6iCT0e26tw18uyX12dk31PI/NK9kNULasS+NDiB3cImovcDtkuF0jy+Y
         cBuADVOkdEuhObdcxce1HEdy4KFuVwfYjDfOk6f8BwdbI5KIT2gQ3l1p48fvyGqsh+dD
         h+llfCbNMxWTBNY9klNK5omAnKmjD5HAtjZbhCrTSTacoTzYUaLHbLNXFyA7RjLprfDP
         WgKJoSoYv971jde+j6ntv/9VzrdhzbCoPDVtnCa61AC5FiQWHXCz/my3J84j7VO00gbw
         ishQ==
X-Gm-Message-State: ANoB5pmz2r3VfOIT3TNrOfKK7eqQN2qUyRwMMukcTs3ZVcluwkPdtzaS
        DUEt7Dn7qlA1jYfQ1hypCltIqw==
X-Google-Smtp-Source: AA0mqf547wAIdfMLEczotwwPA5Zt/mVZpkdrWuFBMjOjByvhXT3cbXDKWUguS0TF5BEOaPkSWX+Pzw==
X-Received: by 2002:ac2:4acf:0:b0:4b5:699e:6e9d with SMTP id m15-20020ac24acf000000b004b5699e6e9dmr5243135lfp.91.1670426094907;
        Wed, 07 Dec 2022 07:14:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e13-20020ac24e0d000000b004946b549a19sm2898207lfr.45.2022.12.07.07.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:14:54 -0800 (PST)
Message-ID: <c0b84752-443f-d935-0ed8-c8ed4d212c2e@linaro.org>
Date:   Wed, 7 Dec 2022 16:14:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-4-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207131731.1291517-4-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 14:17, William Qiu wrote:
> This adds the mmc node for the StarFive JH7110 SoC.
> Set sdioo node to emmc and set sdio1 node to sd.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> index c8946cf3a268..6ef8e303c2e6 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> @@ -47,6 +47,31 @@ &clk_rtc {
>  	clock-frequency = <32768>;
>  };
>  
> +&sdio0 {
> +	max-frequency = <100000000>;
> +	card-detect-delay = <300>;
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	post-power-on-delay-ms = <200>;
> +	status = "okay";
> +};
> +
> +&sdio1 {
> +	max-frequency = <100000000>;
> +	card-detect-delay = <300>;
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	broken-cd;
> +	cap-sd-highspeed;
> +	post-power-on-delay-ms = <200>;
> +	status = "okay";
> +};
> +
>  &gmac0_rmii_refin {
>  	clock-frequency = <50000000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index c22e8f1d2640..e90b085d7e41 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		sys_syscon: sys_syscon@13030000 {

No underscores in node names, generic node names (syscon or
system-controller)

> +			compatible = "syscon";

This is not allowed alone.

> +			reg = <0x0 0x13030000 0x0 0x1000>;
> +		};
> +
>  		gpio: gpio@13040000 {
>  			compatible = "starfive,jh7110-sys-pinctrl";
>  			reg = <0x0 0x13040000 0x0 0x10000>;
> @@ -433,5 +438,38 @@ uart5: serial@12020000 {
>  			reg-shift = <2>;
>  			status = "disabled";
>  		};
> +
> +		/* unremovable emmc as mmcblk0 */
> +		sdio0: mmc@16010000 {
> +			compatible = "starfive,jh7110-sdio";
> +			reg = <0x0 0x16010000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> +				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +			clock-names = "biu","ciu";
> +			resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> +			reset-names = "reset";
> +			interrupts = <74>;
> +			fifo-depth = <32>;
> +			fifo-watermark-aligned;
> +			data-addr = <0>;
> +			starfive,sys-syscon = <&sys_syscon 0x14 0x1a 0x7c000000>;

This does not match your bindings at all. "&sys_syscon" is a phandle,
not a number of tuning retries, as you expect in your bindings.


Best regards,
Krzysztof

