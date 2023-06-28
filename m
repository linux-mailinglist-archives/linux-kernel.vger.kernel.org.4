Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87D74129A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjF1Nfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:35:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42810 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjF1NfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:35:00 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8EDEA1C0E58; Wed, 28 Jun 2023 15:34:58 +0200 (CEST)
Date:   Wed, 28 Jun 2023 15:34:57 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Known bad patches from AUTOSEL was Re: [PATCH 4.14 00/26]
 4.14.320-rc1 review
Message-ID: <ZJw3Ac6ZLtak8PjV@duo.ucw.cz>
References: <20230626180733.699092073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ASWqmMnETCiKMym9"
Content-Disposition: inline
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ASWqmMnETCiKMym9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Yeah, so this one is known bad, and I pointed that out before. Why is
it in stable now? (*) You can't return int from function returning void.

> Helge Deller <deller@gmx.de>
>     fbdev: imsttfb: Release framebuffer and dealloc cmap on error path

These don't belong to stable, either. Explantions went out as replies
to them.

> Marc Zyngier <maz@kernel.org>
>     arm64: Add missing Set/Way CMO encodings
> Osama Muhammad <osmtendev@gmail.com>
>     nfcsim.c: Fix error checking for debugfs_create_dir

Best regards,
								Pavel

(*) I even searched the archives to make sure my message went out. It
seems it did. https://www.spinics.net/lists/stable/msg660667.html
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ASWqmMnETCiKMym9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZJw3AQAKCRAw5/Bqldv6
8tEoAKDB7pdH9p9gcMRPorFGK+hhQ2PXiQCdGb/YlJ+zj3wgbyYevi3kwYfT89Y=
=vKhr
-----END PGP SIGNATURE-----

--ASWqmMnETCiKMym9--
