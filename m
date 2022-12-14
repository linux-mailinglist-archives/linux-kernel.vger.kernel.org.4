Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71C64CB63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiLNNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiLNNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:32:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE226435;
        Wed, 14 Dec 2022 05:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8874961A69;
        Wed, 14 Dec 2022 13:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B222AC433D2;
        Wed, 14 Dec 2022 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671024745;
        bh=MH89dE30fHEW9T6Oa4Zq7WWD3qJmqKbN+HrFHeVqGa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gROYi2pCcBfsJRz2vgYRVSxAT+uujou8Kho151TO608zjks/78vyDHlhU2VoBjzWC
         gQt72/0A09av4cHS6mk+M+f8VaQp+4R7jcyzBJsL5+uf7kfOrJGIqgLjES90X+up6G
         V6Ddw+JMvaeb25fsUw+hYyVJIFyHHceWw+5TvPSA0b8O3SQttbgoGctdiEz/uteXqB
         7vpzZZ0hIaK+fWpMC2ah5vyDJi61/QcdxeH7Wg3se5XZIgQ8hTqwUbjjTW5z7pRX88
         DUWFn91dHTaHaoBa3FXZ7qA+jJozFrSXc7KDoSqGJhzuLqnLd/Jvpu/ta78HTxrJwZ
         Zinj7u0uXaIeQ==
Date:   Wed, 14 Dec 2022 13:32:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     ChiYuan Huang <u0084500@gmail.com>, djrscally@gmail.com,
        hdegoede@redhat.com, markgross@kernel.org, lgirdwood@gmail.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        yangyingliang@huawei.com, gene_chen@richtek.com,
        chiaen_wu@richtek.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v2] regulator: core: Use different devices for resource
 allocation and DT lookup
Message-ID: <Y5nQYom7SsbFnir+@sirena.org.uk>
References: <CGME20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0@eucas1p1.samsung.com>
 <1670311341-32664-1-git-send-email-u0084500@gmail.com>
 <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
 <CADiBU39-FUD787RmV9Z+jsSrb2Se66A6FrLWGxf78q2Ud-SrjA@mail.gmail.com>
 <dc6c80f1-f34d-eaab-d561-32caa7fa140c@samsung.com>
 <Y5ipFd8BfU361QzN@sirena.org.uk>
 <be56fd97-08b5-8a7a-2630-371c83dcab18@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FQkxBF8HaAaafbeu"
Content-Disposition: inline
In-Reply-To: <be56fd97-08b5-8a7a-2630-371c83dcab18@samsung.com>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FQkxBF8HaAaafbeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 11:23:01PM +0100, Marek Szyprowski wrote:
> On 13.12.2022 17:32, Mark Brown wrote:

> > Thanks for jumping on this so quickly!  Marek, are these boards (or
> > similar ones) generally available?  They seem great at showing up issues
> > so it'd be good if I could get them into my CI and spot problems earlier
> > (or something like kernelci.org would be about as good)?

> Well, they are quite old, but I've seen some used ones on eBay. Just=20
> look for "Samsung Chomebook XE503C12" (Peach-Pit) or XE503C32 (Peach-Pi,=
=20
> very rare).

> Getting it integrated into the CI requires a bit of manual work. You=20
> have to solder UART lines to the test points on the motherboard. The=20
> board can be fully controlled via so called Embedded Controller, what in=
=20
> practice means that you can turn power on/off by sending commands to the=
=20
> dedicated EC UART. The kernel console UART uses 1.8V, while the EC UART=
=20
> - 3.3V. Let me know if you need more details.

Ah, oh dear - I'm afraid my soldering ability isn't up to that sort of
modification.

> Peach-Pi was used on kernelci.org some time ago, but I have no idea what=
=20
> has happened to it.

I suspect it might've fallen off the end of the ChromeOS support window=20
and got pulled, I'll see if I can find out.  Perhaps there's some
modified boards kicking about that didn't get thrown out.

--FQkxBF8HaAaafbeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOZ0GEACgkQJNaLcl1U
h9CWxQf/en9YwkNqoWhy3SMuNx5UdiC3UE/SUjy+OweHxP1Vg4uYfkWwo+DyZ1F6
x2U+wVmZDsAG4Sajt8r1xn3sMc4Mzm4By0pL2+k8dKlxtEEyvnJ1F3VimgNgACKk
NekHDfvbcxJgaDzP19XcLzHQNFJ3PvHTxr63S3zvr+b3cfPqx5NXcvhsG4YzNJrR
rjsOXYYPrulhvt5jpWdM+tTzpW5+xBuzCKDnoTg0yeQT/xnI+M9KBgCk1L4Os7kZ
FsHWf5yiut7mtfORGoH4E7YUvNgqXCfsL0shqwIHjuXPaPLRih1yu4p3ZYFU7rdf
oyshvv1XBLeguFobrvGxUxXwZE/yYg==
=3Ppm
-----END PGP SIGNATURE-----

--FQkxBF8HaAaafbeu--
