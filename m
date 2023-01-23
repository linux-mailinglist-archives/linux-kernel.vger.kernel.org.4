Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C45677C84
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjAWNa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAWNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:30:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46496265B1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC42E60EB9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C710C433EF;
        Mon, 23 Jan 2023 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674480639;
        bh=H47c8HUYIIRYyuaouniWJ5/NboG5OtgLOQZuID8sHhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkVU/M72OArI5kNvF5i7BifV9Utn5f76pVJhL5VPgOkDHhKGbjTwmjODDecUV84ry
         aTxZaHU8OZFBIZKgZmJEyk7zilSR8C5CyMtflZvbWeMrhhvzejZFPWScamGjbWnM/0
         LgUwZXkyvvRr9qg6B520zFMWWUhmA/XsUQ9cuFlOKDdmcN7vvX2Suudt0H85g3kKe5
         0hg0+89g+Xu/0U74HnImsC2h97WA6pH0VBsyoKe+0dnKIjv0Be2Mg8JcwkTUuLXAgY
         PRSeS5Q4YfKe1Oob4jNZ8noXpbkzFNjmySfyVrl2FKwdd7wtBTb+AVm7J7/S/fk/Km
         XJPnslPYzHC3Q==
Date:   Mon, 23 Jan 2023 13:30:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: amd: ps: Make acp63_fill_platform_dev_info static
Message-ID: <Y86L+y9SGRIYDQ5C@sirena.org.uk>
References: <20230106023116.117404-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6PicLiRO6Os7KYGm"
Content-Disposition: inline
In-Reply-To: <20230106023116.117404-1-jiapeng.chong@linux.alibaba.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6PicLiRO6Os7KYGm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 10:31:16AM +0800, Jiapeng Chong wrote:
> This symbol is not used outside of pci-ps.c, so marks it static.
>=20
> sound/soc/amd/ps/pci-ps.c:170:6: warning: no previous prototype for =E2=
=80=98acp63_fill_platform_dev_info=E2=80=99.

This doesn't apply against current code, please check and resend.

--6PicLiRO6Os7KYGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPOi/oACgkQJNaLcl1U
h9A+vAf/XDBfdteQbAFU9vUuEt6MBgeIm28y1WLlxkLLi5KWmUr0D9EPKLCg2pC9
sIVqikWy9XibYeR+VDNyndvq9lzuXDpVAQ/qYd9AdXt87718JLoiufWYryPPnpKt
JZGgJ4I0UdSWEAZazEySaSdp3IAK6GXR2hQHVwpmHsFMoACVoTlVqzBT1+Go/Jbl
tE+gzbXloQnDVzCCgYDx/at/ESRJsCR6y0a11R9+Cy9mDotwLyiEVHsyQGGnIqjg
LZefclLx1hm1fWJsXM1hGkODhbQ1LPuCF9XKpzYYT1ArFjfE4dbHvbkA5jdfwIJZ
hVvYFlNS2OllRm3a9yXsKZKLMN6byQ==
=YYiC
-----END PGP SIGNATURE-----

--6PicLiRO6Os7KYGm--
