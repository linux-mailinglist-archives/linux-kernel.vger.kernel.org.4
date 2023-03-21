Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0F6C3D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCUWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:18:40 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE81E5F7;
        Tue, 21 Mar 2023 15:18:39 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 14-20020a9d010e000000b0069f1287f557so5029305otu.0;
        Tue, 21 Mar 2023 15:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgT8vls4hh33J9msm1OhhnWu9ZRUnj1Q8H8sA1kcql4=;
        b=2j1XzdhuJEgmIpJjAEjO4juWgUjZhnhG4F+vsFq4Fs1JeMUCW/eIwYloRHP/AEMz0Z
         DSbaIHp+FEKUml/nMMI2a4PtDFITbIrnwoKnAEIvqmdfzuuaq4VsUfDxcvQtQy1ZbGsG
         63R7sdtvAe9EKhnn8/9smsw/wOTc3S2nBYEvfqeQL2yTY33aUz0xUgrZOyBvDK25fT/r
         KNxEHBLbbR301JfVDIXL70UN8H/NL3L87CfL8GyuBkToo8GR9jLFSoLAZOcHFY2qCVgl
         hzAAtgUpR98UTWx8PQLlFMfAFoFyFCRGPhvVRCUPLzoFUwN0AvHjr/5Rjt+8/1EtcYpP
         9Pmg==
X-Gm-Message-State: AO0yUKXR0S0IIES71tHon3po1bVdBnW68dLLeg+Fy7kUwJr/g7S6555+
        G3xQ37Lf63xXO9h0C3fdWguzAKU2Lg==
X-Google-Smtp-Source: AK7set+rU5ha02hkCLeAmjMoAnusptaZ98SOslOUw6UTplb/Yxc9KvFfzwg/VROypKzVU4n34lhKIA==
X-Received: by 2002:a9d:3f6:0:b0:693:c3bb:8392 with SMTP id f109-20020a9d03f6000000b00693c3bb8392mr74660otf.7.1679437119170;
        Tue, 21 Mar 2023 15:18:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm5163244ooq.8.2023.03.21.15.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:18:38 -0700 (PDT)
Received: (nullmailer pid 1764639 invoked by uid 1000);
        Tue, 21 Mar 2023 22:18:37 -0000
Date:   Tue, 21 Mar 2023 17:18:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system
 controller
Message-ID: <20230321221837.GA1751474-robh@kernel.org>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com>
 <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
 <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com>
 <ce13ca6c-e61a-d31e-2626-d818a5d0e15e@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce13ca6c-e61a-d31e-2626-d818a5d0e15e@arinc9.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:09:59AM +0300, Arınç ÜNAL wrote:
> On 21.03.2023 10:00, Sergio Paracuellos wrote:
> > On Tue, Mar 21, 2023 at 7:45 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > 
> > > On 21/03/2023 06:00, Sergio Paracuellos wrote:
> > > > Adds device tree binding documentation for system controller node present
> > > > in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
> > > > for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
> > > > RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> > > > 
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >   .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
> > > >   1 file changed, 65 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> > > > new file mode 100644
> > > > index 000000000000..f07e1652723b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> > > > @@ -0,0 +1,65 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: MTMIPS SoCs System Controller
> > > > +
> > > > +maintainers:
> > > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > +
> > > > +description: |
> > > > +  MediaTek MIPS and Ralink SoCs provides a system controller to allow
> > > > +  to access to system control registers. These registers include clock
> > > > +  and reset related ones so this node is both clock and reset provider
> > > > +  for the rest of the world.
> > > > +
> > > > +  These SoCs have an XTAL from where the cpu clock is
> > > > +  provided as well as derived clocks for the bus and the peripherals.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - ralink,mt7620-sysc
> > > 
> > > Since you decided to send it before we finish discussion:
> > > NAK - this is already used as mediatek
> > 
> > Sorry, there was too much stuff commented so I preferred to clean up
> > all of them while maintaining the compatibles with the ralink prefix
> > instead since that was where the current discussion was at that point.
> > 
> > > 
> > > > +          - ralink,mt7620a-sysc
> > 
> > As I have said, this one exists:
> > 
> > arch/mips/ralink/mt7620.c:      rt_sysc_membase =
> > plat_of_remap_node("ralink,mt7620a-sysc");
> > 
> > 
> > > > +          - ralink,mt7628-sysc
> > > 
> > > Same here.
> > > 
> > > > +          - ralink,mt7688-sysc
> > > 
> > > I expect you to check the others.
> > 
> > I can change others to mediatek but that would be a bit weird, don't you think?
> 
> I've seen some parts of the MTMIPS platform use mediatek compatible strings
> thanks to Krzysztof pointing them out. I don't like having some parts of the
> MTMIPS platform (pci, mmc, usbphy, etc.) with mediatek compatible string
> while others are ralink.

That's unfortunate, but again, compatibles are just unique identifiers. 
They are only wrong if they aren't unique...

> Like Krzysztof said [0], Ralink is now Mediatek, thus there is no conflict
> and no issues with different vendor used. So I'd rather keep new things
> Ralink and gradually change these mediatek strings to ralink.

So break the ABI multiple times slowly. Again, either you live with 
*all* the existing compatible strings or you declare it is fine to break 
the ABI on these platforms and switch everything at once. Carrying both 
strings (in bindings or drivers) and breaking the ABI is lose-lose.

Rob
