Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580447339F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjFPTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFPTfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:35:07 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484291715;
        Fri, 16 Jun 2023 12:35:06 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3B2201C0E71; Fri, 16 Jun 2023 21:24:55 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:24:54 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.1 28/57] ASoC: SOF: sof-client-probes: fix
 pm_runtime imbalance in error handling
Message-ID: <ZIy3BsIKVkfuolO6@duo.ucw.cz>
References: <20230525183607.1793983-1-sashal@kernel.org>
 <20230525183607.1793983-28-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2zJgghhj21IUPJmD"
Content-Disposition: inline
In-Reply-To: <20230525183607.1793983-28-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2zJgghhj21IUPJmD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are problems with sign-off chain:

> When an error occurs, we need to make sure the device can pm_runtime
> suspend instead of keeping it active.
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
> Link: https://lore.kernel.org/r/20230512103315.8921-4-peter.ujfalusi@linu=
x.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org

">" is missing at the end of lines. Same issue exist with patch 29 in
the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2zJgghhj21IUPJmD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy3BgAKCRAw5/Bqldv6
8sX6AKCEkTFkpXdc6+RUh29AoVqI5UUGowCgrlkOt6/IHkzOxXnDBB5R0J0aT2s=
=ZGl3
-----END PGP SIGNATURE-----

--2zJgghhj21IUPJmD--
