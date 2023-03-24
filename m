Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2086C887F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCXWmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCXWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:42:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70F199DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06CAFB8263B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 22:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432FFC433D2;
        Fri, 24 Mar 2023 22:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679697726;
        bh=mSFKufLTDCXZe4OIXeSCIbH+/iene2azn0ooIi132Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYXurxWmKERP/GrIVcZTkZ+HSUUcwVYj8yrEYGlZejCrPL+ByvnRlBH2gnHCEXdK2
         wRk+23iynjUPOpVcDbJyga/EM7Q0OWwnQr57TxWmhx6oq2TBIJXsDjmKqltULUOk+o
         orsf7jU6h9wRHPSCcVVsFcxCwfPhg/epdn0622kVnbalDL6YY85dG9FKaiX0hZzRPA
         BPEKGxlzdXVGdvf8AxaayArG7RzURgLA82dVoEmmktqNhOKAH3mLss8IKNBpfvpKap
         TTv7M9xxZyRUh74ApR/sJeoHXls2tP9v1K6jRXGkcdntyoZjvwEinir4ef7N6n7pKa
         NLHgEznub4WrQ==
Date:   Fri, 24 Mar 2023 22:42:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shenghao Ding <13916275206@139.com>, lgirdwood@gmail.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
Subject: Re: [PATCH v6] ASoC: tas2781: Add tas2781 driver
Message-ID: <ZB4nO8bVqaKFE3K5@sirena.org.uk>
References: <20230324110755.27652-1-13916275206@139.com>
 <0dfd9d02-30f2-8245-430c-0d4381470606@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c2P+GJtblqhiHXkG"
Content-Disposition: inline
In-Reply-To: <0dfd9d02-30f2-8245-430c-0d4381470606@wanadoo.fr>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c2P+GJtblqhiHXkG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 06:07:32PM +0100, Christophe JAILLET wrote:
> Le 24/03/2023 =E0 12:07, Shenghao Ding a =E9crit=A0:
> > Create tas2781 driver.
> >=20
> > Signed-off-by: Shenghao Ding <13916275206@139.com>
> >=20
> > ---
> > Changes in v6:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--c2P+GJtblqhiHXkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQeJzsACgkQJNaLcl1U
h9ClpQf/dvhWZWGdIcnyO84ZaGkFrP74RXQQjwP6QNGLiEaACgahJpnNN8RolgDZ
99YfARCWQUsyS2XlSaIrOi5D2wFFrtsoSlMJqhI4BsslcUxvVdqDfwkmt8+q643f
Vwi0j6mozIgd7B2JpVKcuM4EiCn6dqoEQh+1xOdAW0JDgFtd5IeV3TnkSyLR7D6S
nn9vJAwXXUfei35vBCwa9NrmpGiEm3ziVoyx1+lsB6LGYUtDCwtW5EDu6pAlPlap
izD4yBztdfbO59KCid3PjFmeIYi6mUlSkzfxmDH6878auwEWkNKcdLxlhiCjmUNf
kZnIgHmJUAKJx3sAJbXUYLbinfK4yA==
=6cGt
-----END PGP SIGNATURE-----

--c2P+GJtblqhiHXkG--
