Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA73D69F733
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBVO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBVO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:57:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4D32CE7;
        Wed, 22 Feb 2023 06:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 656F2B815C8;
        Wed, 22 Feb 2023 14:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7FFC433D2;
        Wed, 22 Feb 2023 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077837;
        bh=0oI0QSVIZmrYGzm5qMI9FC9aY3lntQPLGoGkeh0XrTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zhr39bqj+x9QOvNA+gfkh257ZaUD7gPdpSBgJ2x/L5bH8xIqU5qhpEHpMC/GMgXhO
         0ulwaRWnaBj6fhmCnbcdPAwn2y+qIb0xDkNN3M1RUBih935hUPxP4gWtiWxLyCPvMV
         kKeiejMm2q0cKVSluDw685zojrYX9OvB0Gi/Sr0JxMT6lw/g241bbusWK8ilMJ9RAn
         e+XTiYjBARNyh9n0yQitJByY/7dQqpvvHM8QcNIP4CaeY/DurtL5TK1w1Tkg1h+A8y
         rEZtoUT3Ff5fu5N1cQlRoJK4qxQVfS2Nde9UAmD71lleNujfrZIbqGj4Un+IBMQ+Jc
         +ftVYAfe92jmw==
Date:   Wed, 22 Feb 2023 14:57:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 04/10] ASoC: tegra: Support RT5631 by machine driver
Message-ID: <Y/YtRtSqFAQj+AZU@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-5-clamor95@gmail.com>
 <Y/UcXNueAmrrhWG0@kadam>
 <CAPVz0n01YWQ6FY9RDsa1rw_36n=NKpRLokFiVTxLsMDpQEd4YA@mail.gmail.com>
 <Y/YYaVhE7WwqLIey@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SP3ot0dvarn2c/WQ"
Content-Disposition: inline
In-Reply-To: <Y/YYaVhE7WwqLIey@kadam>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SP3ot0dvarn2c/WQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 04:28:09PM +0300, Dan Carpenter wrote:
> On Wed, Feb 22, 2023 at 09:55:52AM +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 21 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 21:32 Dan Carp=
enter <error27@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:

> > > >  /* Mic Jack */

> > > This comment doesn't make sense now.  It was never super useful, thou=
gh.
> > > Just delete it.

> > It does. Headset is Mic Jack + Headphones combined. headset_check funct=
ion
> > performs check for a Mic Jack component in plugged Jack 3.5

> I feel if we need to discuess what a comment means or if it even means
> anything then that's a useless comment by definition.

If the device doesn't have a distinct mic jack then it's not ideal to
talk about there being one (as opposed to the microphone on the headset
jack).

--SP3ot0dvarn2c/WQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2LUUACgkQJNaLcl1U
h9DohwgAg5B1RDs7IHmHXbAnOEJot3PmpYe4ZT8mvWdsipVsEOmicv9Jq5TgOMBr
8tj3IwItO4yzHJDcN3A/dwYZFVppFntMyVC8RRP13DSzXdwquSXpfnKm+JPoV7MQ
pgCCVTw6NMhE35JfxkzGrvEmJdnPYzxkeDhjOKpNLL+j5w/BntNBUfvtf1mLv0HL
9kHud7beeXTyY6TNXMnm33ZeUjXpGsSXizJgvDrxl+kjr2KG02uS6ad/7fdNhBK3
AnNKzJbzKuydQFAWbBGDQUg2qwkcBzyo8aQm1rpw7WmdS839MaeU0lxyM9aa3WiQ
ndwCYvC+WVNlJ6v9nFJ5XeCtAIJBGA==
=g3uz
-----END PGP SIGNATURE-----

--SP3ot0dvarn2c/WQ--
