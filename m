Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812C61E2B9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKFOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKFOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:50:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1551DA6;
        Sun,  6 Nov 2022 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667746186; bh=ECV+FbP67f13YOWH9y/B96gfaAMWtHMN4kiwg6xe/ew=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Wm8ErbfmDYMYL47J70Vold6InuuMsMDRJlB3C376PAISlSpxry1odeOX5tKlrj7OG
         OFOmpADRZ9A8s7ItjUx0VBJYrQLXHJMQCAJ7v2Zc1CDeFI4+PHr3tqGJeejd387q1q
         NbCwn8e3x5LEoaj8LX86g1MhmRpqxPZ0X+AqP/sTygeEXtT0vRBwVBcrys0dEdD4XA
         65zG/sqagDSWAN8zS8Z1Et9CBAHHdgc9Qa34NrWYaZfKuuA+G7SI2Xu/9mgQK3wtV+
         TrPkGJnfzC3CFWXRR9Bk64qkR9Y0HMGwauL/3RNIGLpWNYBxnxsac2TuB9P+6WMugY
         /Ryi2pTPa6T5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1ocWR32bFn-00O363; Sun, 06
 Nov 2022 15:49:46 +0100
Date:   Sun, 6 Nov 2022 15:49:43 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 8/8] spi: wpcm-fiu: Add direct map support
Message-ID: <Y2fJhzeXQgG5DS1U@probook>
References: <20221105185911.1547847-9-j.neuschaefer@gmx.net>
 <202211060513.HAfQX0DY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjGtmQLcgVoAQZIl"
Content-Disposition: inline
In-Reply-To: <202211060513.HAfQX0DY-lkp@intel.com>
X-Provags-ID: V03:K1:sJ2SqQ6RGeuHWMwFP7t5iXt67gyTZyOmJJqF6LgTdZCth2Pkfvp
 mO5tZHRmO3dVr6RNgK0TL0weozaLrCOk4TTP+5r3AcqUUNKyxvQhPyDvmLLOQf2NQ+7uNGV
 H40KE0ujNuJL6Kt646+lmbXu4h/p6HUdqD+Ig5/i6sjKvEpaUsklXoGEBLnzyTLfazIw3Yi
 wNOrIa36Rw1huGNQSwjtg==
UI-OutboundReport: notjunk:1;M01:P0:WSxHhovQB+0=;pq1/NUCX5J84EDsRYejbVfZlgFf
 Vt9dBCEY6KELW0DhkrVBwh7UtAY1VQBY5SUbwpbzAVgax+jTcT+uRyBfbxp8a4rz6yd10ozw7
 zpZAnY6as+CBd8z38VteSc9C0LMjxYqyl2jXJSeM55S+rJdCzL0DzPajdc/Sde3yi0TqOtP/+
 hVoahS8WYzqkT7XqGXRT4ydjwXKMqHAle6HWQjgA6mzyc2fFTgCxobvWSciDit51Fn0ZNYeuf
 AfB7/SLBOX0dmNPGy2VHGsZfYPczjAY1di1ZI9gWvSf5hzTjr050OighHTR6D3S70xK3NtzLU
 wjkK2IXiyZW75kzpmytNUE06whU/dl/2vVXWvgUK7ycaHpL+M7lqnF8/SHZMXmM5A31JcVJj5
 QV4NstcxBs1yZ2+ztgQmrfMc/gf3zg66+TVwCpRjyZPPpgI84YtV+eCHnxcKfkm0AooKDCLvQ
 Ed5/R3lbDYBBXSqLqhlxwzlT2m9ujfC3pE93zwbRRkNa4rQJSgy4shu6+YLpDWYOSqbfrSXc5
 eYZ8AcKwLhTtaAd3J3GYYRuzgTtAuIVeKwX3MUJuSzF/n6PEPvVNxaAS3sx2327ZN4hR3erde
 hpONkpWsIhPfDr/mNBi8WoHBGk2F5TOCsxcYq4jihPz7iBkc5lSD1YuCOsLNWTKbt6rfiksUV
 QTISCgItLAySJpIQ9i8U3SnXNkji1w3TuCNYC3j77JrcE6WV4mwfSMHI27nDqVECySAFOKwej
 VvgPGVBSS9DgsHNvDM9aSwDrY1tmgv6Ev45GZ50j2sDiftdHxVKmi8uGSeh9Bf1ys+Ojbc9Vt
 QACe7AzyiIlQYckywrDGUDa+Zl7FCrWV19EmpH1uY9GL0Ya4s8d1p9sfePfENt2R5bklT8I3a
 nuZ+aVs+UHNDgsmImIab0/bvQr7BdkeeTSWnVrBl3nSCcCgvDUNwX5Ahjp5wB37nlMgIqfm/m
 beuTJg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjGtmQLcgVoAQZIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 06, 2022 at 05:35:24AM +0800, kernel test robot wrote:
> >> drivers/spi/spi-wpcm-fiu.c:424:24: error: initialization of 'ssize_t (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  void *)' {aka 'long int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  void *)'} from incompatible pointer type 'int (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  void *)' {aka 'int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  void *)'} [-Werror=incompatible-pointer-types]
>      424 |         .dirmap_read = wpcm_fiu_direct_read,
>          |                        ^~~~~~~~~~~~~~~~~~~~
>    drivers/spi/spi-wpcm-fiu.c:424:24: note: (near initialization for 'wpcm_fiu_mem_ops.dirmap_read')
>    cc1: some warnings being treated as errors

Indeed. I'll fix it.

--pjGtmQLcgVoAQZIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNnyYcACgkQCDBEmo7z
X9v61w/+Io1ta7R0TS2m7Vkejmdcl6DZSvXI2z5VpV9J4y3LaDAzvKnb2FGVIcX3
czQ76JDo26wMKTHFxb+PoV/BDss+5c9oPMHmb1AnGMDX/348gPnbDtrASxMnCWkr
pkLpenYQG+EotLl0LRQH5HPCROwKx7sLqDdmcO55GyYLRVv8JIZ4zzdEangBHjph
td4oRWimW/FD3ADtYMu4iGNJGVG4rwwpo6BGGUmJFYLv2OWauk65ByH0x1Iv42cm
23JFPtu8IUctqI91HULI1sJGrHIzGMOX54iJmcRyNJc7U5w6YFaNRxDJ5HbToywe
GOE3t53pw99xuNMC/VzMyUL4dCjqpoxT0GYQFxp4bIRgSKXGeNMG8QZGlZYKNAsH
9m2QW6IwGaUWP8cCzeoaTxv1yOEYNsEO2KR6wQsLNl9Y/oNUfKxlArGvFjN0phx8
SKIm91KyCU9UI/bcdHWYx05fIba/BgMIldPbwasp/2DKF4j7nCe5O89uB1Uh6OZy
a3VXTcu+FKqQMk5iekUgEGAud6vgEkcfNfyGNxSQbt/LYXNKZXnimWQgaOp7mesR
lm14A3Ic0cJX4GHmH12y8YZmGp31y4i+KVoqDrcFF9TPMtkTnKcSfe8vVewDFh3B
4Jefen+bjYZpy02U92Z0h9kh8iqEkj+crx+wtHJKHIopJzV0gBk=
=+33i
-----END PGP SIGNATURE-----

--pjGtmQLcgVoAQZIl--
