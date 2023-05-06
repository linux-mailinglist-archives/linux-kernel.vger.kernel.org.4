Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A06F9272
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjEFOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED11AEDC;
        Sat,  6 May 2023 07:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E406190B;
        Sat,  6 May 2023 14:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EE7C433EF;
        Sat,  6 May 2023 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683382353;
        bh=4jL+XeItzB/ydrH9FfFh3pIsRwNuNtdzO2o90HjqPYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsA7JbIFFjCrX4+f2T7pTF3d42L0sFqsoLchdMBPeP2wp1qYQ0yKe04sxmvXU+bQ0
         SN89+dRX6nPJVjmsw5jJuSyeJbbUtXyvgj4FCTCEhLfXrcfiLBpMGjTay8oo77Re83
         h8sZEDt2s1rI6D+YfOTo83PDz0M8/0IwLbDkC23SSYCEDmdzIjCs1+myC2qtboESm1
         Av4+gbb0sPZ86+JXArzdB4maOW+4c2Wp0E/XWf90aiZVdAcVyPQxz1LNrBP7YkJHz0
         CHSb9gEtEBBuBV63k/s0aUy/aurvEyVolWCHrsoj78wdlN5TwZKRcCKfpNh3e/8oSZ
         e6zCZQtg2qLIA==
Date:   Sat, 6 May 2023 15:12:28 +0100
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
Message-ID: <20230506-corned-blah-19265ead2d75@spud>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-6-changhuang.liang@starfivetech.com>
 <TY3P286MB2611D930A36FDC4EA431D77398739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230506-doorpost-cranberry-59a46968f15e@spud>
 <TY3P286MB2611B62D9408B6D136A8676498739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tAhLt/yCXCKqLS/O"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611B62D9408B6D136A8676498739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tAhLt/yCXCKqLS/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 10:07:39PM +0800, Shengyu Qu wrote:
> Hi Conor,
>=20
> Seems a bug or something, patchwork dropped patch 1, and I didn't noticed
> that, thanks.

It's there:
https://patchwork.kernel.org/project/linux-riscv/list/?submitter=3D208605

But for whatever reason it arrived before the cover, and thus was named
differently. We've been having some list troubles lately & that may be
the cause.


--tAhLt/yCXCKqLS/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFZgTAAKCRB4tDGHoIJi
0p5GAQDh9uTf6hzzu7fU4RJW+FMZNXs/JzIGsuyZuVJPiLc3UwD9FQDVYVbYtiNM
AJm6D9sV3P5Dt7QM8sR8N1Ws0kmkaw8=
=jpgU
-----END PGP SIGNATURE-----

--tAhLt/yCXCKqLS/O--
