Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77554705C98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEQBqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEQBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE121BC3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B9561771
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A971C433D2;
        Wed, 17 May 2023 01:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684287987;
        bh=in1whizeLWlvhF2+6xar1ogYy8/Jxq2IPchedPQ6B6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHiio5/1S2s+PPSZDLWWsJn0iG9F9kpI4p5aH2fMMGa4MhQ3cYGImW/wSQeaIVYdx
         n8jP2d+jEHdCgTAroW3C9BBizd6WfiaPoGFTnUIidO4I3kDRO7roC3JW2GT6JJKCYV
         IZz2eO0XvP3ZlA8zwnmeRKG3VYjnu34G+tr94MFTsedzSqGZLvk5Auh+NgabPQnulD
         rAUdHH8axVGnl9YLnVwOrKtX5vuv2bdUUDzwO2Pqr8HuzWaiZ7xNsoiq8CHS7xszt8
         iCfZpkEf/XCl+tWQIDtQ7w8Bxx6yMF3zvJd84JF00WP0VGv9YNBgEV+WhBRxQTsOA6
         r5OWBDboF/UEA==
Date:   Wed, 17 May 2023 10:46:22 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Stephen Boyd <swboyd@chromium.org>, stable@kernel.org
Subject: Re: [PATCH] SoC: rt5682: Disable jack detection interrupt during
 suspend
Message-ID: <ZGQx7kB6mEL2/wIa@finisterre.sirena.org.uk>
References: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xNwPqIq/92Tep2/e"
Content-Disposition: inline
In-Reply-To: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
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


--xNwPqIq/92Tep2/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2023 at 04:46:30PM +0000, Matthias Kaehlcke wrote:
> The rt5682 driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--xNwPqIq/92Tep2/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRkMe0ACgkQJNaLcl1U
h9Bafwf/QAH3bcfIs5CjDCsQuoDD1Gkw5eGlIX4i3xmz0ZhhQIIpw5tk36OmcPkq
SiVLtAcryA5DzQoQJWRkxV4rkjnvexYVk/2fWDxC4AUstVIT9pr1+B7t/ZmThduf
karaEO5do0OCo79WWNGpOt3ipa1dxRaF+bGXnZLdexdaIGl48L+Brl9eOiTaRv7a
877FUAS0ZyfVWbQgBjGTjTSafxmKnaVf1XzkigOb6SItIfI9qxIpyeGngsLRT80G
vdJbenuYj6s0NAquSxu5J6F9qlhTfnAgxOyFgc9s8zM4A78undZVtB78NJCUh4Kt
+Ayvuo4dMoLGnaiLD5fkoAphKiMP7A==
=pTfh
-----END PGP SIGNATURE-----

--xNwPqIq/92Tep2/e--
