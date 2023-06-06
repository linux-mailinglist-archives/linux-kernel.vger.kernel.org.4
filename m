Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45789724739
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbjFFPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbjFFPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20FB0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1720A62CAB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B8C433D2;
        Tue,  6 Jun 2023 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686063887;
        bh=ItSYZ+KO4DGWy/bW7qm3zg+KCNQ8NPnARJX6M4xvOqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5ACuJLnPmK+S0NPab7ZSPkKu2SZPJlxLEagx/DdM1ohCY1qXEZNqKAUr/Mi4qPnW
         SDOLmyhBOhK7qTNz+EQ+vu6Fl+j7Aynoub23oiaGnpJlSC4ucxpCrXLYeJG1dsK+NK
         s4nCZT5JrktseFt3FMks3CYgppJVcTxkNhBHsNVwpTiMR64BxPJpDTGwZENmw4f1IM
         kZdU/K7N/tTeRoKXKcdDRrEhC/WXTkxaBFJ6i6q7ooW0FYp+Dr/B09pvoe6QbAGmgn
         0rQ0Yx5W71Gikb8HeTY0ku/J6Aux75RML4tjbQh+PRx4EzRThLbSEv1c4ouKWuwEcJ
         KZa7pihDc43FQ==
Date:   Tue, 6 Jun 2023 16:04:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Moti Haimovski <mhaimovski@habana.ai>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "david.m.ertman@intel.com" <david.m.ertman@intel.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] make AUXILIARY_BUS config selection clearer
Message-ID: <20230606-sushi-clunky-8e816f5b206d@spud>
References: <20230606133528.197335-1-mhaimovski@habana.ai>
 <20230606-aspirate-evident-00b27a98a718@wendy>
 <AM9PR02MB7706888212798FE0CC8213D6D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3we3bV80r3awbsJU"
Content-Disposition: inline
In-Reply-To: <AM9PR02MB7706888212798FE0CC8213D6D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3we3bV80r3awbsJU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 02:50:21PM +0000, Moti Haimovski wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > On Tue, Jun 06, 2023 at 04:35:28PM +0300, Moti Haimovski wrote:
> > > Add a display string and a help section to the config AUXILIARY_BUS
> > > section under the "Generic Driver Options" menu in order to make its
> > > selection clearer.
> >=20
> > I am a wee bit confused, since it is not explicitly mentioned here, why=
 is this
> > now going to be user visible/selectable? What was wrong with the drivers
> > that needed it selecting it?

(please don't top post)

>  Noting is wrong with the drivers =F0=9F=98=8A
>=20
> I've stumbled that issue when trying to figure-out how to manipulate the =
auxiliary-bus selection
> Via "make menuconfig"
> The issue is that with the current Kconfig when you run " make menuconfig=
" and enter the
> Device Drivers --->     Generic Driver Options --->   Sub-menu then there=
 is no mentioning of
>  the Auxiliary bus although it is the first entry in drivers/base/Kconfig=
 that this menu is presenting.
> So, the user has no idea that this option exists and no way to manipulate=
 it via menconfig.

That's the point of how it currently is though, no?
We don't allow users to set the option, but rather any device driver
that needs it, selects it.
That way, a person configuring their kernel for some hardware just needs
to enable the drivers for their hardware and knowledge of kernel
internals is not needed.

Is there a particular driver, perhaps in drivers/accel, that does not
select the option, which is why you are trying to set it yourself?

Cheers,
Conor.

> My commit makes this option "visible" by adding the short description in =
the "bool" line
> and , while at it, adding a short description for the sake of future gene=
rations.
> No functionality nor default values were altered.

> > >
> > > Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
> > > ---
> > >  drivers/base/Kconfig | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig index
> > > 6f04b831a5c0..e1caac1d9a58 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -2,7 +2,16 @@
> > >  menu "Generic Driver Options"
> > >
> > >  config AUXILIARY_BUS
> > > -	bool
> > > +	bool "Support for auxiliary bus"
> > > +	help
> > > +	  The auxiliary bus driver provides a way to export an interface
> > > +	  for another subsystem to drive, implement a common intersection
> > > +	  of functionality or split a function into child-devices
> > > +	  representing sub-domains of functionality where each auxiliary
> > > +	  device represents a part of its parent functionality (usually)
> > > +	  driven by another driver.
> > > +
> > > +	  If unsure, say Y.
> > >
> > >  config UEVENT_HELPER
> > >  	bool "Support for uevent helper"
> > > --
> > > 2.25.1
> > >

--3we3bV80r3awbsJU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH9LCwAKCRB4tDGHoIJi
0vX6AP9/NyNe1fyjqCokekCcjpV4dKKOAydB2/cskrWlxwBVBgEAp0FJn83ZrE4N
4Ev7fSyaFMJazT0d91h/Nx+5OpjUtgg=
=hRaY
-----END PGP SIGNATURE-----

--3we3bV80r3awbsJU--
