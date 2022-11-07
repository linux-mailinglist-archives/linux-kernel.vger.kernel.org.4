Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041D361ECE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiKGI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiKGI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:29:29 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C7A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:29:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id be13so15730175lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 00:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+G+Z3fRjw+YmVPah8QnDEbPwrQNevzGVNtku2Zteqko=;
        b=p/Ivu84VjaM2s6AOOjS2hGlpuazO2Ifv/qX1ZLT5UgyP37/xADglycLuhgfyqSjppS
         a85YRL3hjoYVYNjpEANZEBQw4A3ra2/S7Lx6eI6Jxqdk0+oqUWkAK5LDMKqRGsEMPASK
         9X+itdiBrXDbpxpEPygy9iOHvWAk9xvIVOpGy2sVlc1/Un5ZBNaOP5Xuej51L9khne6P
         jz8jfGaPMEzTRoSyt7ACKf3kXdxiFGoj3PnGkfjAY3/uVsdBpoB7DevdXZDv9Z+m9dxa
         RBnjjk27Yt3Mbme5DRNBNyc+yAG6pQaAJrXQIx4t7K9kfoYc2emH1pPLWY+fPCjEb9JP
         TpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+G+Z3fRjw+YmVPah8QnDEbPwrQNevzGVNtku2Zteqko=;
        b=K9CD/KC3R2DX2BSlVymEp7hR58tu+t6Fwwb61G9wVuEo1J4wfalMRY2R5oT7Cu+VAD
         C1k1O6TAo1UatfrA3KDCoAZ/rvLcHEXNCN7s/JF9edpYmXOYoZi1T3jlWNZLD746pBwA
         3AdwzHiX3+3eBW7NBWTK/D5mh0zEF9mkinVry08faUPbYy2P9EqNoyB/Ma0RLV05tXdt
         6DfGAK1tsySdjtf4Rjaj/O21WiW43sMxoGzq9i+rvWDmMlJGCpsQgiRppaNdoE8U9a5N
         mPxx+AnXYxOxFRhAGZNttMvCGoN1esqcwMISSeIV3zzH0BkthvdHqH9KQTXbhJm07O4c
         lOkw==
X-Gm-Message-State: ACrzQf0rLTPBOHEheQwxsmDZhlySNmyH3mz3+mCWVRgPtoktx4cUHEQr
        3y81qoSQHA6pFDu63TIK5QPCDA==
X-Google-Smtp-Source: AMsMyM4itr+2Ipxo0hSi6ESJOXGaPvYia4F+z40sfL+6uusvTHsZiF9bFWl1BTOgHUrh5IA2WU92fQ==
X-Received: by 2002:ac2:5dd5:0:b0:4a2:2960:a855 with SMTP id x21-20020ac25dd5000000b004a22960a855mr18201090lfq.399.1667809766713;
        Mon, 07 Nov 2022 00:29:26 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512201100b004a26b9cea32sm1114789lfb.271.2022.11.07.00.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 00:29:26 -0800 (PST)
Message-ID: <334c5f69-2f25-aeb1-b87f-500cf2a6c205@linaro.org>
Date:   Mon, 7 Nov 2022 09:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: allwinner: a64: add device tree for SoPine with
 clusterboard
Content-Language: en-US
To:     renze@rnplus.nl, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
References: <b3b8320f0d2b54a0557331977582d05c@rnplus.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b3b8320f0d2b54a0557331977582d05c@rnplus.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2022 22:40, renze@rnplus.nl wrote:
> The Pine64 clusterboard needs a to have the tx delay changed to
> 500ps for ethernet to work. This solution was described by multiple
> people on the Pine64 forum years ago and nobody has submitted it.
> 
> Add a device tree for SoPine with the clusterboard.
> 
> Signed-off-by: Renze Nicolai <renze@rnplus.nl>
> ---
>   arch/arm64/boot/dts/allwinner/Makefile                 |  1 +
>   .../dts/allwinner/sun50i-a64-sopine-clusterboard.dts   | 10 ++++++++++
>   2 files changed, 11 insertions(+)
>   create mode 100644 
> arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile 
> b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..15b011d1aaea 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += 
> sun50i-a64-pinephone-1.2.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-early-adopter.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-clusterboard.dtb

This does not look like matching indentation of other entries...

>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
> diff --git 
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts 
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> new file mode 100644
> index 000000000000..6f8020a22670
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2022 Renze Nicolai <renze@rnplus.nl>
> +
> +/dts-v1/;
> +
> +#include "sun50i-a64-sopine-baseboard.dts"

You miss compatible and model. You need to document the compatible in
bindings (just like other top-level).

> +
> +&emac {
> +       allwinner,tx-delay-ps = <500>;
> +};

Best regards,
Krzysztof

