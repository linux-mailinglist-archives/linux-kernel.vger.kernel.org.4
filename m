Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3F6984A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBOTok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:44:39 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE43252D;
        Wed, 15 Feb 2023 11:44:38 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-16aa71c1600so24240543fac.11;
        Wed, 15 Feb 2023 11:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5ARUHj5O6tEjmZ9CS6Mxq8Bptgn3046BEGzeRQO9Qg=;
        b=BIzMDITEedkWQpG3zzwYMRVhlHQnVy/pp0nKNQWA7ks1S+4LtQ03G2Ch8Us4WNSK44
         YCIFgG6v7YWbbUvAsh0jtTtmnpybDfFioKUd27UnByqwcvTjHV0SBvnZA0ev7GB4U++B
         9Y4dfTKR7CjAu7aH0/6sX3g/QRlUr63fOnG4yax7WE2f8M+VmDtifka6Qb3WpSCEV8wM
         OZwAMQdSeZEiXoZKlw4k4TUanzUvDZoRQ6YAWyMfJ/NnkOhngQkrYRgREHjjaNaftNG4
         Qsbf++ujU291CTRzUmOR/syFv+nzZcMHRGuuf2MWm1gBPGvZyquKSejbTgdBhwOAq1id
         HfVQ==
X-Gm-Message-State: AO0yUKVkQvS7k30qldR2FClrGuHE3ZZNvzd7x7UWA2kZEhMGBZF0tP0d
        YJQr+7Yt7SP0WJ8E56aARaNUvqep1w==
X-Google-Smtp-Source: AK7set+5t2H3YbOtx/SmNjnnMnru3s9nT3jM9efFG89gUD+p7ndB1U+kdkwk0ERvmOx0qDj8b3RyKg==
X-Received: by 2002:a05:6870:2191:b0:16d:c438:d049 with SMTP id l17-20020a056870219100b0016dc438d049mr2067514oae.5.1676490277384;
        Wed, 15 Feb 2023 11:44:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s16-20020a056808209000b0037d74967ef6sm5442951oiw.44.2023.02.15.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:44:36 -0800 (PST)
Received: (nullmailer pid 455622 invoked by uid 1000);
        Wed, 15 Feb 2023 19:44:36 -0000
Date:   Wed, 15 Feb 2023 13:44:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add binding documentation for
 TI AM62 DSS Clock
Message-ID: <20230215194436.GA452485-robh@kernel.org>
References: <20230213115954.553-1-a-bhatia1@ti.com>
 <20230213115954.553-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213115954.553-2-a-bhatia1@ti.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:29:53PM +0530, Aradhya Bhatia wrote:
> Add DT bindings for DSS clock divider of TI's AM62 family of SoCs.

Subject: Drop 'binding documentation for '

> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../clock/ti,am62-dss-vp0-div-clk.yaml        | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml b/Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml
> new file mode 100644
> index 000000000000..310d2a989d5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,am62-dss-vp0-div-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM62 DSS - OLDI Divider Clock
> +
> +maintainers:
> +  - Aradhya Bhatia <a-bhatia1@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,am62-dss-vp0-div-clk

What's wrong with 'fixed-factor-clock' binding?

> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-div:
> +    description: Fixed divider
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - "#clock-cells"
> +  - clock-div
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock {
> +      compatible = "ti,am62-dss-vp0-div-clk";
> +      clocks = <&parent_clock>;
> +      #clock-cells = <0>;
> +      clock-div = <7>;
> +    };
> +...
> -- 
> 2.39.1
> 
