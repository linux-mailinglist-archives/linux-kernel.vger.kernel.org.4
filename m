Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F7645BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLGN6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLGN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:58:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B272AC5F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F3EDB81DF4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288DCC433C1;
        Wed,  7 Dec 2022 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670421509;
        bh=RIC1Cb1hSR/PoVvVlchvFUy6mScD0XG2dUhLJIgDbnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcHuDKAix1m05GVzFUIB4skjq7TswGJZAvs1HDb4mp9YiO5Jr1/hLbOd/kSnLUjyC
         TIuipnB6EgbXdGKkBoOKKaysXl3oKWpe9IAbFlkuehQRVtH/smAHnFV6EJvP/B7sUj
         PVJIwq57X2tzVq9TWx51dew5jQv3SJLg3wAe0zG3tYvZ2+ttJAQWap2EoCQ15Ft4fT
         ik1dH0vmDfAieN/JzrBgYZY8LYCkaTpPUSgx0EnL4L2X+Vy4CezKbDHOaIdmYQSXn2
         pAgMd+G3cqGw0QuLmopfX0uLuDOHMO86VwYUdYFBLQ00jtA51PoDXPbFPgjKi/u/Oq
         uH0mmVDXPKd1Q==
Date:   Wed, 7 Dec 2022 13:58:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wang Jingjin <wangjingjin1@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, sugar.zhang@rock-chips.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rockchip: spdif: Add missing
 clk_disable_unprepare() in rockchip_pdm_runtime_resume()
Message-ID: <Y5Cb/1kRQVOrOT0Q@sirena.org.uk>
References: <20221205024317.2422223-1-wangjingjin1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yfqkupk0cs8hEwm8"
Content-Disposition: inline
In-Reply-To: <20221205024317.2422223-1-wangjingjin1@huawei.com>
X-Cookie: What!?  Me worry?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yfqkupk0cs8hEwm8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 10:43:17AM +0800, Wang Jingjin wrote:
> The clk_disable_unprepare() should be called in the error handling of
> rockchip_pdm_runtime_resume().
>=20
> Fixes: fc05a5b22253 ("ASoC: rockchip: add support for pdm controller")
> Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
> ---
>  sound/soc/rockchip/rockchip_pdm.c | 1 +
>  1 file changed, 1 insertion(+)

The subject line says this is a fix for the S/PDIF driver but the patch
is for the PDM driver and I see you sent a separate fix for the PDM
driver.

--Yfqkupk0cs8hEwm8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOQm/8ACgkQJNaLcl1U
h9ClSAf+PYmaTOX76hZfmg6lP/5WGJr8lhDunNZmxMYdQc2BEK/H/wN2l+nR6ES8
v6jxI3ceMQ+78mMpQebV8Hiuvd880D3jjaPh/dZKObPYQvIP6sUthPwAr9nlZh91
s/EDK3rgQcJuOxR2gQdACyfIM+PvJ0HlNaz8RrGKyM3yq2Ik7ZqjeBJ6gPjODOUg
eXG5J5GD0Z64hhs572q95LKTTjtCPtcQ3uXqOSmhSqqPbb/pNqZAik069u3/UesA
JMInss8miBtQv7RfI9ffz4LiINXZpIAFJCeA2BfaLdpenSzz1zfEUfoNZtkQUqJI
6yCz5HFdPCyky7EA/IrsAO8EDNtTUw==
=TDQy
-----END PGP SIGNATURE-----

--Yfqkupk0cs8hEwm8--
