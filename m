Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84C63A8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiK1NEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiK1NEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:04:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7323AE40
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AD4D6116F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF31C433C1;
        Mon, 28 Nov 2022 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669640651;
        bh=MAHEmDCiN0vbrOZKzNTziYXCfsP5QEh77/H5l6XhV4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ih5j5qgbjrAldGfHjRrTtjSZU8R5xKjXKh9C8AZK4IppzHNjJu4bNSR8icuDJm7fd
         hoL3fPX9rBBe94BmqlKqO+BbEvfXeyFJccTdnTq5iu+CwXh0LuRSc0pv0L/D6ddke7
         3yNY9XGMWYXIgAKrHpQzNfVBjCSU48Eh3Nmp52m1VecxAcPzPhOtmohrCvHMVvYNnE
         nY1UrX7dvrSEtzxjCUmWTKc9pnVq64bAEDQHFOy1kU6Zqi5c1mqEUi85EIvTEX0F15
         54F1HrJHTO4PElbESfvSru0f+jl3Wd9V69/6C/OpXIJWC3nC59S753sA7f419FIMbA
         IpPoGeHopPJcw==
Date:   Mon, 28 Nov 2022 13:04:04 +0000
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
Subject: Re: [PATCH v1 4/4] ASoC: SOF: Add DAI configuration support for AMD
 platforms.
Message-ID: <Y4SxxLVu+aSWiLHz@sirena.org.uk>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
 <20221123121911.3446224-5-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRcYyp1a21ZEBUQI"
Content-Disposition: inline
In-Reply-To: <20221123121911.3446224-5-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Cookie: The meek are contesting the will.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRcYyp1a21ZEBUQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 05:49:11PM +0530, V sujith kumar Reddy wrote:
> From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
>=20
> Add support for configuring sp and hs DAI from topology.

This doesn't apply against current code, please check and resend.

--jRcYyp1a21ZEBUQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEscMACgkQJNaLcl1U
h9DyDwf8CgLg3OCxJy2zctWsb8kB4EaKtieIb81yXKV04kOB7HuVezVhLNMH1DjY
g5+sF3UOX5ojq43XmLQvUHluNdjehIvK5JCPIDUCuACR0oLSO7mmcAmIQvwFqCnF
rQcAbdFOH2gk8kvyINyxv/jRTTBhsc9iSvoPfVaQOQzPeSVZ2OsSLrDvUEpxNGpl
ma0ssie7dmnZNaOFtXxbK/bXMYix28tZp7J7mFEEg4zCATR3Pzhchg4/RBGd//p5
kDcX+UsNQRz7ThSME+QU4WomoLnYx0OermyVDVbW7I1ScKTve6WrwM64LaXbS/2S
lJnJloUwUfb5BLxjSh8zgKwobKpHzQ==
=XLKQ
-----END PGP SIGNATURE-----

--jRcYyp1a21ZEBUQI--
