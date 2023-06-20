Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5F7372B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFTRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFTRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:25:15 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C11987;
        Tue, 20 Jun 2023 10:25:09 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-340b8d6aabbso13931915ab.0;
        Tue, 20 Jun 2023 10:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281908; x=1689873908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZJ+hfBpoF28qpVP1tAqIlMpScd7lp8C36ke23sPJp8=;
        b=VB9rGNXCcLOLsMQrmtNapN1Xu4nsBJPVfsvIbX6/Dk/YAlITjVOXPlwRHurlYoGokG
         XkQ3/LsotcmcMhBl+YbPA/zbj5H2x2vFv7y8UhwXSrW3I3eFx7A6jcZftIToarx128Sf
         Gz3UiLxPwxsiz14KTaU+/YP92G0tV6q5KBrVg2sZ1VSa8okXyp2Wx/505D42lXBDJUeq
         +X8cyZqUWilCu4fz8Xsb+v+EHMNOEHH9oPD54sSTKJO3myuv5Atbffe9bQQVOcGpYR4w
         NSzwgDQ8r0bJwsA9VQGbTmdMKtU4SnQ+x1CSnRkUdZnaqKC4mrFCBdbwdOzmBlLtfESu
         QV8g==
X-Gm-Message-State: AC+VfDz4CDOUd7IlTQz6qIGGBuVWiSmPIyUXS9eHuH9+2HC7RsuWw5QL
        VP2TT53+0DbA68lgG+PVPA==
X-Google-Smtp-Source: ACHHUZ4H/q0T8pya673w/shwpYZ9QN8Qh4OiR7wXve8GAzm2Vls6m0Ux1AK9FTWt+Wu0v+SRZI3bgg==
X-Received: by 2002:a92:d3cb:0:b0:342:2b27:725c with SMTP id c11-20020a92d3cb000000b003422b27725cmr7398168ilh.6.1687281908194;
        Tue, 20 Jun 2023 10:25:08 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cecc000000b003428aca64bdsm723883ilq.84.2023.06.20.10.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:07 -0700 (PDT)
Received: (nullmailer pid 3856420 invoked by uid 1000);
        Tue, 20 Jun 2023 17:25:05 -0000
Date:   Tue, 20 Jun 2023 11:25:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, robh+dt@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v10 1/1] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <168728190550.3856357.9055862614036194300.robh@kernel.org>
References: <20230619040742.1108172-1-chris.packham@alliedtelesis.co.nz>
 <20230619040742.1108172-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619040742.1108172-2-chris.packham@alliedtelesis.co.nz>
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

Reviewed-by: Rob Herring <robh@kernel.org>

