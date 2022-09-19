Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE55BC9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiISKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiISKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:50:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB91127;
        Mon, 19 Sep 2022 03:44:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z13so26646280edb.13;
        Mon, 19 Sep 2022 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HqV6X1qjzLYcilKB6wFdh2tVMPDFDXIW92VucSij86A=;
        b=o7BR7P+zS1UWXCAquZeYz8VCAX7ZS43HenGAkRGaQFXkyTKUiGj0eU7ycfddvZnhv5
         BDsKxz/AdAhBsJAhgX3kDwQ0/afcCJKMWGNbvucACNGgFFJhOHqhMF2wOnwQGnHlV/EA
         ptrqxYkzFp/Bc7J5k7P1isc0sr5sZ50gXp5xCGlMDUip+s5zELb70ugQnftnSTi9sMcz
         Ilvm46b0cOzU3IsTieZnHUzCdPaW6s9/r1YvUfGjgQhXdhoo62Q+oE29JTmIshCkxXdn
         PcOE+ml2W0KdsWmtBT+iRYyOR5UeH8hp0dB6ifmP6rDZ9LYnAa/fiRDisgRl6UohW6If
         ypZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HqV6X1qjzLYcilKB6wFdh2tVMPDFDXIW92VucSij86A=;
        b=6c1zzMuQKNO9tq5ZXLkGYH0fBLlM+YZw1f6LrsaEylw6wHk1SMgSKjdxR8wtaSh4JE
         AkaOrC4Lox0S0D1ZZ22DZJFj7VhdrCGynzPOJ6YTL/A31NuICllFy9j6VoAXy4uZtg9L
         Wsqz8gVykrZ/KqnlkGLc8VYEkq510UicxkaR1dNv2WJnL35DsAui3TaEy0+w04v0/aFM
         GAF6ScyN9f4+mfcz8gfg7lS9xYEswYFeFN3IxUFoaYkDLh+ZXs+A81q7CwNE31xBtCml
         ILtMBabDgIIuWnxZWfx3Ipzz1Lp9K9XLKUVmGQcakpItHo7s5UdahqUkDmpJr6MLD/QO
         pWQQ==
X-Gm-Message-State: ACrzQf1MTMOjaoxg4ZdMi8JSrbSDIQsykPZHW8ln/5NJ7b42YXhz/V0r
        l463WQVP0A4lwc8ELPojiRlqQOlhJqc2xV1t4Z8=
X-Google-Smtp-Source: AMsMyM4xkljLtDEl//QR9NR5JF4xykvWeqbsnz4ycJSLS8S+jhrB+aNBGatRDPyMXGTc73FI4kqw99M48vw8DkKdYGc=
X-Received: by 2002:a05:6402:350b:b0:452:2b68:90db with SMTP id
 b11-20020a056402350b00b004522b6890dbmr14905597edd.255.1663584273053; Mon, 19
 Sep 2022 03:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com> <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 11:44:05 +0100
Message-ID: <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com>
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

On Mon, Sep 19, 2022 at 11:15 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Geert,
>
> Prabhakar Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> > enabling wdt2
> >
> > Hi Biju,
> >
> > On Mon, Sep 19, 2022 at 12:06 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven <geert@linux-
> > > > m68k.org> wrote:
> > > > > On Wed, Sep 14, 2022 at 3:43 PM Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > WDT CH2 is specifically to check the operation of Cortex-M33
> > CPU
> > > > so
> > > > > > don't enable WDT2 by default.
> > > > > >
> > > > For consistency I'll drop enabling WDT2 from the RZ/G2L{C} too.
> > >
> > > Does remove unused clocks turn off WDT2 clock during late init??
> > >
> > > If that is the case, we should remove entries from clock table as
> > well?
> >
> > Or add it to *_crit_mod_clks[]?
> >
> > Note that drivers/clk/renesas/r9a07g043-cpg.c creates wdt2 clocks and
> > resets, so that should probably be moved inside the #ifdef
> > CONFIG_ARM64 section.
>
Yes we dont want it to be listed on RZ/Five.

> Yes, both will do, I guess otherwise WDT enabled by Cortex-M33 will be disabled by
> CORTEX-A55 during boot.
>
Agreed.

Cheers,
Prabhakar
