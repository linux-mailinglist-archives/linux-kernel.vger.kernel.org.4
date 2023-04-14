Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E036E2C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNWus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDNWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:50:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1865AE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681512605; i=j.neuschaefer@gmx.net;
        bh=k+3jRXgTPReCyEux1QLX+EwAdB1mjZaxnQ1uRzHgPFI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X01eZ2kN0JO0HRnXg4+I0Wr6UXiaIiJCpxPjEWK9/XUGw6uULvknLRLS7aTrtuxkt
         KHLUkxLa+jCcQ6ZbHhjTANNQYxVpcVCtxv8/4itnEzY5GapSWRHwsP9j85HAb4vS68
         lXSFtjTJ4rJQL/62pxs1GkCDrPgPj9F2OLzh9tnXPT5KeKQ54gj+7DibrJU4ZVqyIW
         6xEzfAXqobSGkIOWg93S/waySFQ9L43kwa+rvJE0Qpgk/zSC/fPTXzWPal90bVDmIi
         idm/xGf9+EZrG9iHHb52yw+M69qZ9ZMoZigIBFInuLiK2xfDUgvHyt4xfRpWw1BSGW
         03aY1xeeO8p7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([81.173.153.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1q9KfN1rn6-00mb6t; Sat, 15
 Apr 2023 00:50:05 +0200
Date:   Sat, 15 Apr 2023 00:50:01 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM ZSTD boot compression
Message-ID: <ZDnYme3w3T6310MJ@probook>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MtWVWVRQEu4Rfh5n"
Content-Disposition: inline
In-Reply-To: <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
X-Provags-ID: V03:K1:xLfVlD/834yQTbAOhcp5UzTaDMq2eblUtqHE3GZhirAmi6rCdvU
 5d8mh4wpvxTUOdrlxWfLc3YlUb1dJ/rdfpgH7Q6lsSQ2fN46VESmFefk3xH56dCL4h7/hyH
 k2knN8Xs3DeGssmQSTWjKtq4tyhgHsQKY3f/F6FtUt+/cJcsJ/XbDLggqvfR6tjGLei/+vc
 t3ZMtZvX49wKI6VDHU/Yw==
UI-OutboundReport: notjunk:1;M01:P0:OZGBpJrhXkA=;f6OJMBJN7WZsK9Ml5X03Jg+VehM
 JLoboQBuiz55Wr58aKenioPaEs4WRm2SSlrljAxU4CZj6ckSraoE0rqQMZhEz/IeaPRijPaDo
 LTooHuqN2gBlNfE0uai5XVaA2U5DlmnwXYBqHqCngkFWB18U4/IrpUEqhQvDd11MmrYeazyzi
 TxeR/u/pcxpTYd7qNUeYp5xYbPxXSVcQIXV5gkgk3BRBdhu/RqjR4dzRKgUqp4jcdWXwCdBhr
 52FCPgnOdZT9fo5qJwx0/MbSm9+P8jInuc9sU8xDd7YtU0cl4y7wkiQKHkrAc/c6We/Gqk0hk
 M96mmHY/5Qn+e6Qkm3PE+eGEKEcH4JAYGT0XdK74NgOLdv/uhq5j27Y6fJCzOKOm2ujHmy764
 lWKr0Xm/Q9H22JNf78mGQIF4VIWlBDnYmpw4fQCP1v8LMfWb1RqZxNzl+cenHdWSwex+UrLu3
 w3mMV/4r3wGM0Cf0mXlsnM8dv0zE4Im1+8FLdB5FTPjs5VFOf7dQHatGAVT5mWFRWnRUJTy8j
 piyZk13vjzO/+xNNEE0viWGmB0nVZuAQq0XsrXS04oFB+gA+f0YKXP7mmfipzouCnWHUgrzpn
 r9CPCJNS9JudxwgdUiLMp7NhhJB5na2gnpEg/SJFbpW++sX5lyO8NNKsZK9OPl4OEtYoL2xhz
 uUV9FYWe9j2tw4yXPYdYSGar0XJXEjCvdylY9K/RBty0WAv22IKPBxJNQ31LlW+wYkoTBtLkN
 OTbYJihxa7PCRDPNKLZkTEsHKumy/balRmks8TLMtvbz13YCQs4mzsJtKHoG1BA8LEwN5QfZJ
 cZulOAcsgVBxpIydfagxH0kS3CAxL/9shurubBfnTBnALqtls4Q5wErUIide96cCAeqgZz/nA
 3xD6h3wmLZfiEt7a8FchT5Nie+634vmvlGaIF/sCV0Kkaw8RHdaCQutjnGV0bZMf8sQpYdvpx
 ckDj2ml07go2Jx9TUlylS1k9I+c=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MtWVWVRQEu4Rfh5n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 11:33:15PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 12, 2023, at 23:21, Jonathan Neusch=C3=A4fer wrote:
> > This patchset enables ZSTD kernel (de)compression on 32-bit ARM.
> > Unfortunately, it is much slower than I hoped (tested on ARM926EJ-S):
> >
> >  - LZO:  7.2 MiB,  6 seconds
> >  - ZSTD: 5.6 MiB, 60 seconds
>=20
> That seems unexpected, as the usual numbers say it's about 25%
> slower than LZO. Do you have an idea why it is so much slower
> here?

No clear idea.

I guess it might be related to caching or unaligned memory accesses
somehow.

I suspected CONFIG_CPU_DCACHE_WRITETHROUGH, which was enabled, but
disabling it didn't improve performance.

> How long does it take to decompress the generated arch/arm/boot/Image
> file in user space on the same hardware using lzop and zstd?


Unfortunately, the unzstd userspace tool requires a buffer of of 128 MiB
(the window size), which is too big for my usual devboard (which has about
100 MiB available). I'd have to test on a different board.


Jonathan

---
# uname -a
Linux buildroot 6.3.0-rc6-00020-g023058d50f2f #1212 PREEMPT Fri Apr 14 20:5=
8:21 CEST 2023 armv5tejl GNU/Linux

# ls -lh
total 13M
-rw-r--r--    1 root     root        7.5M Jan  1 00:07 piggy.lzo
-rw-r--r--    1 root     root        5.8M Jan  1 00:07 piggy.zstd

# time lzop -d piggy.lzo -c > /dev/null
lzop: piggy.lzo: warning: ignoring trailing garbage in lzop file
Command exited with non-zero status 2
real    0m 3.38s
user    0m 3.20s
sys     0m 0.18s

# time unzstd piggy.zstd -c > /dev/null
[  858.270000] __vm_enough_memory: pid: 114, comm: unzstd, not enough memor=
y for the allocation
piggy.zstd : Decoding error (36) : Allocation error : not enough memory
Command exited with non-zero status 1
real    0m 0.03s
user    0m 0.01s
sys     0m 0.03s

--MtWVWVRQEu4Rfh5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQ52HkACgkQCDBEmo7z
X9uhehAA0tS+qeGWot/dj4Bon39HGWPXOsaSNuEazuHoluXDu5OmH3WAZoIYV7RM
Y0CUKLfUYKOuXuleFL4uFI6FaCJsKhtnbsLxbpFXm231Nizt86OOXX2rfZ+R1gqy
5GJit+f2spT8mD2gQ6Sj2bXIs/30CWRUq3aBnOEP/XsZvJvrQewP7ZcYBfJDev33
Vez7qiTrtFhBwJx9fUWGs1ptpoAZXZxKp2u50fdtr0FXRCijEa1EN09Mx2Mmq641
jmNTt1ZsamsbSb98MXfW3stmMoA/EUi5f7HHyZus17mk+SqXXYT8XDi8TNfX/DHP
VogG4EaHF1/yEBkVaMVThZWEDN78DrzNZjEgTmj0BMcCvaXw1INiYX9edYXlMmN1
Hmn7RuhdB7PqzmDrUFhRTkemfmZJF939WZI9NRSdNKpMcwcN0iD/3K4J15ciA2V/
+39SRWSl0a80A8WJivKFcmdCcZiJmlPZiCsQ//20rUauSbfYNlDFMvf6TGfH1uUf
zggrPD7XnjZY3MXX8u+XKPCMi3PoBrP/jfRpEfvHsC0vLhuT+hiHLAN8ADoVr6hA
ISgtMZK2Uc4jYlZcqgm+mSP/UuquNhbciPxKXcLrjP8NSfjfD7eQbalt5hykBdya
rWUdUT3hipPvbXj6EUf4vXpN1XLLg1UxF+S/Eh2lN8p9UcwKUsA=
=sfDd
-----END PGP SIGNATURE-----

--MtWVWVRQEu4Rfh5n--
