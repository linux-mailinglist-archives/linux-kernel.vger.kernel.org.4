Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D6623AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiKJEBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiKJEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:00:57 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402B3134F;
        Wed,  9 Nov 2022 20:00:54 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so1021906fac.1;
        Wed, 09 Nov 2022 20:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cl67aM0A8kGCsNU3bcMg/7JOPhSo1g2SCxTElIolKU=;
        b=O5dQhExP2QXj1aJlV0DJ1PDLJOXFST30H74vaf/EojhI0TF2h4By2tAYw5AFdymYfW
         JVw5ChI6NjiTUSU3oiREx3BR1i9PsC6CL2rbANiB2BJL0VcPPsSmSkfNXWHCCHbgs+tm
         LSGjZShNcqb33FNwOijfWz4SaN1eb2TeHF18G9I8j9OPLQvzUa1UCIM702yHKmxs6KIE
         tJE2R3VIaSjucxqN3ZEBooTeBXvxURp3z0i2Nkz3wA/AiKSsg8PQRzrUgbnZCR4168JF
         UnSo5wqRmYit6Nk78e7wI4MbF0bF/OfEI+yMifsuzqDN8BzigdRvyFr9ZNxAEmHivB81
         Z/aw==
X-Gm-Message-State: ACrzQf2TIwt4CDeJGRfrd9fr45inXKLPAg8K1n7jfqL/A7IxmUrTkNrj
        7iVw7k9xesnU/zGF3xhHDBVqu05G1A==
X-Google-Smtp-Source: AMsMyM4XoNOIKGVSS0bQjbFxmDKYAfgcx2uRNlK04pww5KVRKRTVn3dv2hl11PBsH0G7DwvoWgs5nw==
X-Received: by 2002:a05:6870:4188:b0:12d:484a:2592 with SMTP id y8-20020a056870418800b0012d484a2592mr46671854oac.5.1668052853778;
        Wed, 09 Nov 2022 20:00:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id er33-20020a056870c8a100b00131c3d4d38fsm7002740oab.39.2022.11.09.20.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 20:00:53 -0800 (PST)
Received: (nullmailer pid 3448323 invoked by uid 1000);
        Thu, 10 Nov 2022 04:00:55 -0000
Date:   Wed, 9 Nov 2022 22:00:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: nvmem: add YAML schema for the ONIE
 tlv layout
Message-ID: <20221110040055.GA3436769-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104163833.1289857-7-miquel.raynal@bootlin.com>
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

On Fri, Nov 04, 2022 at 05:38:33PM +0100, Miquel Raynal wrote:
> Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
> compatible networking device.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
>  .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> index f64ea2fa362d..8512ee538c4c 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> @@ -19,6 +19,7 @@ description: |
>  
>  oneOf:
>    - $ref: kontron,sl28-vpd.yaml
> +  - $ref: onie,tlv-layout.yaml
>  
>  properties:
>    compatible: true
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> new file mode 100644
> index 000000000000..1d91277324ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/layouts/onie,tlv-layout.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVMEM layout of the ONIE tlv table
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +description:
> +  Modern networking hardware implementing the Open Compute Project ONIE
> +  infrastructure shall provide a non-volatile memory with a table whose the
> +  content is well specified and gives many information about the manufacturer
> +  (name, country of manufacture, etc) as well as device caracteristics (serial
> +  number, hardware version, mac addresses, etc). The underlaying device type
> +  (flash, EEPROM,...) is not specified. The exact location of each value is also
> +  dynamic and should be discovered at run time because it depends on the
> +  parameters the manufacturer decided to embed.
> +
> +properties:
> +  compatible:
> +    const: onie,tlv-layout
> +
> +  product-name: true

This is a node? If so, you need:

type: object
additionalProperties: false

> +
> +  part-number: true
> +
> +  serial-number: true
> +
> +  mac-address:
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
> +  manufacture-date: true
> +
> +  device-version: true
> +
> +  label-revision: true
> +
> +  platforn-name: true
> +
> +  onie-version: true
> +
> +  num-macs: true
> +
> +  manufacturer: true
> +
> +  country-code: true
> +
> +  vendor: true
> +
> +  diag-version: true
> +
> +  service-tag: true
> +
> +  vendor-extension: true
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        eeprom@56 {
> +            compatible = "atmel,24c64";
> +            read-only;
> +            reg = <0x56>;
> +
> +            nvmem-layout {
> +                compatible = "onie,tlv-layout";
> +
> +                serial-number {
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            compatible = "m25p80", "jedec,spi-nor";
> +            reg = <0>;
> +
> +            otp {
> +                compatible = "user-otp";
> +
> +                nvmem-layout {
> +                    compatible = "onie,tlv-layout";
> +
> +                    mac-address {
> +                        #nvmem-cell-cells = <1>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> -- 
> 2.34.1
> 
> 
