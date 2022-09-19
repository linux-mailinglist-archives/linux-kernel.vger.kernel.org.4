Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94F5BCADE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiISLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiISLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:37:22 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7F2612E;
        Mon, 19 Sep 2022 04:37:21 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id u28so17275722qku.2;
        Mon, 19 Sep 2022 04:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t4Ll3E0E4s59B8mbpiD63I+VMn+XvJFfswpdFK6j1oY=;
        b=is6/F6h0f9jlf2veam+aSNpHHTz7f1t4fpnmxIvpx0FNN1sU7qQz/rVQSKF2COnTUl
         dZF/SlbmhBLuuOUNb57AJj/P+uMlgZBD1MGBPwvYFz0GlHjUc1Cp/hgQ0q/jJVoD3kS8
         65VhC0PnoQVpbRq9YynqpwRxljJoUuXNS+K3YwMU+hehTK7Nfh5PzOYDdKgsx+fyVl01
         xom6I9Rcj+TXvbQwgEWrRoC1mcdiXs/o2bqyE0k2d0ABFjskUOn1qcaCK9t+k6RBmZpQ
         vrLoGonL+s+W8bUwR5gWn3x43/4I2MsqgCN7Eh7Fstd/vlHPvRmRb+n03dc8jT5KQil1
         r2iw==
X-Gm-Message-State: ACrzQf1jdH41HjOeQJ1vxsTgPnvjX+l2DfcAW2SyE9DEOVMQaSe/Mnnt
        uo7QqEtA/MacXRNzRzRYl60N5Ec53Tc31w==
X-Google-Smtp-Source: AMsMyM6MAYcSv3rg2+S7Zl1D11LxdwakKLrtW6Sgm5Zp/X/IY7Iq80Jw26sBUanhC3KwQ6UsHU49IA==
X-Received: by 2002:a37:e101:0:b0:6ce:6a09:879e with SMTP id c1-20020a37e101000000b006ce6a09879emr12326379qkm.587.1663587440815;
        Mon, 19 Sep 2022 04:37:20 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id s14-20020ac85ece000000b00339b8a5639csm10215079qtx.95.2022.09.19.04.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:37:20 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id s14so9247295ybe.7;
        Mon, 19 Sep 2022 04:37:20 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr13052850ybl.604.1663587440164; Mon, 19
 Sep 2022 04:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
 <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com>
 <OS0PR01MB5922A255CBA720023536A151864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8sXfRQAMDGhF4JnK-Ucmb6G502oxt8L=wYZP2Vb3bd3jA@mail.gmail.com> <OS0PR01MB5922C709C73F97E1269DB110864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922C709C73F97E1269DB110864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Sep 2022 13:37:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCyTGbwp9F-PEcn3qxapDMU+UEY2=RVNy8p9fNesKepA@mail.gmail.com>
Message-ID: <CAMuHMdXCyTGbwp9F-PEcn3qxapDMU+UEY2=RVNy8p9fNesKepA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Mon, Sep 19, 2022 at 1:10 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > On Mon, Sep 19, 2022 at 11:55 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > -----Original Message-----
> > > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: 19 September 2022 11:44
> > > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>; Magnus Damm
> > > > <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> > Krzysztof
> > > > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; linux-renesas-
> > > > soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > > lad.rj@bp.renesas.com>
> > > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> > > > enabling wdt2
> > > >
> > > > On Mon, Sep 19, 2022 at 11:15 AM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > > Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > > > > lad.rj@bp.renesas.com>
> > > > > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som:
> > Drop
> > > > > > enabling wdt2
> > > > > >
> > > > > > Hi Biju,
> > > > > >
> > > > > > On Mon, Sep 19, 2022 at 12:06 PM Biju Das
> > > > > > <biju.das.jz@bp.renesas.com>
> > > > > > wrote:
> > > > > > > > On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven
> > > > > > > > <geert@linux- m68k.org> wrote:
> > > > > > > > > On Wed, Sep 14, 2022 at 3:43 PM Prabhakar
> > > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > > > From: Lad Prabhakar
> > > > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > > > >
> > > > > > > > > > WDT CH2 is specifically to check the operation of
> > > > > > > > > > Cortex-
> > > > M33
> > > > > > CPU
> > > > > > > > so
> > > > > > > > > > don't enable WDT2 by default.
> > > > > > > > > >
> > > > > > > > For consistency I'll drop enabling WDT2 from the RZ/G2L{C}
> > > > too.
> > > > > > >
> > > > > > > Does remove unused clocks turn off WDT2 clock during late
> > init??
> > > > > > >
> > > > > > > If that is the case, we should remove entries from clock
> > table
> > > > as
> > > > > > well?
> > > > > >
> > > > > > Or add it to *_crit_mod_clks[]?
> > > > > >
> > > > > > Note that drivers/clk/renesas/r9a07g043-cpg.c creates wdt2
> > > > > > clocks and resets, so that should probably be moved inside the
> > > > > > #ifdef
> > > > > > CONFIG_ARM64 section.
> > > > >
> > > > Yes we dont want it to be listed on RZ/Five.
> > >
> > > OK, So this patch [1] will break existing RZ/G2UL till we have clk
> > changes suggested by Geert.
> > >
> > No it won't, patch [1] just disables enabling wdt2 on A55. Whereas
> > Geert is suggesting adding wdt2 clk R9A07G043_WDT2_PCLK (and also
> > R9A07G043_WDT2_CLK?)  to crit_mod_clks so that we dont disable them in
> > A55 (currently we dont have any scenario where M33 is up with WDT2 and
> > patch [1] is breaking it). Also Geert's other suggestion was to add
> > the WDT2 clocks under ARM64 as we dont want them to be visible under
> > RZ/Five (where wdt2 is not present).
> >
> > Or is it that I am missing something?
>
> It all depends upon whether remove unused clocks turn off WDT2 clock during
> late boot process.
>
> I guess, since we have wdt2 entries in clock table, it will turn off WDT clock,
> since you have disable it from DT( it becomes unused).

AFAIU, the WDT cannot trigger when the clock is stopped, so RZ/G2UL
should be fine?

> By adding critical clocks, it won't turn off the WDT clock.

> > [1]
> > https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.
> > kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> > next.git%2Fcommit%2F%3Fh%3Dnext-
> > 20220919%26id%3D31989ece707adc453eb9f4f019fdac118f8fee72&amp;data=05%7
> > C01%7Cbiju.das.jz%40bp.renesas.com%7C55f37d25d74646611de908da9a2ecfac%
> > 7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637991823087385873%7CUnkn
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=hP2u5NwutD8AhhrOrY6dPvlWW8PkB
> > g3skyTMXBJQaWc%3D&amp;reserved=0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
