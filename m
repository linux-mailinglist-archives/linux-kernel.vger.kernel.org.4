Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1369EB58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBUXkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBUXkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:40:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DEF3400F;
        Tue, 21 Feb 2023 15:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B748B61298;
        Tue, 21 Feb 2023 23:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305F4C433D2;
        Tue, 21 Feb 2023 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677022777;
        bh=ie0GAExwZPpmXLWLkpfA8sVNwYvYbybeiZNOj6h8WEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTbwBBUEzXr2PONY2NQhckcJSZb82zbvfiyxjZ989wicvTS9uHXoL9n7squ+tJaFi
         Rouxs8i5zSa0M1wYR92LiOH5C6E9wC4iK/ghvVBJTdGrEwM6TO8ODO9MUrCtqy0j7x
         c/4fwKmmUVG7w7uqupmuclAqb1eKDGoaBnQ8xOAtgrKM9Q3WXGI65AviknIZe99KZg
         KJVDEnwkYoUYrpbt5/o9fr84D6a3Q2ETfDQILnspFjB1FwYJedXAvtQvLFffhms53q
         UAnpaPrXmOf9gpsekw7ZkA7NYRE//ho1Y2Pdwx8GzGOAt4kYPP9m35PfOzPOamTTa5
         8ZzXBju3bxPig==
Date:   Tue, 21 Feb 2023 23:39:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y/VWNPfApsfm3/UD@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com>
 <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud>
 <72953dc9371b87da8d03c63633d7d9dd.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VknuSA68ljcWlQyJ"
Content-Disposition: inline
In-Reply-To: <72953dc9371b87da8d03c63633d7d9dd.sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VknuSA68ljcWlQyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 02:17:17PM -0800, Stephen Boyd wrote:
> Quoting Conor Dooley (2023-02-16 10:20:34)
> > On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
> > > On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
> > > > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
> > > Please see the picture of these external clocks in clock tree.
> > >=20
> > > # mount -t debugfs none /mnt
> > > # cat /mnt/clk/clk_summary
> > >                                  enable  prepare  protect            =
                    duty  hardware
> > >    clock                          count    count    count        rate=
   accuracy phase  cycle    enable
> > > ---------------------------------------------------------------------=
----------------------------------
> > >  *mclk_ext*                             0        0        0    122880=
00          0     0  50000         Y
> > >  *tdm_ext*                              0        0        0    491520=
00          0     0  50000         Y
> > >  *i2srx_lrck_ext*                       0        0        0      1920=
00          0     0  50000         Y
> > >  *i2srx_bclk_ext*                       0        0        0    122880=
00          0     0  50000         Y
> > >  *i2stx_lrck_ext*                       0        0        0      1920=
00          0     0  50000         Y
> > >  *i2stx_bclk_ext*                       0        0        0    122880=
00          0     0  50000         Y
> > >  *gmac1_rgmii_rxin*                     0        0        0   1250000=
00          0     0  50000         Y
> > >     gmac1_rx                          0        0        0   125000000=
          0     0  50000         Y
> > >        gmac1_rx_inv                   0        0        0   125000000=
          0   180  50000         Y
> > >  *gmac1_rmii_refin*                     0        0        0    500000=
00          0     0  50000         Y
> > >     gmac1_rmii_rtx                    0        0        0    50000000=
          0     0  50000         Y
> > >        gmac1_tx                       0        0        0    50000000=
          0     0  50000         N
> > >           gmac1_tx_inv                0        0        0    50000000=
          0   180  50000         Y
> > >  *osc*                                  4        4        0    240000=
00          0     0  50000         Y
> > >     apb_func                          0        0        0    24000000=
          0     0  50000         Y
> > >  ...
> > >=20
> > > The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" are
> > > actually used as the parent of other clocks.
> >=20
> > > The "dummy" clocks
> > > you said are all internal clocks.
> >=20
> > No, what I meant by "dummy" clocks is that if you make clocks "required"
> > in the binding that are not needed by the hardware for operation a
> > customer of yours might have to add "dummy" clocks to their devicetree
> > to pass dtbs_check.
>=20
> They can set the phandle specifier to '<0>' to fill in the required
> property when there isn't anything there. If this is inside an SoC, it
> is always connected because silicon can't change after it is made
> (unless this is an FPGA). Therefore, any and all input clocks should be
> listed as required.

> If the clk controller has inputs that are
> pads/balls/pins on the SoC then they can be optional if a valid design
> can leave those pins not connected.

=46rom the discussion on the dts patches, where the clocks have been put
(intentionally) into board.dts, I've been under the impression that we
are in this situation.
Up to Hal to tell us if the hardware is capable of having those inputs
left unfilled!

FWIW, there's a v4 [1] of this series - but the question has yet to be
resolved.

Thanks,
Conor.

1 - https://lore.kernel.org/all/20230221024645.127922-1-hal.feng@starfivete=
ch.com/

--VknuSA68ljcWlQyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/VWMAAKCRB4tDGHoIJi
0vMnAP9+HziqXbEJ1GX8HIr5jD+lzSjYpeu8k3IfZk1pte1WdAEAwNfSAKDpB2Sz
rYa+dCvHzPRG/YzqUU8wOHnRfqNDxQw=
=9xTC
-----END PGP SIGNATURE-----

--VknuSA68ljcWlQyJ--
