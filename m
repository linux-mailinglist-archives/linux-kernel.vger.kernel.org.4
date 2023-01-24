Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A3678D63
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjAXBZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXBZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:25:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041B359F;
        Mon, 23 Jan 2023 17:25:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P18Rp2jxXz4y0R;
        Tue, 24 Jan 2023 12:25:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674523543;
        bh=5q3NJPCSg2jvR3DLK90Z0GSVnjuOIa0rURCcBO2ndRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cee4h/WFljPM92sHsydZcM9VchsUZ+UT6cKxDq+S5HllkAfzTLs1JhSdXgYob7+I/
         dipjwYB+RA8n/ONeQ3urfdweIu7uSGZm4syrU44xOJzFL2j04nmhjIksJFdORy6af7
         mEOem4Rb+im6snAp5EfckqQWmtKKkwto6n6ysC3967k3CnTAg7uL4TG/j5PjlUvZpR
         S3PA11xq8PPc0RpLgp6oYsL8JcS5asQb/WIQG9T9SdJqA4t8OXlowz7950DmZgnH5g
         KDcm0DWCVIuBtzK+6zvJj+LFyaPpgplRMgPe+qVqPNsMPLocvpDcIfHazWyvrwYoAo
         6M2SNvym6yVJg==
Date:   Tue, 24 Jan 2023 12:25:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the gpio-brgl-fixes
 tree
Message-ID: <20230124122541.0e310a1f@canb.auug.org.au>
In-Reply-To: <AM6PR08MB43769CCE04DA7C624CA3028AFFC99@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <AM6PR08MB43769CCE04DA7C624CA3028AFFC99@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+odWJyEaQpCa._98RQ/GoKc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+odWJyEaQpCa._98RQ/GoKc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Pierluigi,

On Tue, 24 Jan 2023 00:51:48 +0000 Pierluigi Passaro <pierluigi.p@variscite=
.com> wrote:
>
> On 1/23/23 21:56, Stephen Rothwell wrote:
> >
> > After merging the gpio-brgl-fixes tree, today's linux-next build (power=
pc
> > ppc64_defconfig) failed like this:
> >
> > In file included from include/linux/of_gpio.h:14,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/net/phy/mdio_bus.c:27:
> > include/linux/gpio/driver.h:782:68: error: parameter 4 ('lflags') has i=
ncomplete type
> > =C2=A0 782 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum gpio_lookup_=
flags lflags,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > include/linux/gpio/driver.h:779:33: error: function declaration isn't a=
 prototype [-Werror=3Dstrict-prototypes]
> > =C2=A0 779 | static inline struct gpio_desc *gpiochip_request_own_desc(=
struct gpio_chip *gc,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> >
> > Caused by commit
> >
> > =C2=A0 de5f701724ac ("gpiolib: fix linker errors when GPIOLIB is disabl=
ed")
> >
> > I have used the gpio-brgl-fixes tree from next-20210123 for today.
>
> please provide detailed build instructions.
> Building with
> - commit id de5f701724ac
> - defconfig arch/powerpc/configs/ppc64_defconfig
> - powerpc64-linux-gnu-gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
> The build fails almost immediately as follow
> arch/powerpc/kernel/trace/ftrace.c:839:7: error: no previous prototype fo=
r =E2=80=98arch_ftrace_match_adjust=E2=80=99 [-Werror=3Dmissing-prototypes]
>   839 | char *arch_ftrace_match_adjust(char *str, const char *search)
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~
> However, the same happens rolling back de5f701724ac.

What I actually built to get the above error was what is now the
pending-fixes branch in
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git but
with the gpio-brgl-fixes tree
(git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git branch
gpio/for-current (commit de5f701724ac1) merged in.

but after removing that commit (and its parent), what I built was commit
  83784b157e44 ("Merge branch 'riscv-soc-fixes' of git://git.kernel.org/pub=
/scm/linux/kernel/git/conor/linux.git")
(which is in the pending-fixes branch above) which did not fail.

gcc (Debian 12.2.0-10) 12.2.0

enum gpio_lookup_flags is defined in include/linux/gpio/machine.h which
is not directly included by include/linux/gpio/driver.h or
drivers/net/phy/mdio_bus.c.
--=20
Cheers,
Stephen Rothwell

--Sig_/+odWJyEaQpCa._98RQ/GoKc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPM5UACgkQAVBC80lX
0GzPSgf/bjdk5Cb73Jf/qZyr4xnwN/2zsstv/vkk4wjZTBaJjnaaJLpzFsIGazH/
FWPWBaFYGxKzSxRH79yWJ9dpwSKeVlphAVPSEyTnq0npD881O3grzc5eTyifdA8u
QjsnAy1Z/q6mutPW3Xs8WQ5ZO2C2BJADH/NDd1L5wf3F9Xiia2EllkCdFL417pyB
MXknBzhNH/+MN2TLedXN1n7jzMP9U6en+l+97ep1yadqixMl/GKFgJyYmqoW/7P2
z7JIyhh6/PseolhP1mDTR1VznrEHdp1PgyR0oVT7GKUfoqyBjN9B2cMWRQJMJJ3x
ExUSu5yAvqzFJLYNVHcrDg14EioDXA==
=kiYT
-----END PGP SIGNATURE-----

--Sig_/+odWJyEaQpCa._98RQ/GoKc--
