Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46242638719
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKYKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKYKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:10:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AE1FFAD;
        Fri, 25 Nov 2022 02:10:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b8so5708232edf.11;
        Fri, 25 Nov 2022 02:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IUCM0LE2Qdll2KQhXqeTAiIGjjD6iG7iWRvqL9i1T/s=;
        b=Ns29kwRrHv7Ip/kcPlqzvmLf+DOhGJwpNWyUvTpOBGtbV5cZHzGhPvN0INYbebjz5O
         oX3sgyukJbtrz+blPsF3Cw/Tl87sIlhFOhnzvoXY0RtmuNnSXASazX4+3BDwUX1R9c/l
         Mc+73ig0zJjLkH5Ukr347y8q9SivewP+aGZDKM0A5JsYQtTOASMpS4EJq7yfPUC1SldM
         QSM6/zAlId8XGwAghhcBcz82f8SvpvEUN1/luNYYeA4jHR25lwDy1Jfkcn6x9tPRvZxN
         T/ppXxFKqwZTFvrqz1bhW1F88p5cW7jpwWyU4J/fc8FRFEY/xgI1NursXSuRyXMsh9/8
         Aj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUCM0LE2Qdll2KQhXqeTAiIGjjD6iG7iWRvqL9i1T/s=;
        b=dd+PDPWD/vy3ChzYPNRNlpeg0gJ8+xhadlU6ti/UdDSoqXS7QO9xsFg3GXqwGeylau
         AiSJ8+b/nTL+vp8/Ruv1+UCP2pcsbJmlOgJX6WnwOyMoV/NwheFQVzgRrcH6sE+1lbZd
         IIqt15V054Ov+E6coslbnybll8R52tyvFjuLQqBCdod3dQNJDLsOskIDphT+M6xSI9sQ
         t7TzV+DknVmzji+WcOu5y40w0+tW5gmUcZDkyDgScFtIUFYgip86mJRnvahcNGgK36pa
         G0SXwdFW6+0JJCmk9J/FeySpAJcQ5XLwSzpaVi2Zc9eZv/+pn0NUc3dWp3nnDTAXE8a6
         ytHw==
X-Gm-Message-State: ANoB5pmMNO8PAS7Qq3SSN4Wi+Je0kSrSdfbivs9FpV+U94o2ZPxOXKgp
        rYgdOUGYXIWRTmCzD424RodO/b60iFqhCfzCtH8=
X-Google-Smtp-Source: AA0mqf74kk78BGZ9XqzWiJe0v91Q/kxGQ61MMser1Tuvs6dPAkMcXojiHnTRgz2VPD2O0Krfp5XnCHbHh8QBUvCIXNw=
X-Received: by 2002:a05:6402:f:b0:468:56c3:7c8 with SMTP id
 d15-20020a056402000f00b0046856c307c8mr34662608edu.109.1669371045850; Fri, 25
 Nov 2022 02:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJF2gTT7XEXmLWpP6nnSNRms9kj2NQR2dOA5N+V2UmnsurJogQ@mail.gmail.com>
In-Reply-To: <CAJF2gTT7XEXmLWpP6nnSNRms9kj2NQR2dOA5N+V2UmnsurJogQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 10:10:19 +0000
Message-ID: <CA+V-a8uA=U72Mq7Rqu09BoWRG0jNHXUK=C5VFq=jb0iHLjom5w@mail.gmail.com>
Subject: Re: [PATCH DO NOT REVIEW v4 4/7] riscv: errata: andes: Fix auipc-jalr
 addresses in patched alternatives
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
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

Hi Guo,

On Fri, Nov 25, 2022 at 1:09 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Nov 25, 2022 at 1:22 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This patch is added just for building purpose, as patch [0] will export
> > this in its next version.
> >
> > https://patchwork.kernel.org/project/linux-riscv/patch/20221110164924.529386-6-heiko@sntech.de/
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Note, as Heiko will be exporting riscv_alternative_fix_auipc_jalr() function
> > so that it can be used other erratas Ive just included for compilation.
> > ---
> >  arch/riscv/errata/andes/errata.c | 71 ++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> > index ec3e052ca8c7..4061ad4983bc 100644
> > --- a/arch/riscv/errata/andes/errata.c
> > +++ b/arch/riscv/errata/andes/errata.c
> > @@ -13,9 +13,80 @@
> >  #include <asm/alternative.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/errata_list.h>
> > +#include <asm/parse_asm.h>
> >  #include <asm/patch.h>
> > +#include <asm/sbi.h>
> >  #include <asm/vendorid_list.h>
> >
> > +/* Copy of Heiko's code from patch [0]
> > + * [0] https://patchwork.kernel.org/project/linux-riscv/patch/20221110164924.529386-6-heiko@sntech.de/
> Move it to commit-msg. No link in the code.
>
This patch is *not* to be merged and is just included for compilation
purposes only.

Cheers,
Prabhakar
