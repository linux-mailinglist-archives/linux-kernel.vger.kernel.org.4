Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C5716642
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjE3PKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjE3PKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8131E48
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4FA162A52
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6969EC433A0;
        Tue, 30 May 2023 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685459379;
        bh=wryI4tdQDgbZWVnUP9w85TteWPxdbDUHs17eIPd3Pk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7dz+ZinnwzYE7sWrtr7UN6CTapRrQ7nMmnaxCwm3B4Dl9MK8Xx1Uw0fdQJPLqEyC
         FcFruwtX8AQtl/NU0aebiEUR/qnDC8yrTW3otN26bhjpQxxhLQ0d2J4/f1Tn/ALDQO
         be+0Ct0JCWXif91bjcs0QbmikRjd8TmLTISejZyppKl8kZdLcXe5Q3JwNUDzFHbQh5
         ZwrdjNE5HutW/5jHjsrnw08qi8oxI8KAqHTKZwZkDRwXAb+Oh1Nmp8RchT4DdJL2S9
         6NPAo2d/v8CM7yuaBS9wqqgnEhKfH3zA+ZpAQd+iuthmPx6Ka0hdmuTeRIwoEUQBI3
         I3nt9spqjBzKg==
Date:   Tue, 30 May 2023 16:09:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] sound: Fix incorrect calculation of object size by sizeof
Message-ID: <bf2b90ef-2753-48c7-901a-837408f3ea15@sirena.org.uk>
References: <20230530072648.13998-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pJveqnZYymoAzsuI"
Content-Disposition: inline
In-Reply-To: <20230530072648.13998-1-luhongfei@vivo.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pJveqnZYymoAzsuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 03:26:48PM +0800, Lu Hongfei wrote:

>  sound/soc/sof/ipc4-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 sound/soc/sof/ipc4-topology.c

Why is there a change in the file mode here?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--pJveqnZYymoAzsuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR2EawACgkQJNaLcl1U
h9Dd0Qf/SD5QP7FL+QiJqk6A+gNJFHxv9SGXVWLm/wU6Fx00qWrYSu/dVSGBq7Iz
41skSTsgcYcvvXUxZFTSqnO7DJGigEaOExkE9aqAxod2EIdSU6NnZlLBLbEYyNmQ
DQXMnX4GYtx0OhuDGX3JTFfldz7AoffO5w16D31r+l9zQhBNC/oOi5M96EirA0oX
c5V7C+oPeEPZg89afv0pSOtc1Orkqvwis5BR9idkDYn5lQtR8CNrW6lo5p4iN4uF
baunbDALk038fqMEAPXb7RB19dUMT+NNQXguz8iBkwZlD2AIyLSqLNfedzbDjWcu
Z83/zupMP+A0HiMawpqMPeULo+5aEA==
=uufS
-----END PGP SIGNATURE-----

--pJveqnZYymoAzsuI--
