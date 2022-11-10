Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A696247E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiKJREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiKJREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:04:00 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A174205C7;
        Thu, 10 Nov 2022 09:03:58 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id h132so2459519oif.2;
        Thu, 10 Nov 2022 09:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZauaV7R0boEkRS/4cI0JRTPB10EksAIDg3xneN7uxuA=;
        b=mrmnQAH/TSqD5tspRhyuaRj50Cdk9kcTc4wrbXA34h1Proi5fhLtbpA2iZlpqARLRr
         UUMs591d/CKNvB9YrK2ZODty2244psctnFMUiOkXMytF/sm+ykk/NcY8XX9bNjrgpC/1
         TSXXSktz5RyrBIAL3r3do/MNTyvx3/pr6+yooae7ez8dqC3O8il90/TuJnHCzX/XVhri
         zfAef6wKt8TE95nP5nhp5lIDhQCOOamAQ2BxcdIKTPQMVapT9ZhMTBmjlHa/VarqNvhj
         TYJh0AhwjKjRUTSFnBDEQhTAA9LpznqiKqhUeG9pGc9a8aGLxVncGL7pir7K8p1ZuFap
         g5+w==
X-Gm-Message-State: ACrzQf2qMLK9ILBIV8j+LKtIGQTKkGrdRbS+l2wlWhF4bvMiyXVbWx2V
        yH682JfNIlKItepEpGyekA==
X-Google-Smtp-Source: AMsMyM4Yp3iUigocKbqApqt4C7F98cB6rCXK14bs5kCUOlF50IIvWusqDG+oqGMm+h7ibPBmrFzsiw==
X-Received: by 2002:a05:6808:1ab4:b0:35a:60a3:77d8 with SMTP id bm52-20020a0568081ab400b0035a60a377d8mr1436363oib.127.1668099837994;
        Thu, 10 Nov 2022 09:03:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g37-20020a9d2da8000000b0066cacb8343bsm56352otb.41.2022.11.10.09.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:03:57 -0800 (PST)
Received: (nullmailer pid 532546 invoked by uid 1000);
        Thu, 10 Nov 2022 17:03:59 -0000
Date:   Thu, 10 Nov 2022 11:03:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] Improve MTD bindings
Message-ID: <20221110170359.GA528639-robh@kernel.org>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 05:47:01PM +0100, Miquel Raynal wrote:
> Hello,
> 
> During a yaml conversion review, Krzysztof opened the discussion about
> the links and references made between the different files in the mtd
> bindings. I figured out some minimal changes might be needed to properly
> reference everything correctly and ensure we constrain as much as
> possible the existing bindings. That is what I tried to do here.
> 
> The idea is:
> * partition.yaml defines one MTD partition
> * parsers/*.yaml define partition parsers (mainly compatibles)
> * mtd.yaml contains the generic definition of any mtd device (nand,
>   spi-nand, spi-nor, nor, sram, etc), in particular, it defines the
>   various partition formats (legacy and current) and references
>   partition.yaml as well as a list of all the possible parsers within a
>   "partitions" node.
> * nand-chip.yaml, jedec,spi-nor, mtd-physmap.yaml all describe real
>   instances of mtd device, each of them with a different underlying
>   technology, they reference mtd.yaml 
> * nand-controller.yaml has subnodes which reference nand-chip.yaml.
> * Specific NAND controller bindings reference nand-controller.yaml.
> 
> I've tested each and every patch with the following command and it
> worked fine:
> $ make dt_binding_check -j10 DT_CHECKER_FLAG=-m DT_SCHEMA_FILES=mtd/
> 
> Comments welcome of course :-)
> 
> Cheers,
> Miquèl
> 
> Changes in v2:
> * Fixed all the missing references to partitions.txt.
> * Created a proper partitions.yaml file to cut the logic
> * Constrained #{address,size}-cells to 1 or 2.
> * Used the description advised by Rob to list all the possible partition
>   parsers without having to actually duplicate the compatibles.
> * Deprecated the #{address,size}-cells properties when relevant.
> * Fixed a regex pattern to match all sram device node names (including
>   ones defined under memory-controllers.
> * Added a comment on another "additionalProperties: true" situation.
> * Dropped even more duplicated properties.
> * Fixed a few typos (like s/phymap/physmap/).
> * Changed qcom,smem-part partition type.
> * Standardized the style in the various examples.
> * Improved the nvmem-cells file as well.
> * Added an example to the sunxi-nand bindings.
> 
> Miquel Raynal (17):
>   dt-bindings: mtd: Clarify all partition subnodes
>   dt-bindings: mtd: Remove useless file about partitions
>   dt-bindings: mtd: nand-chip: Reference mtd.yaml
>   dt-bindings: mtd: nand: Drop common properties already defined in
>     generic files
>   dt-bindings: mtd: nand: Standardize the child node name
>   dt-bindings: mtd: ingenic: Mark partitions in the controller node as
>     deprecated
>   dt-bindings: mtd: onenand: Mention the expected node name
>   dt-bindings: mtd: sunxi-nand: Add an example to validate the bindings
>   dt-bindings: mtd: spi-nor: Drop common properties
>   dt-bindings: mtd: physmap: Reuse the generic definitions
>   dt-bindings: mtd: partitions: Constrain the list of parsers
>   dt-bindings: mtd: partitions: Change qcom,smem-part partition type
>   dt-bindings: mtd: nvmem-cells: Fix example
>   dt-bindings: mtd: nvmem-cells: Inherit from MTD partitions
>   dt-bindings: mtd: Argue in favor of keeping additionalProperties set
>     to true
>   dt-bindings: mtd: Drop object types when referencing other files
>   dt-bindings: mtd: Standardize the style in the examples

Other than my comment on patch 13, for the series:

Reviewed-by: Rob Herring <robh@kernel.org>
