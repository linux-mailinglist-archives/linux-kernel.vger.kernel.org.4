Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA8616AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKBRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:35:59 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740CC2DAA0;
        Wed,  2 Nov 2022 10:35:58 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id y67so19947951oiy.1;
        Wed, 02 Nov 2022 10:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+RvV9HroI0e17hg2yo5PeRMsRDFO5hYneSn93G5vAw=;
        b=vq89r9WaxZLs1bFnZiCBES67z1fuQxNaGJTxNHnvl9a5qVZK1S/1Z023dBc5YpXpyl
         8hCgRHNWTtR9fbRlb+VnDqHgQIMHUQPS8zDSS9ebzjzRTbRNzxL6PAf6vh2HG9jArQhO
         GykBt03jOmouSt2DUTL0WGsb7SPRREY78N7K73HzcLUx/D1OXXkRid/Qxixw2oh7CR2J
         vS8Nm7oJDUIEU6TO5S6z6UGguyT27WJibEjlxeRjqFL0Qvw23isZjOgH9KHzZpcQ5lLq
         EQpA26sS5SSAFAr7df+Lvus3qkre38JJbSlz6vQ1VVJD2C/1VFkIsofu59V9spnhwID0
         xa5w==
X-Gm-Message-State: ACrzQf3VDsQ8ynifRnbKvRcyUoMMo2TiSzYXtA7U22dapWPHUnXV59Pb
        2FHyS9uKcIaO+hKcW/oqWg==
X-Google-Smtp-Source: AMsMyM6S6yrU8ZP1Vft7Pfk72GvckKRnabbPfsNxEGLyAuPRkh1o8+IaC7Nwzw++fcYP0UzthbF41Q==
X-Received: by 2002:a05:6808:178a:b0:359:fe7a:14ac with SMTP id bg10-20020a056808178a00b00359fe7a14acmr10682650oib.34.1667410557660;
        Wed, 02 Nov 2022 10:35:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e66-20020a4a5545000000b004805e9e9f3dsm4713825oob.1.2022.11.02.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:35:57 -0700 (PDT)
Received: (nullmailer pid 5954 invoked by uid 1000);
        Wed, 02 Nov 2022 17:35:58 -0000
Date:   Wed, 2 Nov 2022 12:35:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Message-ID: <20221102173558.GA4193055-robh@kernel.org>
References: <20221101215804.16262-1-afd@ti.com>
 <20221101215804.16262-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101215804.16262-2-afd@ti.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 04:57:56PM -0500, Andrew Davis wrote:
> The TI Nspire devices contain a set of registers with a seemingly
> miscellaneous set of functionality. This area is known simply as the
> "misc" region.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/mfd/ti,nspire-misc.yaml          | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> new file mode 100644
> index 0000000000000..d409eae7537bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Nspire MISC hardware block
> +
> +maintainers:
> +  - Andrew Davis <afd@ti.com>
> +
> +description: |
> +  System controller node represents a register region containing a set
> +  of miscellaneous registers. The registers are not cohesive enough to
> +  represent as any specific type of device. The typical use-case is
> +  for some other node's driver, or platform-specific code, to acquire
> +  a reference to the syscon node (e.g. by phandle, node path, or
> +  search using a specific compatible value), interrogate the node (or
> +  associated OS driver) to determine the location of the registers,
> +  and access the registers directly.

Looks like you copied the generic description? Describe what MISC 
contains.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,nspire-misc
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot:
> +    $ref: "../power/reset/syscon-reboot.yaml"

/schemas/power/...

And no quotes needed.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reboot
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    misc: misc@900a0000 {
> +      compatible = "ti,nspire-misc", "syscon", "simple-mfd";
> +      reg = <0x900a0000 0x1000>;
> +
> +      reboot {
> +        compatible = "syscon-reboot";
> +        offset = <0x08>;
> +        value = <0x02>;
> +      };
> +    };
> -- 
> 2.37.3
> 
> 
