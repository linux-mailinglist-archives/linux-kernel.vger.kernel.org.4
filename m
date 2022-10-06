Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A85F6339
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiJFJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiJFJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:04:24 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8261B39
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:04:22 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6A3E71C0017; Thu,  6 Oct 2022 11:04:20 +0200 (CEST)
Date:   Thu, 6 Oct 2022 11:04:18 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Message-ID: <20221006090418.GA14960@amd>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-09-28 20:24:23, Luck, Tony wrote:
> > So let's revamp the idea of having another option/mode for the split
> > lock detector, which is hereby called "seq" (based on the original
> > "sequential" naming in [0]). Also introduces a Kconfig option to give
> > the option of Linux vendors have a choice what mode should be their
> > default. While at it, fix/improve the documentation about bus locking.
> >
> > [1] https://github.com/doitsujin/dxvk/issues/2938
>=20
> Why not just use the workaround suggested in that bug report:
>=20
>    "so manual switching from default setting to split_lock_detect=3Doff h=
elps as workaround here"
>=20
> If you add this extra mode, I'm going to argue that the kernel default
> should be "seq" rather than "warn". So these game players will need
> to add a split_lock_detect=3Doff (or warn) option.

Kernel should not cause userland regressions, and this is one. That
should make it pretty clear what the solution is.

And no, I don't like CONFIG option, either.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmM+mhIACgkQMOfwapXb+vKLhACdH4DxQqgPIBpJlefnoth8wjtT
uoIAmgONAilNmvaXGsTx6qaCB//qGcY/
=r8Et
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
