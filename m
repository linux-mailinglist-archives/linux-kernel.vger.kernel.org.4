Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4B63BFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiK2MFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiK2MEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:04:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB65EF92
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2817EB81366
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90033C433D6;
        Tue, 29 Nov 2022 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669723419;
        bh=63J/YnDXq/ACyXdIg6KmYtgzhnBJ09vWSj+HtNFh0UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dig0p38rYnVjeiB1Q3M316EajBfyFAxAMXCn8yhYP5O8iREhi56imPXZS9Oi1prcy
         uMy2q+5I6LmD7hubMhBfnXCvdyiLIB4kCFWrFoOaKLF6uvlxjLWO44umkom3iQxgeR
         PHI+C5d+bhvFaW/SbRME5W4IjPUr5Qfi3SdoXIrJ2otwrenhxVWHN1AD3r6ueWqswU
         vbkTprtz0EtWR7NRSgkzHseJHHPJpooA8+5UZerzDYjM/z6ljOoLPel3g5+1CAuwpE
         sgN9w3X6d8EKFT/5th180AjXMOboxYUNRyoqoL17bRpBBOIOhncN/BhN3UVuheWteU
         nwV6jJ8JcH5CA==
Date:   Tue, 29 Nov 2022 12:03:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        venkataprasad.potturu@amd.com, ssabakar@amd.com,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH v2 1/1] ASoC: SOF: Add DAI configuration support for AMD
 platforms.
Message-ID: <Y4X1FPSVxpFkEIrN@sirena.org.uk>
References: <20221129100102.826781-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w8MY03ubAP6sTL39"
Content-Disposition: inline
In-Reply-To: <20221129100102.826781-1-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w8MY03ubAP6sTL39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 03:30:59PM +0530, V sujith kumar Reddy wrote:

> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
>=20
> Changes since v1
>     -- Apply on latest broonie-git for-next
>=20
> ---

As covered in submitting-patches.rst any extra material like the per
version changes should go after the ---.  No need to resubmit for this
one.

--w8MY03ubAP6sTL39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOF9RMACgkQJNaLcl1U
h9Abpwf/dvM9h5uM5L44r+YdBfM/2u7+nQiPr1dt2Akaq5HHIDI6d3RiCHqYYcAP
ajq5rUq2hqQwcyulxs7ODNvdSJiAGKSuHA0FMC1wPJ1s4lCuNllbeQDFIeNrQCRs
e18YXg7NO1Q47xzgNZbE34bED8TWQ+dK+zSkZP2nPupUJkRw3JIASHVSy7HAxTwJ
bwE3xc5U2HG7kmtii6GpZitRTEzPsZgb+c0kOHsOdbPdUkim7w4mPksAYGOkrKTn
bSp3dddQtRFc/0C+siDDpYTvOjSxIS+TUwkBlr1fvkz+ZxArZn/Q7nhmxs8UPSNS
y2pgHs1lZB5V9/KEX0OlXAH5v3QJ3w==
=c9Uq
-----END PGP SIGNATURE-----

--w8MY03ubAP6sTL39--
