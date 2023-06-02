Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65965720093
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjFBLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFBLn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40275194;
        Fri,  2 Jun 2023 04:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C750564F32;
        Fri,  2 Jun 2023 11:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC21C433D2;
        Fri,  2 Jun 2023 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685706237;
        bh=qyj2TnFG9Q0Dqv/yetg95LBFYsBmGWLoH4r/LKwHNFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAlxMoP/qBc0mYGcWpYHeVsa9+r7EDw01E7qngnPnA87Tv0sbunfoocMmS0lWr0IO
         xzTgsYDl/xjWuRMFdC/paiH3tQuz2xNEamizJmn5Jg5X97Q+xh3JBOKOEa3DbOQWlI
         R0gUicxEfXmC9PEeI2Mrz23WWJ6luwzf3Wv+d8OXgwN3Y9pLhE/6dLm4WoQJTWz8i1
         bb/ziz/uyfqIMztFJDty5LMV3rIVyt3iMADd2W9+TEfyE49g+MutpJ+WdcCviVuliE
         tPGj795nypFMC5LsLLRXBEkMTkScWCtGx0AdLzjBpsIWn7Qr4IiqHjY7WNRgW9EX9c
         +ivng4bHzEtIw==
Date:   Fri, 2 Jun 2023 12:43:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Message-ID: <3fe93662-82b0-4834-b6c3-473669c66210@sirena.org.uk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yljCHQatclI9IIDH"
Content-Disposition: inline
In-Reply-To: <20230602090322.1876359-2-alvin@pqrs.dk>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yljCHQatclI9IIDH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 11:03:18AM +0200, Alvin =C5=A0ipraga wrote:
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>=20
> The new flag specifies that both ends of the dai-link have the same
> clock consumer/provider role. This should be used to describe hardware
> where e.g. the CPU and codec both receive their bit- and frame-clocks
> from an external source.

Why would we have a property for this and not just describe whatever the
actual clocking arrangement is?

--yljCHQatclI9IIDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR51fYACgkQJNaLcl1U
h9BNRAf/dP2YV4uOYvx3LXMZqRrfypjgfWwbbFEufSIelAq8lZS5puJ+MvumnDqL
XR89aM7F6DDztwC4eCpUETQ1JsAz5EHnoaLe+uxnG5c2wV+AOXi2SVoXLtA+S6lX
3IGObHfe4FnxwvIX2N0wZX0XH20MEpJhJCO71zo+t9dOZo7OykvYEQA+4kkBcePa
7zx9TAhm0VkpEUY3RkT4uymkkyIczcaDkaF2HTNDIG0DEtrw02lXVYi1WmhiY5Ah
C4IlcYDVqwVpAQGboONnZoF8+9IFeZRynit9kSNKajMK9EVz1T+NmXQzUYD/UxfY
sOiGK2eIY2eai/KegHSKFnIOBmOw7w==
=htpo
-----END PGP SIGNATURE-----

--yljCHQatclI9IIDH--
