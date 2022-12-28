Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0436576C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiL1NGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiL1NGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:06:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE3D10E5;
        Wed, 28 Dec 2022 05:06:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A01F614C0;
        Wed, 28 Dec 2022 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A6CC433D2;
        Wed, 28 Dec 2022 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672232776;
        bh=01uoNOtec1mB0nll3ZSfW5VB6a4HmUqgCU6w+M9oF0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZYz6NXpLP5uesNlABqkVGtxGvKYTV+RIciAnR1Qc107KaunN1eeXWfYEn0ZQpx1Y
         O9ZGXAOHKaNFVdlsEusiCM5+P/T9zk0mh5NV5sNH7X94KXlWNtdBUtCWeiNUTQYgQy
         8S9CjYIz3z+1vPoMTg1fI9Qk/oGBIHfMOG0AFr+Yj+yfsG4d7LXMbonbepVMkKWujV
         bWi08kWCju3IvP+TkPSTyMvChDdMtzqKBgXYQ4Gp2YdmXxZPNblJrgrodxoTxhZtlO
         nRvPx1f/fM1f2RPklu0YLBNjkQA8vYFukFRPSnZG4+hSAPrZpPYiCqLzyFEYTP8KjX
         XdP6Yf+F+R5RA==
Date:   Wed, 28 Dec 2022 13:06:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, Conor Dooley <conor.dooley@microchip.com>,
        broonie@kernel.org, konstantin@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jstrauss@mailbox.org, alobakin@mailbox.org
Subject: Re: [PATCH v1] Documentation: process: Document suitability of
 Proton Mail for kernel development
Message-ID: <Y6w/RL2yq16ijWQC@spud>
References: <20221228000330.3971104-1-conor@kernel.org>
 <32a201f7-fb1a-0651-6b82-b2593e56e759@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QaPrpyhDxWcBKQR+"
Content-Disposition: inline
In-Reply-To: <32a201f7-fb1a-0651-6b82-b2593e56e759@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QaPrpyhDxWcBKQR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Joe & Alexander, who were the ones that had the problem.

On Wed, Dec 28, 2022 at 07:33:53PM +0700, Bagas Sanjaya wrote:
> On 12/28/22 07:03, Conor Dooley wrote:
> > +
> > +Proton Mail
> > +***********
> > +
> > +Proton Mail has a "feature" where it looks up keys using Web Key Direc=
tory
> > +(WKD) and encrypts mail to any email recipients for which it finds a k=
ey.
> > +Kernel.org publishes the WKD for all developers who have kernel.org ac=
counts.
> > +As a result, emails sent using Proton Mail to kernel.org addresses wil=
l be
> > +encrypted.
> > +Unfortunately, Proton Mail does not provide a mechanism to disable the
> > +automatic encryption, viewing it as a privacy feature.
> > +This affects mail sent from their web GUI, from other mail clients usi=
ng their
> > +mail "bridge", as well as patches sent using ``git send-email``.
> > +Unless a way to disable this "feature" is introduced, Proton Mail is u=
nsuited
> > +to kernel development.
>=20
> All mails sent via Proton Mail SMTP relay?

I'm not quite sure what the purpose of your question is, sorry.
When I say "bridge", I mean their program by the same name:
https://proton.me/mail/bridge
When I was using proton, I do not recall being able to send mail using
proton without the bridge, their web GUI or their app.
Perhaps Joe or Alexander are aware of anything that's changed in the
last year.

> Also, why is sending encrypted emails
> to public mailing lists (like LKML) not a good idea?

Is that a real or rhetorical question?
Note that the public mailing list *does not* receive the encrypted
copies of the emails.

Thanks,
Conor.


--QaPrpyhDxWcBKQR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6w/PQAKCRB4tDGHoIJi
0hGXAP9SHbuSxpwVSssuzTI6/j+xd7eQUFcwzftscSBAKhv1QwEAicMrLGUjllo6
cZIXwfGOsOlW6tcUu5dEOtvCGMdyBwY=
=W9wN
-----END PGP SIGNATURE-----

--QaPrpyhDxWcBKQR+--
