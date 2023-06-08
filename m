Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB0727F72
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbjFHLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjFHLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A901FFE;
        Thu,  8 Jun 2023 04:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6A364CAB;
        Thu,  8 Jun 2023 11:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE657C433D2;
        Thu,  8 Jun 2023 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686225187;
        bh=wwKRg32ZcZhADNX1fuChejee2tT1rwz/ID9yAF2EOxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jrku5HJZBoF1sj1SGKmxa7C1Ri9N3aZzO8g9+GgpUai7+Zgax8DDcMkuCVA6rmubQ
         RtGuuaAeHJqTTXfseiNlcmZKJTubyQ3cWwV/zSPmXfZdjM7o92q3G/TnVZKehTUhTA
         B+TDFwQUYU1WOhQqPjQzi616se0Z73K71LU4h3e7tZiqAaktHB+sBr12FOdg/pt1kb
         haMCheWw2gBl4h/7RZW5r7koeTGPxbJoNIcr+MDI/a6LpoGmj8JhGcIWhePkT8+cJK
         pVDr9qvluXmD2PwE3jiVTRqs8Fdge0gcpPwVR27BW4GjAWQwpRqIi9Ogo8oUv1kHCw
         7R26Prr8gFm3w==
Date:   Thu, 8 Jun 2023 12:53:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <23420735-0221-4eab-9a4e-07a6225c761a@sirena.org.uk>
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-3-zhuyinbo@loongson.cn>
 <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
 <88f19398-385e-440c-83e9-ce51ea60cc97@sirena.org.uk>
 <fa6d546f-ce92-1fe9-5400-0cb8bccf8ee5@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S7nu9e0I23V+8Twu"
Content-Disposition: inline
In-Reply-To: <fa6d546f-ce92-1fe9-5400-0cb8bccf8ee5@loongson.cn>
X-Cookie: Disk crisis, please clean up!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S7nu9e0I23V+8Twu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 07:45:49PM +0800, zhuyinbo wrote:
> =E5=9C=A8 2023/6/8 =E4=B8=8B=E5=8D=886:29, Mark Brown =E5=86=99=E9=81=93:
> > On Thu, Jun 08, 2023 at 01:15:39PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 8, 2023 at 10:28=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.=
cn> wrote:

> > > > This bus driver supports the Loongson SPI hardware controller in the
> > > > Loongson platforms and supports to use DTS and PCI framework to

> > Please delete unneeded context from mails when replying.  Doing this
> > makes it much easier to find your reply in the message, helping ensure
> > it won't be missed by people scrolling through the irrelevant quoted
> > material.

> okay, I got it.

That was more directed at Andy than you!

--S7nu9e0I23V+8Twu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSBwRwACgkQJNaLcl1U
h9CnWwf/ZckmmeKHGDaBEfpB7XclNw/g9H6bhJmCGrmPwl30JCya7MU3ApuN9mfz
HHFL+V74dHUWRv7XErDcDWNcO2rXepEC0OZF7GOowHbcKqoRCtN1El9PMskRzVHD
l6BowtnqCAtkhaLvpKAP1p7J/vE+uuCz/7l92cnqAqYldJusCVZxOxUjgal/Ikll
SeYgn4LZo+c0gtfQ30ld/W44S6YETVxJh5VOflr4+bHo1Xb0M4A7H9N/B6TPxTJ2
y0ELYUwLaeg1XWgrkQJ1sPFG31j0ZM6XPcTlOxaiVFbH/5UmF1z7kwrVNt1ZZbth
SiOj8GfSzllyc17an1nz+cusKg54YQ==
=SzRs
-----END PGP SIGNATURE-----

--S7nu9e0I23V+8Twu--
