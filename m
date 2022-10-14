Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111D5FF0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJNPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJNPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:13:27 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0C1D3EAD;
        Fri, 14 Oct 2022 08:13:26 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-134072c15c1so6217331fac.2;
        Fri, 14 Oct 2022 08:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkHJ2WaopDUZ1kn2ahx5rf6aUqRXLuVh4aPcDlWTiFI=;
        b=Ov+2SYq4WXXT3wVKhnYWJYB1IDlFujlw7N3yuqvuujLfPrvTNXeWT77k9Ti1GLDrkB
         mmfMlBx8NnDZjNWte20RNxtCmphLSwSlBVqa/nEYTxxU+Z9qlQwZa4C1SurrAKwUBOPu
         JMM3tt9/3BGJMhWdgUHrBqMDyGgGy3lk1dX2hZdtX8ieO3qqs9r6SuA94xUlJp3UsZ18
         qn0Udl8tpmzNiEa3y5JGx0j+DUxAgAep51iA3kJ/SvV8zD9HRQBSK9phkCpX3lTOqEh7
         UWybhGMuufoteKlaR4ql6GMT2GCmHn1MvRW8G8ID6GBUHIuc00pJQmx1uPXgaD+AD6e3
         +41g==
X-Gm-Message-State: ACrzQf1hgTtk4BqizPbfvsenW7EVeNPxIBwT+r3MsQXF2MkagIz0fCqB
        cNfq73JjrRLevSfWFkpkgg==
X-Google-Smtp-Source: AMsMyM51/rLYMuawRnZOlPd9BCtsnx5WBWRjk6J2A5Ed+h5n+44B2Gd7UIpz5sSnFxMIBbSZEVCa3Q==
X-Received: by 2002:a05:6870:b68d:b0:12d:484a:2643 with SMTP id cy13-20020a056870b68d00b0012d484a2643mr8576751oab.105.1665760405161;
        Fri, 14 Oct 2022 08:13:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870310500b00136c20b1c59sm1384346oaa.43.2022.10.14.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:13:24 -0700 (PDT)
Received: (nullmailer pid 1963626 invoked by uid 1000);
        Fri, 14 Oct 2022 15:13:25 -0000
Date:   Fri, 14 Oct 2022 10:13:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: sound: Add sound card bindings for
 Tesla FSD
Message-ID: <20221014151325.GA1940481-robh@kernel.org>
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104901epcas5p1a61ea81c3b1640bd8a064633c0b1e40d@epcas5p1.samsung.com>
 <20221014102151.108539-4-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014102151.108539-4-p.rajanbabu@samsung.com>
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

On Fri, Oct 14, 2022 at 03:51:48PM +0530, Padmanabhan Rajanbabu wrote:
> Add dt-binding reference document to configure the DAI link for Tesla
> FSD sound card driver.

The simple-card or graph-card bindings don't work for you?

> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  .../bindings/sound/tesla,fsd-card.yaml        | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> new file mode 100644
> index 000000000000..4bd590f4ee27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Samsung Electronics Co. Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/tesla,fsd-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tesla FSD ASoC sound card driver
> +
> +maintainers:
> +  - Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> +
> +description: |
> +  This binding describes the node properties and essential DT entries of FSD
> +  SoC sound card node
> +
> +select: false

Never apply this schema. Why?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - tesla,fsd-sndcard
> +
> +  model:
> +    description: Describes the Name of the sound card
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  widgets:
> +    description: A list of DAPM widgets in the sound card. Each entry is a pair
> +      of strings, the first being the widget name and the second being the
> +      widget alias
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  audio-routing:
> +    description: A list of the connections between audio components. Each entry
> +      is a pair of strings, the first being the connection's sink, the second
> +      being the connection's source
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  dai-tdm-slot-num:
> +    description: Enables TDM mode and specifies the number of TDM slots to be
> +      enabled
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8]

maximum: 8

> +    default: 2
> +
> +  dai-tdm-slot-width:
> +    description: Specifies the slot width of each TDm slot enabled
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16, 24]
> +    default: 16

All the above have types defined. You should not be redefining the 
types.

> +
> +  dai-link:
> +    description: Holds the DAI link data between CPU, Codec and Platform
> +    type: object

       additionalProperties: false

> +    properties:
> +      link-name:
> +        description: Specifies the name of the DAI link
> +        $ref: /schemas/types.yaml#/definitions/string
> +
> +      dai-format:
> +        description: Specifies the serial data format of CPU DAI
> +        $ref: /schemas/types.yaml#/definitions/string
> +
> +      tesla,bitclock-master:
> +        description: Specifies the phandle of bitclock master DAI
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      tesla,frame-master:
> +        description: Specifies the phandle of frameclock master DAI
> +        $ref: /schemas/types.yaml#/definitions/phandle

These are common properties. Drop 'tesla'.

> +
> +      cpu:
> +        description: Holds the CPU DAI node and instance
> +        type: object

           additionalProperties: false

> +        properties:
> +          sound-dai:
> +            description: Specifies the phandle of CPU DAI node
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +        required:
> +          - sound-dai
> +
> +      codec:
> +        description: Holds the Codec DAI node and instance
> +        type: object

           additionalProperties: false

> +        properties:
> +          sound-dai:
> +            description: Specifies the phandle of Codec DAI node
> +            $ref: /schemas/types.yaml#/definitions/phandle-array

Already has a type. Need to define how many entries (maxItems: 1 ?).

> +
> +        required:
> +          - sound-dai
> +
> +    required:
> +      - link-name
> +      - dai-format
> +      - tesla,bitclock-master
> +      - tesla,frame-master
> +      - cpu
> +
> +dependencies:
> +  dai-tdm-slot-width: [ 'dai-tdm-slot-num' ]

This should be captured with tdm-slot.txt converted to schema.

> +
> +required:
> +  - compatible
> +  - model
> +  - dai-link
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "tesla,fsd-sndcard";
> +        status = "disabled";

Why have a disabled example? Other than your example won't pass your 
schema.

> +        model = "fsd-i2s";
> +
> +        primary-dai-link-0 {
> +            link-name = "fsd-primary-0";
> +            dai-format = "i2s";
> +            tesla,bitclock-master = <&tdm_0>;
> +            tesla,frame-master = <&tdm_0>;
> +            cpu {
> +                sound-dai = <&tdm_0 0>;
> +            };
> +        };
> +
> +        secondary-dai-link-0 {
> +            link-name = "fsd-secondary-0";
> +            dai-format = "i2s";
> +            tesla,bitclock-master = <&tdm_0>;
> +            tesla,frame-master = <&tdm_0>;
> +            cpu {
> +                sound-dai = <&tdm_0 1>;
> +            };
> +        };
> +
> +        primary-dai-link-1 {
> +            link-name = "fsd-primary-1";
> +            dai-format = "i2s";
> +            tesla,bitclock-master = <&tdm_1>;
> +            tesla,frame-master = <&tdm_1>;
> +            cpu {
> +                sound-dai = <&tdm_1 0>;
> +            };
> +        };
> +
> +        secondary-dai-link-1 {
> +            link-name = "fsd-secondary-1";
> +            dai-format = "i2s";
> +            tesla,bitclock-master = <&tdm_1>;
> +            tesla,frame-master = <&tdm_1>;
> +            cpu {
> +                sound-dai = <&tdm_1 1>;
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
