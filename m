Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D209614C99
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKAOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:31:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C481B7A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 695B9B81DDD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C179C433D6;
        Tue,  1 Nov 2022 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313085;
        bh=PraM4w70iFnWAoFu4Zw06rGjP1yDdSv36Dxtp9QORCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVImuBQ6/V7ednkLtp5llPdeQ1b3JSfc3EoS9xWvDeibHATvolK13vgMEdM+b7nxE
         ZxB7Oiozvcp9nzmLeJhn7I//LlL563AxjoLdVBG38lDZ1vvFQQwOdEBF6XVSEMsvU+
         iejvoT94DPqtkeDz1tlgePKjmDtXicoP5ntdY0bQaLbLGsqJc9oRJodAdD1AcqZvG3
         YVqqXISsgotRCL++Xu5AYWhT8s4L9oVankx+1nmFXEKczIoGc3/t/QC7mIzLXC+IGt
         vOIkNN6eIIjtZyX4N0Ct90QD6IVN5AS+0OHGvLpOYjenj10SuhlLXroRM/B3CWZjEI
         s1um1R79cwXRw==
Date:   Tue, 1 Nov 2022 14:31:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Message-ID: <Y2EttkwUvMReQcqg@sirena.org.uk>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5IRjf+q9nPdcPFUH"
Content-Disposition: inline
In-Reply-To: <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5IRjf+q9nPdcPFUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 03:15:08PM +0530, Venkata Prasad Potturu wrote:

> On 10/28/22 16:28, Mark Brown wrote:
> > > +static int tdm_mode =3D 0;
> > > +module_param_named(tdm_mode, tdm_mode, int, 0444);
> > > +MODULE_PARM_DESC(tdm_mode, "Set 1 for tdm mode, set 0 for i2s mode");
> > Why is this a module parameter - how would a user decide to set this?
> > Is it something that someone might want to change at runtime?
>=20
> While inserting this module we need to pass tdm_mode variable as 0 or 1 l=
ike
> below.

> sudo insmod /lib/modules/$(uname
> -r)/kernel/sound/soc/amd/acp/snd-acp-mach.ko *tdm_mode=3D1*

Right, that's what the code does but why is this something that should
be controlled in this fashion?

--5IRjf+q9nPdcPFUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNhLbYACgkQJNaLcl1U
h9C8Xwf/dZTML7Oy1rYG4am+cIqjeHDdSvmUtO3Pgrl/V+cjSxjhhF2IWtdgHS8q
7/ISFey6kCHwnXPb2rZr6WHVsQmNHznUrP+6i2zMC79EPVr8XRab0wSYM8xyd0sm
BJqWRHqlVpRn2y4VIsJOyqj8eZcqCdX/3N/BEMx+bIX7oeJss1bE++9ioKBCLvHk
4X7mqNOXTbKWMh2rFcl57z+aDGEnu/T4cUjU+hDMQV/LvZG7yzC+VLHQjVo4kcHV
zrw+tMnYwUfw7ypW6sI//Boxy9cdIqjRGBCXrZzd4Mx77I+EtaDPRZGZCVFEFB34
Rpv3Sl96f+v/CunfP5dtZSi5CFn9RA==
=jy5F
-----END PGP SIGNATURE-----

--5IRjf+q9nPdcPFUH--
