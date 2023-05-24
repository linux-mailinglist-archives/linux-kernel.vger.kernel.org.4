Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5270F115
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbjEXIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbjEXIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:35:17 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0182E5C;
        Wed, 24 May 2023 01:33:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 611931C0DFE; Wed, 24 May 2023 10:33:31 +0200 (CEST)
Date:   Wed, 24 May 2023 10:33:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp,
        jan.kiszka@siemens.com, LKML <linux-kernel@vger.kernel.org>,
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
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: 5.10.179-rt87 (was Re: [ANNOUNCE] 5.10.175-rt84)
Message-ID: <ZG3L2vcpSfjnhTcB@duo.ucw.cz>
References: <ZBebYGllb3f9sOOS@uudg.org>
 <ZGS2sTPKvvNHyzGH@duo.ucw.cz>
 <ZGTRX5hb0rK7MQSW@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mGz3srS0TiYi9ni9"
Content-Disposition: inline
In-Reply-To: <ZGTRX5hb0rK7MQSW@uudg.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mGz3srS0TiYi9ni9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >     Linux 5.10.179-rt87
> >=20
> > ...but "real" release would be useful for us, as we could base our
> > -cip-rt on that.
>=20
> We are submitting our stable v5.10-rt kernels to kernel-ci now, to avoid
> problems our local tests were not able to uncover. The process is new for
> me and, while trying to streamline the process on our side, I seem to have
> hit a problem. Please allow me two more days and you shall have the relea=
se
> in hand.

Thank you for the release, we made a -cip-rt release on top of it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mGz3srS0TiYi9ni9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZG3L2gAKCRAw5/Bqldv6
8hJVAJ9ShM5NRNdZmZ+Fh+m1+Ukpx+FLkwCeMeSiTvLPRVOG3WcNt7nPxOkMlaU=
=yxXT
-----END PGP SIGNATURE-----

--mGz3srS0TiYi9ni9--
