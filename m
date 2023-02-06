Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1938168BE69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBFNh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjBFNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:37:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14248358B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:37:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 627ABB80D8A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4816FC433D2;
        Mon,  6 Feb 2023 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675690670;
        bh=hbMUg4C2FzxOpw8ToaDb493iL0oyBf4eM+3FJYiu9Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOvccU8DLF2RyW2GqDr91cER6HgSvApo2LAIYyjrppFwcho3QdBkaJRkdPMvb4R/C
         HacD4WWviRPVp34zz9n8kmzrkTRNpISeaweiSErurgG8Qg3g0Xtm+Y7y4LZb5BDwYd
         ZXpEldlugOzaWL4nWA0hxeKZ05n0lQu3s2ndaDVbGqpp1z61QU7zYHldQV9/yQoN/w
         u91pZ/F4EKhfWHmwpKEKX65E/QODY489sBdhgwVY0J5aCeLL4CEjL7gaVk4s5vIN2D
         WtBWcRQjHQAExtDQIDMIZSuwvGwkWuYrd01deidVHapn4/89dIzjmAeqJrPadmmLza
         hoY9u8wOsCjSA==
Date:   Mon, 6 Feb 2023 13:37:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Rau <david.rau.zg@renesas.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <Y+ECqY/vyT2Iz2zJ@sirena.org.uk>
References: <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk>
 <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk>
 <20230204154222.GA877819@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+zr94RLtWLGe1ik"
Content-Disposition: inline
In-Reply-To: <20230204154222.GA877819@roeck-us.net>
X-Cookie: Hope is a waking dream.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+zr94RLtWLGe1ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 04, 2023 at 07:42:22AM -0800, Guenter Roeck wrote:

> Solve the problem by enabling the ground switch immediately and only
> after an insertion has been detected. Delay pole orientation detection
> until after the chip reports that detection is complete plus an
> additional time depending on the chip configuration. Do this by
> implementing ground switch detection in a delayed worker.

This looks sensible to me.

--a+zr94RLtWLGe1ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPhAqgACgkQJNaLcl1U
h9DIzQf/ekcpkZmkGRQDURuwwftcrEUxbs2H5KsMirLXEuoNwaQojXwZr0IP60hj
OuJ6qR8EivksADWUXbFlo7GpOaWtryeyLBeG26NvX6O2JOMKAfeBkra0K8Feu2Xj
1JeudIecUb8Ysf6pG8LxO8+ZySXd4QORUeILSOHmjSC4meMnLfEScu1JjT7OpBxr
iP7HuPqiWSwaIUw+Pka+ff7PywsvIqU0DWoN/OAblYaEIXrWpMtVCggK4vd3Ewze
6NPGKpqbogRFiL3C+BbEUGqVyjhQZUZfVrIAUkVD6qg7LYCe3tkjLCR+J8r7dz2O
IDJCY5LYLbf8IGrJ4QrCSt03xolSng==
=jcdD
-----END PGP SIGNATURE-----

--a+zr94RLtWLGe1ik--
