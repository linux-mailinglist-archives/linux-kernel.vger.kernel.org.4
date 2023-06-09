Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF047295C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbjFIJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbjFIJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2544B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4401660FCB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE65C433D2;
        Fri,  9 Jun 2023 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686303552;
        bh=hTpVqffufJ2N9o+Xz7ZN9/2MFzyD4BhvJJarsHNu0uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLjOAh08xhYEYFZiJ9MbOZr/TxhFmbxiNjjAW3BehX6L9WfJr1G03oOZmwk4HFnkF
         gk3ARNCfg28FGUCMG3n8OdfLJ4mHvE39aMVa/0u9jsDnTFXmyzVCR0+T54Vuypye61
         3kfiDToJvVoPwW57mwZ4s4CvYLZa0IdUC1Or+OLp34Fmh2JA9+0JeUiNvU7q4JF8NG
         wWXdkTk112vTlfrqvCo05QW8zI6DyIQx9JCrzVht6LgjpQBHYh4zcMxKsPMdDeNLQe
         YjxgbJZZKd26ciO3jr2zHZNdR6r8PTYaDHJMrpU65Na42scniQEED35IL/DkT7PXl5
         of9pBjlFBmJRg==
Date:   Fri, 9 Jun 2023 10:39:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack"
 from Headphone pin name"
Message-ID: <b463d2b1-6822-4c37-82dd-d92c196bda64@sirena.org.uk>
References: <20230608221050.217968-1-nfraprado@collabora.com>
 <1bb65d99-d1dc-7a73-12c0-e7f4cba3525a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pFXW2BxSqw1fbALo"
Content-Disposition: inline
In-Reply-To: <1bb65d99-d1dc-7a73-12c0-e7f4cba3525a@collabora.com>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pFXW2BxSqw1fbALo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 09:37:33AM +0200, AngeloGioacchino Del Regno wrote:

> That commit is made to bring consistency in naming across MediaTek (with
> other) sound card drivers.. I'm not sure whether the right solution would
> be to revert this one, or to make a small change in the UCM, counting that
> we'd be able to add more shared names around, finally reducing the config
> length by sharing actual configurations across various SoCs.

> Any opinion?

It's ABI so if people are noticing it the old behaviour needs to stay.

--pFXW2BxSqw1fbALo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSC8zkACgkQJNaLcl1U
h9BBjAf/Xltwx3g3VOYglckofoEdSEFXheLQnLngKL2QRHoUV6sNUNWRicnS8zc6
v6bLadZRd52Ia/2A2nLZ9GbPAdsCXVsm0YDK3bUZofcy6bdCH3C/TfeuWnWz7Lvd
PnKcfjhycCrYTN6F6JD1RxicvGb3yrIaskdMnTSHHf0tQ9vUhrCXkeiDPv0OD4TC
IYewZzQHPYa5IEOrnqDZA2nCxtr6v/1aaru9WanYB2bREybfScV5WDcezCA1oAp0
UaCziy+G8wqmeowzfVP9FVTdFiAojOB3C8AljbB4yB0mEiaQ5vtB85ynoS9T4UZo
kB1xatM8U/AVx1LtXp9dW3eaTotTzw==
=bEmH
-----END PGP SIGNATURE-----

--pFXW2BxSqw1fbALo--
