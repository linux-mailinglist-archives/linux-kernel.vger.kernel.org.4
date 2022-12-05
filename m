Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD26642E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiLERNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLERNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:13:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9881B1C7;
        Mon,  5 Dec 2022 09:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6FB61253;
        Mon,  5 Dec 2022 17:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44BAC433D6;
        Mon,  5 Dec 2022 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670260426;
        bh=nfwijOP+YknJ/BJyL3BCk2K9XJLKuE3s+gxi7Re4mMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jn4RfWrItXV350OYscEJW9mDXwxsFr18oiqh0LZwV2EY89iy+sPQwEVvVqWti+uud
         C+szYcTcXri5/HOlO/YEI2qMgLQxT1yrClDCRyjHUhcT6PT5M7LIvOpP1ksPj062mb
         eP5R7R6zwdgdXjRxQCnwUQYNzA1tLVjQsYXBGablczconecKiKuylW70yDgeIikGbc
         vo7Z/ZdMMTIMGn4JnhixjgS74gDhYJmqpFdnvqnBC9h8jiErXe+2U1KJugdPtQohDk
         wqEmvHFQ/6de4PjkFy4d47k8t2/VIXqbqlNM0NbKO+6c5AQPYqD5QOzyLF4TAO26pE
         8YN4ciFAZXu9A==
Date:   Mon, 5 Dec 2022 17:13:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y44mxp9Wr/aEdaxE@spud>
References: <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
 <20221117210433.n5j7upqqksld42mu@pengutronix.de>
 <Y3avobkvYK3ydKTS@spud>
 <Y3uZY5mt/ZIWk3sS@wendy>
 <Y4coL74qQX80TNaT@wendy>
 <20221130103755.lhil2jaw3oufr2sf@pengutronix.de>
 <Y44Mk2nGu1Zeq7QQ@wendy>
 <20221205160328.wn4rcs6uxuuaxftd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XYWjmEvx4GFEt7/b"
Content-Disposition: inline
In-Reply-To: <20221205160328.wn4rcs6uxuuaxftd@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XYWjmEvx4GFEt7/b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 05:03:28PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Conor,
>=20
> On Mon, Dec 05, 2022 at 03:21:55PM +0000, Conor Dooley wrote:
> > I came into work today thinking that I could just rebase on top of your
> > patchset and send out a v13, but that was unfortunately not the case :/
> >=20
> > So uh, it turns out that I was wrong about the behaviour of the
> > sync_update register's bit.
> > It turns out that that bit holds it's value until the IP block is reset,
> > and /does not/ get cleared at the start of the next period.
> > I'm really not sure how it worked when I tested the other week [0], so I
> > spent the first half of the day trying to figure out what on earth had
> > happened to my FPGA image. I must've picked the wrong image when I went
> > to test it the other week that had the wrong configuration somehow.
> >=20
> > As a result, I've gone and hacked up another way of transferring the
> > burden of waiting - setting a timer for the period, backed by a
> > completion. get_state() and apply() now both check for the completion
> > and time out otherwise. I'm half tempted to tack RFC back onto the
> > series as I have not really messed with timers at all before and may
> > have done something off the wall.
> >=20
> > I pushed it out (see [1] in case you'd like to look) so that the bots
> > can have a play with it, since it'll be a few weeks before I'll have a
> > chance to properly test that I've broken nothing with this.
>=20
> I didn't look, but I'm convinced you don't need a timer. Something like
> the following should work, shouldn't it?:

Yeah & I did think of something along these lines. I was torn between
something that seemed heavy handed (timers) and calculating if enough
time had elapsed, which seemed a bit hacky.

Figured I was better off doing something quickly & asking rather than
polishing only to find out it was disliked ;)

>=20
>  - in .apply() check the current time, add the current period and store
>    the result to ddata->updatetimestamp
>  - in .get_state do:
>      if (current_time >=3D ddata->updatetimestamp)
>        process fine
>      else:
>        timeout (or wait until ddata->updatetimestamp?)
>=20
> Actually I'd prefer to wait instead of -ETIMEOUT.

Prefer to wait in get_state() or in both it & apply()?
Depending on how far away updatetimestamp is, would we still not want to
time out if it is going to be a long time, no?

Thanks again Uwe,
Conor.

--XYWjmEvx4GFEt7/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY44mswAKCRB4tDGHoIJi
0hYNAPwNShBFmDyuWg7PaIUavpTz8+mejzOVXbkpobCNkxtsTgD6AyEygndAq/lE
o20KrHrwDw/UrorhjSX/v2kzwcZjdA4=
=589v
-----END PGP SIGNATURE-----

--XYWjmEvx4GFEt7/b--
