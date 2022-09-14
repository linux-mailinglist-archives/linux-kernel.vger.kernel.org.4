Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA05B87D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiINMIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiINMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:08:44 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E17F26A;
        Wed, 14 Sep 2022 05:08:43 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id x23-20020a056830409700b00655c6dace73so7886297ott.11;
        Wed, 14 Sep 2022 05:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hMLOKeXHOSnfU4zqlH09bFkg9yKTy1Fq4MgQhLwV+DM=;
        b=WqKPOl6rGbJkJDcmUZJKm9+cFsO7LUXmJzzIuABQtOGMH61PFFFE6DlEYv5XcyZurb
         P6ih1dm839xQss4jsNECSTSPLjfY66ziaAgWveGhr2r59MzK9oAUlis6efayvsrybFbL
         1kORO6DN4zFFWAUMoq9TWm/iWyYw3pElSDmLGBM4SszCmo39CXNRkIyU+gPW5tCXOloC
         V6YpX0IY3pL7ig46D6oJbv9tGQn4UM8RdXuqqHRJzpc+rwhDM3+zKi08QN7s+0mwKpsD
         S5QrYU1BxPkKqFgLxb2m3lGOWu3w7Te37yyPn8In99e0PLNrHUPXbzHjNsKPN5baXsGD
         RQGQ==
X-Gm-Message-State: ACgBeo3RF0fSJ34gdTAuMpZKTGEbcC/2BhMzccgXZf8ed4FTwUtkwSbu
        yG3/O354+F9TwmC4hDvwxA==
X-Google-Smtp-Source: AA6agR4qmKdSRMjr6cCYgddorY7oSjwFoX8ZUGglOu9qJOO8G4H+NFYqgp2cN0UGOoshspqJbqDiNQ==
X-Received: by 2002:a05:6830:6104:b0:654:fb1:faba with SMTP id ca4-20020a056830610400b006540fb1fabamr10605314otb.183.1663157322251;
        Wed, 14 Sep 2022 05:08:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m26-20020a0568301e7a00b006339b36127dsm7172351otr.3.2022.09.14.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:08:41 -0700 (PDT)
Received: (nullmailer pid 1869045 invoked by uid 1000);
        Wed, 14 Sep 2022 12:08:40 -0000
Date:   Wed, 14 Sep 2022 07:08:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: Add bindings for Tegra234 NVDEC
Message-ID: <20220914120840.GA1837218-robh@kernel.org>
References: <20220913131447.2877280-1-cyndis@kapsi.fi>
 <20220913131447.2877280-4-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913131447.2877280-4-cyndis@kapsi.fi>
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

On Tue, Sep 13, 2022 at 04:14:41PM +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Update NVDEC bindings for Tegra234. This new engine version only has
> two memory clients, but now requires three clocks, and as a bigger
> change the engine loads firmware from a secure carveout configured by
> the bootloader.
> 
> For the latter, we need to add a phandle to the memory controller
> to query the location of this carveout, and several other properties
> containing offsets into the firmware inside the carveout. These
> properties are intended to be populated through a device tree overlay
> configured at flashing time, so that the values correspond to the
> flashed NVDEC firmware.
> 
> As the binding was getting large with many conditional properties,
> also split the Tegra234 version out into a separate file.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Split out into separate file to avoid complexity with
>   conditionals etc.
> ---
>  .../gpu/host1x/nvidia,tegra234-nvdec.yaml     | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
> new file mode 100644
> index 000000000000..eab0475ca983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra234-nvdec.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Device tree binding for NVIDIA Tegra234 NVDEC
> +
> +description: |
> +  NVDEC is the hardware video decoder present on NVIDIA Tegra210
> +  and newer chips. It is located on the Host1x bus and typically
> +  programmed through Host1x channels.
> +
> +maintainers:
> +  - Thierry Reding <treding@gmail.com>
> +  - Mikko Perttunen <mperttunen@nvidia.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^nvdec@[0-9a-f]*$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra234-nvdec
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: nvdec
> +      - const: fuse
> +      - const: tsec_pka
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: nvdec
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  interconnects:
> +    items:
> +      - description: DMA read memory client
> +      - description: DMA write memory client
> +
> +  interconnect-names:
> +    items:
> +      - const: dma-mem
> +      - const: write
> +
> +  nvidia,memory-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the memory controller for determining carveout information.
> +
> +  nvidia,bl-manifest-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to bootloader manifest from beginning of firmware. Typically set as
> +      part of a device tree overlay corresponding to flashed firmware.
> +
> +  nvidia,bl-code-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to bootloader code section from beginning of firmware. Typically set as
> +      part of a device tree overlay corresponding to flashed firmware.
> +
> +  nvidia,bl-data-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to bootloader data section from beginning of firmware. Typically set as
> +      part of a device tree overlay corresponding to flashed firmware.
> +
> +  nvidia,os-manifest-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to operating system manifest from beginning of firmware. Typically set as
> +      part of a device tree overlay corresponding to flashed firmware.
> +
> +  nvidia,os-code-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to operating system code section from beginning of firmware. Typically set as
> +      part of a device tree overlay corresponding to flashed firmware.
> +
> +  nvidia,os-data-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to operating system data section from beginning of firmware. Typically set as
> +      part of a device tree overlay corresponding to flashed firmware.

I don't think DT is the place for describing your runtime loaded 
firmware layout.

Rob
