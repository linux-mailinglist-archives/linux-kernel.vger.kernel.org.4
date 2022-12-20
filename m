Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28E1652906
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiLTW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLTW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:28:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EFC15;
        Tue, 20 Dec 2022 14:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 093CD615F3;
        Tue, 20 Dec 2022 22:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A136C433D2;
        Tue, 20 Dec 2022 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671575333;
        bh=Gi9Ls7AdTRHk2NMViPiZtntvSG7jlfdDk6QPGIlIDk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2Hr59aznR/dX/hFFLfxgtR/hNttX/zFoD+8XS8K3C8x/ehvqqzmC/l71nYvFn+yP
         iO4Z/kQYDfD5GhwRAtgYEHAER6BKLLexTEklL8wvkLA/hBYPoMWbuUXLpd3Jglt7IF
         xlQcRLW15MCgoTPTPjH8j4Ja0uRQQzvSWNZGy496FfmCBxqhGC/as8o9Yw5mtLNRRF
         vQvo44t+6WxGQPAnuDceEQVJ4nCONP0OLBADUFlM9p7VwQ+NT7S6at5U9J8Hqo3DhP
         Xuu6KzpTt4fLgCw3kLUCM5kCvt1fkL34IXZ2Tna6bSpu57a/pm84MTbD9unlQce9pt
         iAzYJ5WkgHezw==
Date:   Tue, 20 Dec 2022 22:28:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] reset: starfive: Factor out common JH71X0 reset
 code
Message-ID: <Y6I3IPsmz1YTC3IV@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-5-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4WoZxz9j6RMJx5Ww"
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-5-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4WoZxz9j6RMJx5Ww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:50:47AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> The StarFive JH7100 SoC has additional reset controllers for audio and
> video, but the registers follow the same structure. On the JH7110 the
> reset registers don't get their own memory range, but instead follow the
> clock control registers. The registers still follow the same structure
> though, so let's factor out the common code to handle all these cases.

Is it a bit ornery to want to see this as a movement and an extraction
in two different patches? Would prob be easier to follow that way.


--4WoZxz9j6RMJx5Ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6I3IAAKCRB4tDGHoIJi
0iXqAQDCrwUaYH97jklrhn1ap1Ye2f0+ecPva4uRKLo+1303zwEA4Bhi59oLFzXz
5IZzLDO6LoOXnqMg1y6dWpcMagnIzQU=
=9HFU
-----END PGP SIGNATURE-----

--4WoZxz9j6RMJx5Ww--
