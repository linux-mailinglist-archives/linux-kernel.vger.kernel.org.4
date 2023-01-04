Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB365D5CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjADOfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjADOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:35:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27628395F5;
        Wed,  4 Jan 2023 06:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93FE261767;
        Wed,  4 Jan 2023 14:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EA2C433D2;
        Wed,  4 Jan 2023 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842908;
        bh=xESMQ9GhiTPL5t/wbCxbMUGOGHQ61B4clZ40pfoAgwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcpZl91uJbz/8Ncdf4E5AD/9Qz9BpX2xrHSIBNU4amxvju0v4+uFTiGxNiQPTINKI
         9CnouSr3FiMo//vC2oekT6FjZsHbCe8/tZKBA3Vc8YmdY/DcBy/jaeNHJctpnYyrwB
         oL6nSDOhdArqh59omZGhChTP122ZuFRKUVmeVM1QZwz76IAodCmpQ4kK6T2DGkII6+
         c9R0SunbIPWUOXVP964dPp6Z+Q5v5puNTAbWHyHc3hBh4Ek0IE7CP9yz81/784E1me
         kUB0oUqvzXeJPtX8E8gtAbDu8lw0kzyWIWABvSzoC4GwNM/aw6vuq8PKHG5CCHHTA5
         3K1pxfHuIQN1w==
Date:   Wed, 4 Jan 2023 14:35:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: Enable irq before the spi registration
Message-ID: <Y7WOlkuLaLt1DdY+@sirena.org.uk>
References: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
 <167214860344.446872.17166503994226712534.b4-ty@kernel.org>
 <5db65fd1-575f-df19-0de3-b3e32e4bf1d1@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rYR1PrBg/o4bENGj"
Content-Disposition: inline
In-Reply-To: <5db65fd1-575f-df19-0de3-b3e32e4bf1d1@leemhuis.info>
X-Cookie: Stay away from hurricanes for a while.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rYR1PrBg/o4bENGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2023 at 03:08:51PM +0100, Thorsten Leemhuis wrote:
> On 27.12.22 14:43, Mark Brown wrote:

> > the next merge window (or sooner if it is a bug fix), however if
> > problems are discovered then the patch may be dropped or reverted.

> Quick question: why did you queue this for the next merge window? This
> change *afaics* is fixing a reported regression (a kernel oops)
> introduced this cycle:
> https://lore.kernel.org/lkml/Y6dL2ZWgd1BD6kew@makrotopia.org/

> Or have I missed or confused something?

You've missed something, it's queued for 6.2.

--rYR1PrBg/o4bENGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO1jpUACgkQJNaLcl1U
h9BVCAf+PnTmIJYMJ2GGcFDU67z4Mx4B/0ZOVIcbndNnQq1ZdtePeZ3c3ClWbt31
NEF8G7bieK2Y+cKbFiwQ6siK503B2aTDblSsFO44YlS6BWNSknYlzWjfuMtq7alw
hGub9wuwTQ8yABK1gf99t5ajJ4/l8CVcSwlVMVEdI9rqUZc3/xiv/691VMnsX3oI
xnzDHTxPcpRnZZjSUkaEejBgPRE6zGFdbQyxQMp11CTPNW95gHGl75exUMuJgfyF
MMr2QfQNEAr46OaK/zhbOsGEyQrCSZzwuH0f2dq2CbeAvIxfSf66H3fU1pfnZHzd
REZwHMaFfx5G5yeJm6yAu/62c600oQ==
=pEW3
-----END PGP SIGNATURE-----

--rYR1PrBg/o4bENGj--
