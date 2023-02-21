Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EB69E9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBUWRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBUWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:17:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6600730B25;
        Tue, 21 Feb 2023 14:17:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18FA8B80EF7;
        Tue, 21 Feb 2023 22:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDBFC433EF;
        Tue, 21 Feb 2023 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677017839;
        bh=bs1akhKjv3J4NmgD6apUPLidQ9TEW782FUgeyLThyxA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=C+6QWIYGa1uLXRUxWQg7WY9brhFOOPrRR8c9ih5Y6tzBubrze2OOYnpKlCp45vK4d
         kFhnNQqNod0heMGMtlamwIfY1Q33DssADqtXcAOYAc/O7iyaaRmwZIb/Fxvi0utuy1
         DkE2dL29TGy9GA80R9+GfHrQNeviPT8NQBNYrh1iWissJtOgff5AMtLpGsUl/sXZch
         HRJz51hvEv0wqVF+gTuD/lrmw/z/eCLzNLt7BFxJD5r5TncYdKrgfNG2tyi2Re2SIz
         ytkMmDBiJx62wHzB6DFj6r0ptT+huSMbu370vRq6dqKcZadSpCVaD/ChCte0A4ivVE
         4tuolzr56XuJw==
Message-ID: <72953dc9371b87da8d03c63633d7d9dd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y+5z8skN2DuvxDEL@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com> <20221220005054.34518-8-hal.feng@starfivetech.com> <Y6JB37Pd5TZoGMy4@spud> <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com> <Y6tSWB2+98a8k9Qw@spud> <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com> <Y+5z8skN2DuvxDEL@spud>
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>
Date:   Tue, 21 Feb 2023 14:17:17 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-02-16 10:20:34)
> Hey Hal!
>=20
> On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
> > On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
> > > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
> > >> On Tue, 20 Dec 2022 23:14:39 +0000, Conor Dooley wrote:
> > >> > On Tue, Dec 20, 2022 at 08:50:50AM +0800, Hal Feng wrote:
> > >> > > From: Emil Renner Berthing <kernel@esmil.dk>
> > >> > >=20
> > >> > > Add bindings for the system clock and reset generator (SYSCRG) o=
n the
> > >> > > JH7110 RISC-V SoC by StarFive Ltd.
> > >> > >=20
> > >> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > >> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > >=20
> > >> > > +  clocks:
> > >> > > +    items:
> > >> > > +      - description: Main Oscillator (24 MHz)
> > >> > > +      - description: GMAC1 RMII reference
> > >> > > +      - description: GMAC1 RGMII RX
> > >> > > +      - description: External I2S TX bit clock
> > >> > > +      - description: External I2S TX left/right channel clock
> > >> > > +      - description: External I2S RX bit clock
> > >> > > +      - description: External I2S RX left/right channel clock
> > >> > > +      - description: External TDM clock
> > >> > > +      - description: External audio master clock
> > >> >=20
> > >> > So, from peeking at the clock driver & the dt - it looks like a bu=
nch of
> > >> > these are not actually required?
> > >>=20
> > >> These clocks are used as root clocks or optional parent clocks in cl=
ock tree.
> > >> Some of them are optional, but they are required if we want to descr=
ibe the
> > >> complete clock tree of JH7110 SoC.
> > >=20
> > > Perhaps I have a misunderstand of what required means. To me, required
> > > means "you must provide this clock for the SoC to operate in all
> > > configurations".
> > > Optional therefore would be for things that are needed only for some
> > > configurations and may be omitted if not required.
> > >=20
> > > From your comment below, boards with a JH7110 may choose not to popul=
ate
> > > both external clock inputs to a mux. In that case, "dummy" clocks sho=
uld
> > > not have to be provided in the DT of such boards to satisfy this bind=
ing
> > > which seems wrong to me..

I agree. We don't want there to be "dummy" clks in DT. It should never
be required.

> >=20
> > Please see the picture of these external clocks in clock tree.
> >=20
> > # mount -t debugfs none /mnt
> > # cat /mnt/clk/clk_summary
> >                                  enable  prepare  protect              =
                  duty  hardware
> >    clock                          count    count    count        rate  =
 accuracy phase  cycle    enable
> > -----------------------------------------------------------------------=
--------------------------------
> >  *mclk_ext*                             0        0        0    12288000=
          0     0  50000         Y
> >  *tdm_ext*                              0        0        0    49152000=
          0     0  50000         Y
> >  *i2srx_lrck_ext*                       0        0        0      192000=
          0     0  50000         Y
> >  *i2srx_bclk_ext*                       0        0        0    12288000=
          0     0  50000         Y
> >  *i2stx_lrck_ext*                       0        0        0      192000=
          0     0  50000         Y
> >  *i2stx_bclk_ext*                       0        0        0    12288000=
          0     0  50000         Y
> >  *gmac1_rgmii_rxin*                     0        0        0   125000000=
          0     0  50000         Y
> >     gmac1_rx                          0        0        0   125000000  =
        0     0  50000         Y
> >        gmac1_rx_inv                   0        0        0   125000000  =
        0   180  50000         Y
> >  *gmac1_rmii_refin*                     0        0        0    50000000=
          0     0  50000         Y
> >     gmac1_rmii_rtx                    0        0        0    50000000  =
        0     0  50000         Y
> >        gmac1_tx                       0        0        0    50000000  =
        0     0  50000         N
> >           gmac1_tx_inv                0        0        0    50000000  =
        0   180  50000         Y
> >  *osc*                                  4        4        0    24000000=
          0     0  50000         Y
> >     apb_func                          0        0        0    24000000  =
        0     0  50000         Y
> >  ...
> >=20
> > The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" are
> > actually used as the parent of other clocks.
>=20
> > The "dummy" clocks
> > you said are all internal clocks.
>=20
> No, what I meant by "dummy" clocks is that if you make clocks "required"
> in the binding that are not needed by the hardware for operation a
> customer of yours might have to add "dummy" clocks to their devicetree
> to pass dtbs_check.

They can set the phandle specifier to '<0>' to fill in the required
property when there isn't anything there. If this is inside an SoC, it
is always connected because silicon can't change after it is made
(unless this is an FPGA). Therefore, any and all input clocks should be
listed as required. If the clk controller has inputs that are
pads/balls/pins on the SoC then they can be optional if a valid design
can leave those pins not connected.
