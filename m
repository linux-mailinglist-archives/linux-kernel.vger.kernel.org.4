Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3000B710947
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjEYJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjEYJxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E79E7;
        Thu, 25 May 2023 02:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E05260B66;
        Thu, 25 May 2023 09:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CCC433EF;
        Thu, 25 May 2023 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685008426;
        bh=tLf3d/gKdJeLlsMHMqGEB2pJUyxiRqlEFrB77+u+ub0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHZvWC4W8EmZIK3OdntUi3kT9ru0BfJJhHh6tP01F9qRF5FtXJMxp/6GYe7ayxt9e
         Qy1nQ3ImSYarIQKI58JvdxLsZnxqPNkpVuZwMWvTEy422tg46oSZQuV6fXGZNz4kqW
         6tRHFG3RDhzd3or195z0Sau7VQC8Go6YHzSkYWQI4TCOtHytM3i1cTJQ6kN5F+s5zT
         klaopGVfUV6P3Ro6aMlnHidFMwj4zMa00eaL3V2B2os8xT3nvjIhZWgHnbJle+C6JF
         r77d08PW7VCneRsYMTlJDUsGQaYgF+8f+53ELWphWz9fPX2pRst9cvHiPhgLCXsnkl
         S+BoPymZOR+xA==
Date:   Thu, 25 May 2023 10:53:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qii Wang =?utf-8?B?KOeOi+eQqik=?= <Qii.Wang@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Leilk Liu =?utf-8?B?KOWImOejiik=?= <Leilk.Liu@mediatek.com>,
        Tim Kuo =?utf-8?B?KOmDreW7t+esmSk=?= <Tim.Kuo@mediatek.com>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] spi: mediatek: advertise the availability of Dual and
 Quad mode
Message-ID: <e21758df-7f70-4a76-9759-5621bfa5b0db@sirena.org.uk>
References: <20230523112608.10298-1-qii.wang@mediatek.com>
 <97af2a29-8aef-499d-9f07-bb262ec398cb@sirena.org.uk>
 <7a99a7da9edc93f4e231500b1b781188f894d775.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E5yAS6xqncTy2UwS"
Content-Disposition: inline
In-Reply-To: <7a99a7da9edc93f4e231500b1b781188f894d775.camel@mediatek.com>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E5yAS6xqncTy2UwS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 06:21:26AM +0000, Qii Wang (=E7=8E=8B=E7=90=AA) wro=
te:

> The previous patch was this one:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/spi/spi-mt65xx.c?h=3Dv6.4-rc3&id=3D9f763fd20da7d892ffaedac0c58d821=
922f8a674

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--E5yAS6xqncTy2UwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvMCQACgkQJNaLcl1U
h9CDDwf+O0uRW+IX4K9wPhydgsnobcj/fhSfVLefIiiSvrPRl27vNm1oKmwe6LIm
p0VGIY258AobfS73u0PWEZF8XQsZxzi1kgoi7X/gji1LiqtU/iOBgYLQx4jyv7Or
GWFcmirYNnyzwsaUd5bwIpwsN6N5E95rC1Zo8AZS4eO1Lc/UVr7RtC6H5htyMen6
rmt6d42OpF4gF83ERIL74vGIm/VuqteA55l+yfHGCjYpygH39RaYI6pGUBIasRAo
QjL+s7Jr/+FEj9zt3K0DdCTrBzIwVefejtOixSCLFTgTiDr+/JNLTqwcbk7uYHBD
zXArYY5qi8/pY1oshy9ZhrJnnn7nAQ==
=XjGO
-----END PGP SIGNATURE-----

--E5yAS6xqncTy2UwS--
