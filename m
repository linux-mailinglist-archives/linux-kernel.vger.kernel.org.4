Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD866981E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbjAMNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbjAMNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:11:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3540C21;
        Fri, 13 Jan 2023 05:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF7461961;
        Fri, 13 Jan 2023 13:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECE6C433D2;
        Fri, 13 Jan 2023 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673614806;
        bh=ZP8XIsS+80qkgSOQWeJfZPFezfHfSRD008tq6Tt5pVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+TA5zAKqGXCmaGrYk99jkVIQKonzPOPIegiyi8+3I1BxmPRQIzsBF6XwqZ995nY1
         67EHFMpuyIpINrwtBWjLO72bP1/a+LErlP0dks1cZ/62ZeX991mzu6avglNIIT8IJn
         0QjWBnYyM69eY23rRuLQHJ1QdBNjTUWmagQKDB2y396+kya1S2yYGbFRYhDydcdDGX
         5cNH0vywKEefPBNhPGY4mnJqa5927Q27NJWbzohinWryB/AjfGSJ+fvX4VPb8mnMiC
         a14pIf0Xf35qcjB6F93E/vLbrioQ2MD0A+lRPvtIOLQP5cgQ2FpwKR7QScWVjdQTZz
         +s4zkg6xtizcA==
Date:   Fri, 13 Jan 2023 12:59:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Renesas IDT821034
 codec
Message-ID: <Y8FVz/Mp5xSdI34a@sirena.org.uk>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
 <20230111134905.248305-3-herve.codina@bootlin.com>
 <Y77DKSdZf27qE+xl@sirena.org.uk>
 <20230111174022.077f6a8c@bootlin.com>
 <Y774bY4icD8RuMnX@sirena.org.uk>
 <20230113090431.7f84c93a@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tY5Grajt3iCZ58MK"
Content-Disposition: inline
In-Reply-To: <20230113090431.7f84c93a@bootlin.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tY5Grajt3iCZ58MK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2023 at 09:04:31AM +0100, Herve Codina wrote:

> For DAPM (struct snd_soc_dapm_widget), no kind of .put() and .get()
> are available. I will use some Ids for the 'reg' value and use the
> .write() and .read() hooks available in struct snd_soc_component_driver
> in order to handle these Ids and so perform the accesses.

That's what the event hooks are for - there's plenty of widgets using
SND_SOC_NOPM as the register, look at those for examples.

--tY5Grajt3iCZ58MK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBVc8ACgkQJNaLcl1U
h9AzVQf+IpbKw3nUOCd5FnoIfC7a9hLUt4eHIEqikDmn4Lb0N0OX7frf/8tR948l
KlKpueTgBz0TLqZUaI43dlzt2AeYsHcshaZ8Rkg+2YtAumavq3sc4rrq+9HxRn5X
akZKiao7FYUAVxqcVvyfatB3qtShtwes0I80YL/8JClxfd/vOZTUriymgeTemgwb
3h1esS5zNPKD1rp/h2Fm/AytOFrTE0xA+7HlZ5qmy357cwpc+JKYx9enGt6hwc95
zhE3+AZ1UIc0bFfp8xhGnW0YzlelN1grOl5oar0kdwTOY9kQTwVgTfMp3+L4BBBD
1xdRqnZEhFNnTC1IW724rzztEvTfuA==
=p0Is
-----END PGP SIGNATURE-----

--tY5Grajt3iCZ58MK--
