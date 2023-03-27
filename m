Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF46CA67A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjC0Nvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjC0NvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:51:17 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F461B6;
        Mon, 27 Mar 2023 06:50:17 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id bm2so6380719oib.4;
        Mon, 27 Mar 2023 06:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfYFXw2Ix/5WOpp7b1a+gGOAuPKCPxgjMvzfrLSOi7g=;
        b=x7xSDlxGhW6pPZpXn2pMmNHOe5qF+lsyGHao3KwxsvKGKTpFlPuo7cyWt8irReodXJ
         OZJrjfyhBSvdpUy11qprSR9Jcqsj9snmUCFWCP0fzK5LkBFSmNWr1uteK1EbiaHn6jM2
         4ODQTfVzlbapWR6hoB8oXnFL3fKYTtyoK4PcmKgKve1AoOr8n94EYmzUmv6h439rnF2V
         KLJZ6WZgc+iFKNZ7im0pUOtK/V0gpNCUkHVggGptgqmH3DbjPe7+VJ2iVTLz5EQzg0X5
         geqW8qCQt1Q2ry0m7h4CH84s0/s/HsYQNlhPzxGCgODd7+2VC35s6vbrPSGRLekrRZSY
         dHeQ==
X-Gm-Message-State: AAQBX9fdAb9l1uzBsF6LLfT8tSHPtmel7y/I5DCjNp2A41m9b7sbhNM/
        GM4aWX1Um+TdgFISjdHNeQ==
X-Google-Smtp-Source: AKy350YlszEFWX5rYdZf3ojkY10Mwsb5V+DDNuuA+3YtC0psPbLZ59IgLGavCwvq/sUUhrNGGfq+MQ==
X-Received: by 2002:a05:6808:1a06:b0:389:21:9483 with SMTP id bk6-20020a0568081a0600b0038900219483mr4078442oib.59.1679925000898;
        Mon, 27 Mar 2023 06:50:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o184-20020acabec1000000b0038934c5b400sm778659oif.25.2023.03.27.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:50:00 -0700 (PDT)
Received: (nullmailer pid 3483618 invoked by uid 1000);
        Mon, 27 Mar 2023 13:49:59 -0000
Date:   Mon, 27 Mar 2023 08:49:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V5 1/3] dt-bindings: nvmem: layouts: add fixed-layout
Message-ID: <20230327134959.GA3479532-robh@kernel.org>
References: <20230321102418.4190-1-zajec5@gmail.com>
 <20230321102418.4190-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321102418.4190-2-zajec5@gmail.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:24:16AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With the introduction of NVMEM layouts, new NVMEM content structures
> should be defined as such. We should also try to convert / migrate
> existing NVMEM content bindings to layouts.
> 
> This commit handles fixed NVMEM cells. So far they had to be defined
> directly - as device subnodes. With this change it's allowed to put them
> in the DT node named "nvmem-layout".
> 
> Having NVMEM cells in separated node is preferred as it draws a nice
> line between NVMEM device and its content. It results in cleaner
> bindings.
> 
> FWIW a very similar situation has happened to MTD devices and their
> partitions: see commit 5d96ea42eb63 ("dt-bindings: mtd: Clarify all
> partition subnodes").
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++++
>  .../bindings/nvmem/layouts/fixed-layout.yaml  | 49 +++++++++++++++++++
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 19 +------
>  4 files changed, 83 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> new file mode 100644
> index 000000000000..e698098450e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/layouts/fixed-cell.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Fixed offset & size NVMEM cell
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  bits:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - minimum: 0
> +        maximum: 7
> +        description:
> +          Offset in bit within the address range specified by reg.
> +      - minimum: 1
> +        description:
> +          Size in bit within the address range specified by reg.
> +
> +required:
> +  - reg
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> new file mode 100644
> index 000000000000..f7496ba28f33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/layouts/fixed-layout.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVMEM layout for fixed NVMEM cells
> +
> +description:
> +  Many NVMEM devices have hardcoded cells layout (offset and size of defined
> +  NVMEM content doesn't change).
> +
> +  This binding allows defining such NVMEM layout with its cells. It can be used
> +  on top of any NVMEM device.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    const: fixed-layout
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  "@[a-f0-9]+$":
> +    type: object
> +    $ref: fixed-cell.yaml

This $ref allows additional properties, so here you need 
'unevaluatedProperties: false'. Or restrict fixed-cell.yaml.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    nvmem-layout {
> +        compatible = "fixed-layout";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        calibration@4000 {
> +            reg = <0x4000 0x100>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> index 8512ee538c4c..3b40f7880774 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> @@ -18,16 +18,13 @@ description: |
>    perform their parsing. The nvmem-layout container is here to describe these.
>  
>  oneOf:
> +  - $ref: fixed-layout.yaml
>    - $ref: kontron,sl28-vpd.yaml
>    - $ref: onie,tlv-layout.yaml
>  
>  properties:
>    compatible: true
>  
> -  '#address-cells': false
> -
> -  '#size-cells': false
> -
>  required:
>    - compatible
>  
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 75bb93dda9df..b79f1bb795fb 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -49,23 +49,8 @@ properties:
>  patternProperties:
>    "@[0-9a-f]+(,[0-7])?$":
>      type: object
> -
> -    properties:
> -      reg:
> -        maxItems: 1
> -        description:
> -          Offset and size in bytes within the storage device.
> -
> -      bits:
> -        $ref: /schemas/types.yaml#/definitions/uint32-array
> -        items:
> -          - minimum: 0
> -            maximum: 7
> -            description:
> -              Offset in bit within the address range specified by reg.
> -          - minimum: 1
> -            description:
> -              Size in bit within the address range specified by reg.
> +    $ref: layouts/fixed-cell.yaml
> +    deprecated: true
>  
>  additionalProperties: true
>  
> -- 
> 2.34.1
> 
