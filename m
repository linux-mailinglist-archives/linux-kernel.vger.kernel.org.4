Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133D1600DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJQLgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJQLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:36:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C457573
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDD861072
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CDBC433D6;
        Mon, 17 Oct 2022 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666006588;
        bh=8qGy9UfVwi4BhKxbhVxrqPML0YObZ5NNiu0yo8NG8iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfR1JbTkeX+yFPO+3/KOVmhKlJAqNah/g+zi5StYrh+90OMUSeISy19ox87NhSkVD
         LRozXuXBeb9wwXYVIPLbBhUNuRj4JzJgvgs1B9B8yNoe8fpdKAW0md9Uy+oHWNCGn0
         S0i1S2IZd1vbji2fnebbPa1rDixJwvnaX2Lui6WGLaXgwW3NUiwz9FZbn6TYHMOG73
         SQioiTm+rVKflpC2zKitC68TXEQKoI05abR/axcoKXPaqi7+hbS5+Hu50vaI6VxUK1
         yyzaR+75xU733modJ4RmiChaPrP40bqqRsNYCCH7dwvOYEkGU8s/Y3TC+cWd2lkD7D
         HzYcKp3mJTwog==
Date:   Mon, 17 Oct 2022 12:36:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove()
 in __exit_p()
Message-ID: <Y00+N/2eE+GSrQqh@sirena.org.uk>
References: <3225ba4cfe558d9380155e75385954dd21d4e7eb.1665909132.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oFfgUlb/hNvOP2FO"
Content-Disposition: inline
In-Reply-To: <3225ba4cfe558d9380155e75385954dd21d4e7eb.1665909132.git.geert@linux-m68k.org>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oFfgUlb/hNvOP2FO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 16, 2022 at 10:33:50AM +0200, Geert Uytterhoeven wrote:
> If CONFIG_SND_SOC_TLV320ADC3XXX=3Dy:
>=20
>     `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320=
adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tl=
v320adc3xxx.o
>=20
> Fix this by wrapping the adc3xxx_i2c_remove() pointer in __exit_p().

Why does this driver need this but most others don't?

--oFfgUlb/hNvOP2FO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNPjYACgkQJNaLcl1U
h9DgUAf+OQ10eMrPjpgDk+H4uChrDC0hCUqAaTVFpeQkCkoqUOG/rXgnChAYLYN6
oUFMN7WVbH/j33JxbrirLs+LMh6U4d4JjX7qnvsuM55X5f7XadjhJzunnGQfXLCh
n45s3BcNpHRBPVGW+NUI5fe7vk8qqnEVT9FaxI0dT4gSwIpT1QkY0D5G3LtxEl+p
BvEfxBg2BeGnUYlSoFvWnoELxxG3zg41Mspz58Hjr5ImHG6Rn16vUXLoGXEbnEtC
saNpIRQNwRS4DFTT7bIHSnFCWn49ij7VYk6dDkuwsQQNP2HA87nXzVCbacUEAQvI
mNrBpZyX2T2cV85b2IQYLAlK5xM34g==
=cGIX
-----END PGP SIGNATURE-----

--oFfgUlb/hNvOP2FO--
