Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1953D727CD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjFHK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFHK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30E272A;
        Thu,  8 Jun 2023 03:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89E4061EDC;
        Thu,  8 Jun 2023 10:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E76AC433D2;
        Thu,  8 Jun 2023 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220173;
        bh=w2pWfbbhDHvHmHIXNXZaKojWPeRA5BW+Atw03blxAOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbMGnuZsBnZfxjtoCSD9d4MQt/7nC4/eu7y1rgP7ncXg2gW+MdQURRPtRb1Zym8ib
         LfxlQhlUaY43ptuGR3TwihDyUZrjR8szy9EcCbrBW15U8MkEmfp+40pc+UO1b3Cj2T
         7rokYUjUYvzyQPk8aWOh28ULri+PeYKc3pGH3f62Z4lcNNRO0k4PbWZL9YkXuc1FRx
         NUDPQdfPo5NwyGanQ3c10QSZq4azWc0ayOMPoFCK2Eapza8HGUDn/QPD3UhizjcTL4
         0MhfqICEY3Zd1iun6m8gp8ug9U0RHGEgqo42YIAHzUo8JNFnNYNT8y9k1dzSX+0ROX
         +Vc/V12ZqaIDw==
Date:   Thu, 8 Jun 2023 11:29:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <88f19398-385e-440c-83e9-ce51ea60cc97@sirena.org.uk>
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-3-zhuyinbo@loongson.cn>
 <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J8T3OI+or6rwIopE"
Content-Disposition: inline
In-Reply-To: <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
X-Cookie: Disk crisis, please clean up!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J8T3OI+or6rwIopE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 01:15:39PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 8, 2023 at 10:28=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> =
wrote:
> >
> > This bus driver supports the Loongson SPI hardware controller in the
> > Loongson platforms and supports to use DTS and PCI framework to

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--J8T3OI+or6rwIopE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSBrYYACgkQJNaLcl1U
h9B99Qf/SHOHBEYpx6PqFNDjgbURnRP+DzhF/OKNjr8wVcf8xiP7Vx5+SHrxaokj
mH6uStf4oHOwcfXU5+R0x5ZEBztaYz1p80nsygGPszYLZmEFjNxX0EyGqLyO05jy
larM2IqcdnUYLp8Ba6OREnfABhFcHM9Txg01u8JEvR0FC1ZNEzaSGNVHFDcHsNqk
H8baxV34vl6kFTyBIe3Y0U+3JeCaIKfKjBw+8jMGA+Gp8ws1MMQAw0uZeebDs9Ua
bk8ahJ8jmyfpF8e7lReW6cmfs0OrXXaOjmfkJ9IUx90EHKXSZzIycuppI76xk381
J+2NXM7EZF7Vn92N0KwvX3qV5QJcVQ==
=0LaQ
-----END PGP SIGNATURE-----

--J8T3OI+or6rwIopE--
