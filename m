Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FA6EAA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjDUMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjDUMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEB118C5;
        Fri, 21 Apr 2023 05:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0444F63E9A;
        Fri, 21 Apr 2023 12:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649D0C433EF;
        Fri, 21 Apr 2023 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682080926;
        bh=1viMKIx6sqkhuLg2xAjcicJimbx0TA+4g/Mnc+kkj3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW24TVib54lA9ORge5qtx6oE5Hj4K0FUcHqURggViP0rNx3DKw07WK5sfUU2pLfTo
         daTK1gAQpA6Nr/MsoJgx+iQ9ufT7JNri4s0aQMOfHntfaefeArkjKsMvjyxMvX5ZkV
         9YZs4YRKTJdGeVCLIlhrnqK9mODAo2K5zvncMP3jxeqgfSynQXaU5bXmv8UTpIiCp6
         304dM4VX4jjleJLiVsyrh8vRsVQz2QqXUEbAGg7e+En8MmlOH4vGIBe8jh2UeX9SIq
         3N4SXgj6JGpOGc3WLzuoTponSdoU6Gk4LVeR6nleFE9/ZeQd7whAuSJO+T6JdVvBhv
         LPuvlUp3Ox5OQ==
Date:   Fri, 21 Apr 2023 13:41:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/5] regulator: max77541: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <0f8ffae5-1267-4373-8979-1989318497ec@sirena.org.uk>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1FRzun8VXwn6ZIl1"
Content-Disposition: inline
In-Reply-To: <20230412111256.40013-3-okan.sahin@analog.com>
X-Cookie: Hailing frequencies open, Captain.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1FRzun8VXwn6ZIl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 02:12:43PM +0300, Okan Sahin wrote:

> Regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery
> and 5VDC systems.

Reviewed-by: Mark Brown <broonie@kernel.org>

--1FRzun8VXwn6ZIl1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRChJUACgkQJNaLcl1U
h9BgwAf9FFeuk/6y+CZ9pA0Rp+BYHqdrTxCmBMSO+UPH2NliQymSV+sHGkDOq02r
iqh0AK+SAs6dEZmN+Xx6k98CsM6N0m4Rh+fF8cR9O27WOsNH06QSPuDWCLeno1ZA
H1jKKF6ByRumicUzziIma9kOjA1ufx0AAVfUbdBt1ZCgJeuZv0yWb3d+jAvHOWcH
lSDTkN7jwo1UjFFowTkH6MzmElS43JdiZ5eXdLYFRJAs4aTv0r4MKQoksckGMt/u
wOZ8arow4RwJz0f+akvSvyFaOm3F4IoLCf4Hz+gPdVOQIuKX2PKunGluODN63GRI
wZPgsp5OEw0pWsLo6Ko4eI3K/WgEjw==
=Ut0n
-----END PGP SIGNATURE-----

--1FRzun8VXwn6ZIl1--
