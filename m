Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6F5BCD64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiISNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiISNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:38:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5222F3A4;
        Mon, 19 Sep 2022 06:38:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kr11so18442851ejc.8;
        Mon, 19 Sep 2022 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Aq7E+C+mPkgyCTuc01GayX9nJ5jEMVTcMTFtwMbZhm0=;
        b=eSi8MyPAwHZAZwZisEW0iw5+z1npuH20WFuormJA27os7lGwqonvKw/jkHBoObd/FB
         69Bt0V9WcJcnkh4yB+8952BP4Cmi5o0wn1PiycO2g6NpDQiW88YETJsv4QoEyVR3Odu3
         lzI295QOvcF3It+ffN2MDz7L4ZtGjsw3DQjhut50iNKI7mFwoV6hQwcWeEjFo5ZAR3xM
         O/fUJaOEebSr+GclmHVHxK5zlGl70Naaicz5jUue/gb7S+a2FDpTVlmzG4gLHHq2tLX6
         s8AEbp2ZKVRqw7j6429gmjb+aWpSaaba4+9n55b5xJ9cbcbq19aW6gDv/HeNBwLrH7mq
         5Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Aq7E+C+mPkgyCTuc01GayX9nJ5jEMVTcMTFtwMbZhm0=;
        b=m7CA/DJ2MyoZjPxac/q9CMtlxmApLglZzfRALHcRc51shDaSI8VMkCVAZE9k37IsIp
         HrG/1qsSkYYDLpeS1NXsGDC2L+I7OGuwfdZMoCRnmeMqBCQfDqmIFNqld+MwiyH4EKOH
         cx4GdcYdDQUSqu9++vnK3jp5r2vaPd0abzZDacENhpKoo9zPaTem9wU6KXQAf1t/i3S+
         WkpxKXFojPfccxPCa67+4t2yb9sQ4JkEsmxMcea+T8eOSAiZeHl7UY0ObkZjG17CmIhm
         jLC4TqlVMCm9gTy26KpuH+lWgeSleBn7fP4rTk41Ft7gG4CuFFpFuLoRvID+1HXgnMTY
         aE3w==
X-Gm-Message-State: ACrzQf0Gn8/rgBxcmYQExY25YcZi99FTlUzpFl4XtcNaIbq3/CIXoRjg
        y9QgDdpN+LJsOQimNRmc1DP3+zSomVKYbAisA+OWj/Io3Gs=
X-Google-Smtp-Source: AMsMyM6DIu+1wYjSQsjOh8NGzR44lqN2ZxLAz580lZiq4+8IU6Q37vbn6F2aBcMovArUitTvpmBI/C9oc3wJekhjxfY=
X-Received: by 2002:a17:907:2c41:b0:77d:8aed:cf7c with SMTP id
 hf1-20020a1709072c4100b0077d8aedcf7cmr12824835ejc.447.1663594698426; Mon, 19
 Sep 2022 06:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 14:37:50 +0100
Message-ID: <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

On Mon, Sep 19, 2022 at 2:35 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> > Subject: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical
> > list
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT CH2 is
> > specifically to check the operation of Cortex-M33 CPU on the RZ/{G2L,
> > G2LC, V2L} SoCs and we dont want to turn off the clocks of
> > WDT2 if it isn't enabled by Cortex-A55.
> >
> > This patch is in preparation to disable WDT CH2 from the RZ/G2L (alike
> > SoCs) DTS/I by default.
> >
> > Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/renesas/r9a07g044-cpg.c
> > b/drivers/clk/renesas/r9a07g044-cpg.c
> > index 02a4fc41bb6e..cf9b1bd73792 100644
> > --- a/drivers/clk/renesas/r9a07g044-cpg.c
> > +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> > @@ -412,6 +412,8 @@ static const unsigned int
> > r9a07g044_crit_mod_clks[] __initconst = {
> >       MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
> >       MOD_CLK_BASE + R9A07G044_IA55_CLK,
> >       MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
> > +     MOD_CLK_BASE + R9A07G044_WDT2_PCLK,
> > +     MOD_CLK_BASE + R9A07G044_WDT2_CLK,
>
> Do we need to turn on this clock unnecessarily?
>
No, this is in preparation to disable WDT2 by default from RZ/G2L{C} DTS/I.

Cheers,
Prabhakar
