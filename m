Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13F7271E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjFGWmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjFGWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:41:59 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087D9E;
        Wed,  7 Jun 2023 15:41:58 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33b4552e55cso134365ab.0;
        Wed, 07 Jun 2023 15:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177717; x=1688769717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niroRP37z6owYjdnCp9NpBqt0WNxQm1WNvpSD/M4+KE=;
        b=aFkJ34owRqmrbbPebUAK8hM2bpqlGoVDTaYLkedbh9kRWg8+6DpPxM/INIL0BfsXkx
         5xqXdRoIgS169ENgdmolmT+D8LfL5a7eAkOf9rvNqkMWkuFE+uxzxsyPUZVWENRtLfCu
         66wWt57xje02wXfHlDOO8YOZAZ6RDz1C4J76xGXhFBeFxjsbAucGrW9WRSvzA2M8v/iK
         iJMrbBSWAwIL2HZqQKh/kgSWAIuTx2APSQTaHqHgIdOq3JIQ+M5LN1nxl5H7YRySZGxl
         eeuMiJdhDLJS4IvHAlKJnj08JGUbh/WFMZmCwuyUFvkmckSHUfECHWQ7Tu4XqUiS62x0
         8rSg==
X-Gm-Message-State: AC+VfDyU+LGvQETK54aurmmwlirOX2GpUfMMkRTvVQrZjqJIEiHQqd7M
        Xm0BuOmvpJlb7fBC3Afchg==
X-Google-Smtp-Source: ACHHUZ5Z3vbKZKsDwdySO5Ibf+7Y8RPug1tGlVrv2kPF8d41NK8OisCqYY08ABKV4orIin0+8AQXOw==
X-Received: by 2002:a05:6e02:1aab:b0:333:49f9:a5f3 with SMTP id l11-20020a056e021aab00b0033349f9a5f3mr385105ilv.2.1686177717431;
        Wed, 07 Jun 2023 15:41:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dj6-20020a0566384b8600b004165289bf0csm3751642jab.168.2023.06.07.15.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:41:56 -0700 (PDT)
Received: (nullmailer pid 114271 invoked by uid 1000);
        Wed, 07 Jun 2023 22:41:55 -0000
Date:   Wed, 7 Jun 2023 16:41:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Message-ID: <20230607224155.GA107156-robh@kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2d27bfea-4746-444c-89f4-e5d35cb7de66@emailsignatures365.codetwo.com>
 <20230605140149.16841-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605140149.16841-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:01:48PM +0200, Mike Looijmans wrote:
> Add bindings for a fixed-rate clock that retrieves its rate from an
> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
> or similar device.
> 
> Component shortages lead to boards being shipped with different clock
> crystals, based on what was available at the time. The clock frequency
> was written to EEPROM at production time. Systems can adapt to a wide
> range of input frequencies using the clock framework, but this required
> us to patch the devicetree at runtime or use some custom driver. This
> provides a more generic solution.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v4:
> Use proper "if" block and add example dts
> 
> Changes in v3:
> Modify fixed-clock instead of introducing nvmem-clock
> 
> Changes in v2:
> Changed "fixed-clock" into "nvmem-clock" in dts example
> Add minItems:1 to nvmem-cell-names
> 
>  .../bindings/clock/fixed-clock.yaml           | 42 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> index b0a4fb8256e2..71a5791da438 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> @@ -12,7 +12,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: fixed-clock
> +    enum:
> +      - fixed-clock
> +      - fixed-clock-nvmem
>  
>    "#clock-cells":
>      const: 0
> @@ -26,11 +28,41 @@ properties:
>    clock-output-names:
>      maxItems: 1
>  
> +  nvmem-cells:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Reads clock-frequency and/or clock-accuracy from an NVMEM provider in
> +      binary native integer format. The size of the NVMEM cell can be 1, 2, 4
> +      or 8 bytes. If the contents of the nvmem are all zeroes or all 0xff, the
> +      value reverts to the one given in the property.
> +
> +  nvmem-cell-names:
> +    minItems: 1
> +    items:
> +      - const: clock-frequency
> +      - const: clock-accuracy
> +
>  required:
>    - compatible
>    - "#clock-cells"
>    - clock-frequency
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fixed-clock-nvmem
> +    then:
> +      required:
> +        - nvmem-cells
> +        - nvmem-cell-names
> +    else:
> +      properties:
> +        nvmem-cells: false
> +        nvmem-cell-names: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -41,4 +73,12 @@ examples:
>        clock-frequency = <1000000000>;
>        clock-accuracy = <100>;
>      };
> +  - |
> +    clock {
> +      compatible = "fixed-clock-nvmem";
> +      #clock-cells = <0>;
> +      clock-frequency = <48000000>;

If the freq comes from nvmem, why is this needed?

I think this should probably be a separate schema file as the only 
other thing shared is #clock-cells.

Rob
