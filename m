Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CAE5B73C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiIMPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiIMPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:09:04 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B177553;
        Tue, 13 Sep 2022 07:31:47 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1278624b7c4so32620802fac.5;
        Tue, 13 Sep 2022 07:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tj9IaKd3V1LuUQ7OzzJ/L+w5soQvCCrAzGZ3d7sXgeU=;
        b=JuHcfCrZ/4xDb9hE81GSjQydbrnsQ00tf8f6Tn0G2Q6jc73wLHH7O0+xxhmnuS60p6
         4tGDivpPjk0ixgeAGAvQeB7Hn9pJ0ecP9hsQ5uRwSGU2HImMC7GF7+UoRMmLL52eg+9x
         lyM9vqjV89Ds3h3FSnHW/kPXbgmendktFAzdOL3bqPzPep/foZtsrM3kNpjBFN3GoiS4
         uHudOzIASfpagZg2aEaX58TRaqCpLlzX8hdJVP6MVKoxqrrztfLGF1Q5FGVznFYsdQIo
         IBeZHxo7LUbEGjrphbTVHmv5d9PmVNWskRlA237jV85kUZDdlGjvvZW1HwCNon4atzu/
         nL2w==
X-Gm-Message-State: ACgBeo1tlXDzoEN3MRQo/98+ezq0zHWMj13gFQy/Hach4a4gGRL80FO5
        2O+8/B81ccEp9tsGtm8bNPEYcIMJIg==
X-Google-Smtp-Source: AA6agR7PIbzqcKoTBfvtNXth+cXiNYZjzdTsrAu8f4IZ+GA9u0Y0kkQ9kXUc385HG9xo7xD4RV9YvQ==
X-Received: by 2002:a05:6870:51ca:b0:11b:98fa:432b with SMTP id b10-20020a05687051ca00b0011b98fa432bmr1959987oaj.109.1663079425048;
        Tue, 13 Sep 2022 07:30:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r35-20020a05687017a300b0011e37fb5493sm7278331oae.30.2022.09.13.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:30:24 -0700 (PDT)
Received: (nullmailer pid 3625970 invoked by uid 1000);
        Tue, 13 Sep 2022 14:30:24 -0000
Date:   Tue, 13 Sep 2022 09:30:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4 v3] dt-bindings: memory: Add jedec,lpddr4 and
 jedec,lpddr5 bindings
Message-ID: <20220913143024.GA3620595-robh@kernel.org>
References: <20220909232139.645945-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909232139.645945-1-jwerner@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:21:39PM -0700, Julius Werner wrote:
> This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
> existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
> needed for topology description, so other properties like timing
> parameters are omitted. They can be added later if needed.

I only see patch 3. Please only send complete series.

> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                |  4 ++
>  .../memory-controllers/ddr/jedec,lpddr4.yaml  | 35 ++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr5.yaml  | 46 +++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> 
> Changelog:
> 
> - v2
>   - removed minItems
>   - moved `$ref` below `maintainers`
>   - renamed example node from `lpddr4` to `lpddr`
> - v3
>   - removed manufacturer-id property from examples
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> index 4114cfa8de67f1..92ef660888f318 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> @@ -45,9 +45,13 @@ properties:
>        - 512
>        - 1024
>        - 2048
> +      - 3072
>        - 4096
> +      - 6144
>        - 8192
> +      - 12288
>        - 16384
> +      - 24576
>        - 32768
>  
>    io-width:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
> new file mode 100644
> index 00000000000000..fa9b30ee89cb81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPDDR4 SDRAM compliant to JEDEC JESD209-4
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^lpddr4-[0-9a-f]{2},[0-9a-f]{4}$"
> +      - const: jedec,lpddr4
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    lpddr {
> +        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
> +        density = <8192>;
> +        io-width = <16>;
> +        revision-id = <1 0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> new file mode 100644
> index 00000000000000..01e11aabc5a3f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPDDR5 SDRAM compliant to JEDEC JESD209-5
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"

And here.

> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^lpddr5-[0-9a-f]{2},[0-9a-f]{4}$"
> +      - const: jedec,lpddr5
> +
> +  serial-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Serial IDs read from Mode Registers 47 through 54. One byte per uint32
> +      cell (i.e. <MR47 MR48 MR49 MR50 MR51 MR52 MR53 MR54>).
> +    maxItems: 8
> +    items:
> +      minimum: 0
> +      maximum: 255
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    lpddr {
> +        compatible = "lpddr5-01,0200", "jedec,lpddr5";
> +        density = <8192>;
> +        io-width = <8>;
> +        revision-id = <2 0>;
> +        serial-id = <3 1 0 0 0 0 0 0>;
> +    };
> -- 
> 2.31.0
> 
> 
