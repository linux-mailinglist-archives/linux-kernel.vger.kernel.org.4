Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427C70DBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbjEWLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjEWLrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:47:47 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B4FE;
        Tue, 23 May 2023 04:47:44 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 604CC1C0AB3; Tue, 23 May 2023 13:47:42 +0200 (CEST)
Date:   Tue, 23 May 2023 13:47:41 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jorge.lopez2@hp.com, hdegoede@redhat.com, Lyndon.Li@amd.com,
        hadess@hadess.net
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
Message-ID: <ZGyn3Z4SXKzD9Dg7@duo.ucw.cz>
References: <20230522190405.880733338@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C6hq0D3PCQvxfLve"
Content-Disposition: inline
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C6hq0D3PCQvxfLve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Mon 2023-05-22 20:05:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Jorge Lopez <jorge.lopez2@hp.com>
>     platform/x86: Move existing HP drivers to a new hp subdir

This moves multiple files, and even the remaining fixups are over 200
lines. It is not suitable for stable.

> Hans de Goede <hdegoede@redhat.com>
>     ACPI: video: Remove desktops without backlight DMI quirks

As far as I can see, this is only cleanup in 6.1, and we don't really
need it in stable?

> lyndonli <Lyndon.Li@amd.com>
>     drm/amdgpu: Fix sdma v4 sw fini error

Could someone double check this? Changelog does not explain that 4.2.0
hardware no long needs special handling.

> Bastien Nocera <hadess@hadess.net>
>     HID: logitech-hidpp: Reconcile USB and Unifying serials
> Bastien Nocera <hadess@hadess.net>
>     HID: logitech-hidpp: Don't use the USB serial for USB devices

I see this changes serial numbers for users. Is it good idea for
stable?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C6hq0D3PCQvxfLve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGyn3QAKCRAw5/Bqldv6
8pZZAJ4rrnZm4CTC54LlESgBoVYrF39XcACeOU279kOMcGjStX1ho/IbswZylEc=
=ZKid
-----END PGP SIGNATURE-----

--C6hq0D3PCQvxfLve--
