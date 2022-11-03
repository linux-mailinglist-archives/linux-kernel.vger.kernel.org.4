Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA8617DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKCNYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiKCNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:24:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A41764FA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4647CE269D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E37FC433D6;
        Thu,  3 Nov 2022 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667481846;
        bh=L6gTgH7FGXP4LHxXJHXJyKDjkUgnH8bq7PXv7yKPwyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dm2vslACzU7ZlQKvCTG93D4yvkQTlP3CU+jApY6zziqQKbx3cO3TsUKd6CXbe0m8Q
         qh1Bd2C/OeiEhndcpzwEwitRSycraHf44lJyxXETNYX4+a2eL1fE0C9Eq+t6pjDFsG
         Ze36BJ5eRLR5kefnNsKi+/4BOAfOQOqIqxDKZjPVgucDUyE6EFa+AuV0AbyJ2lef5F
         f+M1LuRTM6vQGMe4ij/wkxpVFI5s73IVDXJIWH4R6jMFbua4fQUVheYtqe/dWD70Pq
         CUIdIWZQhmc+W0w9Xp12yy9W1SmmggvuHmXMYGKu/tSPdtGyuKnOF4W83K9O8hLcII
         ImMPuN5A6xk/Q==
Date:   Thu, 3 Nov 2022 13:24:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Juan Alfonso Reyes Ajenjo <jareyes@gmv.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?B?Ik1hcnRpbiBQb3ZpxaFlciI=?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Fabio Estevam <festevam@denx.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Plaza Roma <gplaza@gmv.com>
Subject: Re: [PATCH] Fix tas2562 volume table values
Message-ID: <Y2PA8Bo59YDKvlRG@sirena.org.uk>
References: <VI1PR07MB5839C95198DD090316E87B78BA389@VI1PR07MB5839.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tQ0tr3a1Ah8NYMl"
Content-Disposition: inline
In-Reply-To: <VI1PR07MB5839C95198DD090316E87B78BA389@VI1PR07MB5839.eurprd07.prod.outlook.com>
X-Cookie: Dead? No excuse for laying off work.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tQ0tr3a1Ah8NYMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 01:03:01PM +0000, Juan Alfonso Reyes Ajenjo wrote:
> This patch fixes -90dB value (0x84a3 instead of 0x695b)
> This patch adds missing -20dB value (0x06666666)
> float_vol_db_lookup must have 56 values as volume is from 0 to 55 (0-110d=
B)
>=20
> Signed-off-by: Juan Alfonso Reyes Ajenjo jareyes@gmv.com<mailto:jareyes@g=
mv.com>
> Signed-off-by: Gustavo Plaza Roma gplaza@gmv.com<mailto:gplaza@gmv.com>

It looks like this got mangled a bit by your mail client - the signoffs
are rather confused and...

> static const unsigned int float_vol_db_lookup[] =3D {
> 0x00000d43, 0x000010b2, 0x00001505, 0x00001a67, 0x00002151,
> 0x000029f1, 0x000034cd, 0x00004279, 0x000053af, 0x0000695b,
> -0x0000695b, 0x0000a6fa, 0x0000d236, 0x000108a4, 0x00014d2a,
> +0x000084a3, 0x0000a6fa, 0x0000d236, 0x000108a4, 0x00014d2a,
> 0x0001a36e, 0x00021008, 0x000298c0, 0x000344df, 0x00041d8f,

=2E..there's what looks like a lot of whitespace damage which means the
tooling won't be able to understand it.  I usually recommend git
send-email for sending patches, it will avoid most issues.

Also I'd expect Juan's signoff to be last if it's him sending the patch
(possibly Gustavo should be a Co-developed-by or something?).

--7tQ0tr3a1Ah8NYMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNjwO8ACgkQJNaLcl1U
h9A1agf9H+hPUKiN+og4yJFY5KPBrvPGozO7ZEWc+WjN4FRRY3R36U91Jy6UbsKt
pC038cYIhd8lMP7bSsfwzjHpfuD40khHVlc/1ByRfV8o36fEVhIwhyJMt1p8WBco
GVsM+nFaagTiwutrdpp8gFzT69W43FmmK8ilhdWFGMuagd1CKNIu10q5j/w8H9sl
1Vnrzo8PokACPUL5ZwvxivsDMQkwPHPYwLGAqeamK6iNa66oWL4cs6TjDbLqO2Gn
wH5s20CRfD9ilIOQRhimsh610QcgroZOmsF1pXrC/lDIpHHWsYabuW3gpxYHx8S2
ZlOFasVKGMqEkgVsBpaOzFqmovT9Sw==
=5GW6
-----END PGP SIGNATURE-----

--7tQ0tr3a1Ah8NYMl--
