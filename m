Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFA706B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjEQOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjEQOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D366D72B4;
        Wed, 17 May 2023 07:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D2060CF4;
        Wed, 17 May 2023 14:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597AC433EF;
        Wed, 17 May 2023 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684334140;
        bh=5Mw0eRB8Cw4nL5cm0Wg8etkyvQ8Ovplue6eotuaj9IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWBfg8m4uUbnpMPo4wg+0hUfYznPygvRsl2eKkTCHhLGZVYEjz5syTm9xpWfW5vmF
         vwIrAnHTJlUPj8LBqsXl67LNqBrpisxKQuujUSMwU1xGWaKj8rNyS7D8vDkP1n4LSU
         fyHkOUoHU3WGv0KMfi7bicHBIfq7fK8ksh7cIUUMPHOX0nN4ZBbCoJ6pIkUzyWb3oN
         HCOhC98G8JkwodX+OmKeDUPeiwo9uoV7M3rfVRgvqkTbM9hgmRNxWM8yXAuWaNdMlG
         wEISrYz89wdwCI+AR2sxT3fZDRE0YRxhIGR52IR2OqpSQGHx/97a73p2PFML0pekB9
         +YtXj7hPVEdrQ==
Date:   Wed, 17 May 2023 23:35:38 +0900
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
Message-ID: <ZGTmOtl8oqMdMmtY@finisterre.sirena.org.uk>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-2-bstruempfel@ultratronik.de>
 <ZF2y1YNkSbXzRm4V@finisterre.sirena.org.uk>
 <CAEktqcthEG=AWTk9VcVkwexH6xV_xHw1hqxkkPkD=d1NqPKqSg@mail.gmail.com>
 <ZGF+Ei5sn4ci41LU@finisterre.sirena.org.uk>
 <CAEktqcsYDn8Gncf8Mk-7dCX+qA=ZTAu_JFTNi-KL0UjPnmG=pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dstuhimKoUBADMGE"
Content-Disposition: inline
In-Reply-To: <CAEktqcsYDn8Gncf8Mk-7dCX+qA=ZTAu_JFTNi-KL0UjPnmG=pw@mail.gmail.com>
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


--dstuhimKoUBADMGE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 10:26:07AM +0200, B=F6rge Str=FCmpfel wrote:

> However I am not so sure about setting it unconditionally, since this
> is dependent on the spi-controller. Not all spi-controller show this
> behavior, that they use a high mosi line in idle mode and have the
> ability to change this. As far as I know, another common behavior
> is that the mosi just keeps the last state which it transmitted. In this
> case, devices like Neopixel would still work without this mode bit.

The behaviour the device needs is that the device have a low MOSI, how
that is achieved is immaterial.

--dstuhimKoUBADMGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRk5jkACgkQJNaLcl1U
h9B0JAf7B7L591jcDcvBFF7fvBcFXjGQtyd+NmNvja6Nu61UGoKmeZ/aCB1r3Cev
PFL9wxkeSwhnHNXIiR84o8arggMvri5woViO0TqEuXSWSt162KQXgB/VT2dY5/xi
Rcqs8kromRORRaFuQPTnaQlAmDzP9bvwRb7DHVul+UQpr8iLQ3rdw+FrGh9W8cMv
p/1Gngv+xU/mMUsuaZUbPBt3n+bqWEmNRKjDWO9VKWq2SeegR8YuRKyUCaczblRn
ysFfgujGZwMz8JU4XQVaW/DBnfUq10qZBZlCDUKs5WKBog78CaB+9NU0JTMn7LLw
cMsxL9Ct7kI2EtXQxnuvA2/QecIgqA==
=hgLr
-----END PGP SIGNATURE-----

--dstuhimKoUBADMGE--
