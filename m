Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38C96F9268
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjEFOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjEFOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB752ABC4;
        Sat,  6 May 2023 07:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5A461AB9;
        Sat,  6 May 2023 14:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB5EC433D2;
        Sat,  6 May 2023 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683381918;
        bh=y0WUlgC0WNbDSzHmroKR1xYfLSonnnO8yE7x3BwO8Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMu3vWPzkqw2+2Xyps4vtfabZ3xscPVhWaFOYJ3xR/Uv6tRaOhc0UhspeEOi5iC5b
         esk6lhSRWmC+Dh3UqpDhLQvNAnkhqPinu3hGt2e1YfQxE2VRUyYDAFBOiJuxi8QLMz
         nxqXzcoqw+Ls9q5OPlkfeXUPnCkBlG/f+wpUfsqzsUgC0sy7ON/b3eY1pl5LVsRviO
         1P1Hd5IWqR3TO2fk69rCy+okOzcQ5fbBwy01kvnKECoDyI4tTQ8g9rcERRtAOIsJih
         ferfKXjPSLYJP3csrBHWmUUYJm2VKu6MnwVSs1av5hpoMUsb4sqJq0Kig9mO3feAgv
         Ej1yfVMbijnXw==
Date:   Sat, 6 May 2023 15:05:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RESEND v2 5/6] soc: starfive: Add JH7110 AON PMU support
Message-ID: <20230506-doorpost-cranberry-59a46968f15e@spud>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-6-changhuang.liang@starfivetech.com>
 <TY3P286MB2611D930A36FDC4EA431D77398739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6JSd8vtVYWFfu/f7"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611D930A36FDC4EA431D77398739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6JSd8vtVYWFfu/f7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 09:58:39PM +0800, Shengyu Qu wrote:
> > +static const struct jh71xx_domain_info jh7110_aon_power_domains[] =3D {
> > +	[JH7110_PD_DPHY_TX] =3D {
> > +		.name =3D "DPHY-TX",
> > +		.bit =3D 30,
> > +	},
> > +	[JH7110_PD_DPHY_RX] =3D {
> > +		.name =3D "DPHY-RX",
> > +		.bit =3D 31,
>=20
> Where are JH7110_PD_DPHY_RX and JH7110_PD_DPHY_TX defined?

In the dt-binding header added in 1/6.

Cheers,
Conor.


--6JSd8vtVYWFfu/f7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFZemQAKCRB4tDGHoIJi
0nuqAP9R4qyILj4K9sBrUCVnY6cUY3qlE2a2ZHQIZzt1hlTrkgD+M8Yq641T2EMD
nB2i4m6nEnTrd0ecq0vgyQa3k3i9xAc=
=5hOP
-----END PGP SIGNATURE-----

--6JSd8vtVYWFfu/f7--
