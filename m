Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F15B8BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiINPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521B792F1;
        Wed, 14 Sep 2022 08:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 324D061D42;
        Wed, 14 Sep 2022 15:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDBEC433B5;
        Wed, 14 Sep 2022 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663169144;
        bh=s8Zya7nr1IH4LVxPFMGBwyM71TXotZVu5kNE5NlYC/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vq4vNCCDuGHeXI3L68QpDsugkMEhH5uCfpQivnP+GMenxfWRptCv6jwxiHGDl/BSf
         pB77X7SNP6gEB7/BOmjko6qJD2hk61I/bbUVTF/KOoMmOMkQQCMqKTHDJpY9SK2iSA
         sE6KCnLTWgA40ft6kXxEGhhw+8WnBPjwRDsugN2bs42rXZ0JKfri+HWnn8vrQ2UTdD
         RVGjtbeqO+/x4ltnPyhMyIFDcHuX0zgk7y6FihuOC6FSrREy5TjbQRejMXJqN9mCqt
         FyoVi6vg0FOtnLvAgb8Ue5VydpkeyxpzF1rgmhbsMe49MFcOvjLK6kIGnrSjK5nSYB
         x3U6LR0Uu3bkA==
Received: by mail-vs1-f53.google.com with SMTP id 129so16258026vsi.10;
        Wed, 14 Sep 2022 08:25:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo0tFrVimLo2Fk2ce9yhYlnPthjDpRxTDPtCGFXTRSI9Sg6KLCAz
        ThIZsFQIoTmJuJGhLJ9DoecbH0iqwIIr9g5bvw==
X-Google-Smtp-Source: AA6agR5T0qx3DOjT227Yr0wW94npJRy1Hsz66HzwaAkZ/JvVj0UCT1kCcq+i3sBbLO+o2pXkwZGEM6fSwmotX2R8QDc=
X-Received: by 2002:a67:c18a:0:b0:398:4c72:cafb with SMTP id
 h10-20020a67c18a000000b003984c72cafbmr9193050vsj.53.1663169143415; Wed, 14
 Sep 2022 08:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220913131447.2877280-1-cyndis@kapsi.fi> <20220913131447.2877280-4-cyndis@kapsi.fi>
 <20220914120840.GA1837218-robh@kernel.org> <6d739e27-c41c-e18f-8d13-0c38b912aa86@kapsi.fi>
 <YyHl+4O56brs1Pik@orome>
In-Reply-To: <YyHl+4O56brs1Pik@orome>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Sep 2022 10:25:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLGgjb97amt6dc7k-k6O=cDQNMteWadtf-x-9NdVz1eJw@mail.gmail.com>
Message-ID: <CAL_JsqLGgjb97amt6dc7k-k6O=cDQNMteWadtf-x-9NdVz1eJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: Add bindings for Tegra234 NVDEC
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Sameer Pujar <spujar@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 9:32 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Sep 14, 2022 at 03:19:01PM +0300, Mikko Perttunen wrote:
> > On 9/14/22 15:08, Rob Herring wrote:
> > > On Tue, Sep 13, 2022 at 04:14:41PM +0300, Mikko Perttunen wrote:
> > > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > > >
> > > > Update NVDEC bindings for Tegra234. This new engine version only has
> > > > two memory clients, but now requires three clocks, and as a bigger
> > > > change the engine loads firmware from a secure carveout configured by
> > > > the bootloader.
> > > >
> > > > For the latter, we need to add a phandle to the memory controller
> > > > to query the location of this carveout, and several other properties
> > > > containing offsets into the firmware inside the carveout. These
> > > > properties are intended to be populated through a device tree overlay
> > > > configured at flashing time, so that the values correspond to the
> > > > flashed NVDEC firmware.
> > > >
> > > > As the binding was getting large with many conditional properties,
> > > > also split the Tegra234 version out into a separate file.
> > > >
> > > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > > ---
> > > > v2:
> > > > - Split out into separate file to avoid complexity with
> > > >    conditionals etc.
> > > > ---
> > > >   .../gpu/host1x/nvidia,tegra234-nvdec.yaml     | 154 ++++++++++++++++++
> > > >   1 file changed, 154 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
> > > > new file mode 100644
> > > > index 000000000000..eab0475ca983
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
> > > > @@ -0,0 +1,154 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra234-nvdec.yaml#"
> > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > +
> > > > +title: Device tree binding for NVIDIA Tegra234 NVDEC
> > > > +
> > > > +description: |
> > > > +  NVDEC is the hardware video decoder present on NVIDIA Tegra210
> > > > +  and newer chips. It is located on the Host1x bus and typically
> > > > +  programmed through Host1x channels.
> > > > +
> > > > +maintainers:
> > > > +  - Thierry Reding <treding@gmail.com>
> > > > +  - Mikko Perttunen <mperttunen@nvidia.com>
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^nvdec@[0-9a-f]*$"
> > > > +
> > > > +  compatible:
> > > > +    enum:
> > > > +      - nvidia,tegra234-nvdec
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 3
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: nvdec
> > > > +      - const: fuse
> > > > +      - const: tsec_pka
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: nvdec
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  iommus:
> > > > +    maxItems: 1
> > > > +
> > > > +  dma-coherent: true
> > > > +
> > > > +  interconnects:
> > > > +    items:
> > > > +      - description: DMA read memory client
> > > > +      - description: DMA write memory client
> > > > +
> > > > +  interconnect-names:
> > > > +    items:
> > > > +      - const: dma-mem
> > > > +      - const: write
> > > > +
> > > > +  nvidia,memory-controller:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description:
> > > > +      phandle to the memory controller for determining carveout information.
> > > > +
> > > > +  nvidia,bl-manifest-offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Offset to bootloader manifest from beginning of firmware. Typically set as
> > > > +      part of a device tree overlay corresponding to flashed firmware.
> > > > +
> > > > +  nvidia,bl-code-offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Offset to bootloader code section from beginning of firmware. Typically set as
> > > > +      part of a device tree overlay corresponding to flashed firmware.
> > > > +
> > > > +  nvidia,bl-data-offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Offset to bootloader data section from beginning of firmware. Typically set as
> > > > +      part of a device tree overlay corresponding to flashed firmware.
> > > > +
> > > > +  nvidia,os-manifest-offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Offset to operating system manifest from beginning of firmware. Typically set as
> > > > +      part of a device tree overlay corresponding to flashed firmware.
> > > > +
> > > > +  nvidia,os-code-offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Offset to operating system code section from beginning of firmware. Typically set as
> > > > +      part of a device tree overlay corresponding to flashed firmware.
> > > > +
> > > > +  nvidia,os-data-offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Offset to operating system data section from beginning of firmware. Typically set as
> > > > +      part of a device tree overlay corresponding to flashed firmware.
> > >
> > > I don't think DT is the place for describing your runtime loaded
> > > firmware layout.
> > >
> > > Rob
> >
> > The way I see it, from the kernel's point of view it's not runtime loaded
> > but a contract with the bootloader. Bootloader sets up hardware in a certain
> > way the kernel doesn't otherwise know so the bootloader needs to tell the
> > kernel how the hardware is set up.
> >
> > The fact that the information is supplied through an overlay is accidental
> > -- equivalently the bootloader that sets up the firmware could adjust the
> > device tree like we do in other situations, but in this case an overlay is
> > an easier implementation method.
>
> I think the key bit of information to know here is that the kernel is
> not permitted to load this firmware. It's a bootloader early in the boot
> process that sets this up in a secure context and then needs to convey
> that information to the kernel.
>
> Perhaps a slightly more idiomatic way to pass this information would be
> using a reserved memory node? That could span the entirety of the secure
> carveout (therefore removing the need to query the memory controller for
> that information) and be identified with a compatible string that would
> allow custom properties for these various offsets. Yet another way would
> be to have each of the bootloader and OS regions (manifest, code and
> data) be their own reserved memory regions. But given that this is one
> chunk with different regions inside makes that seem excessive.
>
> Rob, do you have any other ideas how this information could be passed to
> the kernel if not via DT?

Just update the description summarizing the above removing the overlay
aspect as when they are set is more important than how.

Rob
