Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916569A642
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBQHv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQHvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:51:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83EA5A3BC;
        Thu, 16 Feb 2023 23:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676620313; x=1708156313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOejNXoNWWUPIQy9fpw83kfp7qZbCfTd5AdMHmp+szQ=;
  b=kjOJmBSYuX2U0w6iVhgk6mHdPiiW8j2q1R71tIyZrDtgETXu6wzFPJMO
   JgD1x8Q+3TyEBHqHm5tZCbHnuqZk74052DJmcyPlTqkVe6P3nfnB+zrf0
   3STUQOP5NIhR1iROUDhSMXhS+ZZr5qLbUdWu/Mq69chYIaCtNEeUgYt/o
   l8tpX3yc+DQIFnWeL7oFz1konxbv1SAp5PJrCq9OdPqhIdlY1tfSqldgS
   mfvgol9fkNluiV8+7YrgSmJ4Qrryl9mvjlU2EgIzYqaOCSXa6U29lNnrP
   /xn9LMvT2MrY8GO17Fw501ZEaGYWXjDip6Qeav1UhquGhVVec4jA8PINK
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="asc'?scan'208";a="212479409"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 00:51:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 00:51:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 17 Feb 2023 00:51:50 -0700
Date:   Fri, 17 Feb 2023 07:51:24 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y+8x/KSujhgNLAd6@wendy>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com>
 <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud>
 <68e61f28-daec-ce72-726a-1fffe8e94829@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JlO8Q7GKUV78Z9cu"
Content-Disposition: inline
In-Reply-To: <68e61f28-daec-ce72-726a-1fffe8e94829@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--JlO8Q7GKUV78Z9cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 10:27:27AM +0800, Hal Feng wrote:
> On Thu, 16 Feb 2023 18:20:34 +0000, Conor Dooley wrote:
> > Hey Hal!
> >=20
> > On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
> >> On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
> >> > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
> >> >> On Tue, 20 Dec 2022 23:14:39 +0000, Conor Dooley wrote:
> >> >> > On Tue, Dec 20, 2022 at 08:50:50AM +0800, Hal Feng wrote:
> >> >> > > From: Emil Renner Berthing <kernel@esmil.dk>
> >> >> > >=20
> >> >> > > Add bindings for the system clock and reset generator (SYSCRG) =
on the
> >> >> > > JH7110 RISC-V SoC by StarFive Ltd.
> >> >> > >=20
> >> >> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> >> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> >=20
> >> >> > > +  clocks:
> >> >> > > +    items:
> >> >> > > +      - description: Main Oscillator (24 MHz)
> >> >> > > +      - description: GMAC1 RMII reference
> >> >> > > +      - description: GMAC1 RGMII RX
> >> >> > > +      - description: External I2S TX bit clock
> >> >> > > +      - description: External I2S TX left/right channel clock
> >> >> > > +      - description: External I2S RX bit clock
> >> >> > > +      - description: External I2S RX left/right channel clock
> >> >> > > +      - description: External TDM clock
> >> >> > > +      - description: External audio master clock
> >> >> >=20
> >> >> > So, from peeking at the clock driver & the dt - it looks like a b=
unch of
> >> >> > these are not actually required?
> >> >>=20
> >> >> These clocks are used as root clocks or optional parent clocks in c=
lock tree.
> >> >> Some of them are optional, but they are required if we want to desc=
ribe the
> >> >> complete clock tree of JH7110 SoC.
> >> >=20
> >> > Perhaps I have a misunderstand of what required means. To me, requir=
ed
> >> > means "you must provide this clock for the SoC to operate in all
> >> > configurations".
> >> > Optional therefore would be for things that are needed only for some
> >> > configurations and may be omitted if not required.
> >> >=20
> >> > From your comment below, boards with a JH7110 may choose not to popu=
late
> >> > both external clock inputs to a mux. In that case, "dummy" clocks sh=
ould
> >> > not have to be provided in the DT of such boards to satisfy this bin=
ding
> >> > which seems wrong to me..
> >>=20
> >> Please see the picture of these external clocks in clock tree.
> >>=20
> >> # mount -t debugfs none /mnt
> >> # cat /mnt/clk/clk_summary
> >>                                  enable  prepare  protect             =
                   duty  hardware
> >>    clock                          count    count    count        rate =
  accuracy phase  cycle    enable
> >> ----------------------------------------------------------------------=
---------------------------------
> >>  *mclk_ext*                             0        0        0    1228800=
0          0     0  50000         Y
> >>  *tdm_ext*                              0        0        0    4915200=
0          0     0  50000         Y
> >>  *i2srx_lrck_ext*                       0        0        0      19200=
0          0     0  50000         Y
> >>  *i2srx_bclk_ext*                       0        0        0    1228800=
0          0     0  50000         Y
> >>  *i2stx_lrck_ext*                       0        0        0      19200=
0          0     0  50000         Y
> >>  *i2stx_bclk_ext*                       0        0        0    1228800=
0          0     0  50000         Y
> >>  *gmac1_rgmii_rxin*                     0        0        0   12500000=
0          0     0  50000         Y
> >>     gmac1_rx                          0        0        0   125000000 =
         0     0  50000         Y
> >>        gmac1_rx_inv                   0        0        0   125000000 =
         0   180  50000         Y
> >>  *gmac1_rmii_refin*                     0        0        0    5000000=
0          0     0  50000         Y
> >>     gmac1_rmii_rtx                    0        0        0    50000000 =
         0     0  50000         Y
> >>        gmac1_tx                       0        0        0    50000000 =
         0     0  50000         N
> >>           gmac1_tx_inv                0        0        0    50000000 =
         0   180  50000         Y
> >>  *osc*                                  4        4        0    2400000=
0          0     0  50000         Y
> >>     apb_func                          0        0        0    24000000 =
         0     0  50000         Y
> >>  ...
> >>=20
> >> The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" are
> >> actually used as the parent of other clocks.
> >=20
> >> The "dummy" clocks
> >> you said are all internal clocks.
> >=20
> > No, what I meant by "dummy" clocks is that if you make clocks "required"
> > in the binding that are not needed by the hardware for operation a
> > customer of yours might have to add "dummy" clocks to their devicetree
> > to pass dtbs_check.
> >=20
> >> For the audio related clocks (mclk_ext/tdm_ext/i2srx_lrck_ext/
> >> i2srx_bclk_ext/i2stx_lrck_ext/i2stx_bclk_ext), they will be used
> >> as the parent clocks in audio related drivers. Note that some
> >> clocks need to select different clocks as parent according to
> >> requirement.
> >> So all these external clocks are required.
> >>=20
> >> >=20
> >> > It would seem to me that you need to set minItems < maxItems here to
> >> > account for that & you do in fact need clock-names.
> >> >=20
> >> >>=20
> >> >> > I'd have ploughed through this, but having read Krzysztof's comme=
nts on
> >> >> > the DTS I'm not sure that this binding is correct.
> >> >> > https://lore.kernel.org/linux-riscv/20221220011247.35560-1-hal.fe=
ng@starfivetech.com/T/#mdf67621a2344dce801aa8015d4963593a2c28bcc
> >> >> >=20
> >> >> > I *think* the DT is correct - the fixed clocks are all inputs fro=
m clock
> >> >> > sources on the board and as such they are empty in soc.dtsi and a=
re
> >> >> > populated in board.dts?
> >> >>=20
> >> >> Yes, the fixed clocks are all clock sources on the board and input =
to the SoC.
> >> >>=20
> >> >> >=20
> >> >> > However, are they all actually required? In the driver I see:
> >> >> > 	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
> >> >> > 		    JH7110_SYSCLK_GMAC1_RGMII_RXIN,
> >> >> > 		    JH7110_SYSCLK_GMAC1_RMII_RTX),
> >> >> > That macro is:
> >> >> > #define JH71X0__MUX(_idx, _name, _nparents, ...) [_idx] =3D {			\
> >> >> > 	.name =3D _name,								\
> >> >> > 	.flags =3D 0,								\
> >> >> > 	.max =3D ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
> >> >> > 	.parents =3D { __VA_ARGS__ },						\
> >> >> > }
> >=20
> >> >> > AFAICT, RMII reference feeds RMII_RTX & RGMII RX *is* RGMII_RXIN?
> >> >> > Does that mean you need to populate only one of GMAC1 RMII refere=
nce
> >> >> > and GMAC1 RMGII RX and the other is optional?
> >=20
> >> >> Yes, actually only one of them is chosen as the root clock
> >> >> source of the clock "gmac1_rx".
> > |  *gmac1_rgmii_rxin*  =20
> > |     gmac1_rx         =20
> > |        gmac1_rx_inv  =20
> > |  *gmac1_rmii_refin*  =20
> > |     gmac1_rmii_rtx   =20
> > |        gmac1_tx      =20
> > |           gmac1_tx_inv
> > |
> > | description: GMAC1 RMII reference
> > | description: GMAC1 RGMII RX
> >=20
> >=20
> > So you're telling me that you can either:
> > - Provide GMAC1 RMII reference and GMAC1 RGMII RX & then use different
> >   clocks for gmac1_rx and gmac1_tx
> > - Provide only GMAC1 RMII reference & use it for both gmac1_tx *and*
> >   gmac1_rx
> >=20
> > Is that correct?
>=20
> Yes, it is.

Which would then make GMAC1 RGMII RX optional, rather than required?


--JlO8Q7GKUV78Z9cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+8x/AAKCRB4tDGHoIJi
0ng2AP9laHdcGkQgr/k2MLWKGByViMscggcXJRE/8hKzY7gTvQEA3FgxcicBwysX
yesQe4IpWXBVeLnEpUeFFxTdty8PvQE=
=NKFm
-----END PGP SIGNATURE-----

--JlO8Q7GKUV78Z9cu--
