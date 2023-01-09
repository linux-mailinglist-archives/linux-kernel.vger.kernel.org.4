Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAB66253F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbjAIMQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbjAIMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:15:56 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16FA1AC;
        Mon,  9 Jan 2023 04:15:54 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id h10so6058482qvq.7;
        Mon, 09 Jan 2023 04:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v56FuzTOF65NQx86r40RWrRUL/Au3qdgwGh4dAhX/Q=;
        b=XHOLDZ/kESuYN4g/G4oLqcQ4+FnNUlHSCJ+nRkAih3HN4kAVchC2GiHEW6gqAUROsA
         Vs7lVNYF3pCmnnZ6GkiK6d/JLl1zxFFvNSeO4lBN6lDrDsw3cagrVqALOEB9jdCFAGbh
         oJW5TXsbAA5sS55uJev3RJNOIwz/i7NYc+nuJPD2k1Fc7BkclF6+KaS1MR0osHxLQvAc
         HGq/Zl5QocVH4u9uaUvtq4mSRNUJUqSmLvJLg/J68W2+ef+4VqijoRpUTO20fT/ShIY/
         JIotNwmZ5VJsA8r08clPoIuTeUQ7NygpTiCUCVlmDWaOEIeXo8HFBawknnRmTE4Nbr65
         AP4A==
X-Gm-Message-State: AFqh2kr9YCEuS6XZ6QDSwc2sBEzrnMsoGtWl1LaiV6358V4KzU/fdnBU
        T2ol0lqJoIrIK74gC02oJfkcDPFzjwezDw==
X-Google-Smtp-Source: AMrXdXuNjFPmuJ7BKbGEb5LyMEi7Qd9ysHPTDlVQWyTtW97BoLanJqlTOcguH51wlYDbzOJpoJ+PCg==
X-Received: by 2002:a0c:bf52:0:b0:531:dcf9:a17e with SMTP id b18-20020a0cbf52000000b00531dcf9a17emr28364132qvj.26.1673266553084;
        Mon, 09 Jan 2023 04:15:53 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bl19-20020a05620a1a9300b006fa9d101775sm4240295qkb.33.2023.01.09.04.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:15:52 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-482363a1232so110190757b3.3;
        Mon, 09 Jan 2023 04:15:52 -0800 (PST)
X-Received: by 2002:a05:690c:c02:b0:48d:1334:6e38 with SMTP id
 cl2-20020a05690c0c0200b0048d13346e38mr4982292ywb.316.1673266551917; Mon, 09
 Jan 2023 04:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y7iYZqKcoRycsoTg@spud> <CA+V-a8uBDx42o12UUwP=bBjeGzJJSP=jPcQr0xgkvkkoA7_vFA@mail.gmail.com>
In-Reply-To: <CA+V-a8uBDx42o12UUwP=bBjeGzJJSP=jPcQr0xgkvkkoA7_vFA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 13:15:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7bfJXo4FujuwEOOzNsdEWB60VYurdFdbO8GwTMwb5yA@mail.gmail.com>
Message-ID: <CAMuHMdW7bfJXo4FujuwEOOzNsdEWB60VYurdFdbO8GwTMwb5yA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Sat, Jan 7, 2023 at 9:47 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Jan 6, 2023 at 9:53 PM Conor Dooley <conor@kernel.org> wrote:
> > On Fri, Jan 06, 2023 at 06:55:24PM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > >
> > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > describes the L2 cache block.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > > @@ -0,0 +1,81 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright (C) 2022 Renesas Electronics Corp.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Andestech AX45MP L2 Cache Controller
> > > +
> > > +maintainers:
> > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > +
> > > +description:
> > > +  A level-2 cache (L2C) is used to improve the system performance by providing
> > > +  a large amount of cache line entries and reasonable access delays. The L2C
> > > +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> > > +
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
> > > +          - andestech,ax45mp-cache
> > > +
> > > +  required:
> > > +    - compatible
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: andestech,ax45mp-cache
> > > +      - const: cache
> >
> > You might find value in a specific compatible for your SoC & enforce
> > constraints for it. Or you might not & I don't care either way :)
> >
> Good point actually. Geert what do you think?

That might be prudent, to cater for the way the standard AX45MP cache
block is integrated into the RZ/Five (or any other) SoC.

Still, in the absence of an SoC-specific compatible value, you can
handle integration issues using soc_device_match().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
