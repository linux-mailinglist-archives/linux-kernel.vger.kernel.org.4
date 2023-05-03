Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691306F5F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjECTix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:38:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFA619E;
        Wed,  3 May 2023 12:38:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35231755;
        Wed,  3 May 2023 21:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683142726;
        bh=z9h1L4FSJYTgSOT7AfLs56rIVm5AivZZhOhg4sKWHi4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a8Mde7Wq+kgQROwZsD+KBym+sRVMmdVzsbm78XhQs8EE7NJkZ0lG+URWyI5p8j4Xh
         k46gSixmYinJf4E/ZrlihlPlNqybD1M7a15X9NrluEJr4IETUu8km27IHLR1yrnCCz
         b8vEQnjmgX4JdOv4MzaLB+2ReSPEMTuIt/9a29q0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdV0iZJwNDRTxZXr-Rg_=VDN1hYw2gbSwwys1EDrzgC7Ew@mail.gmail.com>
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com> <20230502170618.55967-3-wsa+renesas@sang-engineering.com> <CAMuHMdV0iZJwNDRTxZXr-Rg_=VDN1hYw2gbSwwys1EDrzgC7Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a779a0: Add PWM nodes
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed, 03 May 2023 20:38:46 +0100
Message-ID: <168314272625.1880445.3765065467307871846@Monstersaurus>
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

Quoting Geert Uytterhoeven (2023-05-03 11:14:52)
> Hi Wolfram,
>=20
> On Tue, May 2, 2023 at 7:06=E2=80=AFPM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > From: Phong Hoang <phong.hoang.wz@renesas.com>
> >
> > This patch adds PWM nodes for R-Car V3U (r8a779a0) SoC.
> >
> > Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> > [wsa: rebased]
> > Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.5.
>=20
> > --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > @@ -1108,6 +1108,56 @@ msiof5: spi@e6c28000 {
> >                         status =3D "disabled";
> >                 };
> >
> > +               pwm0: pwm@e6e30000 {
>=20
> I'll move this before serial@e6e60000 while applying, to preserve sort
> order (by unit address).

I still wonder when we can have nice tools that will sort DT and format
DT files for us!


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

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
