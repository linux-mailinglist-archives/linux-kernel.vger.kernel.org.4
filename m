Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0401F69B9A0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBRLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:17:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19ED1B334;
        Sat, 18 Feb 2023 03:17:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E72060A05;
        Sat, 18 Feb 2023 11:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC75C433EF;
        Sat, 18 Feb 2023 11:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676719033;
        bh=MBpW+wS6kJjM9nw/RX4T/6lVEQz7JAtQyjKM0xZ3B+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbCF8rxLVhB+zqGRt9Y85P0PTJ2aOqfqKaNuekrrAE8pdZY1DEN6tfgBbSozPG08i
         uLE/Z4IlY8Xm89vjqDdVvdAeigbQGvCKq1bzTbxy+vQ1KvJ4cDbUY843nJd9yOKBLa
         aCAMgekEnGtWT+s5V2eR0/VUKcnRNfJxs905kkDVTJwvncsCu10mxEBRa8puviTSrT
         +XvUrr7SCjxlsPvL2iYkfGqbNq8TULVBOlD+1ZjWvLoyTBuCndbogYtwXKRU2n2qXM
         0eJqB9JeLzVMGD104WB0SvLA8b7i65q2NU5CR5rXD13YUWMfqnb7LgeHb9T8Wq/n0W
         /ZbIfRiDiOnbw==
Date:   Sat, 18 Feb 2023 11:17:08 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
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
Message-ID: <Y/CztNs6laTzttrI@spud>
References: <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud>
 <68e61f28-daec-ce72-726a-1fffe8e94829@starfivetech.com>
 <Y+8x/KSujhgNLAd6@wendy>
 <d3b06d0b-ff17-ebab-bae5-e1ec836fe667@starfivetech.com>
 <Y++B43uCnPQlRYFi@wendy>
 <dcba75b5-7b62-35aa-6836-5d5edd785002@linaro.org>
 <Y++q9ln8P3XegqfN@spud>
 <41e4f293-99eb-f157-b4a9-3d00b15f4652@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PuWXwRc8It3YJ8xy"
Content-Disposition: inline
In-Reply-To: <41e4f293-99eb-f157-b4a9-3d00b15f4652@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PuWXwRc8It3YJ8xy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Krzysztof,

On Sat, Feb 18, 2023 at 11:20:30AM +0100, Krzysztof Kozlowski wrote:
> On 17/02/2023 17:27, Conor Dooley wrote:
> > On Fri, Feb 17, 2023 at 04:47:48PM +0100, Krzysztof Kozlowski wrote:
> >> On 17/02/2023 14:32, Conor Dooley wrote:
> >>>>>> Yes, it is.
> >>>>>
> >>>>> Which would then make GMAC1 RGMII RX optional, rather than required?
> >>>>
> >>>> If thinking in this way, I must say yes, it is optional. But actually
> >>>> GMAC1 RGMII RX feeds gmac1_rx by default.=20
> >>>> For a mux, it usually works if you populate only one input to it.
> >>>> Does it mean all the other inputs are optional? And how can we define
> >>>> which input is required?
> >>>
> >>> I'm not sure, that is a question for Krzysztof and/or Rob.
> >>
> >> That's a long thread, please summarize what you ask. Otherwise I have =
no
> >> clue what is the question.
> >=20
> > Sorry. I tried to preserve the context of the conversation the last time
> > I cropped it so that things would be contained on one email.
> >=20
> > For me at least, I am wondering how you convey that out of a list of
> > clock inputs (for example a, b, c, d) that two of the clocks are inputs
> > to a mux and it is only required to provide one of the two (say b & c).

You skipped this part which was what I was trying to ask you about.
Do you know how to convey this situation, or is it even possible to
express those rules?

> >> Does the mux works correctly if clock input is not connected? I mean,
> >> are you now talking about real hardware or some simplification from SW
> >> point of view?
> >=20
> > I'm coming at this from an angle of "is a StarFive customer going to sh=
ow
> > up with a devicetree containing dummy fixed-clocks to satisfy dtbs_check
> > because they opted to only populate one input to the mux".
> > I don't really care about implications for the driver, just about
> > whether the hardware allows for inputs to the mux to be left
> > un-populated.
>=20
> Whether hardware allows - not a question to me.

> BTW, this is rather question coming from me...

I don't understand what you mean by this, sorry.

Thanks,
Conor.


--PuWXwRc8It3YJ8xy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/CztAAKCRB4tDGHoIJi
0jg/AP4wInRGlkOUh1Al9iKc09rdNcx7Y9+jOgeM4wKt33DlgQEA+4tSZw88zO0/
a6YhAFGSsTVeN3Rx2Dki8r642zgv0wk=
=XpKK
-----END PGP SIGNATURE-----

--PuWXwRc8It3YJ8xy--
