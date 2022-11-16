Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2262CB81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiKPUwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiKPUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:52:12 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EA865E7B;
        Wed, 16 Nov 2022 12:52:02 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id q83so19903220oib.10;
        Wed, 16 Nov 2022 12:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNs3dmKw7nmk2FDDih1lJS6XwxqcCdzu4CVibDAnn08=;
        b=M5c1ulnFTeXRc79HkiEXF26NTSl3mI9tJdFp1r8bNQxXWAwknRwE6UmlOPx9phsyk1
         b8+gmsq2kn46AOULqTTQfbTyiOB8J8POFHuO9boVSGlvA/Ptx7BOQN6wGu+p2/GpRDKZ
         gR6YxcJxiULjA7mzi8gIrAV7Q6f1YuUwhOI2KVZ6Syv/oO+uuku91Qtx/FSjRhygtQts
         yp9yF3o0rG9Sn0BM5B7j55m0MmJ6MniFK9ljC2I1qKrbyIPnORD/PAjeC9Qf4BgeIjY4
         CRQhNvN+2S44iADNk3jhUGgOh5g/O4gpfvuFVcTocyKI+1aPjxjx6gZwLFpD/cSh85jI
         S3wA==
X-Gm-Message-State: ANoB5pnl626cQHWacjiGMalP5etN0EvC+RXAMnrsxlL2SBh29pU+7vMS
        SwHulHZYvos4O3HF8akjSA==
X-Google-Smtp-Source: AA0mqf6ZtFlNK7bNHkj1ZklctN9SGFMbHDZY9jHWFCMMGP2vveAOhQQ41HGL597nAKsv4OpT1As1kg==
X-Received: by 2002:a05:6808:3af:b0:359:fcae:7c3f with SMTP id n15-20020a05680803af00b00359fcae7c3fmr2641623oie.68.1668631922066;
        Wed, 16 Nov 2022 12:52:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w6-20020a056808018600b003458d346a60sm6508941oic.25.2022.11.16.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:52:01 -0800 (PST)
Received: (nullmailer pid 861574 invoked by uid 1000);
        Wed, 16 Nov 2022 20:52:03 -0000
Date:   Wed, 16 Nov 2022 14:52:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
Message-ID: <20221116205203.GA846642-robh@kernel.org>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
 <20221114085659.847611-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114085659.847611-4-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 09:56:57AM +0100, Miquel Raynal wrote:
> From: Michael Walle <michael@walle.cc>
> 
> Add a schema for the NVMEM layout on Kontron's sl28 boards.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../nvmem/layouts/kontron,sl28-vpd.yaml       | 62 +++++++++++++++++++
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> new file mode 100644
> index 000000000000..fef795e79c36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description:
> +  The vital product data (VPD) of the sl28 boards contains a serial
> +  number and a base MAC address. The actual MAC addresses for the
> +  on-board ethernet devices are derived from this base MAC address by
> +  adding an offset.
> +
> +select: false
> +
> +properties:
> +  compatible:
> +    const: kontron,sl28-vpd
> +
> +  serial-number:
> +    type: object

       additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description: The board's serial number
> +
> +  base-mac-address:
> +    type: object
> +    description:
> +      Base MAC address for all on-module network interfaces. The first
> +      argument of the phandle will be treated as an offset.
> +
> +    properties:
> +      "#nvmem-cell-cells":
> +        const: 1
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      otp-1 {
> +          compatible = "user-otp";
> +
> +          nvmem-layout {
> +              compatible = "kontron,sl28-vpd";
> +
> +              serial_number: serial-number {
> +              };
> +
> +              base_mac_address: base-mac-address {
> +                  #nvmem-cell-cells = <1>;
> +              };
> +          };
> +      };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> index ecc7c37cbc1f..f64ea2fa362d 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> @@ -17,6 +17,9 @@ description: |
>    define and might require dynamic reading of the NVMEM device in order to
>    perform their parsing. The nvmem-layout container is here to describe these.
>  
> +oneOf:
> +  - $ref: kontron,sl28-vpd.yaml
> +
>  properties:
>    compatible: true
>  
> -- 
> 2.34.1
> 
> 
