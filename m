Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87F634B75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiKWAF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWAFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:05:54 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74CD2F57;
        Tue, 22 Nov 2022 16:05:53 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id n188so12144067iof.8;
        Tue, 22 Nov 2022 16:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOAOA3l25FTlYWgHdX0NRqhyY9RcRAzmGvtq9++eoqg=;
        b=zN8wvWkvhB3aWE6+Ul8ko4wtDbePEXuyuJ8SBoDmCib4qmXxJp/ig97AtEdJLdwxiK
         zABZHiAU4ZKmexgcoUMB4jdnsgf/ToA9VXbl1DHT/rCzal+BGFRbkBf0JzHl+zofisD3
         M1mP+vVEKqnr7JZbDurXgoUFpif+IIh9ZZRFk18FKiVoAqRFuYzgGfHVv9ptG0CXdIc8
         cjDkVRySbyGbzyjkONdUXBTzMNrwe83tcMCuosFcQkkip7LL2bbd1iN3ZuA26q0UbGy2
         znsYADbpf0j8lK9IeRMNbn7978hCB6OamqFR8Fw+tY0X49HlrSSbuo3qU3/cmho89a7/
         OUOg==
X-Gm-Message-State: ANoB5pk/MeX2Wy9PJE0MABBYTUINLUuhjQcRwtAHEKt94RK245Ojy44b
        DfLX+M1Zc8xqJz0J+6LmLa7FCypfDQ==
X-Google-Smtp-Source: AA0mqf7BJHES9MUwE3wyYO2MhDcoicDShRER72IeewX9pYLrmCObA2dqPuNTNfOnNiY9xNcRz1K8tA==
X-Received: by 2002:a6b:c844:0:b0:6db:fe34:6948 with SMTP id y65-20020a6bc844000000b006dbfe346948mr3010433iof.209.1669161953103;
        Tue, 22 Nov 2022 16:05:53 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b4-20020a05660214c400b006cab79c4214sm5776318iow.46.2022.11.22.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:05:52 -0800 (PST)
Received: (nullmailer pid 823019 invoked by uid 1000);
        Wed, 23 Nov 2022 00:05:52 -0000
Date:   Tue, 22 Nov 2022 18:05:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: Re: [PATCH v7 2/7] media: dt-binding: nuvoton: Add bindings for NPCM
 VCD and ECE engine
Message-ID: <20221123000552.GA817752-robh@kernel.org>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
 <20221122085724.3245078-3-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122085724.3245078-3-milkfafa@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:57:19PM +0800, Marvin Lin wrote:
> Add dt-binding document for Video Capture/Differentiation Engine (VCD)
> and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  .../bindings/media/nuvoton,npcm-video.yaml    | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
> new file mode 100644
> index 000000000000..b5be7ef09038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/nuvoton,npcm-video.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Video Capture/Encode Engine Device Tree Bindings

Drop ' Device Tree Bindings'

> +
> +maintainers:
> +  - Joseph Liu <kwliu@nuvoton.com>
> +  - Marvin Lin <kflin@nuvoton.com>
> +
> +description: |
> +  Video Capture/Differentiation Engine (VCD) and Encoding Compression Engine
> +  (ECE) present on Nuvoton NPCM SoCs.

Sounds like 2 h/w blocks? If so, then it should be 2 separate nodes.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-video
> +      - nuvoton,npcm845-video

'video' doesn't sound like the name of the h/w block(s).

> +
> +  reg:
> +    items:
> +      - description: VCD registers
> +      - description: ECE registers
> +
> +  reg-names:
> +    items:
> +      - const: vcd
> +      - const: ece
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: VCD reset control
> +      - description: ECE reset control
> +
> +  reset-names:
> +    items:
> +      - const: vcd
> +      - const: ece
> +
> +  nuvoton,syscon-gcr:
> +    $ref: /schemas/types.yaml#definitions/phandle
> +    description: Phandle to the Global Control Register DT node
> +
> +  nuvoton,syscon-gfxi:
> +    $ref: /schemas/types.yaml#definitions/phandle
> +    description: Phandle to the Graphics Core Information DT node
> +
> +  memory-region:
> +    description:
> +      CMA pool to use for buffers allocation instead of the default CMA pool.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - nuvoton,syscon-gcr
> +  - nuvoton,syscon-gfxi
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
> +
> +    video: video@f0810000 {
> +        compatible = "nuvoton,npcm750-video";
> +        reg = <0xf0810000 0x10000>,
> +              <0xf0820000 0x2000>;
> +        reg-names = "vcd", "ece";
> +        interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
> +                 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
> +        reset-names = "vcd", "ece";
> +        nuvoton,syscon-gcr = <&gcr>;
> +        nuvoton,syscon-gfxi = <&gfxi>;
> +    };
> -- 
> 2.34.1
> 
> 
