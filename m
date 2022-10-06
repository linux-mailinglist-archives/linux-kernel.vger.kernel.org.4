Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B85F62BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJFIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJFId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:33:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F208E450;
        Thu,  6 Oct 2022 01:33:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z3so784826edc.10;
        Thu, 06 Oct 2022 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nA04VVvZv5Bn1xVBn3M3j3znxj4LObeNF3b5A2ql07Q=;
        b=PV3LqS92zg0PtR5MyndvQnm7iltQPx4Utf3smnACujE2OltGCdkLNExogDBNlxZXMh
         1GUmKis+CXfjBGv33N804F6c+dotf4rLsmLHfu8g+RcxrWZPj1IdXMtjAgX+GOCjNlCi
         KTb8mrESreQ4s3X1Y7NRJhvlGObM1vYeFkM80q9drWMjlhSYXff+y+VNZYTH95ip6tNV
         IU4h71CpoXIrZLYTEHPfZUMh1ij1OWJgGkXSzupNXWiFAV2D3XHgYhgiypTIxfbgtKku
         i08Bi9qq8D8qbtmfnEBbDVG+FqxF01gt4KjmC5m1satruMhPcRKqzlTykfhtmwA6pENi
         scww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nA04VVvZv5Bn1xVBn3M3j3znxj4LObeNF3b5A2ql07Q=;
        b=N5NqNw9qyA4YkR/T5VfXWQQ8xJZ4TrQwtL4iuH0HAVAaGkBV+vJzoi9OCkRuZ0Z8kU
         r+CjhGL7UXiUKo7w89f/Omp7vjL2qbAlmBL2X07y/JoI73mVS+7wmdttnNxYz4QiMnF4
         NJRgTVr7wfDP/4xvZCkQfp0c5m9IIEYQTr0iZPrB5FKY/X+VDmGpWaSDrOwuAmnKNSqJ
         BL/m8BuW4q6hAyCR52oVh3aXMMyLT4jMul3CVeMRTAudCAlU05cx5fHxmAdLdodbvBeC
         rXFCtDfQyTSlHDnGFFwP0MpftdZhRE71u2nuHIG2UTxj6gUr1sDoNINM2cGJnWKA8MBX
         jOyQ==
X-Gm-Message-State: ACrzQf1ikFJQ59QCcwadCuOSt4YRXSxaSvy+q+GzX5cMHBfFifJFjNV9
        IA2cDlyErTLBFMWkHZF8iwNhdTa+Z4xjUM15FOc=
X-Google-Smtp-Source: AMsMyM6v9Yq12jZP/7hmW5p7S7nQvJxI0pbgZNgPBNxEHZzjbDqwdM77t3mfeBD35jWlPK/Owvl7J3eoH25us72Xmf4=
X-Received: by 2002:a05:6402:5255:b0:459:ebaa:c2b8 with SMTP id
 t21-20020a056402525500b00459ebaac2b8mr1194197edd.150.1665045205330; Thu, 06
 Oct 2022 01:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
 <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
 <OS0PR01MB592278FB3E443C84130FCA7D864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922DAA91FFD18FD52FEC916865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8uNhM92ezEX3iCcP2zp3Er9EPDy1Z-4L3gQfe=xU8O1bw@mail.gmail.com> <CAMuHMdU0BSByCZynkdhDQNcQ+7UT=YgZLe_YNVR4d=dS=2mX=g@mail.gmail.com>
In-Reply-To: <CAMuHMdU0BSByCZynkdhDQNcQ+7UT=YgZLe_YNVR4d=dS=2mX=g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Oct 2022 09:32:58 +0100
Message-ID: <CA+V-a8v87MhRQw_ccbwusnW-U=vkKDaBaKhpuqueRNZsErvC-Q@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
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

Hi Geert,

On Thu, Oct 6, 2022 at 9:16 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar, Biju,
>
> On Wed, Oct 5, 2022 at 2:56 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Oct 5, 2022 at 9:27 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > On Mon, Sep 19, 2022 at 2:52 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > On Mon, Sep 19, 2022 at 2:35 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > > > From: Lad Prabhakar <prabhakar.mahadev-
> > > > lad.rj@bp.renesas.com>
> > > > > > > > > Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT CH2 is
> > > > > > > > > specifically to check the operation of Cortex-M33 CPU on the
> > > > > > > > > RZ/{G2L, G2LC, V2L} SoCs and we dont want to turn off the clocks of
> > > > > > > > > WDT2 if it isn't enabled by Cortex-A55.
> > > > > > > > >
> > > > > > > > > This patch is in preparation to disable WDT CH2 from the RZ/G2L
> > > > > > > > > (alike
> > > > > > > > > SoCs) DTS/I by default.
> > > > > > > > >
> > > > > > > > > Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > I got confirmation that that using WDT2 from CA55 is prohibited.
> > > WDT2 is only for CM33.
> > >
> > > With CPG register, we can select whether CM33 to trigger CM33 cpu reset, or trigger system reset
> > > when WDT2 overflows.
> > >
> > > If WDT2 is used by CA55, it may result in unexpected behaviour.
> > >
> > Thanks.
> >
> > > So we may need to take WDT2 entries from binding + dtsi + clock table??
> > >
> > > Or
> > >
> > > Added it to critical clock list, to avoid changes in binding + dtsi + clock table
> > > at the expense of turning on the WDT2 clk unnecessarily.
>
> ... plus still risking to interfere with the CM33.
>
> > I'm in favour of option#1 except that we keep WDT2 entries in binding.
>
> Agreed (bindings are append-only).
>
I'll get the patches out to get rid of WDT2.

Cheers,
Prabhakar
