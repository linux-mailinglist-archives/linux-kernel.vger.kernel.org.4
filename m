Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB336E28A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDNQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDNQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900949E3;
        Fri, 14 Apr 2023 09:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 622BE64904;
        Fri, 14 Apr 2023 16:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B7C433EF;
        Fri, 14 Apr 2023 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681490828;
        bh=kLySdUEMQr1iUvlQq6Htdfgpuyp1tU6kNYr8ymjcJnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZEjQWuoiaLMzrotKOefVL+KiaM61y6oJKqWG8HFdNkhwH2QW1Efhz7uwpZtwl6K6
         WilqvCdPSuY2QoommbloPIYgOiKpHYPdZaL4AmnjffO1mSDkbcrXBopNbiB6I3rk4W
         9ECmmny4LI3rkqydUbpL7fy35cxKUj5LQpPvCqDHwnsPl/6cT/HNAwHQQG2kByojwy
         szLQElxMKHDl6PPrQb7NlXFE9D3yyu1jle6XZg8zHfWNo4eDkTz6+PgGRe68r5bvaW
         gKTj7wdyFyw7/86HcMpL3EZwShkxgfj/azOQTpdRlKoR/+EG1qydfVIuKH6rgBPIkI
         BoVXZFUikBiJg==
Date:   Fri, 14 Apr 2023 17:47:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Subject: Re: [PATCH 0/9] Add Chameleon v3 ASoC audio
Message-ID: <6d90ad41-bb2d-41a0-8a4a-922b78967a2e@sirena.org.uk>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6K3bg/ncOMgdX1Ax"
Content-Disposition: inline
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6K3bg/ncOMgdX1Ax
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 04:01:54PM +0200, Pawe=C5=82 Anikiel wrote:

>  sound/soc/Makefile                            |   1 +
>  sound/soc/chameleonv3/Kconfig                 |   7 +
>  sound/soc/chameleonv3/Makefile                |   2 +
>  sound/soc/chameleonv3/chv3-audio.c            | 111 ++++++
>  sound/soc/chameleonv3/chv3-i2s.c              | 347 ++++++++++++++++++
>  sound/soc/chameleonv3/chv3-it68051.c          |  41 +++

Please at least make a directory for Google as a vendor, we don't want
people adding directories for each individual product.  That said
generally we add machine drivers in the directory for the relevant SoC
family, is there any reason that pattern isn't followed here?

--6K3bg/ncOMgdX1Ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5g4IACgkQJNaLcl1U
h9Awagf/ddeh9NiL6xTm0jG7Plq85gP3Pyvhk2dVP91pSzF9F2Ji14MAlnMxtKdW
I01PMKID+Zk7oMMvVWT6XwDfK6F6ScWBXR+uwqhtD2m+5Qz+srCzqKyZZpWevujg
KSrw9av66SOmEHB8BYWK7PnhBGV27/0E8mxzHqaxWNyyVkJhgxhBakVda9ocacmY
hBjUSiivVFpEV36uNZrn2N9ivcj8Ux5mVpNhFLF1BGnlMGLvYyZMcbfAUtkAm9AN
rgduYeGNGttpn7p3/xjusIeboE0QZU/6JYfQ+tX6FTSm1QeklwL6e0G8hb8OzLQz
OYG7LQgbQju5RMftb4EWn0bLI/4qsw==
=rrTF
-----END PGP SIGNATURE-----

--6K3bg/ncOMgdX1Ax--
