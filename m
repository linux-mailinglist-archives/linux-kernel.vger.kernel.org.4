Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6959E6F9D65
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjEHBap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjEHBan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418111155B;
        Sun,  7 May 2023 18:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C797661DD6;
        Mon,  8 May 2023 01:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72C2C4339B;
        Mon,  8 May 2023 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683509437;
        bh=71tKkv/u71avtNDi58s+M3G3sV9kmPvH9mDaj5alk/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdvBvb3sKdbaCJubt4senOcamv3ec20kFlVjpx22nVFzwX6sfJtAbNPbJk+dW6+nH
         0Ff+MRKmezq1AfMxuO3SMNsZKbFqghzjJAFuqA63SGFHxBpBs6XIbyQfxL5J9Srra9
         1QJgjwVAEB5OA/xVpqcLHpQP+nBGIjBjI23Jyda09T8QVv4GdvomrKqaldYS12SuIq
         6Ht+h0GwHpHGJ6YgUFx+OHs47oCAP6Vkc3HLLhZDbdme0t5Omrp8Av4x47VAG+Dhng
         n+Ex1plvYWG6XxOiR2l8+jZIyVHuj4Te7T2Yp8Kc5WV0hEWNBhyMp+H7YWtvMD3Rsw
         Y/6zf0NnRHtIA==
Date:   Mon, 8 May 2023 10:30:34 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: Add TDM for StarFive JH7110
Message-ID: <ZFhQujhpbt/7yGGc@finisterre.sirena.org.uk>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-2-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qWpif/cLlKqgWzLh"
Content-Disposition: inline
In-Reply-To: <20230506090116.9206-2-walker.chen@starfivetech.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qWpif/cLlKqgWzLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 06, 2023 at 05:01:14PM +0800, Walker Chen wrote:
> Add bindings to describe the TDM driver for the StarFive JH7110 SoC.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qWpif/cLlKqgWzLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRYULkACgkQJNaLcl1U
h9BS4Qf8CgZlP8jyB6NeLlBTyYs8KyQY4c35cBZLLJ+/fu2+EGGCptpPCtHXkrnx
jPTC4V5et4pWy2E4Aqk5vHXKmsR/cvXdjXM1VrdRwculFef0xWwV29F6ru8WrW5J
pQxXzgHn2PpZrdybJ4RFmABz9V9Pe9NotLtP5yxVCqHemsg09MZSmnqObikbqXi6
eqXK/b5HAkCHQUEJyisSCY4Fcxz8XaIc1a0bP6+++bwFdnVN0zk6WS499QQWgXc8
hZNcb1x6hXYav4LKZETl4xFYUHdopNIpL7cbdsvcyF8mRGI68qK84TFxTx9kXqS5
9ZCLw0ZkIwMad6/JkDdSGqETIZ0R4g==
=TbwX
-----END PGP SIGNATURE-----

--qWpif/cLlKqgWzLh--
