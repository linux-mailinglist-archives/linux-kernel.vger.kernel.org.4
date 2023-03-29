Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64376CEF07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC2QQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjC2QQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1665A4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF81461D78
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08697C4339C;
        Wed, 29 Mar 2023 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680106534;
        bh=G4dVWJC9NCVuwbkU+mwAPv8tHAZfPNeVeHpf3nQLXSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5Nzj20FuJdHToeDsi5HN6NuI7/8NyJTzwWUwaHjxzFadhOAiDpC7b/yVIELCwe+p
         cdphsNss+A2gzedtFQPt849YWPC6it4d4t5RiQZqGFFj7vWrDGZ772+zEcLepZEOpK
         h8RRDsgfbGJa0kkHSe9jJcRAqkjviuh077eqK5J0pZreXpg1oh5p2xUgX22qDa2VOy
         ZV2Y4LNh5yBA/VuFMs/RDhKpVonMYzO70okYGnUvq5p1A8KnHumJNGbkTmm1YpO1Dr
         8639YotFiYzfxWOlii6a/ai0dRjf85RAp5cbOQQuanWrcJJKXWe2SjMDflHsZ/P0SG
         uY6cDv5DYGOxw==
Date:   Wed, 29 Mar 2023 17:15:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     jassisinghbrar@gmail.com, linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mailbox,soc: mpfs: add support for fallible services (was [PATCH
 v3 0/8] Hey Jassi, all,)
Message-ID: <09cdec20-c3c8-4eb1-9a74-87f429543d3c@spud>
References: <20230307202257.1762151-1-conor@kernel.org>
 <d7c3ec51-8493-444a-bdec-2a30b0a15bdc@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U2QkwUshhApUL/i4"
Content-Disposition: inline
In-Reply-To: <d7c3ec51-8493-444a-bdec-2a30b0a15bdc@spud>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U2QkwUshhApUL/i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jassi,

On Tue, Mar 07, 2023 at 08:30:31PM +0000, Conor Dooley wrote:
> On Tue, Mar 07, 2023 at 08:22:50PM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
>=20
> I botched $subject, I blame copy pasting the branch-description from
> lore and not double checking the output of --cover-from-description=3Dauto
>=20
> This should be a more suitable one... /sigh

Replying to the one with a reasonable $subject... Are you okay with this
revised version of the series (you were happy with most of the v2 IIRC),
and if you are, would you be okay with me taking the lot via the soc
tree as I have some other bits that depend on the changes here?

Thanks,
Conor.

> > Here are some fixes for the system controller on PolarFire SoC that I
> > ran into while implementing support for using the system controller to
> > re-program the FPGA. A few are just minor bits that I fixed in passing,
> > but the bulk of the patchset is changes to how the mailbox figures out
> > if a "service" has completed.
> >=20
> > Prior to implementing this particular functionality, the services
> > requested from the system controller, via its mailbox interface, always
> > triggered an interrupt when the system controller was finished with
> > the service.
> >=20
> > Unfortunately some of the services used to validate the FPGA images
> > before programming them do not trigger an interrupt if they fail.
> > For example, the service that checks whether an FPGA image is actually
> > a newer version than what is already programmed, does not trigger an
> > interrupt, unless the image is actually newer than the one currently
> > programmed. If it has an earlier version, no interrupt is triggered
> > and a status is set in the system controller's status register to
> > signify the reason for the failure.
> >=20
> > In order to differentiate between the service succeeding & the system
> > controller being inoperative or otherwise unable to function, I had to
> > switch the controller to poll a busy bit in the system controller's
> > registers to see if it has completed a service.
> > This makes sense anyway, as the interrupt corresponds to "data ready"
> > rather than "tx done", so I have changed the mailbox controller driver
> > to do that & left the interrupt solely for signalling data ready.
> > It just so happened that all of the services that I had worked with and
> > tested up to this point were "infallible" & did not set a status, so the
> > particular code paths were never tested.
> >=20
> > Jassi, the mailbox and soc patches depend on each other, as the change
> > in what the interrupt is used for requires changing the client driver's
> > behaviour too, as mbox_send_message() will now return when the system
> > controller is no longer busy rather than when the data is ready.
> > I'm happy to send the lot via the soc tree with your Ack and/or reivew,
> > if that also works you?
> > I've got some other bits that I'd like to change in the client driver,
> > so via the soc tree would suit me better.
> >=20
> > Thanks,
> > Conor.
> >=20
> > Changes in v3:
> > - check the service status in the .tx_done() callback rather than
> >   mpfs_mbox_rx_data()
> > - re-order the if/else bits in mpfs_blocking_transaction() to please my
> >   eyes a bit more
> > - expand on the comment in same
> >=20
> > Changes in v2:
> > - up the timeout to 30 seconds, as required for services like image
> >   validation, which may vary significantly in execution time
> > - fixed a typo!
> >=20
> > CC: Conor Dooley <conor.dooley@microchip.com>
> > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > CC: Jassi Brar <jassisinghbrar@gmail.com>
> > CC: linux-riscv@lists.infradead.org
> > CC: linux-kernel@vger.kernel.org
> >=20
> > Conor Dooley (8):
> >   mailbox: mpfs: fix an incorrect mask width
> >   mailbox: mpfs: switch to txdone_poll
> >   mailbox: mpfs: ditch a useless busy check
> >   mailbox: mpfs: check the service status in .tx_done()
> >   soc: microchip: mpfs: fix some horrible alignment
> >   soc: microchip: mpfs: use a consistent completion timeout
> >   soc: microchip: mpfs: simplify error handling in
> >     mpfs_blocking_transaction()
> >   soc: microchip: mpfs: handle timeouts and failed services differently
> >=20
> >  drivers/mailbox/mailbox-mpfs.c              | 55 ++++++++++++---------
> >  drivers/soc/microchip/mpfs-sys-controller.c | 52 +++++++++++++------
> >  2 files changed, 67 insertions(+), 40 deletions(-)
> >=20
> > --=20
> > 2.39.2
> >=20



--U2QkwUshhApUL/i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCRkIgAKCRB4tDGHoIJi
0ofnAPwKBFZRz3izNDuZY/X9OL2aOfmrmyQ6Xx79PGALj3UuqwEAjdO3y63M8Dtu
n4iJ3iJbwtSj+GjvwWE8aIAXVkegEgg=
=31fE
-----END PGP SIGNATURE-----

--U2QkwUshhApUL/i4--
