Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7562B724
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiKPKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiKPKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:04:32 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DC9AC;
        Wed, 16 Nov 2022 02:04:30 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B2ACE1C09F7; Wed, 16 Nov 2022 11:04:27 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:04:27 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 4.19.261-rt116
Message-ID: <Y3S1q/qEAj/59H16@duo.ucw.cz>
References: <166845241635.12044.11510831858945534704@beryllium.lan>
 <Y3KSiYf2WAct0Oks@duo.ucw.cz>
 <Y3KXHRz9qzzok/yH@duo.ucw.cz>
 <20221115141408.nmdicdl6g66yfxkr@carbon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7kLyZNsjmOIdX/4V"
Content-Disposition: inline
In-Reply-To: <20221115141408.nmdicdl6g66yfxkr@carbon.lan>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7kLyZNsjmOIdX/4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I see the -rt115 in git. I guess 4.19.265-based -rt release can be
> > expected soon?
>=20
> It seems I missed to update my local git tree before starting with the
> update... /me goes back to do another update

Thank you!

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7kLyZNsjmOIdX/4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3S1qwAKCRAw5/Bqldv6
8oO2AKCurHD67iRYgxN+OrqslcTjJJ4KAACfSSkgkckPsdNxPX69bODo3tu0mAg=
=wiqm
-----END PGP SIGNATURE-----

--7kLyZNsjmOIdX/4V--
