Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA265BCA37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiISLFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiISLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:05:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EC5FD2;
        Mon, 19 Sep 2022 04:05:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 29so40707182edv.2;
        Mon, 19 Sep 2022 04:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ffyYci8Cf2esuaXaWN3KVP5g+EkkwLDI9z5ZcYEaC98=;
        b=Rk696bcpxXps6GHmTbPyE+qZlW5Jia1W5cE4VqsAEd0kLnSJBD/OvblTW+Y/pnTW1J
         OiqwV4Dl4lgMpPHeFv66MAJITVOwq56rb5A1FMo04Uv6yerybquc2g6lT/OVIqLEWjct
         BldLMrZL1r1pOcltAaFwqrpwp+LWBwbb4+igOr1rhSrWvHeAIu8ZU0tR18QY+ZulZo9v
         k0IGmWZqOykSaoq7Qg3b+zJyCJQYnMmQrmZkeV+ZVJDw84VnMuMDecFaUb01TH4V8i9S
         IRLID3QcXp6ZCPfFyAJh90RU0kIRlfCV71m53lNkvJmfLFbfZyTKSvNvqa3MwAGbzZIS
         MeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ffyYci8Cf2esuaXaWN3KVP5g+EkkwLDI9z5ZcYEaC98=;
        b=0VBh17WFnrmbbFFqXjWdQsuDRgbRcMCSnC1ZPVwW/XMPrey3BghwUHX5VGah6BNP0Y
         k/fyJYt8trSJ3shXQ6ndfhqkbugw72HxfcgvqDQ53sD9Xynz7vCnvBGOGP8eQ+d4poGK
         g34pvYKLUpwEUi4h/I4nXUaESblLRAiV4rYL3fR4J8MIxtlqd+dr6bAOrU55cEaWnd7m
         4cLju3BAPja8GVOPpVW3/vigUHov+CDMQlFblWL67NuJEQD9FjKO9LDyzUSAqwsbyLL9
         g2+3dBwznbE+2mSmDXV9Z275hCA4rlFHdZSArG/pqCxj8v92lS2C66v/SyL0FFTQICiL
         Vfug==
X-Gm-Message-State: ACrzQf0GyvyrLj1eQAUfqIYlXC3yPFT+cZQRr/BdF/TzOt9zLEFPiOck
        +sKmwIv8eltLa7ifVIdz8eJ+0/T3pQ/lKw0zZZo=
X-Google-Smtp-Source: AMsMyM73YAL5MUu8TRtc/s4WPblx+Gi0jIbef+tpl0c+a2YMflfSTjE9R3iTqOiOWMW1edR1fChE8u1xTQVxCe6yDZ0=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr14883133edb.0.1663585504492; Mon, 19
 Sep 2022 04:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
 <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com> <OS0PR01MB5922A255CBA720023536A151864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922A255CBA720023536A151864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 12:04:36 +0100
Message-ID: <CA+V-a8sXfRQAMDGhF4JnK-Ucmb6G502oxt8L=wYZP2Vb3bd3jA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On Mon, Sep 19, 2022 at 11:55 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 19 September 2022 11:44
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>; Magnus Damm
> > <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; linux-renesas-
> > soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> > enabling wdt2
> >
> > On Mon, Sep 19, 2022 at 11:15 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > >
> > > Hi Geert,
> > >
> > > Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > > lad.rj@bp.renesas.com>
> > > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> > > > enabling wdt2
> > > >
> > > > Hi Biju,
> > > >
> > > > On Mon, Sep 19, 2022 at 12:06 PM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > > > On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven
> > > > > > <geert@linux- m68k.org> wrote:
> > > > > > > On Wed, Sep 14, 2022 at 3:43 PM Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > From: Lad Prabhakar
> > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > >
> > > > > > > > WDT CH2 is specifically to check the operation of Cortex-
> > M33
> > > > CPU
> > > > > > so
> > > > > > > > don't enable WDT2 by default.
> > > > > > > >
> > > > > > For consistency I'll drop enabling WDT2 from the RZ/G2L{C}
> > too.
> > > > >
> > > > > Does remove unused clocks turn off WDT2 clock during late init??
> > > > >
> > > > > If that is the case, we should remove entries from clock table
> > as
> > > > well?
> > > >
> > > > Or add it to *_crit_mod_clks[]?
> > > >
> > > > Note that drivers/clk/renesas/r9a07g043-cpg.c creates wdt2 clocks
> > > > and resets, so that should probably be moved inside the #ifdef
> > > > CONFIG_ARM64 section.
> > >
> > Yes we dont want it to be listed on RZ/Five.
>
> OK, So this patch [1] will break existing RZ/G2UL till we have clk changes suggested by Geert.
>
No it won't, patch [1] just disables enabling wdt2 on A55. Whereas
Geert is suggesting adding wdt2 clk R9A07G043_WDT2_PCLK (and also
R9A07G043_WDT2_CLK?)  to crit_mod_clks so that we dont disable them in
A55 (currently we dont have any scenario where M33 is up with WDT2 and
patch [1] is breaking it). Also Geert's other suggestion was to add
the WDT2 clocks under ARM64 as we dont want them to be visible under
RZ/Five (where wdt2 is not present).

Or is it that I am missing something?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220919&id=31989ece707adc453eb9f4f019fdac118f8fee72

Cheers,
Prabhakar
>
> >
> > > Yes, both will do, I guess otherwise WDT enabled by Cortex-M33 will
> > be
> > > disabled by
> > > CORTEX-A55 during boot.
> > >
> > Agreed.
> >
> > Cheers,
> > Prabhakar
