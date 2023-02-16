Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F8699C04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBPSUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:20:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E852A15A;
        Thu, 16 Feb 2023 10:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F192CE2CCB;
        Thu, 16 Feb 2023 18:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071CFC433D2;
        Thu, 16 Feb 2023 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676571639;
        bh=jK04dJp0pBaLqeMaRgMoUwmpJaZiVkQJQAEC+NYBGZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/ynTfzxEjIbO4oAwSK1Hbwj7eaBIhBw3bZXLs2Io67aP7zyaNaiFGk5hsSR0vdon
         9MGT/Iv8MPFmFQuJbEdvQ+dtiI4SN8+IyBPQ05h6iZfB1JC441ntei2IuQ5KdNgNXe
         9xjgQpJdpeTZ3OPWHNT4VtSYbH7BuHoB3YqZGRtKDzvXczDUOrMd3nQIQP9Gglk/Ja
         uvZOw6tDh2Ay9jt8XoQEvlWT5attfigQ0XkXLZyjeb5HhwIvnLcmmT47D6a+8wztr4
         v1p3pc4bH+b9hcHPTRw/77gkhKa8Rsxb/r2lxmKVUWxWQZPp1z5bbEViIzt2F45hI3
         nyiJeINLDIUiw==
Date:   Thu, 16 Feb 2023 18:20:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y+5z8skN2DuvxDEL@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com>
 <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tfomlMJXp+aiuG3l"
Content-Disposition: inline
In-Reply-To: <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfomlMJXp+aiuG3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Hal!

On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
> On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
> > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
> >> On Tue, 20 Dec 2022 23:14:39 +0000, Conor Dooley wrote:
> >> > On Tue, Dec 20, 2022 at 08:50:50AM +0800, Hal Feng wrote:
> >> > > From: Emil Renner Berthing <kernel@esmil.dk>
> >> > >=20
> >> > > Add bindings for the system clock and reset generator (SYSCRG) on =
the
> >> > > JH7110 RISC-V SoC by StarFive Ltd.
> >> > >=20
> >> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >=20
> >> > > +  clocks:
> >> > > +    items:
> >> > > +      - description: Main Oscillator (24 MHz)
> >> > > +      - description: GMAC1 RMII reference
> >> > > +      - description: GMAC1 RGMII RX
> >> > > +      - description: External I2S TX bit clock
> >> > > +      - description: External I2S TX left/right channel clock
> >> > > +      - description: External I2S RX bit clock
> >> > > +      - description: External I2S RX left/right channel clock
> >> > > +      - description: External TDM clock
> >> > > +      - description: External audio master clock
> >> >=20
> >> > So, from peeking at the clock driver & the dt - it looks like a bunc=
h of
> >> > these are not actually required?
> >>=20
> >> These clocks are used as root clocks or optional parent clocks in cloc=
k tree.
> >> Some of them are optional, but they are required if we want to describ=
e the
> >> complete clock tree of JH7110 SoC.
> >=20
> > Perhaps I have a misunderstand of what required means. To me, required
> > means "you must provide this clock for the SoC to operate in all
> > configurations".
> > Optional therefore would be for things that are needed only for some
> > configurations and may be omitted if not required.
> >=20
> > From your comment below, boards with a JH7110 may choose not to populate
> > both external clock inputs to a mux. In that case, "dummy" clocks should
> > not have to be provided in the DT of such boards to satisfy this binding
> > which seems wrong to me..
>=20
> Please see the picture of these external clocks in clock tree.
>=20
> # mount -t debugfs none /mnt
> # cat /mnt/clk/clk_summary
>                                  enable  prepare  protect                =
                duty  hardware
>    clock                          count    count    count        rate   a=
ccuracy phase  cycle    enable
> -------------------------------------------------------------------------=
------------------------------
>  *mclk_ext*                             0        0        0    12288000  =
        0     0  50000         Y
>  *tdm_ext*                              0        0        0    49152000  =
        0     0  50000         Y
>  *i2srx_lrck_ext*                       0        0        0      192000  =
        0     0  50000         Y
>  *i2srx_bclk_ext*                       0        0        0    12288000  =
        0     0  50000         Y
>  *i2stx_lrck_ext*                       0        0        0      192000  =
        0     0  50000         Y
>  *i2stx_bclk_ext*                       0        0        0    12288000  =
        0     0  50000         Y
>  *gmac1_rgmii_rxin*                     0        0        0   125000000  =
        0     0  50000         Y
>     gmac1_rx                          0        0        0   125000000    =
      0     0  50000         Y
>        gmac1_rx_inv                   0        0        0   125000000    =
      0   180  50000         Y
>  *gmac1_rmii_refin*                     0        0        0    50000000  =
        0     0  50000         Y
>     gmac1_rmii_rtx                    0        0        0    50000000    =
      0     0  50000         Y
>        gmac1_tx                       0        0        0    50000000    =
      0     0  50000         N
>           gmac1_tx_inv                0        0        0    50000000    =
      0   180  50000         Y
>  *osc*                                  4        4        0    24000000  =
        0     0  50000         Y
>     apb_func                          0        0        0    24000000    =
      0     0  50000         Y
>  ...
>=20
> The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" are
> actually used as the parent of other clocks.

> The "dummy" clocks
> you said are all internal clocks.

No, what I meant by "dummy" clocks is that if you make clocks "required"
in the binding that are not needed by the hardware for operation a
customer of yours might have to add "dummy" clocks to their devicetree
to pass dtbs_check.

> For the audio related clocks (mclk_ext/tdm_ext/i2srx_lrck_ext/
> i2srx_bclk_ext/i2stx_lrck_ext/i2stx_bclk_ext), they will be used
> as the parent clocks in audio related drivers. Note that some
> clocks need to select different clocks as parent according to
> requirement.
> So all these external clocks are required.
>=20
> >=20
> > It would seem to me that you need to set minItems < maxItems here to
> > account for that & you do in fact need clock-names.
> >=20
> >>=20
> >> > I'd have ploughed through this, but having read Krzysztof's comments=
 on
> >> > the DTS I'm not sure that this binding is correct.
> >> > https://lore.kernel.org/linux-riscv/20221220011247.35560-1-hal.feng@=
starfivetech.com/T/#mdf67621a2344dce801aa8015d4963593a2c28bcc
> >> >=20
> >> > I *think* the DT is correct - the fixed clocks are all inputs from c=
lock
> >> > sources on the board and as such they are empty in soc.dtsi and are
> >> > populated in board.dts?
> >>=20
> >> Yes, the fixed clocks are all clock sources on the board and input to =
the SoC.
> >>=20
> >> >=20
> >> > However, are they all actually required? In the driver I see:
> >> > 	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
> >> > 		    JH7110_SYSCLK_GMAC1_RGMII_RXIN,
> >> > 		    JH7110_SYSCLK_GMAC1_RMII_RTX),
> >> > That macro is:
> >> > #define JH71X0__MUX(_idx, _name, _nparents, ...) [_idx] =3D {			\
> >> > 	.name =3D _name,								\
> >> > 	.flags =3D 0,								\
> >> > 	.max =3D ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
> >> > 	.parents =3D { __VA_ARGS__ },						\
> >> > }

> >> > AFAICT, RMII reference feeds RMII_RTX & RGMII RX *is* RGMII_RXIN?
> >> > Does that mean you need to populate only one of GMAC1 RMII reference
> >> > and GMAC1 RMGII RX and the other is optional?

> >> Yes, actually only one of them is chosen as the root clock
> >> source of the clock "gmac1_rx".
|  *gmac1_rgmii_rxin*  =20
|     gmac1_rx         =20
|        gmac1_rx_inv  =20
|  *gmac1_rmii_refin*  =20
|     gmac1_rmii_rtx   =20
|        gmac1_tx      =20
|           gmac1_tx_inv
|
| description: GMAC1 RMII reference
| description: GMAC1 RGMII RX


So you're telling me that you can either:
- Provide GMAC1 RMII reference and GMAC1 RGMII RX & then use different
  clocks for gmac1_rx and gmac1_tx
- Provide only GMAC1 RMII reference & use it for both gmac1_tx *and*
  gmac1_rx

Is that correct?

> >> >=20
> >> > > +
> >> > > +  clock-names:
> >> > > +    items:
> >> > > +      - const: osc
> >> > > +      - const: gmac1_rmii_refin
> >> > > +      - const: gmac1_rgmii_rxin
> >> > > +      - const: i2stx_bclk_ext
> >> > > +      - const: i2stx_lrck_ext
> >> > > +      - const: i2srx_bclk_ext
> >> > > +      - const: i2srx_lrck_ext
> >> > > +      - const: tdm_ext
> >> > > +      - const: mclk_ext
> >> >=20
> >> > If all clocks are in fact required though, isn't this kinda pointles=
s to
> >> > have since we already know that the order is fixed from the "clocks"
> >> > property?
> >> > Krzk/Rob?
> >>=20
> >> The clock-names are used to easily identify these clocks in the clock =
driver.
> >=20
> > *IF* all clocks were in fact required, which they aren't, you could rely
> > on the order alone in the driver as it is enforced by the binding.
>=20
> OK, I'll remove "clock-names" property in the bindings and device tree.
> Instead, will use index to get these clocks in drivers.

Hang on until you answer my question above before deleting this from the
dt-binding & driver ;)


--tfomlMJXp+aiuG3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+5z8gAKCRB4tDGHoIJi
0l/OAP4mjA8CLknFT2rh06ebAfVs/7Tq4xi/y0ZV1CybXw0gpgEAvrvV1QJ39Y/d
ugfr6YG/I/ZWeyu4M8p2/ls9gz+0uww=
=uJUs
-----END PGP SIGNATURE-----

--tfomlMJXp+aiuG3l--
