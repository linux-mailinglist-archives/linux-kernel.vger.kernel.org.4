Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689260DDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiJZJDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJZJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:03:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC197D5C;
        Wed, 26 Oct 2022 02:03:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 21so6401575edv.3;
        Wed, 26 Oct 2022 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gDNxtobUIfhtD2mKMmmLy/tXc7osg3CCVHX7FcrkmPc=;
        b=T1yfzXvULUMP09Uf9fnUwN9VSCCe0NkyS2d0KwcTBHfrNUBabNh+WYyxzPa5VjyjaX
         buKV34XWyOKSjK4VZnt0wHF/NskjZ6HAY5FEq4iSJKVuNmGvy9/7Tt/apwcHWDl2SWIg
         0d84omawo5owLLuYtiZoPQKG/cmNoWZjdEdqFnRnE0NyGi/fawG5gKlMr6J6wTGPrCcf
         Q0jiPT24y6oBY4j5KhI4nvpqidweOzWZMZs8jnrL94SPwwx6LASbCwRb2XbxW4fFvVzP
         yNLKO1XXzM0fvJUBgf4ydxF69mHXve33jMLQdbkdQGINK/M0v1D7ZDhR/ePMM7E0Mc/F
         aexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDNxtobUIfhtD2mKMmmLy/tXc7osg3CCVHX7FcrkmPc=;
        b=Oq5i359IdOzpOsz806LkRHnabNsymaPpjUupatliloseiT8m3UACbxhAXTnEnA0VeR
         YxFnFhCbfQSdze8enYRmTWauQnigPF8hDPbIJ78qchXsAxJletwwSTMBsmmo3yIiP26X
         iadVod9LcbjW1LRkp3Ws0f/Mb8PNQBf/6RG0G+fEoOf4vJ/15X+p1hKM/xH8oeJ2CtUL
         IcSo8XAMwUzYGm9AuFPlHqhzvV9p1P3CA6gpWRjiDEc1piEeLGo0PdD8flnL5Y3NHE5l
         hvJa3mA3rkwexAfBsfsen6siwe798PXV8rs+w/PFMvCZg71TN/zIW31r2BdLclB+UgfL
         0LtA==
X-Gm-Message-State: ACrzQf3gKrCRNeT3UyV15jM7ehMXG6z9nH4mt3M/V0j0AhjatEjkQ8Hi
        aOSOMmKDiid7viFMIkO4Cn+XvSillMWF8+U6tFT4ZyBNjrow5A==
X-Google-Smtp-Source: AMsMyM63ecp3AsNA5gtSQQOnUBmaKiZJgJwUkJ0dya0NyFNs+fEUvY9D0Kc75T5z+p3tVL+/4eMPjfsy4tniIWmi1g8=
X-Received: by 2002:a05:6402:2552:b0:45d:ecf:b23 with SMTP id
 l18-20020a056402255200b0045d0ecf0b23mr40194998edb.255.1666774999716; Wed, 26
 Oct 2022 02:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026014227.162121-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVa28=84ZovtWazx0w=xWLDZioK0+CVnoE=NALjMewSkg@mail.gmail.com>
In-Reply-To: <CAMuHMdVa28=84ZovtWazx0w=xWLDZioK0+CVnoE=NALjMewSkg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 10:02:53 +0100
Message-ID: <CA+V-a8skHerzruXSnOm0bZLLk-O6e0pdh6nysXEFh5RJN-D3eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: renesas: r9a07g044: Add CRU_SYSCLK and
 CRU_VCLK to no PM list
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

Hi Geert,

THank you for the review.

On Wed, Oct 26, 2022 at 8:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Oct 26, 2022 at 3:42 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
> > sequence for the CRU block hence add these clocks to
> > r9a07g044_no_pm_mod_clks[] array.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Dropped usage of DEF_NO_PM() macro
> > * Added CRU_SYSCLK and CRU_VCLK to no PM list
> > * Updated commit message
>
> Thanks for the update!
>
> > --- a/drivers/clk/renesas/r9a07g044-cpg.c
> > +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> > @@ -412,6 +412,11 @@ static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
> >         MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
> >  };
> >
> > +static const unsigned int r9a07g044_no_pm_mod_clks[] __initconst = {
>
> This cannot be __initconst, so please drop this keyword.
>
OK.

> > +       MOD_CLK_BASE + R9A07G044_CRU_SYSCLK,
> > +       MOD_CLK_BASE + R9A07G044_CRU_VCLK,
> > +};
>
> I believe I haven't seen patches yet to add support for these clocks?
> Perhaps these can be combined?
>
Ahh my bad, yes the patches have not been sent out for it, I'll
combine this while adding the clocks.

Cheers,
Prabhakar
