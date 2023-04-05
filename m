Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A109F6D7C24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbjDEMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjDEMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299D1B9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4CC622F9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F1BC433EF;
        Wed,  5 Apr 2023 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680696132;
        bh=0chTIunSmr+WHRXS+JXh64e1b6L4YpPfuEtUD4qzE5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM0mKoM/0IS4Q5Dyy5MEEcxptpUYJXzG6tav8sQV79wTciKPjtuAXMUQ6NHP5Hvj/
         qTgcC5r5fMNiqHSgosdTDEn6/1NgySv0OcaT92rONf/e2zHQIKBVT8jR7VuNr/1gf3
         Q3DI0omxiaShzWYUTtPnmCpnee01QMZECPaWAYTAz/kUW+he0orZq7OUtHWGY09cJ8
         hsoJtVYGqcxcMwbuVWERzjxfC1vIDAo9B2Owj9eYfk2D5DdN6RwshJwRSbF69thpnq
         vD5IW6CQejlecpr1Ii1tiU4dRuzqWNxOQ4UbPbikxz99mzte7TQWcinew3pvaTjgZx
         SvO1bL+hoWlDA==
Date:   Wed, 5 Apr 2023 13:02:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     "Ding, Shenghao" <shenghao-ding@ti.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        Shenghao Ding <13916275206@139.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Message-ID: <84738924-8467-45e4-9e68-0f9633f938f7@sirena.org.uk>
References: <20230329100107.8181-1-13916275206@139.com>
 <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
 <7a0cfa60e2a244168edd49c3d2f6a2bd@ti.com>
 <458d7c2f-bcee-9ec3-e955-9661a06a3349@wanadoo.fr>
 <bbae9e35f2bf4cbcbc78f852041e4b2e@ti.com>
 <030c2cbf-dec3-91fb-ac82-949cf5764b78@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e8MDLbCuMChiZ671"
Content-Disposition: inline
In-Reply-To: <030c2cbf-dec3-91fb-ac82-949cf5764b78@linux.intel.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e8MDLbCuMChiZ671
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 01:35:34PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:

> It makes sense, as array access reads 8 bit value, you would need to acce=
ss
> value using pointer instead. So instead of doing be32_to_cpu(test_buf[i])
> you would need to do be32_to_cpu(*(test_buf + i)) if I didn't mess the
> pointer magic ;)

> And then I'm not sure which is better, be32_to_cpup or be32_to_cpu.

The p variant works with unaligned pointers but might be slower if the
architecture doesn't support unaligned access.  For this application it
probably doesn't matter either way.

--e8MDLbCuMChiZ671
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtYzwACgkQJNaLcl1U
h9Bc1Af/eDQye78rgNWb+jc+/dj+X+raUYc4Xq2BQbJ9RuBegejxWD1//K8Hh8UJ
spCMiiTZBMktU6pgggCwEEpkBGgMw2FA4lfLYaMw/lLBdqk3ISgcATGFn5c/APpX
qsQ1eI5FO7kfA40+xv5jg2n88okQHbLgjMzaZa8PJpU4gTY6X17QmGLfsl+3qbBz
uv4DXBbUSTvbXqHOLjSiUoWH+UBo3Ki2TIOwGi6USRkA+QnYulVu1PFqnYFsG5i8
ECmR1ms5JC05IEWOlPN4/jLOvaxycaQdOuCwsW2nf4FWGePt8JEwBGDX4tFU5mcT
7qi2zG7/UBJ34L1w7eAwy7XRzhMX1A==
=NOZi
-----END PGP SIGNATURE-----

--e8MDLbCuMChiZ671--
