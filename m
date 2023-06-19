Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F829734B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjFSFP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSFPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:15:54 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF45E44;
        Sun, 18 Jun 2023 22:15:52 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-341daf315b3so18130225ab.0;
        Sun, 18 Jun 2023 22:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687151752; x=1689743752;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hv4CEmAhj1Hi95VDdTjMuzk8MJM/EyaFg5RhCCtRkFc=;
        b=YCBjDH1vNBMmN+UelBcLVQjJVySjut/ZtvVfWp1FW3tN17dSDadKKsz4sjacMK8c/u
         6bo/rZLfy2EobaWDVTjNcXvULuHQIhgnjcuqXE7jtiSfj/96n0HINvtfXWHkp+17DrpO
         xswNXyrCM/6NFFQ8m9kG9eGaOdUKgp0xniEL2zDqkIB6Bvzgan1C9RUy8EcsaKphD8rP
         XEs2XvbauXbKrSV3z4I6ciVva50Bptd/Z5cLznvY0qUII97vffWXeTH3o57UF4xOhe2G
         oXvPmzoo5Yg1eLxGuxiqrJJ6MxABChui63b8L3T5klAO0YCdr4Jdyxm2QdaEYuRMZfv6
         AKbw==
X-Gm-Message-State: AC+VfDwBihdnaR3yQOKlQUmWVkagMK9v/TbzO9QB5WW1CcgzMvWicJdi
        Z3f9jBFLHxS7qk2G12h6Aw==
X-Google-Smtp-Source: ACHHUZ7Fz0Fna1FCPaUxoew0s8JvdN7I9AHqi+3UkyUlgo1Jp7ZxcUpFDE2ePaiMg6nFm7fhKwaYyA==
X-Received: by 2002:a92:d482:0:b0:342:2727:92ea with SMTP id p2-20020a92d482000000b00342272792eamr4065576ilg.28.1687151751957;
        Sun, 18 Jun 2023 22:15:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t12-20020a02c48c000000b0040f94261ab1sm7967930jam.12.2023.06.18.22.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 22:15:51 -0700 (PDT)
Received: (nullmailer pid 72683 invoked by uid 1000);
        Mon, 19 Jun 2023 05:15:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     vigneshr@ti.com, linux-mtd@lists.infradead.org,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, richard@nod.at,
        miquel.raynal@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230619040742.1108172-2-chris.packham@alliedtelesis.co.nz>
References: <20230619040742.1108172-1-chris.packham@alliedtelesis.co.nz>
 <20230619040742.1108172-2-chris.packham@alliedtelesis.co.nz>
Message-Id: <168715174979.72667.4900626634189785417.robh@kernel.org>
Subject: Re: [PATCH v10 1/1] dt-bindings: mtd: marvell-nand: Convert to
 YAML DT scheme
Date:   Sun, 18 Jun 2023 23:15:49 -0600
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


On Mon, 19 Jun 2023 16:07:42 +1200, Chris Packham wrote:
> From: Vadym Kochan <vadym.kochan@plvision.eu>
> 
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> There was also an incorrect reference to dma-names being "rxtx" where
> the driver and existing device trees actually use dma-names = "data" so
> this is corrected in the conversion.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v10:
>     - Formatting for description
>     - Restrict clocks to 1 item for non-8K devices
>     - Don't allow "marvell,armada-8k-nand-controller" without
>       "marvell,armada370-nand-controller" (undoes a change from v8)
> 
>     Changes in v9:
>     - depend on series from Miquel
>       https://lore.kernel.org/linux-mtd/20230606175246.190465-1-miquel.raynal@bootlin.com/
>     - enforce minimum/maximum for nand-rb
>     - move required: block for controller
>     - move unevaluatedProperties: for nand chip
>     - remove label, partitions and nand-on-flash-bbt which are covered by
>       generic schema
> 
>     Changes in v8:
>     - Mark deprecated compatible values as such
>     - Allow "marvell,armada-8k-nand-controller" without
>       "marvell,armada370-nand-controller"
>     - Make dma-names usage reflect reality
>     - Update commit message
> 
>     Changes in v7:
>     - Restore "label" and "partitions" properties (should be picked up via
>       nand-controller.yaml but aren't)
>     - Add/restore nand-on-flash-bbt and nand-ecc-mode which aren't covered
>       by nand-controller.yaml.
>     - Use "unevalautedProperties: false"
>     - Corrections for clock-names, dma-names, nand-rb and nand-ecc-strength
>     - Add pxa3xx-nand-controller example
> 
>     Changes in v6:
>     - remove properties covered by nand-controller.yaml
>     - add example using armada-8k compatible
> 
>     earlier changes:
> 
>     v5:
>        1) Get back "label" and "partitions" properties but without
>           ref to the "partition.yaml" which was wrongly used.
> 
>        2) Add "additionalProperties: false" for nand@ because all possible
>           properties are described.
> 
>     v4:
>        1) Remove "label" and "partitions" properties
> 
>        2) Use 2 clocks for A7K/8K platform which is a requirement
> 
>     v3:
>       1) Remove txt version from the MAINTAINERS list
> 
>       2) Use enum for some of compatible strings
> 
>       3) Drop:
>             #address-cells
>             #size-cells:
> 
>          as they are inherited from the nand-controller.yaml
> 
>       4) Add restriction to use 2 clocks for A8K SoC
> 
>       5) Dropped description for clock-names and extend it with
>          minItems: 1
> 
>       6) Drop description for "dmas"
> 
>       7) Use "unevalautedProperties: false"
> 
>       8) Drop quites from yaml refs.
> 
>       9) Use 4-space indentation for the example section
> 
>     v2:
>       1) Fixed warning by yamllint with incorrect indentation for compatible list
> 
>  .../bindings/mtd/marvell,nand-controller.yaml | 226 ++++++++++++++++++
>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
>  MAINTAINERS                                   |   1 -
>  3 files changed, 226 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/mtd/raw-nand-chip.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/marvell,nand-controller.example.dtb: nand-controller@d0000: nand@0: False schema does not allow {'reg': [[0]], 'label': ['main-storage'], 'nand-rb': [[0]], 'nand-ecc-mode': ['hw'], 'marvell,nand-keep-config': True, 'nand-on-flash-bbt': True, 'nand-ecc-strength': [[4]], 'nand-ecc-step-size': [[512]], 'partitions': {'compatible': ['fixed-partitions'], '#address-cells': [[1]], '#size-cells': [[1]], 'partition@0': {'label': ['Rootfs'], 'reg': [[0, 1073741824]]}}}
	from schema $id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/marvell,nand-controller.example.dtb: nand-controller@d0000: nand@0: Unevaluated properties are not allowed ('label', 'nand-on-flash-bbt', 'partitions' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/marvell,nand-controller.example.dtb: nand-controller@720000: nand@0: False schema does not allow {'reg': [[0]], 'label': ['main-storage'], 'nand-rb': [[0]], 'nand-ecc-mode': ['hw'], 'nand-ecc-strength': [[8]], 'nand-ecc-step-size': [[512]]}
	from schema $id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/marvell,nand-controller.example.dtb: nand-controller@720000: nand@0: Unevaluated properties are not allowed ('label' was unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/marvell,nand-controller.example.dtb: nand-controller@43100000: nand@0: False schema does not allow {'reg': [[0]], 'nand-rb': [[0]], 'nand-ecc-mode': ['hw'], 'marvell,nand-keep-config': True}
	from schema $id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230619040742.1108172-2-chris.packham@alliedtelesis.co.nz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

