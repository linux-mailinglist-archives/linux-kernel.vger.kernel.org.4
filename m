Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A746F8BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjEEV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjEEV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:56:15 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C214C29;
        Fri,  5 May 2023 14:56:11 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6a5f21a0604so1609576a34.2;
        Fri, 05 May 2023 14:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323771; x=1685915771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNSzvzZVt7UhzIY8EoLz5e+V2L8esY8YLcJw3l2ZqdI=;
        b=A9hBqqh3VMwLW6IOMrKzKW8ksgaJQhRzpiPI6+OsTRufVvrgLpNKXfgjnnsuvUkZnP
         LiR1rQivO0MQTMFNyQ8J8pJ7DUXA3ER7Ow/iM54CbvZ/BY9pIVPCiIRDXAtn+DuhlxOB
         HlMiYp57qRHssYHht5N1aleZdUsg7qhIpwuGmMdlF2xxHC+hISZAV1WeWHPyyIw243b7
         euaAU94MrCjidAFGmCHvMj7pO6S7zPNmllESuEsQx0H935n3o/1NVBTbYW8oAiBrMS8p
         SeVM7V1ESH6QTUcx33W2TkJBiUJJBbHhnEDWxExikAQiVgfeaWk0UFafRPeY5bhLDRm/
         EBBg==
X-Gm-Message-State: AC+VfDxew7SEDe1wIuClR/+eT9hhAT8RFmtwjGtar0zAU2ir101swZ4k
        8+5xQYJJFHqK+9V1U7Azxw==
X-Google-Smtp-Source: ACHHUZ5zgZU6g0y02V5jdYf6mrjFieqefFlz1SVWsfrF5XzkkX8aQBWc1/4RPWTq7PD4kohrvqcyNg==
X-Received: by 2002:a9d:5909:0:b0:6a6:23eb:728e with SMTP id t9-20020a9d5909000000b006a623eb728emr1298665oth.29.1683323770900;
        Fri, 05 May 2023 14:56:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n4-20020a0568301e8400b0069f0a85fa36sm1348780otr.57.2023.05.05.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:56:10 -0700 (PDT)
Received: (nullmailer pid 3630402 invoked by uid 1000);
        Fri, 05 May 2023 21:56:09 -0000
Date:   Fri, 5 May 2023 16:56:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: partitions: add linux,ubi
 compatible
Message-ID: <20230505215609.GA3620855-robh@kernel.org>
References: <cover.1683043928.git.daniel@makrotopia.org>
 <faa0ceb4470f7160b05e892932d20b4a540c5955.1683043928.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa0ceb4470f7160b05e892932d20b4a540c5955.1683043928.git.daniel@makrotopia.org>
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

On Tue, May 02, 2023 at 05:48:39PM +0100, Daniel Golle wrote:
> Add bindings for MTD partitions to be attached as UBI devices.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/mtd/partitions/ubi.yaml          | 49 +++++++++++++++++++

linux,ubi.yaml

>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> new file mode 100644
> index 0000000000000..aa02fbbd50716
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unsorted Block Images (UBI)
> +
> +description: |
> + Unsorted Block Images (UBI) is a volume management system typically
> + used on NAND flash providing bad block management as well as
> + wear-leveling.
> + Any partition containing the compatible "linux,ubi" will be attached
> + as UBI device.
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/partition.yaml#
> +
> +properties:
> +  compatible:
> +    const: linux,ubi
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            label = "bootloader";
> +            reg = <0x000000 0x100000>;
> +            read-only;
> +        };
> +
> +        ubi@100000 {
> +            compatible = "linux,ubi";
> +            label = "ubi";
> +            reg = <0x100000 0x7f00000>;
> +        };
> +    };
> -- 
> 2.40.1
> 
