Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E976A9764
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCCMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCCMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:43:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80B18142
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:43:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 576DA617D6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D420C4339B;
        Fri,  3 Mar 2023 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677847392;
        bh=0joJXlrLY2FhKeY0R+mHaabUyq405E4hscw3qzY4bGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvrmjQrn31tBey39NdmtTU2RL0bB1Uty1VxBaH2Gzm/EvWcEROFLRM+qt7qWEYPzK
         /rvgSycDmt3W0rz4odwLiNqit4XDG+AhhBkgLnaJ006paESXLFjgKszufH8x9Xky1r
         uqLI/xwVaEDoDeIMn1+o0V27DtClyiwZO0JN0YCHKNkNbXkeksUeFSGNGqgAzr6Pu0
         jG4I/I7Vqb9zTKaOGKM6GBxgvro5/363LlKOrBSk7/QVFGnSV6ilIefBF/T65qYTsb
         jc1ykinJXhiUjIF7pDNtjWjyUScEaherthghFoy5knREIqbTqaiZHzTn1b+rQ/ZMGj
         RvCNkKd3RK6xw==
Date:   Fri, 3 Mar 2023 12:43:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: clarify that SND_SOC_IMX_SGTL5000 is the old driver
Message-ID: <a36d3650-f0f9-4604-8262-cbcfa881b54c@sirena.org.uk>
References: <20230303093410.357621-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QTeiKIHJAymC+ynn"
Content-Disposition: inline
In-Reply-To: <20230303093410.357621-1-luca.ceresoli@bootlin.com>
X-Cookie: You are fairminded, just and loving.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QTeiKIHJAymC+ynn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 10:34:10AM +0100, Luca Ceresoli wrote:
> Both SND_SOC_IMX_SGTL5000 and SND_SOC_FSL_ASOC_CARD implement the
> fsl,imx-audio-sgtl5000 compatible string, which is confusing. It took a
> little research to find out that the latter is much newer and it is
> supposed to be the preferred choice since several years.
>=20
> Add a clarification note to avoid wasting time for future readers.

Perhaps it's time to just retire the old driver?

--QTeiKIHJAymC+ynn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQB61oACgkQJNaLcl1U
h9C+Lgf/fx3hpA4MUUUkOYrBGKMMCFhcQ/4OoSQcxV5n2rJCC584mHb9fEA3Yycs
2GLwVUiJc6y2Co0xpjil7IkOuHCKBjUP9vCAZn3jQCENbGeafJvLe79fgGE5a8VX
jmE5iQD8ZcwOZiX9KCJq8Ro6RJKVNqfWrZtGNXrcu+QbGOfqr2fu7tu/apxyv8rp
JC8rpx4Kv7hTsaNel3RTsbcOIVOUKljtaXEfxbCijzhmhBu6o4ck7Q17LEFRc/kx
1BkpLJQOBYVIJfOQZ1CNlKC8S6KZ4aNqZTqCkOF0Ae6bV2X3VeRyt4yvC5ayH99y
bHBgeVGyX/DJf07TuN5s9KSBTKFPwg==
=tYaW
-----END PGP SIGNATURE-----

--QTeiKIHJAymC+ynn--
