Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8A602C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJRM6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJRM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:58:44 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A60733FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:58:42 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f8so8524721qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucYx/ZcxAj0eqxJBkJHSbfr6EoLtOwM0SF55iwWJYL8=;
        b=pTm0RraJW+fpnsbad+JBth4Blr70EJ7OMUeqvgXjtN0jrE50Jhb1da/1oacQ9P3ybd
         HzfPwy2zlal/AWnTAmfSiiANd7i1SxxtLIhRvqfVeVln9OVtwwtqAES3CbuAnJ2zRoY2
         s0T6i2oIu43AKs6Tq2UYy5bSEf5Meq6BmgJtgvarKLiJW0Yb60dvBAHk08Ur7gKHyZZj
         mSD38yL4yNmTbfJST44igC2yAMIKPjMdhBegQHFULH4+smVti92jZ8q5siiV2mzZZ2YP
         VZwzKDMwlbq1PxBXw3njK5fsuhZYhfc5imEtNdZVpjA7UyrFivx20FkphsE5GvgMZ1uh
         KTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucYx/ZcxAj0eqxJBkJHSbfr6EoLtOwM0SF55iwWJYL8=;
        b=tQJQVvlzEjcgMn5jN/zJtbyUMJCtDTYFBJitoT7fAPbn4mQ4LQYOj9RR6TAEbmWvDg
         Zws5M55hu2lGIq9ITWbWi+jmv5oXrOMsa+jntuqDNNZiQjBJicem+gCt96K+k3FpJ9h7
         djttXQZKlvXR/4LcXjIrGYitf935+WLV7++q5Y3dL6dMBC92FiQyhQZFPvp5gTRnlL1K
         wRX5RbbQ7q4gvEW53ajCyrQA/QG7xkf+/x0k1ZmO55zKdPXQnnbElpOdxkJ7sqDne607
         ewuCrug/0reH/H4wWbaF3kF0TadGBhgs46wgE7dSg0pFSHCxZVug/veNW93ISZBYrnbG
         ncjA==
X-Gm-Message-State: ACrzQf3HfNZJqJoLYIj3qx/A2sAA1O/3eCsuWA5Q98BuEaXz409D+evQ
        0xwAGEQhUO1xu384WJrORiBnyg==
X-Google-Smtp-Source: AMsMyM7kE9qwlcJHqkmwJp7kIg7dbeuwAUH4KZLLqbXpu5YG5/1Sid02glzdQMtsKEgYIOIQZegL8w==
X-Received: by 2002:a05:620a:2443:b0:6ee:b1f0:3798 with SMTP id h3-20020a05620a244300b006eeb1f03798mr1611302qkn.444.1666097921416;
        Tue, 18 Oct 2022 05:58:41 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id l3-20020a37f903000000b006ee2953fac4sm2196727qkj.136.2022.10.18.05.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 05:58:40 -0700 (PDT)
Message-ID: <573603ff-b3d3-0be8-1a56-53d980e96dd5@linaro.org>
Date:   Tue, 18 Oct 2022 08:58:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: Add initial support for AM68 SK
 System on Module
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20221018123849.23695-1-sinthu.raja@ti.com>
 <20221018123849.23695-3-sinthu.raja@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221018123849.23695-3-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 08:38, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> AM68 Starter Kit (SK)[1] is a low cost, small form factor board designed
> for TI’s AM68 SoC. TI’s AM68 SoC comprises of dual core A72, high
> performance vision accelerators, hardware accelerators, latest C71x
> DSP, high bandwidth real-time IPs for capture and display. The SoC is
> power optimized to provide best in class performance for industrial
> applications.
> 
>  AM68 SK supports the following interfaces:
>       * 16 GB LPDDR4 RAM
>       * x1 Gigabit Ethernet interface
>       * x1 USB 3.1 Type-C port
>       * x2 USB 3.1 Type-A ports
>       * x1 PCIe M.2 M Key
>       * 512 Mbit OSPI flash
>       * x2 CSI2 Camera interface (RPi and TI Camera connector)
>       * 40-pin Raspberry Pi GPIO header
> 
> SK's System on Module (SoM) contains the SoC and DDR.
> Therefore, add DT node for the SOC and DDR on the SoM.
> 
> Schematics: https://www.ti.com/lit/zip/SPRR463
> TRM: http://www.ti.com/lit/pdf/spruj28
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 129 +++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> new file mode 100644
> index 000000000000..734c13eb0490
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-j721s2.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 16 GB RAM */
> +		reg = <0x00 0x80000000 0x00 0x80000000>,
> +		      <0x08 0x80000000 0x03 0x80000000>;
> +	};
> +
> +	/* Reserving memory regions still pending */
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +

Drop empty line.


Best regards,
Krzysztof

