Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82F65F3FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJDJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiJDJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:34:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569754C89;
        Tue,  4 Oct 2022 02:32:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g27so1155139edf.11;
        Tue, 04 Oct 2022 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=scCLn+ph1UwggMlH0DfSAgp5HKCsgoA8BWLgo9P4NBI=;
        b=g288wrK1MpJ5OqQfyyRnufGz8XScpljjEmSqeO11AOP8i6mrztUnVqx82KgfBbvDWJ
         AQku5ORj7LyTEsI09W35txqcRR8krUCRWzCqwhW17/7lRaKlq+vDvgvDR75skcRZv1G4
         mfyNaIvOGKzbkLHT3w9Lm48g2KEGANtNvBAZA03dbbHXHy7SSIN5XbyRis9CJJo9dTxx
         MHr17EhrRj0sZNsdYvmFPHklRT3BYClHOb/GaWQavDNrpJfd1BdWp4v4CQU9s1Ya2fdl
         2j9kRjL06AhKewOyZjZWTVpIa2iy3KEcTgNuvKpO9fzIcSLGoQHgFIMXoY4Xzrsp1qQi
         i+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=scCLn+ph1UwggMlH0DfSAgp5HKCsgoA8BWLgo9P4NBI=;
        b=uKQz3lQZ0i0aNRcNV+ZC50gWIRpBXQW2qS1EeYWvPej7waf5KFC0n1UVsURhCVoUeh
         2fbeJIcw3C0F1O8yMyVDJ8U4sKeC3aUtm6aVGjYSdcKAvaJrRmYBYK+ekBnNrsKEUNYP
         TR0tysBm+u3ojil3xQp3PAZR59uiJ5bBbNs875mNR04krinCo+LdbW3Auf7D96+oqK8+
         VKcgPDtZkgBloTsvwNXy1CQaDNKboJLT+Lmwnnd8zoAm0a8OfkaZO5SSMXzNgaN4ZjOg
         o4+pW4C2p+clewCP0Wt5Jn1D+7yuN4sfsjKYt8O+sKvFpI1ruE4N1Zv+6bt13qb2+eIY
         as6w==
X-Gm-Message-State: ACrzQf2Wxgo5FDy3bdApriK78pg+enpT04aaBHcGl0DlXhwx0GeQiTm6
        LOD0Y0e4JPYbPH2L3xZ7XAuh7LrPnsT55jerSPs=
X-Google-Smtp-Source: AMsMyM59PqwrgK1dRoo/jsyDhll8qx53jwPGZsthXe0V2zWSaj5gaulmAalr/5BCASTSdEWSfkl+r1bN56y+mCxx2nY=
X-Received: by 2002:a05:6402:5485:b0:459:147a:d902 with SMTP id
 fg5-20020a056402548500b00459147ad902mr6778287edb.263.1664875892283; Tue, 04
 Oct 2022 02:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
 <CA+V-a8vnNQDMgjhJfz91g++dVVv5Z5FTuFrNRHLW3PjPump0Mg@mail.gmail.com>
 <YzvhaxuZbeCwLZ5m@wendy> <CA+V-a8uYwm+Z4=3beNZE7q3mG7S3uKdEagY2c-KStD0thyw6Gw@mail.gmail.com>
 <CAMuHMdXqV3DMLLfS5Vrkmx1KOBHqyC_pO7kHLnMf8OPSFe6doA@mail.gmail.com>
In-Reply-To: <CAMuHMdXqV3DMLLfS5Vrkmx1KOBHqyC_pO7kHLnMf8OPSFe6doA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Oct 2022 10:31:05 +0100
Message-ID: <CA+V-a8vK8KKeAvqur+CnE=SBkvYsQ7g_Gu5=v=qZ-0=VTk+RjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: soc: renesas: r9a07g043f-l2-cache:
 Add DT binding documentation for L2 cache controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
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

HI Geert,

On Tue, Oct 4, 2022 at 10:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Oct 4, 2022 at 9:59 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Oct 4, 2022 at 8:32 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > > On Tue, Oct 04, 2022 at 08:26:01AM +0100, Lad, Prabhakar wrote:
> > > > On Tue, Oct 4, 2022 at 7:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Tue, Oct 4, 2022 at 12:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > > > > >
> > > > > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > > > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > > > > describes the L2 cache block.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
> > > > >
> > > > > Not andestech,ax45mp-cache.yaml?
> > > > >
> > > > I wasn't sure as we were including this in soc/renesas so named it as
> > > > r9a07g043f-l2-cache.yaml if there are no issues I'll rename it
> > > > andestech,ax45mp-cache.yaml.
> > >
> > > I may be guilty of suggesting soc/renesas in the first place, but should
> > > this maybe be in soc/andestech? I have no skin in the game, so at the
> > > end of the day it doesnt matter to me, but I would imagine that you're
> > > not going to be the only users of this l2 cache? Or is it a case of "we
> > > will deal with future users when said future users arrive"? But either
> > > way, naming it after the less specific compatible makes more sense to
> > > me.
> > >
> > As there aren't any Andestech SoCs upstream, I am in favour of keeping
> > in soc/renesas for maintenance. If in future there comes a new soc
> > from Andestech (which will go into soc/andestech) we will have to
> > split the maintenance work.
> > But anyway if there will be any users of L2 cache we could always
> > provide a config option which can be used by other SoCs.
>
> What about Documentation/devicetree/bindings/cache/?
>
Sounds good to me.

Cheers,
Prabhakar
