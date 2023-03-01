Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DD6A699A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCAJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCAJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:14:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F14691
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677662023; x=1709198023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MOnKZeHa2P5fMFhCHmdolm7+KsHjyAeRtEZf6JcY01s=;
  b=RqqXAU/5bM44pn0HECX6aE5uDV87qgZ2bJKpgMouXqDhiW9i5ZPWrzCU
   484G6itrxfsTGalDBh/2FIVdjDbJsRqxnAN/hdniZZWuGMu+HzEzqrh0Q
   oMBfFYg1GMXRV0AJHzRRrqx1WlxPU7n3MWBZ93yr9GucC9FLFZ3/VFCo2
   pL6khlw7fZTS+/KZreYmjNY4ZiVi72dMw9ms5z788DLxJEtveTrJ18MJZ
   zU/5SVnd5Tzw3hTmKzWeyRC0/dEo9nCQNhtZCKe1s9Uz2eFttd7DFZP2B
   u+JsAf0j5uDHwakD+UvFPxRtzKrPWkdguM4Vt3I7uxYO3Mc7ub/LmFHXg
   w==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="asc'?scan'208";a="199305289"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 02:13:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 02:13:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 1 Mar 2023 02:13:03 -0700
Date:   Wed, 1 Mar 2023 09:12:36 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] .mailmap: Add Alexandre Ghiti personal email address
Message-ID: <Y/8XBEOSsMD7r+bw@wendy>
References: <20230301090132.280475-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9KhjAIgsnEjzZ9TK"
Content-Disposition: inline
In-Reply-To: <20230301090132.280475-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9KhjAIgsnEjzZ9TK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

+CC Andrew, I think it is he that picks most things up for .mailmap.

On Wed, Mar 01, 2023 at 10:01:32AM +0100, Alexandre Ghiti wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
>=20
> I'm no longer employed by Canonical which results in email bouncing so
> add an entry to my personal email address.
>=20
> Reported-by: Conor Dooley <conor@kernel.org>

Could this be converted to, on application, to:
Reported-by: Conor Dooley <conor.dooley@microchip.com>
That'll make the corporate overlords happy :)

Thanks Alex, hopefully one less set of those irritating bounce emails in
my inbox!

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.mailmap b/.mailmap
> index 318e63f338b1..9a1050fac1a1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -26,6 +26,7 @@ Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
>  Alexander Lobakin <alobakin@pm.me> <alobakin@marvell.com>
>  Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>
>  Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@fre=
e-electrons.com>
> +Alexandre Ghiti <alex@ghiti.fr> <alexandre.ghiti@canonical.com>
>  Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
>  Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
>  Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
> --=20
> 2.37.2
>=20
>=20

--9KhjAIgsnEjzZ9TK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/8W6wAKCRB4tDGHoIJi
0gSkAP9AI3FBXe/sVCMCDjAXlfsZtZJkFsB/gqg0qtnR3dTCAQEAmXMVfU0BS4O5
EH/5fHHrz0dDDcTHaavHSWP1M+/Gwwo=
=aQA+
-----END PGP SIGNATURE-----

--9KhjAIgsnEjzZ9TK--
