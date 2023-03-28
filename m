Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823F76CC158
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjC1NrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjC1Nqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C0CA2E;
        Tue, 28 Mar 2023 06:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725F0617BB;
        Tue, 28 Mar 2023 13:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C061C433D2;
        Tue, 28 Mar 2023 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680011208;
        bh=Mt2fPpoCHv3etx/7+GSXPHM6kWNp/CtAN1iv470diNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ma6q4h3V/SJ64ME5bOW7EdCe+sFNLNZa/J5CRX7A6PXzQ8XdGeo8JXAMTEuIRHrup
         ozXFaQSxdNy3d53+uAkjJyw2JkrSa8BbiN1UAmlxIC1FSeLdw4r9o75i66HQERu1Ae
         Y/mqH6dZR3vU5Uih1yKoDKBzcrypGS5JOcduMngz51H3TeYPpokMP04yVV3Hub8qpU
         BOtE2krS3kig0ps8/L3LYiJv9NBJ10U349A2yuJ8pskXq3ZmiBttfEma1GmeU5DskR
         iIgKd7nprIXMyCMQcYSU6o6DRvLf0pGR5gMNCqBUOEJ2oatoJiT/h/l5NDmwRm8wCx
         flL0DkpKeGCHA==
Date:   Tue, 28 Mar 2023 14:46:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sahin, Okan" <Okan.Sahin@analog.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+bD4dpjGg+/NmqP"
Content-Disposition: inline
In-Reply-To: <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C+bD4dpjGg+/NmqP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=E1 wrote:

> IIRC, regmap_read() is not really reentrant and it is used in the IIO
> driver on the sysfs interface. So, yeah, I think you need the regmap
> lock and better just leave the config as is. Yes, the lock is opt-out
> so let's not disable it :)

All the regmap operations are fully thread safe.

--C+bD4dpjGg+/NmqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQi778ACgkQJNaLcl1U
h9A3jAf/Swfu/yUS1Pclj62j2mBsLC7dH8S8kyafjuDnOqTnv3o6WZJ63VvbqN/P
4pC3PgTLKZV8GFZL6J6m5n0Km4dO8IseWDSF8fahYnVsSQ0DaBVBLEJNpu01GxDf
fulyCDV6bA3zwZ5FNOBGtKr9GT2MlBkxIbjo8ZJ6e1l8Imy661DcU8o5mhiv3x0w
7DvMzE+2BAOjRkp/AH7+8BZ1VbqRTj9NGjl63DycHMg5ADfJD/LfOpNwh8PzjsI+
MX4aE1SSl2iyLKXKxuBfi+Ciqx3rMr+NJvKBdLLBUQpo+1Ls8YlhqbeNMFzNi/PJ
0C9FrJbyIZ83jd/GUbd8Bx/YB2PYrw==
=E507
-----END PGP SIGNATURE-----

--C+bD4dpjGg+/NmqP--
