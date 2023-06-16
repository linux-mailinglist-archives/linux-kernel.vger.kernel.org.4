Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534BF7339E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjFPTbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbjFPTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:30:38 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063103A8B;
        Fri, 16 Jun 2023 12:30:34 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C23661C0E73; Fri, 16 Jun 2023 21:30:32 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:30:32 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.10 13/21] ASoC: soc-pcm: test if a BE can be
 prepared
Message-ID: <ZIy4WMDkMqxNoEg/@duo.ucw.cz>
References: <20230531134415.3384458-1-sashal@kernel.org>
 <20230531134415.3384458-13-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yvTgwKKZUIxy1Uk0"
Content-Disposition: inline
In-Reply-To: <20230531134415.3384458-13-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yvTgwKKZUIxy1Uk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This problem was detected on Intel IPC4/SoundWire devices, where the BE
> dailink .prepare stage is used to configure the SoundWire stream with a
> bank switch. Multiple .prepare calls lead to conflicts with the .trigger
> operation with IPC4 configurations. This problem was not detected earlier
> on Intel devices, HDaudio BE dailinks detect that the link is already
> prepared and skip the configuration, and for IPC3 devices there is no BE
> trigger.
>=20
> Link: https://github.com/thesofproject/sof/issues/7596
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
> Link: https://lore.kernel.org/r/20230517185731.487124-1-pierre-louis.boss=
art@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

">"s are missing in the email addresses here.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yvTgwKKZUIxy1Uk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy4WAAKCRAw5/Bqldv6
8jfxAJ9S3GBxXVwaCu+rl0V8uD4d0NhSzQCfdgQUlcP6kcQ9GCBGGC1LfpdXS1E=
=eOOG
-----END PGP SIGNATURE-----

--yvTgwKKZUIxy1Uk0--
