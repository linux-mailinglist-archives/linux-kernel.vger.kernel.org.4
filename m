Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F407020CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjEOAei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjEOAeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4110CA;
        Sun, 14 May 2023 17:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68B1611FE;
        Mon, 15 May 2023 00:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2348C433EF;
        Mon, 15 May 2023 00:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684110874;
        bh=hZX3lsPty37NkozQs0xkxwcNAftmAAsvZvG63ar1tIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuMQ48xUx7MMO850z8B3/cCEiLYwhg2q8ds2b/lxdcNBqP2JHA8a/Igij0hhBolnc
         8vlgzxmahgWWF9eYjRbvkHkZpSNJle7oxokov+AZW61dnBqThYqgcB5Wo7sHb8Ui6K
         uTqAGBo70MojaUEIMom1PbH8MJoAsABdkCZDqUmI05REkz03fznjdZADFzjCSEbLW5
         uZ56rZu9MzhKRmORGcSV+0ngSHYvEPerS7iD1MJhZW5BB5+rihUUtP/Vlb66hm7q2u
         swrR3w2XNiGl58pMnqSJwMWmySE6CFwPfqZgWk20IXUGgDRYkKIRyMiyDr1+IHCRsW
         fu4ji2xx8U9kg==
Date:   Mon, 15 May 2023 09:34:26 +0900
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?B=F6rge_Str=FCmpfel?= <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: Introduce spi-mosi-idle-low flag
Message-ID: <ZGF+Ei5sn4ci41LU@finisterre.sirena.org.uk>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-2-bstruempfel@ultratronik.de>
 <ZF2y1YNkSbXzRm4V@finisterre.sirena.org.uk>
 <CAEktqcthEG=AWTk9VcVkwexH6xV_xHw1hqxkkPkD=d1NqPKqSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jG3+yPPt0iwCjHtr"
Content-Disposition: inline
In-Reply-To: <CAEktqcthEG=AWTk9VcVkwexH6xV_xHw1hqxkkPkD=d1NqPKqSg@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jG3+yPPt0iwCjHtr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 08:54:19AM +0200, B=F6rge Str=FCmpfel wrote:
> Am Fr., 12. Mai 2023 um 05:30 Uhr schrieb Mark Brown <broonie@kernel.org>:

> > If this is always required for a given device (which I'd expect to be
> > the case) why configure it through DT?  I know we've got some legacy
> > stuff like that but not all legacy DT choices were good and no need to
> > continue the pattern.

> Yes this will always be the case for specific spi-device, spi-controller
> combinations. Just to make sure, that I understand your suggestion
> correctly: You propose to check from the specific spi-device-driver, if
> the spi-controller supports this particular mode-bit, and then set it if
> it does and thereby loose the need for the DT entry completely?

Yes, we shouldn't need DT here.  Though the device should just be
setting this unconditionally if it's always required.

--jG3+yPPt0iwCjHtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRhfhEACgkQJNaLcl1U
h9CUQwf9GOgkGMy4AAK5Y1LcKpaX1j7DIItEjuPWsM9sjmduKp921EvFyALp/hqU
UdQ3emjnx3i2kaV+9GxNuIB3auUEu2xE2guAzd2tRbLbDOaK/4k8G3blLSghOBYu
CQy7EGP8JKKM658ru88SQMTC2A7IXS5HNh0s1WwakmaynDYkIk0bO0dqz8zwR23P
BoYJQgr9Z6TQwoivQ9/M5pO3cH/FIEw1gY8ajxdbsUXwRd75qJCL+rLjNbC654cb
kryggjSO7KUNPUpUdQM/H9p2W7v1zl4iJcvr8P3/b9k7qwwluFSFJHyUnOZ3Ecd8
gOIvDmrDs66z0vPIcd8Mb5X73Dr0mg==
=QIKm
-----END PGP SIGNATURE-----

--jG3+yPPt0iwCjHtr--
