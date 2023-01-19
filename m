Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF6673F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjASQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjASQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:59:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAB9035;
        Thu, 19 Jan 2023 08:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CC661CE4;
        Thu, 19 Jan 2023 16:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85341C433F1;
        Thu, 19 Jan 2023 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674147544;
        bh=RF7r/yCO3++XGdA6LiIF6KXulOuZEe98+/7LlxVZQH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQoiqCvpDUa/QybJ5jQbTus0Ja3L42zIp3CXFNNBQP4Xlnb9lds2RMM4gFocuVpGj
         qLy1YiCfZsavYjAE+nNIy6OGPmZ2X8GKk1bXMUs7LGVxGkWCEKGwq18iMqs5SZPTpn
         Vyq3aImgkKElrrDXpMiW49C1q+HsPz1eP3DndMul2VfU3bwK1YEgrpd+/3TEMzpzmZ
         jmNwSEV0ARGnsnjvz84OOUFXkTZ32MTLsc5WOR1H0MTa9jQJ7cxeQZZvxYSdMSoQEp
         AsLy9GuTBDWnaNuXGdvsZIxi8PWneHED/nUbbJP2g7Em2Bnq54PaH6AvsG7ovcq9io
         0OT8HHx2A5GZQ==
Date:   Thu, 19 Jan 2023 16:59:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
Message-ID: <Y8l21Kb42l2ZcIC+@sirena.org.uk>
References: <20230118161110.521504-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzVt0O2u5Oo2htJ5"
Content-Disposition: inline
In-Reply-To: <20230118161110.521504-1-arnd@kernel.org>
X-Cookie: What is the sound of one hand clapping?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bzVt0O2u5Oo2htJ5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 05:10:45PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This data is no longer passed by the platform code, so
> there is no point passing it down at all.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/samsung/s3c24xx-i2s.c: In function =E2=80=98s3=
c24xx_iis_dev_probe=E2=80=99:
/build/stage/linux/sound/soc/samsung/s3c24xx-i2s.c:436:56: error: passing a=
rgument 4 of =E2=80=98samsung_asoc_dma_platform_register=E2=80=99 from inco=
mpatible pointer type [-Werror=3Dincompatible-pointer-types]
  436 |                                                  "tx", "rx", NULL);
      |                                                        ^~~~
      |                                                        |
      |                                                        char *
In file included from /build/stage/linux/sound/soc/samsung/s3c24xx-i2s.c:21:
/build/stage/linux/sound/soc/samsung/dma.h:17:55: note: expected =E2=80=98s=
truct device *=E2=80=99 but argument is of type =E2=80=98char *=E2=80=99
   17 |                                        struct device *dma_dev);
      |                                        ~~~~~~~~~~~~~~~^~~~~~~
/build/stage/linux/sound/soc/samsung/s3c24xx-i2s.c:435:15: error: too many =
arguments to function =E2=80=98samsung_asoc_dma_platform_register=E2=80=99
  435 |         ret =3D samsung_asoc_dma_platform_register(&pdev->dev, NULL,
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/samsung/dma.h:15:5: note: declared here
   15 | int samsung_asoc_dma_platform_register(struct device *dev,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--bzVt0O2u5Oo2htJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJdtQACgkQJNaLcl1U
h9DgjwgAgU0/cJsXAH8jVFRez5j0+Ywfwgj3yHcHuFoz+nMGVyWiantq0Ngpc4hl
A2xXiyPAUihszEWIB8CsTZZ6QkinxuTVzhvCfZsBHP9cxv4N+wLUkCEZyFof1V9T
Y260keksOWfsGEv2j4kiwf/sjEUp7rpiBhRal7Anf3wB9RDRuRhEVTIIWXqoFfZd
l4NnvS9Nzis5VdmtlUd9mmz3EOPZ/MCjeaZk3Su5Wq4B2tCxxR3zhINn6Fugkk7p
pF4BzZvVHKiO2TACVEd22dyF4Jl5e7tDnFNaWB4SVr8AyKg4XbPxJueIoNp0Ix80
vwaqN+MsmKDjZvMhsU4KsP9HmfzP9w==
=aHDc
-----END PGP SIGNATURE-----

--bzVt0O2u5Oo2htJ5--
