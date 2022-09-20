Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FFF5BED5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiITTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiITTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8A632D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297F06234F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 19:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F41DC433C1;
        Tue, 20 Sep 2022 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663701002;
        bh=KO7G5WxNJXJAIUz3AMugGKT/5LCjFWrXqbYdBNyWYxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hcrkv7GwQuKe4uPNCtaeep9W1E4lrkk7Mz6t0hVaAv1fAF+KJt21UeuSrLUnhexql
         m+Kkg9u3RZQ7qlVsbQ0uhWsSUV+jFL7uhIlXk+G3A0PTHTV5KGDZuPdYg0btfw9jvv
         Y9VhgggHNK/HioHocKawjkRyfAtrbgDIjb4pO3ow58YIH9kSNuLOTB8+PxX/IjnOgs
         wr0kDrPqm9znilflT96PS6Fd5bcBmkXh4Xl2HSedW8guXoGGgD7Y6HhkMIDvXB+QaD
         +0Ct+bJ1ughg//Zz58CAZYzG2OvR4OJla/7hnIfLRNjVQ6HsHFMdxOp4mVhJ+iwhzQ
         b2GutXaAPLbUQ==
Date:   Tue, 20 Sep 2022 20:08:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Sebastian S <iam@decentr.al>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks
 table
Message-ID: <YyoPxP9Cj2DVsCGE@sirena.org.uk>
References: <20220920171320.7776-1-mario.limonciello@amd.com>
 <YyoBjHftjG/ACAuJ@sirena.org.uk>
 <f4fea2ca-00ae-ba85-b666-9fa267961add@amd.com>
 <YyoLYe9uGNnfl1iA@sirena.org.uk>
 <557738ee-9e22-6c04-c098-0ca965e67aed@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5K1nY0l6oJaFvMYA"
Content-Disposition: inline
In-Reply-To: <557738ee-9e22-6c04-c098-0ca965e67aed@amd.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5K1nY0l6oJaFvMYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 20, 2022 at 01:56:34PM -0500, Limonciello, Mario wrote:

> I guess the author forgot to include you in To or CC.  Would you like me to
> just re-send the combination of both of them as a v2 (including the first on
> on behalf of Xiaoyan Li)?

Yes, please.

--5K1nY0l6oJaFvMYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMqD8QACgkQJNaLcl1U
h9DAggf/V9+n8NR5Rc0p32kdD9lOyL6pcg/KHj5tIBTjsUXfnmuyzAiMxvIJK6zw
TWG3zZjOo3Xoh8Ms5C6EMhD3IhrWOoWhZARNRTNqlKKNC+EiJcjeZvAJnoWEkFLA
WX/6d5r7tIL8c/OBjNFRQLZreyNVBVfkQkNCubyit4viLCFzaGEgSwIL3uPGyV/8
ikNA6gNuBFt8vco1Z2DGYizRDiXH5t2UW5TQWFqRRJk33JEVR09yKxF1TJSuQW8t
RvmBkf/AgKIM/6Uz9LXyz1lzkvI+x4NMnUSbKeFmGIfJfEZEs4QKSHENTZj60gLs
FoiIQMMSahbYdWCqPNLFMEvj6wBitA==
=AlMz
-----END PGP SIGNATURE-----

--5K1nY0l6oJaFvMYA--
