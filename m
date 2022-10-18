Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A625D602D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiJRNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:46:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45FF61D48
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:46:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w3so9614800qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bk1cdWlqVhbhLyQ5Z0Zwm2RMGNfzdRPJPquTEkxwGHE=;
        b=eTE2CBBoY8P+wFvZ5WJ8YTjFt3XYrDBbVejGXLnQROjLeveblnjTK7tp6+x3PNeyLV
         nl+kC/51un8xz66tWMZFsOfn7l6JOXEdSX4noD/wVmTq59861M7563YIEj36/A4iytgT
         ypqFJKyPaNnb2jA4K2WKMjyYtXYpyyt1xiamShV7Q5mkqy1S1BW9QPCwNSudex4VdPoZ
         CL52impiIZL8J1vI2exlcidmRxw7MzWnn5lqSjfPCQE4wVjsYBd480CRrOukxCQyXq4v
         E0vdLe/zF54VtEl3O+iY22rgkC8XMpaOgZEC904aXAvLSRiPQqIc+h/Xlx2488hMYKmA
         AMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk1cdWlqVhbhLyQ5Z0Zwm2RMGNfzdRPJPquTEkxwGHE=;
        b=sz6Y4sNCFgeZebWhdqjkMPPw/hd3t+UMMMdkrb36XwrCZHFha6qrWHdypRqTcqPknX
         1zE98CayZU9yfaOwI9rlp7mddihcAsrT5kW7je7LC7Wh5jzuYFXJvJjIDTXG/ntNENGr
         K8c3N9i7F6tLKiT26VI6ny4gcj3IHeH2ldwHSL/KaEVh6mYxTLK2PakAjxP738GFnRr3
         /8yVcCfbDQ9dcrJOGivLJwr3GSXgQYfq90FPCzV5HIYNK+2eo03NR0Q5Zl6s+2YpLHrF
         VT1CHntzdEybYWTVLgfJhO2QVufqBEPFhIvnWH64RZgLT8ozACrq3L42FA3OlvU9h8Lv
         4jXw==
X-Gm-Message-State: ACrzQf0hHQK4rSn2zHzmyYCyNt9hxAZYLZut8y+MdThb7NMqTMiuj/bD
        wvy+ib9VUITZTwDtOafPfgA6+A==
X-Google-Smtp-Source: AMsMyM6WvkWA2L2ll4WKjb1TisgOdDzT0tIlfPlXDDEbaY+sefp3eDrCawcJJSviK5xy4qL9wXJecQ==
X-Received: by 2002:a05:622a:164b:b0:39c:ec98:a13 with SMTP id y11-20020a05622a164b00b0039cec980a13mr2131165qtj.339.1666100817866;
        Tue, 18 Oct 2022 06:46:57 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s23-20020a05622a1a9700b003988b3d5280sm2027602qtc.70.2022.10.18.06.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:46:57 -0700 (PDT)
Message-ID: <eb670850-6e97-df7b-cb62-1513f877956a@linaro.org>
Date:   Tue, 18 Oct 2022 09:46:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/3] clk: loongson2: add clock dt-bindings include file
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221018130531.301-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221018130531.301-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 09:05, Yinbo Zhu wrote:
> This file defines all loongson2 soc clock indexes, it should be
> included in the device tree in which there's device using the
> clocks.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS                                 |  6 +++++
>  include/dt-bindings/clock/loongson2-clock.h | 29 +++++++++++++++++++++

Use subject prefixes matching the subsystem (git log --oneline -- ...).

These are bindings.

>  2 files changed, 35 insertions(+)
>  create mode 100644 include/dt-bindings/clock/loongson2-clock.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a162b6fba6fe..3db469f51d74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11914,6 +11914,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>  F:	drivers/clocksource/loongson2_hpet.c
>  
> +LOONGSON2 SOC SERIES CLOCK DRIVER
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-clk@vger.kernel.org
> +S:	Maintained
> +F:	include/dt-bindings/clock/loongson2-clock.h
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/include/dt-bindings/clock/loongson2-clock.h b/include/dt-bindings/clock/loongson2-clock.h
> new file mode 100644
> index 000000000000..23806408fe49
> --- /dev/null
> +++ b/include/dt-bindings/clock/loongson2-clock.h

Filename matching the compatible, so:
loongson,ls2k-clk.h

> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Dual license, like bindings, unless you are not allowed.

> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_LOONGSON2_H
> +#define __DT_BINDINGS_CLOCK_LOONGSON2_H
> +
> +#define	LOONGSON2_REFCLK_100M				0

Drop weird indentation after define.


Best regards,
Krzysztof

