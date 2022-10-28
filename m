Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C886115A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJ1PQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJ1PQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D11DED5B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06A6EB828BB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6307BC433D6;
        Fri, 28 Oct 2022 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666970166;
        bh=AcI+yswH+2IbcHUpYNQ9KmXw7+ZnsTQFzdaCM3sr5zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q11wdu/kZuFgRdKuJnGuJzp2/PsP9miDo3cwvfWcWFLL6T7QPrwNN90pz1Rar9G2r
         F0z8VW4AJckbaBeV7bfAfS7MPFxX/7NBlLcLKJnQ775AHHw0GarOEoPKZZL2bqwRjO
         Gk2hMWVBbMV5HGdkc3vdbzxV26uwBDosGSzFv7whAL8X1rljBpdqjGuGirNr33Oj9m
         2aeHDSvqDCzq1u0xwLea3wuD7dvIAAmRoyOQ88mkMqLwb7n2x3F75WzGeTtPkR2HXX
         /VTdk66bElhVbLzLsNquZQCePtqP4yf19HrMU3FY6nsrzqrTNW+kVNw89zQBoF/Khl
         gAWcM695Ah8Zg==
Date:   Fri, 28 Oct 2022 16:16:01 +0100
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
Subject: Re: [PATCH] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
Message-ID: <Y1vyMQ8Jj7/smeC6@sirena.org.uk>
References: <20221028141129.100702-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5YV3kYcAJnGOoxea"
Content-Disposition: inline
In-Reply-To: <20221028141129.100702-1-maarten.zanders@mind.be>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5YV3kYcAJnGOoxea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 04:11:28PM +0200, Maarten Zanders wrote:

> This commit fixes:
> cab04ab (ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk)
> 203773e (ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk)
> 2277e7e (ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk)

Please use 12 character hashes for disambiguation.

--5YV3kYcAJnGOoxea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNb8jAACgkQJNaLcl1U
h9BPkwf+JDWLwUW4JY8Nn+45+cQNp7ekugOkKUUyMa5cWq66XKGMsFYPkbx6YNay
H2eN9b4GeQtYwkLRkf50yidDuVkevyxVQJ7FIX7Tq9+/Th6RPiydXixG1iegEI/Q
4lCMamv4jAigNGi6ZcVFpehuxicesCFLVNISNJscEaM6kY14lP8Bgygw/2YKez/0
B1fq09ZE2oDFerrjUid5+CCEPwOO7DEH4rX4kEuCtSUO6cJfNSgSRF0/qczNbkYM
BXmPfkFUjvBmQEhX0n2dy/LWWEixRiGOJOpKoOK7kQmo3sIrZW/WepTrDGoTQ0GQ
PYMB8pzbp4O270F4CpI7NvUz/FqsYQ==
=UpvD
-----END PGP SIGNATURE-----

--5YV3kYcAJnGOoxea--
