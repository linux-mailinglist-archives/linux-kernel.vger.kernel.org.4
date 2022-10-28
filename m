Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D14611661
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJ1Pxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJ1Pxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:53:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9AA42D4A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A587B828BB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B5C433D6;
        Fri, 28 Oct 2022 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666972407;
        bh=Lr1MwqXp3hb+RyMzAElHgRcN7Y4whufOoogdp/QICXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTgfPiGxN+g6J1oqeP/b8waZLuwwYlzUeopDw3tKWQ2fLSvWeEmx2N0S+KBOwV5GM
         8FFZrFsAkI0qDCT8MI4PkZELaDiYF/g6VfedIdEUD5piGBOYpwrvbccRsj3k3OqXF/
         u0S3AFqp0J2kVByxUJDqFhrfztIqZuPtJgLxM13IUU5ikfJbLZgHq+RhkBRB2mOiGV
         LqMsA0GRAGHVR9R1tmd7hUSa4p/8glzeP6wkYLniQgnXce2B9PbYSwbGj71aQh08dL
         08Bnw5+OzrtGq4dhLXSnstJefE5LheVFTH6huSer0knqkKZANbfESvRLPpJfaRszGe
         mNiDn6nWvYxng==
Date:   Fri, 28 Oct 2022 16:53:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
Message-ID: <Y1v68WuDck1oaVmk@sirena.org.uk>
References: <Y1vyMQ8Jj7/smeC6@sirena.org.uk>
 <20221028154534.112175-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zDVZfyM54uy1DY0q"
Content-Disposition: inline
In-Reply-To: <20221028154534.112175-1-maarten.zanders@mind.be>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zDVZfyM54uy1DY0q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 05:45:34PM +0200, Maarten Zanders wrote:

> commit 203773e39347 ("ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk=
")
> commit 2277e7e36b4b ("ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk")
>=20
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>

If people send tags like Reviewed-by please preserve them unless you
make some change to the patch that would invalidate them, that saves
people duplicating their effort checking patches when they haven't
changed.

--zDVZfyM54uy1DY0q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNb+vAACgkQJNaLcl1U
h9AwBwf/b90319UQfp1/m9HiG8Biyy4dC4eMZuLMs/OQl1kflINQp2JtHId2cqlD
h2nn5TBXn1MjDqqAK0asOXUEh29VNS77YdTQiF6j39vZdhbeezG1WTy8DBBjmCT+
6z5QYVIC1wkdOxCvqUf98QBMfZ/7hjHrmkc4MRTRRq085IPkuLxU9OrZUAVVTBGd
jDTMjT0VM3uwjvESDZJ3/4cah2+9RTpUni9BEyXvbHf0qWY2yiE+13TjiJ1W9Y7p
c0FHtp0VhJJrBnquCrX1J2PRGLeBuLdquNbAJN+wTsi9k6emiebjg2iG1mxxLXp7
4i4G99xn9OdJ74Lle+g48S5+eWULeQ==
=c6ad
-----END PGP SIGNATURE-----

--zDVZfyM54uy1DY0q--
