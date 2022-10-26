Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA9C60DD85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiJZIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiJZItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:49:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFD7696D;
        Wed, 26 Oct 2022 01:49:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k2so19425936ejr.2;
        Wed, 26 Oct 2022 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MJh7DiSXx4gAb7HCDsIOJJtlUdSHILNknT/gqSP4jIs=;
        b=hUJXnkAmLoDFvc+OAKAbkTZjdAnA78VzhEiBOQ1/KbfUpWLwSJcDPx7W9gaJXgEdM2
         PpxosC+syBwxuPJxFQYHW4ZtZvRF54oqw7v9DwcHMhMckXzmxauihWV6opRCWgnzZr7D
         bg2lX3EnrZhZczuH2R+8hXD8aswuKrZ2zeoDq9Zl/R/KBgjvZA4R78QSMEENr711Sljf
         T7lTAj3K9d4hJaRXYFjUzCplzKoTnTjTPcMyP15lDUVRc3boZRz7obYcecEu7a2MRmNb
         MA6W+P5kbkYZoa4M8NyzSEZHerJ/+9F5dlh7giqj9DgxPEqUbIcbIJjzWR33/+JDxiLW
         ylrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJh7DiSXx4gAb7HCDsIOJJtlUdSHILNknT/gqSP4jIs=;
        b=WHC8l3BgtA8IgNj+9JYG6038UiFx4GILYYe6PeedjHE2/0DqEeQghvlPfRMWDOQKbl
         Hxn+5/vhHpCzxgGAIbA1d+LkSVVATFoddjCLpmpzHVHKFulQ2De/bFDfBCGsFa9VY/uK
         2CpKnWdiz0QaJtlg9EhuL1/KjSb5Zx+H7HWDFZWKKFn2UiwN0+6i+ml+1RrAidRhcB+S
         FAXevNRmcKh7CeABZG1U3dnlObdajy2vZe7A004vpqcwRyTu3kpyalXTkJD1TUbDA30Y
         SNnVv9vm5Qn3lhi2yzD5mbAW0KdCJTsjiemgRswcds/hDwCUxcAnyiR7a2qiybn/Tz7e
         RerA==
X-Gm-Message-State: ACrzQf3DNKtCj2iCwRB4CWKZC/eaHN7NKHF05uk3w0I42MEHT86m5r3y
        gGoFD9AsYoa20ViClzuToKd/C0FvmU+MY2uARyA=
X-Google-Smtp-Source: AMsMyM6ha+jkiZv5zA162G038cLapYf7uShWHlkex2qKWutM+ighn8N0BhMgwOX0iz9VsH6WUh2FMVavZ6CFj+ZRLu4=
X-Received: by 2002:a17:906:5a4b:b0:78d:4e5a:d101 with SMTP id
 my11-20020a1709065a4b00b0078d4e5ad101mr35512916ejc.196.1666774149529; Wed, 26
 Oct 2022 01:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026014227.162121-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVg1sFH1gAqo3yf5-m7edfHFO0VM63n=FmDQHhJqSpHyg@mail.gmail.com>
In-Reply-To: <CAMuHMdVg1sFH1gAqo3yf5-m7edfHFO0VM63n=FmDQHhJqSpHyg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 09:48:43 +0100
Message-ID: <CA+V-a8sySpYZ4fAsNNc9aEzDL4v+8G3XB71KZt72nADnscUVhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Thank you for the review.

On Wed, Oct 26, 2022 at 8:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Oct 26, 2022 at 3:42 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > There are cases where not all CPG_MOD clocks should be assumed to support
> > PM. For example on the CRU block there is a particular sequence that needs
> > to be followed to initialize the CSI-2 D-PHY in which individual clocks
> > need to be turned ON/OFF, due to which Runtime PM support wasn't used by
> > the CRU CSI-2 driver.
> >
> > This patch adds support to allow indicating if PM is not supported by the
> > CPG_MOD clocks. Two new members no_pm_mod_clks and num_no_pm_mod_clks are
> > added to struct rzg2l_cpg_info so that MOD clocks which do not support PM
> > can be passed by no_pm_mod_clks[] array and when the driver uses Runtime
> > PM support the clk ID is matched against the no_pm_mod_clks[] array to see
> > if the clk is needed to be included as part of Runtime PM.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Dropped DEF_NO_PM() macro
> > * Added genpd member to struct rzg2l_cpg_priv
> > * Added no_pm_mod_clks and num_no_pm_mod_clks members
> >   to struct rzg2l_cpg_info
> > * Updated commit message
>
> Thanks for the update!
>
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
>
> >
> >  static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)
>
> Time to rename "unused" to "domain" ;-)
>
Indeed, I think the naming came from R-Car :)

> >  {
> > +       struct rzg2l_cpg_priv *priv = container_of(unused, struct rzg2l_cpg_priv, genpd);
>
> I can fix that while applying...
>
Thanks.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Cheers,
Prabhakar
