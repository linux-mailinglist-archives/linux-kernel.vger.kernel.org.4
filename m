Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94796141D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJaXbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaXbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:31:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B61CC;
        Mon, 31 Oct 2022 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667259053; bh=Ydt30ZiOwoAlHwQQhVHso8KMBpJhTV2zmKzAWz49L3k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=N6jqJdwt6r4UlyHJQ5Nn9gf2K4rMAeSo0GJU2XVV5AXdc2fEgh8lynBJApgPusUHR
         wCO56RusmAVBcUfheAapG3hHFC00SpeM3YHztaYPoZllAfB2AGtrdPMNUkKx+TAgeF
         ZmEIaCgqVgKmJiFS7pTlS4pebGwVXKupBVy+bCe77vNtybUtsfGnf18tDWtFl/xaiN
         KnLPvYv2LIK0Tj0dz2XHdPoxAcn1rchdHPO8Ra8gB2cRJBofvpBAhDFH/SvnkXLVw4
         m/eFObmS2ohMOdE1QO0j9OoNCg+YCQobYwzMjeOIFdMr//25N2PtYqZtIGXby8koRY
         XmwIUrCmHcExg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.189.154]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1pOifb34md-00qkAn; Tue, 01
 Nov 2022 00:30:52 +0100
Date:   Tue, 1 Nov 2022 00:30:51 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: nuvoton,npcm-fiu: Change spi-nor@0
 name to flash@0
Message-ID: <Y2Baq2gtpGVoIBJs@probook>
References: <20221031222559.199509-1-j.neuschaefer@gmx.net>
 <Y2BURsf5xKyfMn4+@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yYhPxXbmJxZLcJpQ"
Content-Disposition: inline
In-Reply-To: <Y2BURsf5xKyfMn4+@sirena.org.uk>
X-Provags-ID: V03:K1:WWR7Zc4ssSK8aKgo/jAZe4YzExcnZi0wjzmJdCstujb1AiDoe2G
 zQkc4A4mWO0ihGrS95QQEQs+wl1OWvtrfK8A0YiBUoY1jLYvYxSvKsPuO56soJQIchQZDSk
 iA4l3UuycOWFZsLnKwzN6q64ZbqgDQhkJ2u6Ecsthnyzh4nLGt5AFUS1k3rI6299bzQWsQ8
 xdlNp21AtQ/+7rbkv78og==
UI-OutboundReport: notjunk:1;M01:P0:6695kWv5LRI=;FJ9O1qSTJw53FfkUYY9HmLoLg1O
 +Fz2ysyLqXhd2rmXJAafBcWaWpM5vl6YduohLD6+mXiEgk6M/1lMIX/tPVCj8JEBCR8Cj+EIU
 bNCLm4NiFhZkRzW3/vrHYJ28B1cb7FeCKLg8ca1zS6vfqyJIlGR6nulWqryoVv3UzlH+zAcO+
 /LraYSMPOwnZ+ZRZlViHAI3LQyWM+m777otmHUCTuzunlhTZTSG1jNaS32w8gTs775/yn6+CN
 0LVeXgLqMX6SIB5YPOjtHjCDzR7nsp5W6MLl5ldzFyp44HdJazmbAM4Q1E2zieJPMyQRtm7ws
 B2wvHmsx0mp3+bwGHeIIKylUpd/ryuhJ/Z+x0zuJtFe3bhMvCQg76mtCcKvQSo/u8R3mAu46R
 q6fZ+A7GchCVR9k/KqzSJfwXOwjD7Qq5aZ5ORoAK3gzmliEIwAvfShgzgjeUKeVKsx1yRar4v
 8kpbbtxpBUZu0etYQFTELptbHTVJ+49rfJhgHbd4gnbYukHH5+HihqHJZ2ljKT1DdvjdG2FF4
 YugG0tqdaP/yDZPVPpncch6Rk6sgGaK3N7BltD00jmsdc3bfDHa+hKDWN+5JnVggHR4j/cGzT
 iunMwZNMzliCL6WaNH5b1Ax5ZxRy5O5QnQjLaKdBOF4jJteVDqZurI7/V2rJjheRgm8kEGCzn
 Pj0mCRUGmVdy9tvA2QG8lBrGfbm2LYD9w04M0t4fhrk+gxMuxHQeL5NE4MclutGjUOUKyY3gD
 VXBnkR0Wnifu02f9BEPjD9vcynQqJWTk0MAa1K3RBdMU/qlyciSp/Zz57BzSvwljdrtPlSf43
 /l9EoY+X81ATguOFS9+ahLwnFK+F5SlbsUyuPxdlY+SnzYD2OiEdpk5teZG8r1GB77X3I9pqX
 n23AdRfsikAwO5Tn0FkA9yHR+t+t+/HaWHfocT/UwUOUlE6C3bC/m5CWUK975k6lczY/TRl8j
 jbu+ccHbTbeh3KcuAYbgvbc4mOo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yYhPxXbmJxZLcJpQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 11:03:34PM +0000, Mark Brown wrote:
> On Mon, Oct 31, 2022 at 11:25:59PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > The node name for flash memories has been standardized to "flash@...".
> > Fix the example in nuvoton,npcm-fiu.txt accordingly.
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Documentation/devicetree/bindings/spi/ has a wild mix of

 - spi: <some vendor>:
 - spi: dt-bindings:
 - dt-bindings: spi:


"spi: dt-bindings:" seems to win out slightly. I'll switch it to that for v=
2.


Jonathan

--yYhPxXbmJxZLcJpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNgWogACgkQCDBEmo7z
X9vfshAAiK26wbBQbFCBucnUGZTFpx0brpsEL/LKl/3IH2xTjgIlMC/mjHwCXWS+
42hZfk/brTkVYFHR3w/OFbdAPTb5YcpRXkgsaTP3acYDFHBs6YSn/KKYb7AWRaz4
mp0HKDLU8138sZbmQnAXRf2S74prur6KvEKYynQRLn5gQJnY7pVCRrHMIdzsKXIK
pU/hjFLIobZGQtFRzvd34ObiaWzf0j2PBtJ8zPWIP3r3fmyrX3LGBt76ENX9QDjt
xeuvxfEkoQE2q0IXyb3M4uhzSHENE7C1ExXwr5WNxvKAKrLQwGj34BBIBfi3jCeo
QqBZETCja3NFEqYTWdKZY0tH9q9onZcQG6T8QQZ8pJ1ZSqV/3okQM1CNw1XS2TWi
9+cT7wg+IJG/f8789gqdYFJlemXx4uQ0E+wjEuWinptX+AqTjRJMhhXFYAy9uFA2
AnERTsD03R2vET5abhHFV9u3Oi+nlyLMhc3UF4wyEhVtIMIAplOHnPKfrkdicTgi
9my93+U2QIdCooZNzT4raEHxASBdLF7B/cc+GmiYRhouPFSY728bjBcQIrM7Mkua
ibVX8inuw+k/DsLpnqIvIhojEGi3dRn2EEXpDb04nQNPRFXfXq6FgwdyYRMYklVR
rCcMNE9wdw3G3Q99ecvy1DGDz3cYvZpiLk3hkCfcdsN9gSpoiUo=
=2Gef
-----END PGP SIGNATURE-----

--yYhPxXbmJxZLcJpQ--
