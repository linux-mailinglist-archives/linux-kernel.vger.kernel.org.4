Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898D604C72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJSP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJSPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD701057CB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A5B61940
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D796C433C1;
        Wed, 19 Oct 2022 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194765;
        bh=fJdI2PBQOaREVvpTxeqc6G49+0wfiPXAfQXbuZuicAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzYxiWbt8AF/qFab0s3SEUyzaWb0qtYbQAWg9WYsn0nImZapgtW1W5B2dG4aRhDaB
         KWy7SS8AMOHx2v1KcaSvQ/7FT0dK43aPxl5t50tMzkCBMEhqYH9jA+0pNWuO4KSyzg
         qi2Q5B677LGUnpefIVMMwww4ts/Uf6R2sQBVVEH34caMO1ofjE8tt4YDzqZ7UtmltF
         cQYotxV+Is06tXeQurY2GV9w20fGnqmb1zEo6j43Kp7ZiF5GFT3nfXnRu1eyWMVefO
         EqqDwX4eWZlB7bFHCd62PceggAb7kjU2pUHr9ULcdzpoWg7qLCcoEi2y+6HrN/p5T4
         et62X2YEgQTEA==
Date:   Wed, 19 Oct 2022 16:52:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 09/14] ASoC: remove unused davinci support
Message-ID: <Y1AdRh3JaPFZLn60@sirena.org.uk>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t3dbVmTiil0pAD+H"
Content-Disposition: inline
In-Reply-To: <20221019152947.3857217-10-arnd@kernel.org>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3dbVmTiil0pAD+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 05:29:35PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The dm644x and dm3xx SoCs have been removed, as have the
> da850_evm/da830_evm machines, the remaining machines all use the
> DT based probing and do not use the vcif driver.

Acked-by: Mark Brown <broonie@kernel.org>

--t3dbVmTiil0pAD+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNQHUYACgkQJNaLcl1U
h9BTdwf453mQSwA5Mv146gjM9oiK/qfm7cNpWjxlZhT4KRrSVisjgjeGCKLzsqiU
uOofwzIGivVdJGQ3xLUW2k8Jg9X6TI7Sfzje1kbMSBj698mkmb7RYsyos7BDzLDJ
M83G0sZ3eOhJlX0tcZM20N9zqv5VPV6oEauZK58M+39jogswQ3LKWFGiaR+aoIkR
yHUZqevTzYT1Y/+78LwAA6XTV6Y8kPPPvUKDwx9AVBPwYimqLqOnfnJhny7vOLdc
R8D2GJkfAv0ON0KVpr4inwyyHYS9Lc/jnIuNp9WDt+GcccZR4NF5SJlqQU/mn6yO
n3yv5QQR4mjnoTASLuUQ6cNVDEHW
=jAkz
-----END PGP SIGNATURE-----

--t3dbVmTiil0pAD+H--
