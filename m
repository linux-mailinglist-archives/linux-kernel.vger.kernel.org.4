Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BC706647
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEQLNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEQLM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:12:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69D2708;
        Wed, 17 May 2023 04:12:52 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24AD71C0E53; Wed, 17 May 2023 13:12:50 +0200 (CEST)
Date:   Wed, 17 May 2023 13:12:49 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        nobuhiro1.iwamatsu@toshiba.co.jp, jan.kiszka@siemens.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: 5.10.179-rt87 (was Re: [ANNOUNCE] 5.10.175-rt84)
Message-ID: <ZGS2sTPKvvNHyzGH@duo.ucw.cz>
References: <ZBebYGllb3f9sOOS@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oGWPWU6pRB5bmxAR"
Content-Disposition: inline
In-Reply-To: <ZBebYGllb3f9sOOS@uudg.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oGWPWU6pRB5bmxAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 5.10.175-rt84 stable release.
>=20
> You can get this release via the git tree at:

Are there any plans for new -rt release?

Last I see is:

Author: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Date:   Fri Mar 24 11:52:56 2023 -0300
    Linux 5.10.176-rt86

There's pending one in rt-next:

commit 5f84852113c1391abe8c38defdda562640bb3808 (origin/v5.10-rt-next)
Author: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Date:   Fri May 5 14:40:10 2023 -0300
    Linux 5.10.179-rt87

=2E..but "real" release would be useful for us, as we could base our
-cip-rt on that.

Thanks and best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oGWPWU6pRB5bmxAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGS2sQAKCRAw5/Bqldv6
8ruXAJ9rdRb7whS4MXPlmWSho1wjeu3dFACfVcNZlsMR1hRZWNiYmptMbSshq10=
=GkZT
-----END PGP SIGNATURE-----

--oGWPWU6pRB5bmxAR--
