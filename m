Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFEE748E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjGETwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjGETwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:52:42 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083A1BC8;
        Wed,  5 Jul 2023 12:52:11 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-783698a37beso355521139f.0;
        Wed, 05 Jul 2023 12:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586717; x=1691178717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgxCgI0UhXaalrd8FtZ3lKHjbHQYR+CHqoq8oQgcBj8=;
        b=X3pVCOmJpBbfhdZcDChPxYRTG0mCFQZt8+ukhvnQO3NhFvLkORBDgf3sjcjqkuiqD4
         amg9a+jR8VFrCeWiLt42DJ3jsdXBvNPi37tbB3DyFEL1DHJ86PgVwnuHUxNTq1cJbrBC
         9zFUraBoag4A+IJSmyYJDIMdK5G2XO96jjlrfriv7urOV/j8Ryo7Ym0D+PpZKHiaN3n/
         OtgSihTll7aGI5tSINq5j07NxsNaZwG6BZ+hLXqV9/mcr4NOUFPQcXWQHFVIjexw5zjP
         nDwLBebILpX9576jAZUotFTjdZF36D0b3saB8FCvMNVtJlPeaCHKAGTQbiwzTGu6zhAQ
         FWaA==
X-Gm-Message-State: ABy/qLYRAwDzRWznqsLkTlFwPJKXLZNs1esCgkAEzgmkokEPhPWQgFPT
        zewTzFqlW2YifnWhcB57kw==
X-Google-Smtp-Source: APBJJlFfE26pMmnc4X7bL1ZeGdt2/p9FLN9uM6KgYidS2YWs2WUaDK7eEf0pVgwqz52ouAz0T6SvXg==
X-Received: by 2002:a5e:891a:0:b0:785:ff35:f340 with SMTP id k26-20020a5e891a000000b00785ff35f340mr118432ioj.14.1688586717448;
        Wed, 05 Jul 2023 12:51:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h2-20020a02c4c2000000b00411bdcdc488sm7729558jaj.173.2023.07.05.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:51:56 -0700 (PDT)
Received: (nullmailer pid 1730881 invoked by uid 1000);
        Wed, 05 Jul 2023 19:51:54 -0000
Date:   Wed, 5 Jul 2023 13:51:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: Add SEAMA partition bindings
Message-ID: <20230705195154.GA1702900-robh@kernel.org>
References: <20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org>
 <20230705-seama-partitions-v2-1-9d349f0d5ab7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-seama-partitions-v2-1-9d349f0d5ab7@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:17:46PM +0200, Linus Walleij wrote:
> This types of NAND partitions appear in OpenWrt and
> U-Boot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix up the binding to be childless
> ---
>  .../bindings/mtd/partitions/partitions.yaml        |  1 +
>  .../devicetree/bindings/mtd/partitions/seama.yaml  | 50 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> index 2edc65e0e361..9bd0a8d800da 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> @@ -21,6 +21,7 @@ oneOf:
>    - $ref: linksys,ns-partitions.yaml
>    - $ref: qcom,smem-part.yaml
>    - $ref: redboot-fis.yaml
> +  - $ref: seama.yaml

I think this is in the wrong place. These should be device level 
partitioning schemas, not an individual partition type. (Though nesting 
is possible)

>  
>  properties:
>    compatible: true
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
> new file mode 100644
> index 000000000000..5ed7764bba69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/seama.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Seattle Image Partitions
> +
> +description: The SEAttle iMAge (SEAMA) partition is a type of partition
> +  used for NAND flash devices. This type of flash image is found in some
> +  D-Link routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L,
> +  DIR890L and DCH-M225, as well as in WD and NEC routers on the ath79
> +  (MIPS), Broadcom BCM53xx, and RAMIPS platforms. This partition type
> +  does not have children defined in the device tree, they need to be
> +  detected by software.
> +
> +allOf:
> +  - $ref: partition.yaml#
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +select: false

Remove this and your example will fail. You need unevaluatedProperties.

There's a problem in partitions.yaml. It never gets applied, so this 
schema never gets applied. The default 'select' is generated based on 
$nodename or compatible, but it has neither. This needs some more 
thought on how to fix given the variable way partitions can be combined. 
Probably at a minimum, all the 'select: false' need to be removed. 

> +
> +properties:
> +  compatible:
> +    const: seama
> +
> +  '#address-cells': false
> +
> +  '#size-cells': false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            compatible = "seama";
> +            reg = <0x0 0x800000>;
> +            label = "firmware";
> +        };
> +    };
> 
> -- 
> 2.34.1
> 
