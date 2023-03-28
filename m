Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120756CC636
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjC1P1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjC1P0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:26:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5731040A;
        Tue, 28 Mar 2023 08:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4AE63CE1D9E;
        Tue, 28 Mar 2023 15:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3287DC433EF;
        Tue, 28 Mar 2023 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680017092;
        bh=qGf+OC44axRVj+XT/Z4tuG6YvUk8bQLbHyJdumlNYFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATpCBChtUg6pUL3KFBojFCXqzNljH3Fn4vl4Q2jOPQYEVtHOWOCiboqBBQXjGyR4v
         xcWzFZ1/IzZ9GiAW80DEDvpIj304SUmm09iKmBKB+HPYMKT4ZhSC1xo/VCVvnj+E7m
         CyjnE1SwPOBJQdABuBrgOMXU1Qfc7WqwfykRZsjhIl/RFThLN6pi3vjulQZIQxiIip
         C6rGDRMAFxVV6S1mTJGgR9aKNxkumCUbE5+Ie6tG37TCkshzzrGGTfVdDT4YDQzGVX
         Vyzmg8Kh2NAMSX//QJ5eLaI3xW6uBZNiWHYpV4zqHUYUHRXvjgtpQwIPtuV1qFJf1s
         1z4x4WL9W445A==
Date:   Tue, 28 Mar 2023 16:24:44 +0100
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
Message-ID: <163f2c26-2cf7-4109-bf1f-efddc95da0d5@sirena.org.uk>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
 <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
 <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cU/jzET003kbiyJi"
Content-Disposition: inline
In-Reply-To: <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cU/jzET003kbiyJi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno S=E1 wrote:
> On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=E1 wrote:

> > > IIRC, regmap_read() is not really reentrant and it is used in the
> > > IIO
> > > driver on the sysfs interface. So, yeah, I think you need the
> > > regmap
> > > lock and better just leave the config as is. Yes, the lock is opt-
> > > out
> > > so let's not disable it :)

> > All the regmap operations are fully thread safe.

> Even if 'config->disable_locking' is set? I think that is what's being
> discussed in here...

In that case the caller has to ensure that the regmap is only used in a
thread safe fashion.

--cU/jzET003kbiyJi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQjBrsACgkQJNaLcl1U
h9B/MQf9GFZs2jkpCdNWV9YHg6lazF76/rn3D4icdGkiIzG3k1r5HoAq0JJGNFmA
0j3maqTeoW+d+v6YX/i6gM6OQ9pY7RDikaRnqeKbKVccDUwYKbbHpPRY7ctWf+uO
JcVFzACHf8fPGGBK9Qrp1L1llGqXKBU7TVxfI0r9X8QPoh0NmtKqG+/0+P7Sso9Z
NSZOIlpQ9OStMphPT+5cG4TCa12GVqsNdFHb90eIowzp+mhn1BxGwLx/xi0wXegs
Gzt7pG8s0om0V1enRMfSWNZQCo/sbKnxGYldP+w5Y17OPGEdaCkk0qUbZk8bAOze
DH09i76sXgSR4PQ6lGdHGT4gqdZSBw==
=cY75
-----END PGP SIGNATURE-----

--cU/jzET003kbiyJi--
