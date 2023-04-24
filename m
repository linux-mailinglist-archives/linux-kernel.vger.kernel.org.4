Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C86ECBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjDXL5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjDXL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:57:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CB46A4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D4F620FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDE7C43443;
        Mon, 24 Apr 2023 11:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682337423;
        bh=I2E6bsA4GSej+ovVD3xRo8aYuAiPwVPdjepeG6qyxiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbtiuAY+jHtvjd6G+C4oXzfROYDxKZH53g82RZk7dMWoMYU45FsEiZz5yfdFs6fb7
         3aSf2dkS+3PiXoBNcEzmajEQWCWnrlRb7aiAhs7ghuVSITwoJkzaM5uZaL9Nl1BO8r
         IHuVcZR6wsYd5JfA9Hm68GtjxZVoPVIpJUyTgqoDPGpLSTagkndKkxdgBRxuQ5A8LK
         GPi/iNa3s1Ut3xTRHy9FpITRlbJglXlTv7VqRNoiVvJTUYZ78knO9eyIheySQQ8A/G
         q61EhVMG1A/3xNDaNq1fQqnWIFpiFNRO3TUITMRy6EZ45To9FEqhhlDhpPVsSYEzQF
         fTbkUB/PI4shw==
Date:   Mon, 24 Apr 2023 12:56:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yuchen Yang <u202114568@hust.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: regulator: core: remove return value check of
 `rdev->debugfs`
Message-ID: <1ea2bb36-af47-4651-8f37-b72736ca0367@sirena.org.uk>
References: <20230424025738.34950-1-u202114568@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/Ez3a5pkBrDa1Ia"
Content-Disposition: inline
In-Reply-To: <20230424025738.34950-1-u202114568@hust.edu.cn>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/Ez3a5pkBrDa1Ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 10:57:37AM +0800, Yuchen Yang wrote:
> Smatch complains that:
> rdev_init_debugfs() warn: 'rdev->debugfs' is an error pointer or valid
>=20
> According to the documentation of the debugfs_create_dir() function,=20
> there is no need to check the return value of this function.
> Just delete the dead code.

Please stop sending these patches.

--W/Ez3a5pkBrDa1Ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGbokACgkQJNaLcl1U
h9ASzQf+NpZeyskBotd5pfBm3Yj2NP65xRbsRbQwd7xwiExZ4QMPtTZR3OnsizW2
z25qC4HlqaSKXSWzZieY3nrsoHU1NMM0aKsSrphVx8LKqZH6l+Ud2ZFHm6OFIGYF
59FZuosf+XaC3VnX5th04LFIqpXMNw+PrflvwfszTnk+zTp5sRTgy5fXsVjt2xDd
BPHWZHBIkPPyMkHuUrhykUQObSrWCD2mz6GNKMf2ngyi7hZQCkGrPUO1az1K5Zs4
rqQLnRwCVJbGmgKWjAuNxO15xsDBPrpc6ckMMicbMCnXzOufm8FCFEWpYzIV3Fj9
I3geNDdoNxssVS3JiCNZSxdhjRQUNA==
=4rZs
-----END PGP SIGNATURE-----

--W/Ez3a5pkBrDa1Ia--
