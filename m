Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3D63DC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiK3SEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiK3SEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:04:25 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223727061F;
        Wed, 30 Nov 2022 10:04:25 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1433ef3b61fso21924751fac.10;
        Wed, 30 Nov 2022 10:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O92/4gRbBZHRaTcuTNcEC3gTvM1Cg9IfNLbdStTU/4w=;
        b=e9hS8/RO9ikfCpdQPdkRRNVlvsWqYh46dyxv7f1W4VswjATZImE0gFFT+PVoHXq350
         OVbT8reE7TVaOfFGVAn/OIxSWglyrZMVhqCj356jqTOCftNoPhhONj4gEnST6oo0zvkW
         T2EzVLRKRlkQ/iGrGwi3udBZPmf0mJKABo08b3gkjOzzpSm4oMFCUcLdORftrvboSj9O
         h3vHhUstjXwSdzprosxI8sNsWBT9QBBPXb4psaWfYoVd1K0Xa6rIIzTJGZZHQVFKeAhW
         Xqg0PXe3UyU+pT7hjaBFolSFnhvGYnUm0FklUJevzvVgV7rgkkdpXS02ECUwCHtRmbCr
         UN+w==
X-Gm-Message-State: ANoB5pmo3gf5HyAyWCjfn7iP/Np9Wa4Dfxzx9v9x/aMdmFdkQxgBec/n
        KolsqJXPz7X0ldavozZX6A==
X-Google-Smtp-Source: AA0mqf6eVp8liyqBEwwxUaePBihI5WtgVxnCAjlpm1rxRun20hfKca4NFhBlYl+T7dO+q/0y0pLPBg==
X-Received: by 2002:a05:6870:e99f:b0:142:d085:c1cc with SMTP id r31-20020a056870e99f00b00142d085c1ccmr27521723oao.29.1669831463700;
        Wed, 30 Nov 2022 10:04:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a056870a44700b00130d060ce80sm1509542oal.31.2022.11.30.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:04:23 -0800 (PST)
Received: (nullmailer pid 2535078 invoked by uid 1000);
        Wed, 30 Nov 2022 18:04:22 -0000
Date:   Wed, 30 Nov 2022 12:04:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: serial: add bindings doc for
 Bouffalolab uart driver
Message-ID: <20221130180422.GA2527975-robh@kernel.org>
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120082114.3030-2-jszhang@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 04:21:08PM +0800, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver
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

'bouffalolab' needs to be documented in vendor-prefixes.yaml.

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

Drop, not relevant to the binding.

> +        serial0 = &uart0;
> +    };
> +
> +    uart0: serial@30002000 {
> +        compatible = "bouffalolab,uart";
> +        reg = <0x30002000 0x1000>;
> +        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&xtal>;
> +    };
> +...
> -- 
> 2.37.2
> 
> 
