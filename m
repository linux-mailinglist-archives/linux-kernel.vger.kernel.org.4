Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17E366982B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbjAMNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241672AbjAMNNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:13:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4388DCA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:02:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id az20so33084018ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9bRnSUIIBlwb6MpE5e1oVxsjs4GpyyLcDDS0s/lBTU=;
        b=yrUlREfxRYqriTbErFoIw3ZcyZWS1N0sRUBW8NzyXsmnVgdYSHKVmiZWkeTWw6ZKr6
         kAtHYFonsM6XspY0XZqofh5W10rINH7ZAT6LPviyaXdhs5DUyxh9B274G5hd2rHcOWUi
         GNexS2nmbBtizV+vnR2m4Da7IAkz5dN+EmZs0X2iXTpIZ86dSugXyBKDO9DtnZfDU3CP
         YuTt/tLYgh2trDIRK7QBwKUeDNKMsmPh8dRIgoEimmlk0Er/irVLvGlCVkC15ezTzXou
         hVWaF5PxWPuiWCLMhMdkzyueQHjfjbtM2uYJyHMHhx5Z9doIcSy9SsqPb/rV2HKntYOa
         OF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9bRnSUIIBlwb6MpE5e1oVxsjs4GpyyLcDDS0s/lBTU=;
        b=mKj2rOWW+LzTiIx2s6Sc9sLFvJ2CxBNj1gqcwf8OPi0VJGWf7eQPqCrxQLMPHY4x2T
         2Y9HsFZo04RoUQigY6QeD8zlPeMYJb0FflAxMJP1l7JoikpQraWItRJGBuS0wpZ9iJU5
         t+p04Vqg8ThFV41PGeP116HwBrUClC4X5TzsKNswllwG/kppX2SesBJL7KU0tscXRTbs
         P+eV6YuHhiFxT//YqGwBxUZi1GUkQaxPqIaYc8HnRiNRCrWIKz0yOdJx//032OwzJZcJ
         pCTbEasTISI7SWyph6BanQnRibVk95m1mjGeY+lp2t/cGdW0r12Z4L3Z4Zl7O+A8yoSq
         hCWQ==
X-Gm-Message-State: AFqh2kqyykDEFCb4qpuewlEf4RGRIyNxW8i9n+5QtSMJn2ZPWPmJmJdD
        wKgKjRS1MXGMffn365kCUxy1wOuxGDyfWav8
X-Google-Smtp-Source: AMrXdXtuXfM/WIV+7uDgxFRyI8NotN8EFqhThvDeqAW1tWBFtJHimhEZPJYL/U3eUxW5FQaMwMjVbQ==
X-Received: by 2002:a17:907:175c:b0:84d:45db:b203 with SMTP id lf28-20020a170907175c00b0084d45dbb203mr15472856ejc.12.1673614925149;
        Fri, 13 Jan 2023 05:02:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fy5-20020a170906b7c500b0084d3bf4498csm7054343ejb.140.2023.01.13.05.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 05:02:04 -0800 (PST)
Message-ID: <405c2e98-ce26-becb-23c1-dccc6a588167@linaro.org>
Date:   Fri, 13 Jan 2023 14:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] dt-bindings: mailbox: add Marvell MHU
Content-Language: en-US
To:     Wojciech Zmuda <wzmuda@marvell.com>, linux-kernel@vger.kernel.org
Cc:     jassisinghbrar@gmail.com, robh+dt@kernel.org, sgoutham@marvell.com,
        devicetree@vger.kernel.org
References: <20230113125323.3744-1-wzmuda@marvell.com>
 <20230113125323.3744-3-wzmuda@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113125323.3744-3-wzmuda@marvell.com>
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

On 13/01/2023 13:53, Wojciech Zmuda wrote:
> Marvell Message Handling Unit is a mailbox controller present in
> Marvell OcteonTx and OcteonTX2 SoC family.
> 
> Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
> ---
>  .../bindings/mailbox/marvell,mhu.yml          | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mhu.yml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mhu.yml b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yml
> new file mode 100644
> index 000000000000..3fe8238eefe7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/marvell,mhu.yml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Message Handling Unit
> +
> +maintainers:
> +  - Sujeet Baranwal <sbaranwal@marvell.com>
> +  - Sunil Goutham <sgoutham@marvell.com>
> +  - Wojciech Bartczak <wbartczak@marvell.com>
> +
> +description:
> +  The Control-Processors Cluster (CPC) provides Arm-platform specification
> +  entities for managing the system. One of the CPC processors is the System
> +  Control Processor (SCP). The SCP is responsible, among others, for booting
> +  the chip, clock and power initialization, controlling power consumption
> +  through DVFS, monitoring temperature sensors and controlling AVS. The SCP,
> +  as each XCP, contains mailboxes for software-to-software communications.
> +  Mailbox writes cause an interrupt to the local XCP core or to the AP.
> +  This driver exposes AP-SCP Message Handling Unit to the system, providing
> +  the mailbox communication mechanism to the system, with the intention
> +  of plugging into the SCMI framework. It is designed to work with Marvell
> +  OcteonTX and OcteonTX2-based platforms.
> +  Mailbox has no other usage than SCMI communication. In case of
> +  configurations running without SCMI support it should be disabled.
> +
> +properties:
> +  compatible:
> +    oneOf:

This is not oneOf...

> +      - items:

And you have just one item...

> +        - enum:

And wrong indentation below, so this was not tested. Please do not send
untested code.

> +          - marvell,octeontx-mhu
> +          - marvell,octeontx2-mhu
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    description: Index of the channel
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    / {

Why this is needed?

> +        mailbox: mailbox {

unit address is still wrong.


> +            compatible = "marvell,octeontx2-mhu";
> +            reg = <0xe000 0 0 0 0>; /* DEVFN = 0xe0 (1c:0) */
> +            #mbox-cells = <1>;
> +    };
> +

And this DTS code should not be sent... it wasn't ever compiled.

Best regards,
Krzysztof

