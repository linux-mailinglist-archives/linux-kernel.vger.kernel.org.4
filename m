Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346115EF370
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiI2K34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI2K3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:29:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF025E94
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B2D60F4D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BF6C433D6;
        Thu, 29 Sep 2022 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664447388;
        bh=Ct3rpu6jdxUMpNcwrqLEGWuHzOZd+t40yGCSzkMNywQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poxnamR56W7z9N/18lMs879J5ufX8i2zJa/w/DqL+L/GxfG6LqO7AyxiBdFTVB01x
         nbht1fRozh7kFBqqvejepcLLIOhASO4/+obkBKm1FjZTJ1DbCyF9RHuwjFMI//cIH+
         Vx5oZqoybi+7tT7nPFODRVy4bgvEjlRq7+vTZH/2jsMmsFFw4zbXB64QuD5H1eSo60
         xf8nRPoJG5lhZrvD6QN4rdgA8+IV/vg/mI+N933rGFczyjpzItHcs/Z2xoh89IQVHh
         yNdq3zGSbR3Lw22aIx1cOI3mrIEGqvohElgRs0Ly4i2X1dcaa/4keeq13DT7yaRibF
         K/sdOqlLHSFoA==
Date:   Thu, 29 Sep 2022 11:29:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] ASoC: amd: acp: Add setbias level for rt5682s codec in
 machine driver
Message-ID: <YzVzlZ4LOwaLkzHo@sirena.org.uk>
References: <20220929070828.3950101-1-venkataprasad.potturu@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SwTGG9bJqF3v2K7+"
Content-Disposition: inline
In-Reply-To: <20220929070828.3950101-1-venkataprasad.potturu@amd.corp-partner.google.com>
X-Cookie: Last week's pet, this week's special.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SwTGG9bJqF3v2K7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 12:38:22PM +0530, Venkata Prasad Potturu wrote:
> From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
>=20
> Add set_bais_level function for rt5682s codec to enable bclk and lrclk
> before codec widgets power on and disable bclk and lrclk after widgets
> power down, to avoid pop noise

Please allow a reasonable time for review...

--SwTGG9bJqF3v2K7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM1c5QACgkQJNaLcl1U
h9CfdQf+JNAC9Md2HFgBnBsxw6gz04oxAb/sihhvpSmvllsnbMTbgWFqOIEjad+P
JA05eh7PHjC+ljLmmNU+DqK9SABZsnTzGXmMgkCIB//RrqtDIb1KFNZBpN7mozWu
1UAEX7JdJAAhMU8n2qQTsho62/2g3IjZdwSiDKWK4zesQIDF6QiLNVUmQdyOuaUb
VZHRafBVF5/k1J02Sl3hulVT6cqVchJ6J9JkHqRbjBo6GAWfld0dXqJyZ5+z/uIY
P1dtk93LZYFkoDNZf/qcnkXDnC4nrLoU004qBz53EhePo3mB8HqDkzaI8OmCdD1o
56h27TtvY08e5m8zGV8LKrEii9aEGQ==
=33hd
-----END PGP SIGNATURE-----

--SwTGG9bJqF3v2K7+--
