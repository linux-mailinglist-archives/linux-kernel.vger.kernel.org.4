Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C7673A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjASNgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjASNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:36:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA77ED42
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:36:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3024707wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJD7Kl5VEUATsJzLnc7eycDEXwQ+o0DclxGlPjICZ2Q=;
        b=cnwWF3cKGyszbj8Ip5UQW4g9Fw/rEj6vq4lu/uq4EabnkzOlPzBWU6Y9VHjCHJSBh+
         +VcReyEbz62vkPvZy9/zJZXkC+82fLWT7eWSmQPX5HRe8ZNGzZqiqLvdetOB4PqLWtKc
         Mv6LR3dEOsD1PdPgRhtbXeowXGfbG1avlFbG3FGjUR38kCPGJiXC3OjOGhIPPvgEHOnz
         bEqFB9wDqdns/yVj0J7tosPaXKtFGk5Rwru5x0/Yw3kIs4+2Mnpn3YtQmSKCz1GD5sl3
         TeujiB1cF69jZj43u9aUZqYEvo0RzlYZn1tNkaxL7IONJTeUxEfj5Yp+Z6mAigVLz4Vo
         cgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJD7Kl5VEUATsJzLnc7eycDEXwQ+o0DclxGlPjICZ2Q=;
        b=UwNw35ulT+MrFuj1rkjZ/9vcwnqYrvkq5SzLDs72FSPg3LPfontPA47DbJScrZgOG4
         rxSbpH0aIhBmeyw+MW7nX+UUZHRBWZOF5MA/5KBB3HMNszfkqJf8S0JxUtLRYJZGrlCI
         9Rs2z5tuL3GRDYOMQpbM2D26smOX63e5KvObyOMU2tlBN41LSkjxKH/TmdDMpE3UzM9n
         x/o8iPcbEMdas6euZLzFRlqeXm7iV3nRyMiyxyJHnSrAphyP3oVx06kFRXHmalbuImUi
         YScqRO9xqLSxDxGl/RfbZVJBQ00QMyF+bUxSov1tUKokd09THJ8nicPAPYbRyCAYM1kD
         7O7w==
X-Gm-Message-State: AFqh2kqF7bJYdebKqTOoiKQGRiXeaO3ou4wP+zaW+gugbTDNPA2aKOy2
        oQFG88redGdU9IGOIFVMQzpYqg==
X-Google-Smtp-Source: AMrXdXvIb8PdQfhtBzGOuCTnzF7AN0ml/BERewJ3b2fRVJPNoGzEVUvejglYNDqQs9GUp/W4bTyiNQ==
X-Received: by 2002:a05:600c:540b:b0:3da:282b:e774 with SMTP id he11-20020a05600c540b00b003da282be774mr18847188wmb.38.1674135361860;
        Thu, 19 Jan 2023 05:36:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cfa81e2eb4sm5454359wmq.38.2023.01.19.05.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:36:01 -0800 (PST)
Message-ID: <802ae1e3-8046-675d-cf4e-d3468604a3e8@linaro.org>
Date:   Thu, 19 Jan 2023 14:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arch: arm64: dts: Add support for AM69 Starter Kit
Content-Language: en-US
To:     sabiya.d@mistralsolutions.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20230119132958.124435-1-sabiya.d@ti.com>
 <20230119132958.124435-3-sabiya.d@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119132958.124435-3-sabiya.d@ti.com>
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

On 19/01/2023 14:29, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> AM69 Starter Kit is a single board designed for TI AM69 SOC that
> provides advanced system integration in automotive ADAS applications,
> autonomous mobile robot and edge AI applications. The SOC comprises
> of Cortex-A72s in dual clusters, lockstep capable dual Cortex-R5F MCUs,
> Vision Processing Accelerators (VPAC) with Image Signal Processor (ISP)
> and multiple vision assist accelerators, Depth and Motion Processing
> Accelerators (DMPAC), Deep-learning Matrix Multiply Accelerator(MMA)
> and C7x floating point vector DSP
> 
> AM69 SK supports the following interfaces:
>        * 32 GB LPDDR4 RAM
>        * x1 Gigabit Ethernet interface
>        * x3 USB 3.0 Type-A ports
>        * x1 USB 3.0 Type-C port
>        * x1 UHS-1 capable micro-SD card slot
>        * x4 MCAN instances
>        * 32 GB eMMC Flash
>        * 512 Mbit OSPI flash
>        * x2 Display connectors
>        * x1 PCIe M.2 M Key
>        * x1 PCIe M.2 E Key
>        * x1 4L PCIe Card Slot
>        * x3 CSI2 Camera interface
>        * 40-pin Raspberry Pi header
> 
> Add initial support for the AM69 SK board.

Thank you for your patch. There is something to discuss/improve.

> 
> Design Files: https://www.ti.com/lit/zip/SPRR466
> TRM: https://www.ti.com/lit/zip/spruj52
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile       |   1 +
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 180 ++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e7c2c7dd0b25..04b1a7611096 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb

I was told the order of entries here is "time of release". Is it
correct? This is the order you want to keep here and am69-sk was
released after j721s2-common-proc-board but before j784s4-evm?

>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>  


Best regards,
Krzysztof

