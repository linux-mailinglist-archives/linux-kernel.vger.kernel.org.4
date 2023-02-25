Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4E6A282C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBYJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBYJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:17:28 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2911ACD0;
        Sat, 25 Feb 2023 01:17:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9FC391C0AB2; Sat, 25 Feb 2023 10:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1677316646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVomgrlVcKbKHqY20EcIxvF06UgcWi8Fb+JC0ZMX+tw=;
        b=NKv+VYp6JDa26eqRY+etKicKhm6nejkDfTvC2t8WqUzc43WFqjvixbLmXGqQ5rJOb3wWM0
        QZg8aDYqIROEwIn7am3YECA70x1odRz7e/ew126Ft2iy7cw/DoqHQSaNpEhpXSlYE8QQ0m
        AGRxfKAtHcQusiL8yMwUq6KdCa/cc34=
Date:   Sat, 25 Feb 2023 10:17:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <Y/nSJvm6h4Sq5PR2@duo.ucw.cz>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wUWUakVz7YN0DDf8"
Content-Disposition: inline
In-Reply-To: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wUWUakVz7YN0DDf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +If your platform uses techniques like Secure Boot, prepare the system to=
 permit
> +starting self-compiled Linux kernels; install compilers and everything e=
lse
> +needed for building Linux; make sure to have 15 Gigabyte free space in y=
our home
> +directory. Now run the following commands to download the sources of Lin=
ux,
> +which you then use to configure, build and install your own
> kernel::

15GB is quite a lot. Maybe the shallow clone should be given another
chance?

> +       mkdir ~/linux/ ~/linux/sources ~/linux/build
> +       git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git \
> +         ~/linux/sources
> +       cd ~/linux/sources/
> +       # hint: if you don't want to build any stable or longterm kernels=
, skip the
> +       #   next two commands
> +       git remote add linux-stable \
> +         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> +       git fetch --all
> +       # hint: if you want to apply patches, do it at this point (see be=
low for details)
> +       # hint: at this point it's recommended to tag your build (see bel=
ow for details)
> +       yes "" | make O=3D~/linux/build/ localmodconfig
> +       # hint: at this point you might want or have to adjust the build =
configuration
> +       #  (see below for details)
> +       # note: if you are running a Debian kernel, you'll have to adjust=
 the configuration
> +       #  at this point (see below)
> +       make -j $(nproc --all) O=3D~/linux/build/

Is the complexity of using O=3D worth it for one-off kernel builds?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--wUWUakVz7YN0DDf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/nSJgAKCRAw5/Bqldv6
8goeAJ9kvJcd1ci6ELgtSrXqqRap8FoLIACggBWRqzdN8Nl8uG0DVJDsTc5V85o=
=OjwI
-----END PGP SIGNATURE-----

--wUWUakVz7YN0DDf8--
