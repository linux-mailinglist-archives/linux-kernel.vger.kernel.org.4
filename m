Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B016CF81E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjC3APb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3AP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A903C0;
        Wed, 29 Mar 2023 17:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B16AD61E7C;
        Thu, 30 Mar 2023 00:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3AAC4339B;
        Thu, 30 Mar 2023 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680135326;
        bh=SaIyAyIEWPkCOiTbcEAAhLZPQpGrVicNNzSuEc0r0CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5aAij/ePqjFcpoij5+qOeXhFYRUXzZzThXwXjkLGT0WGbKycfH+EqBxDxLFth0Mx
         uq5l+kRLWvX31xJw4UXGMAnfv9RY5Ob9bj0pfDEguNQk3rxWLrukyYi39qtAW+/9VK
         IwbbUdVPUdKO0pNnJwG35WhpZ7KWFxP8Gg/Tvety1vIpNBXtiFO8LORMMAMmmS2We3
         aN5htjW3vCMMYYlQWRP3mrdCTvw0RkxdHkDjx3BcM7Hr9N9thBNyL5to3yrcktUkSZ
         15yOMjgVOTSRmzy+RTE/00Tj8tNjKwEcp4oq4D6lDJoaeoxakm1qiCZT8lTnCSBWvk
         b7YDGp4rP1OGQ==
Date:   Thu, 30 Mar 2023 01:15:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     "Yang.Lee" <yang.lee@linux.alibaba.com>, heiko <heiko@sntech.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] spi: rockchip-sfc: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZCTUm7XRKwTotda8@sirena.org.uk>
References: <20230328062118.86336-1-yang.lee@linux.alibaba.com>
 <48f1ee32-a030-8188-3a9d-612888b9678f@linaro.org>
 <e6d8f4ce-8b3b-4cce-be94-cd5902c676ae.yang.lee@linux.alibaba.com>
 <e01a753e-aea2-5489-e436-2ec0f3fedb64@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="voc5FpAxHeBmyvcz"
Content-Disposition: inline
In-Reply-To: <e01a753e-aea2-5489-e436-2ec0f3fedb64@linaro.org>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--voc5FpAxHeBmyvcz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 08:18:27AM +0100, Tudor Ambarus wrote:
> On 3/29/23 07:06, Yang.Lee wrote:

> > Because=A0the=A0maintainer=A0list=A0of=A0each=A0SPI=A0driver=A0file=A0i=
s=A0not=A0identical,=A0I=A0am=A0worried=A0about=A0causing=A0trouble=A0for=
=A0too=A0many=A0people,=A0so=A0I=A0split=A0it=A0into=A0multiple=A0patches=
=A0based=A0on=A0this.

> The change is trivial enough to don't bother at all. Here's an example:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3D4b23603a251d24022f2fa48ee67610eb245a4115

No, it's fine - it doesn't really get in the way and can be
helpful to people doing backports.

--voc5FpAxHeBmyvcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQk1JoACgkQJNaLcl1U
h9AkrQf/X5y8FOFpN9XpUUUQDvbu/UJFxu6wK5iAYMpdiS1tcPNdyOKXEOfOGbjz
OFBNsc/UWQPllZqggDyemxNw7x2WAKcF6JWCV2uRn2ptzYrEr+zQMeO3k83I3Eam
Ji35vaalvmXG92tSk70DOrJIGmC6yL5OMkSnZU2dWM+eIgiLxjJos/8sShx3zd5d
ODoO2h1qsUetCkrz9uw9yGU6yWYuZRLkP9kJETwF5AVgjVhrDkt2CtJMKQC8nNzE
LHkMmIRLAIQm6KIjivd4jGYdBOhw5TRWszIFdrNWLcUgAJEZ2YOadZFClwhhthT7
GKogxOITZyeUdFT/a5sG2HDCMoapkA==
=UTll
-----END PGP SIGNATURE-----

--voc5FpAxHeBmyvcz--
