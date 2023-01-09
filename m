Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63466626AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjAINPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjAINPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:15:21 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11935CE9;
        Mon,  9 Jan 2023 05:15:16 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id p12so4128510qkm.0;
        Mon, 09 Jan 2023 05:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSUdLrxzBijeq6n48AhMiENVGSCtgGd+6QTQeX7bjt0=;
        b=i15/5pAnOcrMuZG6TH8IDmEatOjPjSJxynun1QFaUHMUnv4KFgPkixClqPMY8ugIm2
         F6PNxnHPH7LSS1huO3m4RaW2sbq34Ty6HiowH54ckk6NVwTVKB1e9nrwl5jnbzKeBO4A
         osKtHruej3BJU2mHpuIpxmNcDl/ZrpOtaq8nrrjBEE+8YJ4hQFycFw/B/wgCiKC/pqou
         4z9c5qT5EJtqEooAeU5oQsAD9u7g06mT0H52sFGG3PBRR2q6dvr4idqPM3bGdo3TTlkt
         6m7S9dm5S22hPE37pmUbM8A3zx2/EvFQ8sGjG8j2h0hpKm7caFHqmm34ng9bVrqUY05H
         WoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSUdLrxzBijeq6n48AhMiENVGSCtgGd+6QTQeX7bjt0=;
        b=mTSempkN5W0m5wkHHSXr6A2ZiGm2ydFMR8zMKPTkIQL7vChlesZve+WEAEjPU1sx1g
         Xodq/OojyqD4I7MTbiJLiY6ovF6ORR1aMOfFlvQpd3FvUdqY4m/fH0FbVLK2kPm+y9NT
         fppCbonucDO1/EyiMGdghHNO1Yjx4X6a5i3QU1NWiyL2GV4/G0H0MygwTW+mlqB5tTFW
         YR0NwBkV9eHDfsD0XdfkDwws5LUWpo/Z6xGzKomqkFpvBgOyNwL2lBIxRfjC48ls7hcW
         DnwELWLjWoup4wD0MU9vukFOpVvnoBJQdhfjr8eX0b19HkG2hiMODFFoiWmdkdlG+4N+
         WhGQ==
X-Gm-Message-State: AFqh2kpbe/kEZo1Qn89Fdwpw6ZhVowBjbnppfkBMLjgYey2yOi6yu400
        poKVvc7SmptA1vAMemjt+wZBNltUTdkRtsGbbr4=
X-Google-Smtp-Source: AMrXdXv7Wrf4SKRpoq5GquZxdfjtOOA2B5uMATxEShJibRpqIsfDIdqFzs/nC7U+IKbrIe+IdeULTg1ZL3KZJ5EU/HU=
X-Received: by 2002:a05:620a:1651:b0:704:dd59:a1b2 with SMTP id
 c17-20020a05620a165100b00704dd59a1b2mr3145507qko.477.1673270115115; Mon, 09
 Jan 2023 05:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y7iYZqKcoRycsoTg@spud> <CA+V-a8uBDx42o12UUwP=bBjeGzJJSP=jPcQr0xgkvkkoA7_vFA@mail.gmail.com>
 <CAMuHMdW7bfJXo4FujuwEOOzNsdEWB60VYurdFdbO8GwTMwb5yA@mail.gmail.com>
In-Reply-To: <CAMuHMdW7bfJXo4FujuwEOOzNsdEWB60VYurdFdbO8GwTMwb5yA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 Jan 2023 13:14:47 +0000
Message-ID: <CA+V-a8vHe5cjxQusxmnXKouw76gxGFdHL1g+n6-5JWFkhVECaA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for the feedback.

On Mon, Jan 9, 2023 at 12:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Sat, Jan 7, 2023 at 9:47 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, Jan 6, 2023 at 9:53 PM Conor Dooley <conor@kernel.org> wrote:
> > > On Fri, Jan 06, 2023 at 06:55:24PM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > > >
> > > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > > describes the L2 cache block.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
>
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > > > @@ -0,0 +1,81 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +# Copyright (C) 2022 Renesas Electronics Corp.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Andestech AX45MP L2 Cache Controller
> > > > +
> > > > +maintainers:
> > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > +
> > > > +description:
> > > > +  A level-2 cache (L2C) is used to improve the system performance by providing
> > > > +  a large amount of cache line entries and reasonable access delays. The L2C
> > > > +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> > > > +
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        enum:
> > > > +          - andestech,ax45mp-cache
> > > > +
> > > > +  required:
> > > > +    - compatible
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: andestech,ax45mp-cache
> > > > +      - const: cache
> > >
> > > You might find value in a specific compatible for your SoC & enforce
> > > constraints for it. Or you might not & I don't care either way :)
> > >
> > Good point actually. Geert what do you think?
>
> That might be prudent, to cater for the way the standard AX45MP cache
> block is integrated into the RZ/Five (or any other) SoC.
>
> Still, in the absence of an SoC-specific compatible value, you can
> handle integration issues using soc_device_match().
>
Agreed,  I'll continue with the current DT bindings.

Cheers,
Prabhakar
