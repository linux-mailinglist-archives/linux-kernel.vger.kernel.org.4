Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF25F3D92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJDIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJDH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:59:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A20F581;
        Tue,  4 Oct 2022 00:59:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kg6so11760623ejc.9;
        Tue, 04 Oct 2022 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VeMEKABc3TtQILBjNAJQ+M6awy0IySm+oQwftWHEreI=;
        b=g+OnsE5yeTe/tK/ketaT7bh+9Vr20MGUX+hbOcbZSlojs35kAWPBJN8LE/c2bF/9bc
         looShX/tKDdWMyAaeD7hRI97YzfpkiDAmKlC/Ql8I+d2dkpSiAehAXZUvF8ft10c1jer
         8KnA+jOyt7FoW4pOrtcqYKK5y5ULYfTIB5azGT/r36CZQ8QqML0PBnXFcNQ4Y1MZVObU
         FuKk6vAFEBB33/N7JzCtZ7tnEj2kFHjNe8nWRrfCBGqebFv49psJ5tq/G8U8IiYUSjQJ
         LWXEOQIkaeKScnHQBM2ey4PZqa9yid4CTWMvEjjLsMtkmpVzG/Kah8HbsFU8ccWM07TN
         tvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VeMEKABc3TtQILBjNAJQ+M6awy0IySm+oQwftWHEreI=;
        b=A0JYHPt8FQR+3aXyuNywKIXdgl1RCVzp9es5C5WSMASraTqX29ISZ7xFJKU3rxPvFp
         dvehFH1B1qTAMn5i9sq89bmiC9qKwqUVujLa0ObgveKY300I4s+M/Sh6v2gIc4rptOWX
         72kSWTlE21r9eDDkGLdWtIJNO3kK5CxNWn2g3sIOAEPgLTrcX34eT2wk3H06APCF0dHw
         TegDWbsFahQWuMrtgJZzgqmXP4DfiZL8IilOVV1vdVVTNc1k8TV5yHnyZugGRO9Mmavk
         o0Gn8sXquH1RB8I9nZBtxYYs5XBSthPKw2Q6BZmOBlm8X5KuZzAwvR4LzxXhcy/TO1qY
         jw9g==
X-Gm-Message-State: ACrzQf3720inoOj/3w3U5/0aW3F8C0oShPWtM7c++OPvfd7ZAZKLjP+b
        u47eFwo5wwN+5JaZXoiHALqkmJtWojpkSp33+Sg=
X-Google-Smtp-Source: AMsMyM5/zTBC84CIeJBis9zUHCHVy3BvddGdj29NigpREEoHIg97rBxi9HBysvUfSAXHYtOWzSsmRFJa07GV++Z9AwA=
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id
 17-20020a170906059100b0073dc3ef84aemr18491993ejn.155.1664870388235; Tue, 04
 Oct 2022 00:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
 <CA+V-a8vnNQDMgjhJfz91g++dVVv5Z5FTuFrNRHLW3PjPump0Mg@mail.gmail.com> <YzvhaxuZbeCwLZ5m@wendy>
In-Reply-To: <YzvhaxuZbeCwLZ5m@wendy>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Oct 2022 08:59:19 +0100
Message-ID: <CA+V-a8uYwm+Z4=3beNZE7q3mG7S3uKdEagY2c-KStD0thyw6Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: soc: renesas: r9a07g043f-l2-cache:
 Add DT binding documentation for L2 cache controller
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Tue, Oct 4, 2022 at 8:32 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Tue, Oct 04, 2022 at 08:26:01AM +0100, Lad, Prabhakar wrote:
> > Hi Geert,
> >
> > Thank you for the review.
> >
> > On Tue, Oct 4, 2022 at 7:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Tue, Oct 4, 2022 at 12:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > > >
> > > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > > describes the L2 cache block.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
> > >
> > > Not andestech,ax45mp-cache.yaml?
> > >
> > I wasn't sure as we were including this in soc/renesas so named it as
> > r9a07g043f-l2-cache.yaml if there are no issues I'll rename it
> > andestech,ax45mp-cache.yaml.
>
> I may be guilty of suggesting soc/renesas in the first place, but should
> this maybe be in soc/andestech? I have no skin in the game, so at the
> end of the day it doesnt matter to me, but I would imagine that you're
> not going to be the only users of this l2 cache? Or is it a case of "we
> will deal with future users when said future users arrive"? But either
> way, naming it after the less specific compatible makes more sense to
> me.
>
As there aren't any Andestech SoCs upstream, I am in favour of keeping
in soc/renesas for maintenance. If in future there comes a new soc
from Andestech (which will go into soc/andestech) we will have to
split the maintenance work.
But anyway if there will be any users of L2 cache we could always
provide a config option which can be used by other SoCs.

Said that I'll let Geert decide on this.

Cheers,
Prabhakar
