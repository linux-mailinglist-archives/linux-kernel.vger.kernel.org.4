Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500166FEE67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEKJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:12:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F296E9D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:12:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50db7ec8188so4939363a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683796363; x=1686388363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDUjdj+Iypx9FcQl5FOdB2kP0msJAjTr8nwomYPJ6mY=;
        b=BRhcP4U4WOW6kWSSy8MgyGHENqZQjiqUwKTdvHBaPtcKf4daG31Fd2+X6lHGAZlbuu
         avIkAnYmDWuCHHJj7GdMBn+i+d12/mAW4QP09B2J226LyqAJ4/6STn632gSF807Q1F5R
         QCxrcrlFB5tylXAcVb7Ir1H/9Zsb4Q7ASSq+XUApbLpSeNXAg0AFwtYXmu+BNqGJ4r1C
         rqNr2ldTHfsQzPGihA6x9kbXULyEwE7+sxQrVRbxufd0msQv/uyF22WV8yUf1Ggva7Uu
         uLc5jMv1WK5pSNerA5gRQq620AqoEw7GAptzNfqRXA5xPMx+KiavJ7oxi13UPZo4MXN5
         B7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796363; x=1686388363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDUjdj+Iypx9FcQl5FOdB2kP0msJAjTr8nwomYPJ6mY=;
        b=jF8HTlLC0LeNvYHWpia8Dj6xr3iamRL0QmbPuO5jAcLj57MghkpSYrcguuRKfkwvMP
         gHbOdmSOWqoYudGa7tAcK2MlAtVIS020tlmQeyh9ROC0Q64/LswRLWjzsc5nE+9DKbYR
         rObWK1sdPwHSRv0kPdgSGIRWK6qAchewbRp3Ikd22tnUitcpTHSecb7zGbnxUSZZim+m
         R4JQ6O9FQT5AaMdTZu0JBc/mxwmNXA5ebHtz3W8l+FEun8o0UHjGKJ596EMsRNEgk8fa
         wadPiRCrWumXcrDOhNxYKazkHUZluxL+VFAFm/7DIXcbuhz8BFQAGkM22YpkPGgSc5NH
         d6EQ==
X-Gm-Message-State: AC+VfDySElxzcd/G0/LfTb0Bb2F82H9h3VMAZ1rYk5q/Ktgt+9gUkWtN
        EGCGD2RXGy5/EzrAMObkaHhNDw==
X-Google-Smtp-Source: ACHHUZ4DOKhebB1vHG765Jc1wnpOXsgULcjllpOZUSAXOrc+LK+vlzdVvo6IB+8wnKK4Bm3FthvJmw==
X-Received: by 2002:aa7:d705:0:b0:50d:8c5b:86b with SMTP id t5-20020aa7d705000000b0050d8c5b086bmr15489089edq.21.1683796363264;
        Thu, 11 May 2023 02:12:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b0050c0b9d31a7sm2786457edx.22.2023.05.11.02.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:12:42 -0700 (PDT)
Message-ID: <11ba5878-da04-d4fc-8e22-a20e5986d2ee@linaro.org>
Date:   Thu, 11 May 2023 11:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] riscv: dts: thead: add sipeed Lichee Pi 4A board
 device tree
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230510204456.57202-1-frank.li@vivo.com>
 <20230510204456.57202-3-frank.li@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510204456.57202-3-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 22:44, Yangtao Li wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
> minimal device tree files for the core module and the development
> board.
> 
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
> 
> Cc: Icenowy Zheng <uwu@icenowy.me>
> Cc: Wei Fu <wefu@redhat.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -cleanup `light`
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/thead/Makefile            |  2 +
>  .../dts/thead/th1520-lichee-module-4a.dtsi    | 39 +++++++++++++++++++
>  .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 33 ++++++++++++++++
>  4 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/thead/Makefile
>  create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
>  create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f0d9f89054f8..1e884868ccba 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -2,6 +2,7 @@
>  subdir-y += allwinner
>  subdir-y += sifive
>  subdir-y += starfive
> +subdir-y += thead
>  subdir-y += canaan
>  subdir-y += microchip
>  subdir-y += renesas
> diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/thead/Makefile
> new file mode 100644
> index 000000000000..e311fc9a5939
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_THEAD) += th1520-lichee-pi-4a.dtb
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> new file mode 100644
> index 000000000000..bc5f8677d546
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "th1520.dtsi"
> +
> +/ {
> +	model = "Sipeed Lichee Module 4A";
> +	compatible = "sipeed,lichee-module-4a", "thead,th1520";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x2 0x00000000>;
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <24000000>;
> +};
> +
> +&osc_32k {
> +	clock-frequency = <32768>;
> +};
> +
> +&apb_clk {
> +	clock-frequency = <62500000>;
> +};
> +
> +&uart_sclk {
> +	clock-frequency = <100000000>;
> +};
> +
> +&dmac0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> new file mode 100644
> index 000000000000..86d677175feb
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
> + */
> +
> +#include "th1520-lichee-module-4a.dtsi"
> +
> +/ {
> +	model = "Sipeed Lichee Pi 4A";
> +	compatible = "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead,th1520";

Missing bindings.

Best regards,
Krzysztof

