Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C9B6F5F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjECTh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:37:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC75619E;
        Wed,  3 May 2023 12:37:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9A5C755;
        Wed,  3 May 2023 21:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683142671;
        bh=yfAwbaUKZSnKoed08VhWC18/ixIfVmYbDcSFtKakHU0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rNuKNqiUSObj9aRyK/babtm2zk7dtSzaiT5OYlhefE9Zu91EnR5LkSpvqxvZcpYMf
         cgSf1A4NXldjj19uWO+8Z4soOEEIRl1T/7b5az6EJanCyaRO3ddIv5+chsMNLu4H2H
         qMQZTYmW2Neza4nG8B4rw6LlTtsiFVSiR8WJtRYs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com> <20230502170618.55967-2-wsa+renesas@sang-engineering.com> <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: r8a779a0: Add PWM clock
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed, 03 May 2023 20:37:51 +0100
Message-ID: <168314267169.1880445.1440127465012985035@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2023-05-03 11:09:29)
> Hi Wolfram,
>=20
> On Tue, May 2, 2023 at 7:06=E2=80=AFPM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
> > +++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
> > @@ -170,6 +170,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[=
] __initconst =3D {
> >         DEF_MOD("msi3",         621,    R8A779A0_CLK_MSO),
> >         DEF_MOD("msi4",         622,    R8A779A0_CLK_MSO),
> >         DEF_MOD("msi5",         623,    R8A779A0_CLK_MSO),
> > +       DEF_MOD("pwm",          628,    R8A779A0_CLK_S1D8),
>=20
> Do you mind if I rename this to "pwm0" while applying, to match the docs?
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-clk-for-v6.5.

Either way is fine with me, and I've seen this work now so:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>=20
> >         DEF_MOD("rpc-if",       629,    R8A779A0_CLK_RPCD2),
> >         DEF_MOD("scif0",        702,    R8A779A0_CLK_S1D8),
> >         DEF_MOD("scif1",        703,    R8A779A0_CLK_S1D8),
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
