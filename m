Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9F631DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKUKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKUKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:09:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0841276D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:09:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r12so18107085lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxrwoV4uWAErf9DL6sbWjIb3t+zcjaVCbt4w4586XkY=;
        b=Wed0FFJ81XFeo/OAhCrlzD6g9EDFNqhjFc6GWDE+gFplOeMHnMYKzJe06LfyI8dihk
         dX2CQCikjWSKjz+bBsAMq6DXgQRrR4f4jjYOH1cEFlxtN4/OSlU/ZxBFc+R/E3hmh4lQ
         yrfzBynHDAvigzlXz2rwhPv7+aKa09hrMZ0VcOiXsU1cZ+1YtaCgRFV7vw6LL0oahIYB
         Sx+eHl44hLwcd1qhkHn4pUilfYQdfKDa9WC3VtsavFbS1pA64Wen1F23TqyRWG18s5kP
         j4z8qQOtl+0nLwm4XB0KOlMz/zoA7hc6eVozDfFiv0wS6wk/zAg8oEcAxs/QxdT03ay3
         vC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxrwoV4uWAErf9DL6sbWjIb3t+zcjaVCbt4w4586XkY=;
        b=h12qWCTu+mHZxhExDvMn9/gQ54JJiBlamhuroxp0cCN767cPPXdUuk6Z53Trviuv7W
         Izdqgq0QBhg5RBc3762iTa/5zP86YTcZek1Y2afNiFoM8TFfvGoVKi/tZBbgVkbcunHw
         M55GvqyDKH2lSZTjbyAfh/yw3kfltFS3UDnzVlbE6Q+Mgn5yXCl+69NOo1A3wu9MpRf5
         bkX2t7RaUpGkRyD4mjbFqDKvMSWquE+GWQJmhwd27lWBRBAmH1sT+wiRJBNd1VKypDEU
         oSujZYnuC3xRYhC+YTcWE+s4f59RW5qWOGtglX+sKzQX/QMaaDlLmZJYXg97lGzw4ZeP
         cfIg==
X-Gm-Message-State: ANoB5pkI19GJsCjD536WGhQtUCjo4Zx4KUou98KFZChgMgloisfkM+/j
        w7WnrzFeMazIYUjHOgc9qDjUZA==
X-Google-Smtp-Source: AA0mqf5GeXjgbrXXdWAXxvd6orgjBRuVp8zzcCyfmnYfi/NNmTb9WEE8schAAo/sbXXSZ/qNgDNyxA==
X-Received: by 2002:a19:7001:0:b0:4b1:8fbb:d3f4 with SMTP id h1-20020a197001000000b004b18fbbd3f4mr5968366lfc.70.1669025344352;
        Mon, 21 Nov 2022 02:09:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d20-20020ac25454000000b004948378080csm1953159lfn.290.2022.11.21.02.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:09:03 -0800 (PST)
Message-ID: <1774dce0-b9eb-6b75-c9c2-98dbc05db04a@linaro.org>
Date:   Mon, 21 Nov 2022 11:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] dt-bindings: serial: add bindings doc for Bouffalolab
 uart driver
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-2-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221120082114.3030-2-jszhang@kernel.org>
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

On 20/11/2022 09:21, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver

Subject: drop second, redundant "bindings doc".

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/serial/bouffalolab,uart.yaml     | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> new file mode 100644
> index 000000000000..6cef956d33d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both lines.

> +
> +title: Bouffalolab UART Controller
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: bouffalolab,uart

No model number? From bouffalolab there will be only one, exactly UART
model? No new models in next 5, 10, 100 years?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    aliases {
> +        serial0 = &uart0;
> +    };

Drop aliases, not related.



Best regards,
Krzysztof

