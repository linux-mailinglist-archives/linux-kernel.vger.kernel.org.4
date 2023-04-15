Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9336E2E51
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 03:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDOBxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 21:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:53:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA549FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681523558; i=j.neuschaefer@gmx.net;
        bh=VPWEigCp7vzQZd7CKWpOuVBagfWMUqURjCMHGWXXDCs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=P4i025P9TU3c3UlxEZvweOE6U8C+4rXpBIJrwOjL8yPydAI7NNBGyHDppK+bOL1kb
         tMgBDATAwZfU15u7Rsy6+w7OA84Bxd2GREjdSIRbBa6MpCCikl7lZKRBn8Q3NBlwws
         OApLl7WrBRwHD30eSpc/paC4EurQLfjoDBGLjXb8idKVE4+Ef85HBtB5RAeyvOzcHE
         uuS9tEe/II2/bcaauCNtETlNdZ/qnfAqCD2RY2kPbass6W7QmnHN6pb9HYKXkCfwZZ
         C8HtMGkHNnnG18/OgcG0mC8KVfeNAnl2RabMG7wh+DBpLCfw5x4IXEi8qpE32QCNJT
         Y/AkoHs6k+JrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([81.173.153.53]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1qLTGT0pW3-00dZ5e; Sat, 15
 Apr 2023 03:52:38 +0200
Date:   Sat, 15 Apr 2023 03:52:34 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 1/3] ARM: compressed: Pass the actual output length to
 the decompressor
Message-ID: <ZDoDYh01GYjdwp63@probook>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <20230412212126.3966502-2-j.neuschaefer@gmx.net>
 <20230413052050.GB9837@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dLt/khkji09eQ9Ix"
Content-Disposition: inline
In-Reply-To: <20230413052050.GB9837@atomide.com>
X-Provags-ID: V03:K1:dBIRB48REk7T6R85Mr+o/FFvtnm2aGOmdT6CjRgjOEsM5OJWhc9
 2DeGjUPBqNTaCn9XAFHsNiXviclx3afb3XAIeknIht5vGY3jo5YczvdGujenGchSq6l3MAh
 YsuELVJQ0p8dTarVpTY5YET94dx7mAj4Fo0tD9M0wvqBp+14jOkNwqehs0VvORPbU9tRAoe
 9dDITolaRx2MwdwGjniIQ==
UI-OutboundReport: notjunk:1;M01:P0:yZpYo+eQceU=;M5XHc/LUGQ6c1ksvaPAuZn9dbaI
 HO1Gg1jlP3iPw2Wyuw6tq4mvScfDpeCoj1Gu4nDuzPxhSZCSDgSJXW+dHLy2BLlItfCJXWnxZ
 97QD57HAKAgwQLt5J7YjHjowIW1ziUHfZ1PWit2PyUBVnqvzR4e9qn/NKNiBB11uQ6KtVRgC2
 wcebsHQQPmZxQRNhiy0DIB+6+OKF59Jw8szkjeoAJCr0/Cw7O6mbN0FWCDuz8cLXZpJPGgycC
 i7w+qlBYv6bjbCuwS5wosAG1URDK73kZm06lDrLLAKq29tU8o7+6KpUlivTbnhyC+wcsJScIt
 KQ7G3NBY459s9x6KBEj0XysdDNaTGZ2eQeHDSR3HIdY/1rilmpBbINoJh6przkYyHWe1wOYft
 0eGMSqJI4iM1fgb1n19Gu+Fp+/l8wN7EqL/4x0P0TIs9eBS9kCiEJKP6ETs8nvVPxrqN99ox3
 vcW75fxEGOWpkbzXFF3l1dbtfdVJqAssyGsJO1Tloi7Kzu5CZ4GMnYW5Q4asWsKgiof9hvj4P
 ZQQd/7J82niQy+mm5DhVFsJ1v2fzhQJ8JAh7H11XyhVyThOq0GZ35c5IFhj9qKiTe4ZjhvRAS
 nsqQ+szJkxiK8c8c0CiYONy8E1sc6fRBcNFqDM8QnWABumOIXes5uAOvmgsrduGfl0zg9dJHO
 6yBiny98//Xn8ICzQ4RNbnYUEnQD/G9lmdEbMP8b53tsIonuOdHKtdnAXYO/G+rwbOVFG8I5r
 rM2nSjaBGjDx/cMRPv6HkVD7ollof79+3a82huHavMNlQuW6C90hJHWmMyV4Z9xBl9keVlBmn
 Gz1k5l3d6eVuyw3DbYDl2S4ymCkA1CKvWDoSucXVQOkpsYsjNSj4yzk8MgOuPlWHMwcHitowT
 07yUKq3phHGiT53D7JMKoKd1LLe3PepVHw2/jXjGHxic/4/NCQv2SsCp5dONVb9CIG0OLTUTY
 yXo56fSj16QEIvQu5bx930Ti6xY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dLt/khkji09eQ9Ix
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 08:20:50AM +0300, Tony Lindgren wrote:
> * Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> [230412 21:22]:
> > --- a/arch/arm/boot/compressed/misc.c
> > +++ b/arch/arm/boot/compressed/misc.c
> > +static u32 get_inflated_image_size(void)
> > +{
> > +	return get_unaligned_le32(input_data_end - 4);
> > +}
>=20
> Just something to check.. This patch should not picked for the old stable
> kernels that did not have the uncompressed image size at the end. Maybe
> the patch should have a Depends-on tag to prevent possible issues?

As far as I can see, the appended size has been around for a really long
time (v2.6.28, commit bc22c17e12c130dc929218a95aa347e0f3fd05dc), far
longer than the oldest LTS kernel that's still around.

>=20
> Other than that looks good to me:
>=20
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Thanks

Jonathan

--dLt/khkji09eQ9Ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQ6A0AACgkQCDBEmo7z
X9vtpxAAjWUuKQgQzvqF71IztmOzNwe0TWSbAQezw+JOGX3+NtpmJQSYa3SG6RFw
tUaGPRtg4EXPN6+SCaBJzNvIDt8+7S5e+A1PP+wHo/eoWcp0U0r36ApNUgtBORLq
CqtU36X+QdQSB3Op9WFzhWmKTu3IiIrAztaAyV2I0PmI6rfNGe65SiJsLSx+p1/v
x/guzjSqWtkrErxU6otskmZ7IwQtnxkDD6qY54ESIXc2qgI3cc8/Wo5jt4c/iYZm
Bq8jGCi5acFMeY+A0zHHwNPzOutuCakeaP/Jgfq8FV3XvRoa6Znpda2wtMkZRQsm
5DuA0NFDxFoZXSa367/ET763u4w7pOQ10JhI/kBVtiu6YHQCRlSf1yNadR/iRGrW
eaO91EzM5S8X3TiQ0h4UGZyfugzenAMDk+sZV4rlZwa0axzuRTY2IaDqI8Gn9vWF
0XoPBcytx1bYPsoioBBQXmOCXfdkzNAZwEZ2QLtfPpzUZYOzNSrp39NqP+A6iaQE
Ul0w8CgwJJzjG3YTPh5fZNWrUnAw/4k43/j+Y7ttWZQ4qS3Yn/g+g0MqA6ECNMdg
sA5IMEy6KEyJ6ot3bB7SyWj+LlUfhVeP7YTSpN5vAh1YH5G0+4PW51WoNbOnU91o
8T5dXnWzeHWRY53kPfxWrn9zGw7uKJb/tDjmWznLNFi148xwoLc=
=VVLD
-----END PGP SIGNATURE-----

--dLt/khkji09eQ9Ix--
