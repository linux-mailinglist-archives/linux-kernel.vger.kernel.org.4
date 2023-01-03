Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187C165C58B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjACR6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbjACR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:58:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84811168;
        Tue,  3 Jan 2023 09:58:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EB9EB8107E;
        Tue,  3 Jan 2023 17:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495FAC433EF;
        Tue,  3 Jan 2023 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672768698;
        bh=cTy/1spNTKFoJW4HCyaPM1+hZTnwZtXVlxf6CLg8Cac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0UXGOfK3aWc09wR1wOl3yu0ph68r2CDo1Yah17x8OSci+g+BANttcmWsQOsEKIrE
         nIlO/cL8uMXnNhDkFqCm0EcHJDsZ+dWiUDm9NJPN+4jYk9zUnJSNji1mCbHtPZlphU
         k2D26jOlxIUSMy9GeQLlUMddBeZYc1IBadScDmrNUxpoJY6nZX6TY2ROxLewnpz8Rz
         mis2JBSUEXtJRDqFuGF5PClCbiD4flEzkReAzIT1rsarCCpYITGjF58twgTuqcI8Og
         I3pw271zn4NQr3Tlm6hJyOmE16yk5Yld7Aj2BDVBHypnVQ3MzLvRYP8QHm2j0zXutb
         MuY7lWRdzs9Rg==
Date:   Tue, 3 Jan 2023 17:58:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Lee Jones <lee@kernel.org>, jstrauss@mailbox.org
Cc:     jstrauss <jstrauss@mailbox.org>, christophe.jaillet@wanadoo.fr,
        jansimon.moeller@gmx.de, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <Y7RstV9EEgGbR0oJ@spud>
References: <20221227223131.um6muahhxbom7crg@libretux>
 <Y7Qe3Rx+9jzdK1g8@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7XLwC7eJ3fFPkUDG"
Content-Disposition: inline
In-Reply-To: <Y7Qe3Rx+9jzdK1g8@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7XLwC7eJ3fFPkUDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2023 at 12:26:05PM +0000, Lee Jones wrote:
> On Tue, 27 Dec 2022, jstrauss wrote:
>=20
> > Hi Conor,
> >=20
> > Thanks for the insight, I suspected it was some silent Proton issue. I
> > have switched to Mailbox.org, so all of my future emails and patches
> > will originate from this address.
>=20
> Thanks.
>=20
> Although when replying to this message, I get:
>=20
>   Reply to Y6slQLto568WfmfZ@spud? ([yes]/no/?):

Judging by the "spud", that's my message-id from the previous mail.
Joe, might wanna figure out why your mailer is adding a reply-to header
with that in it!


--7XLwC7eJ3fFPkUDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7RstQAKCRB4tDGHoIJi
0ixtAP9Pt46moYxYEhPOjT9h7FicYP/UzMwEjQ79G6c7QQ0vjQD+LxH9Hs7X42zL
1hCKY6v4OI0Vt2XkB/0DSEWh8jG16AE=
=Lmhr
-----END PGP SIGNATURE-----

--7XLwC7eJ3fFPkUDG--
