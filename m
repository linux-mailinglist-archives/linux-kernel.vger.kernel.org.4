Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC006892FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjBCJCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBCJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:02:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8692C00
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:02:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so1832860wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2aiCKLplfBwX38ykcuLOaza164bQFv98FeeJ7x8FKo=;
        b=IHQ5dxA3E39PcS7l2mnGFejvdya63XtTLOxXnNaryTsGL35LJ3P+W/+O17cVjN8CBQ
         Vl6p8iCa92W+Bu1vt/TtpQWNT+PWjT9bh1y6rw+cex5hKQXLX43+uKpdpAmdfre6v2mR
         WrrjjAi4C83DWeIGYezsmNofS4KltrsaCgdkqNQCchLxcCbxxslmo1v+8YMSSj5H8wXD
         9lqIogxZrRFuLtDW2Nn/LfXX9oS6pgul6Hhon+6Ok4ZQ+GJsPJ8Y0ZzcCtJkw0O8TWy0
         P2ycUmuIIT4PKBItag7PSuzMiIAiHFtefp0lCHOuQNXyjj7KAg461XnqtG+4ChxQ1vJD
         bXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2aiCKLplfBwX38ykcuLOaza164bQFv98FeeJ7x8FKo=;
        b=r1Yu/eHFaHkS8QCxkGd1owfpCLnPWfOMaahQBsuIKj3NozpkixQy4iVbLkWiFH8lDQ
         GZAlxdWDOP5ZpQuOeUm5Yr163/ONPmKMSXMi61p4iJZ+jaBXEqD8RXFFhu6brBlMUYDx
         U92m6F1igrKjQUpeeBNp0UkP7YLW5vhkEcq8453C8NVPpyYEbhdXaza2TFpk/7XbFNvr
         wEfyceTbyAHeuh5vorA7jLtGbC/986F8ZsvpQJBMrUlLpgPJIgMtxCAXgNV1GIle62Re
         jyKuNBLDBXahKKVMDvPNC84Ivi+dtqMuXy+/JnYLLNRYD8CMCK6icrbqTMUOG6q87W1W
         ifOQ==
X-Gm-Message-State: AO0yUKUDifGwSR0hDMbfcJV1zUTvj8Vs3KU+nUI9peETUf7Uio5qLZvV
        7tRP2nidNEEcAYGIuF/pj/gL4A==
X-Google-Smtp-Source: AK7set8fAEK8Uz2xDND8RKaAbMEMsT8CBVBEB/JVTCIULoPRT91JYLEobcoPWf0bjmDyTEvfWixQTQ==
X-Received: by 2002:a05:600c:4f06:b0:3da:b40f:7a55 with SMTP id l6-20020a05600c4f0600b003dab40f7a55mr3958239wmq.6.1675414955338;
        Fri, 03 Feb 2023 01:02:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b003dc433bb5e1sm2331776wmo.9.2023.02.03.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:02:35 -0800 (PST)
Message-ID: <3c5bda9f-08b9-f2ba-6951-9fc614d4debc@linaro.org>
Date:   Fri, 3 Feb 2023 10:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-4-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203081913.81968-4-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 09:19, William Qiu wrote:
> This adds the mmc node for the StarFive JH7110 SoC.

Do not use "This xxx". Use imperative mode.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> Set mmco node to emmc and set mmc1 node to sd.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>


> +
>  &gmac0_rmii_refin {
>  	clock-frequency = <50000000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 64d260ea1f29..ae1a664e7af5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		sysreg: syscon@13030000 {
> +			compatible = "starfive,sysreg", "syscon";

No:
1. Undocumented.
2. A bit too generic. You should have here SoC specific compatible as
well (either as second or third compatible, if all your SoCs share
register layout).

> +			reg = <0x0 0x13030000 0x0 0x1000>;
> +		};
> +

Best regards,
Krzysztof

