Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80E681B99
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjA3UdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjA3Uc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:32:57 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0013ABD;
        Mon, 30 Jan 2023 12:32:53 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id s66so11120495oib.7;
        Mon, 30 Jan 2023 12:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xWU7JtGiv4WHE9A77mE3J9vVWaUjGZ8XBIVuKFbI5w=;
        b=ktsW2+HMJjy1PNg0uhlQUfvf7SYVhU9yntP10hXc7NOQENoVoFTNlL13gOvHSHoeVa
         gkT+XQMyB0lyCk2zvYJgzK1Tiu2SniKp93VZbpqT4pBX1VviZkdRsTkNW+2jJT3EU/RC
         bn7pxJnZk1KMW88wL7rD9N0KkyHAYoTaGZzlHZz71W+cp+iFctxxSJSE5PQUwBm/MKRm
         3d7JEj2EVCtOqOZV7SljwGlxSyDULJY5vU9l4Jenq/S+leh3S/TsPxH+XY2ENLd0n1ZF
         V6i8qV6E1dRcK6LwdjcQsMiprjsozZBgDNq/SmLAMRnw5CNN2egxeIHOsdHIOD11Q/M7
         hw1g==
X-Gm-Message-State: AO0yUKWCEoPQx4GmKkLNcwK31KS5OtoCpJv+Xs4JLLGDDTfy840FVt61
        yFXVzUAzEw67jUrLkgbr9g==
X-Google-Smtp-Source: AK7set9wcFon0K9frrLTB1cxJZ7QUNhn+Tl1E92rzVwuxACeAqsgaTS9NMglX4o7jholnRev0ahHIQ==
X-Received: by 2002:a05:6808:f05:b0:378:193f:5d84 with SMTP id m5-20020a0568080f0500b00378193f5d84mr4888765oiw.10.1675110772301;
        Mon, 30 Jan 2023 12:32:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ck14-20020a056830648e00b0068664355604sm5911327otb.22.2023.01.30.12.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:32:51 -0800 (PST)
Received: (nullmailer pid 3308138 invoked by uid 1000);
        Mon, 30 Jan 2023 20:32:51 -0000
Date:   Mon, 30 Jan 2023 14:32:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: io: new binding for IO
 accessible NVMEM devices
Message-ID: <20230130203251.GA3290808-robh@kernel.org>
References: <20230127175831.26753-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127175831.26753-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 06:58:30PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With the NVMEM layouts binding in place we should now use:
> 1. NVMEM device access bindings
> 2. NVMEM content description bindings
> 
> This binding allows describing NVMEM devices that can be accessed using
> IO mappings.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/io.yaml         | 37 +++++++++++++++++++

What do we call nvmem using ISA/PCI IO space? That was my first thought 
seeing "IO". Probably unlikely, but still. "MMIO" instead?

>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/io.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/io.yaml b/Documentation/devicetree/bindings/nvmem/io.yaml
> new file mode 100644
> index 000000000000..67e0aae9cd94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/io.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/io.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IO access based NVMEM
> +
> +description: |
> +  This binding describes simple NVMEM devices that can be accessed by simply
> +  mapping a predefined IO address.
> +
> +  It's a generic solution for providing NVMEM content access. The way of
> +  handling actual content may be device specific and can be described using a
> +  proper layout.

As the accesses are memory-mapped, the child nodes should also have 
memory-mapped addresses. IOW, you need 'ranges', '#address-cells', 
'#size-cells'.

> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    const: io-nvmem
> +
> +  reg:
> +    maxItems: 1

The first addition here will be access size restrictions. Perhaps add 
that now (reg-io-width).

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nvmem@10000 {
> +        compatible = "io-nvmem";
> +        reg = <0x10000000 0x10000>;
> +    };
> -- 
> 2.34.1
> 
