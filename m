Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96121628AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiKNVCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbiKNVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:02:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B022622;
        Mon, 14 Nov 2022 13:01:59 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 75DFC660299E;
        Mon, 14 Nov 2022 21:01:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668459718;
        bh=Wr8DXJaBzIXXYYSptkp/QmPu4ccApmtbSiLsb9qIdzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4IN7hgCTJ5r2JnO4b3HCT6jlBrdLSBiLI5PLKTiAm693sETo8J8W5/gKAvX60xev
         h0Nhu5BE1wf1gT9xkKRUuaj00OIZZYGYaP9ZvI/QxfuS2hd4N1zlAHP06tuakdqPI1
         ign24mrx5OgcEQoJCHVdxzoojquW/TOmzXOeKC1bCQcCz0/xpT16gcMqMmpzA5zhB1
         mwXPPMgRU8l8spKK2KXNMsu/nwXoiTkWpvkt1w85iyKk9hgJYYdTxPFWE189scmXZe
         n8hTDszPbC6ylGc6ZII2iVKigHL2hCItsROxGtvHdKJYUX1jLPVFejlWjfrYU8fCS4
         bO7Ip/UrV6ZYw==
Received: by mercury (Postfix, from userid 1000)
        id 0BE12106D194; Mon, 14 Nov 2022 22:01:56 +0100 (CET)
Date:   Mon, 14 Nov 2022 22:01:55 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] headers: Remove some left-over license text in
 include/uapi/linux/hsi/
Message-ID: <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
References: <4919073b3dee8ca7612989659d31b12f9c5491ba.1662897400.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3n3g2mza2t5gm3ai"
Content-Disposition: inline
In-Reply-To: <4919073b3dee8ca7612989659d31b12f9c5491ba.1662897400.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3n3g2mza2t5gm3ai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 11, 2022 at 01:56:59PM +0200, Christophe JAILLET wrote:
> Remove some left-over from commit e2be04c7f995 ("License cleanup: add SPDX
> license identifier to uapi header files with a license")
>=20
> When the SPDX-License-Identifier tag has been added, the corresponding
> license text has not been removed.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

IIRC that was intentional, since the plan was to seek for an
explicit Ack from the copyright holder when removing the text.
I've added Greg for clarification and hopefully the latest
mail address from Kai and Peter.

-- Sebastian

>  include/uapi/linux/hsi/cs-protocol.h | 14 --------------
>  include/uapi/linux/hsi/hsi_char.h    | 14 --------------
>  2 files changed, 28 deletions(-)
>=20
> diff --git a/include/uapi/linux/hsi/cs-protocol.h b/include/uapi/linux/hs=
i/cs-protocol.h
> index c7f6e7672cb5..07c3bfb67463 100644
> --- a/include/uapi/linux/hsi/cs-protocol.h
> +++ b/include/uapi/linux/hsi/cs-protocol.h
> @@ -6,20 +6,6 @@
>   *
>   * Contact: Kai Vehmanen <kai.vehmanen@nokia.com>
>   * Original author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
>   */
> =20
>  #ifndef _CS_PROTOCOL_H
> diff --git a/include/uapi/linux/hsi/hsi_char.h b/include/uapi/linux/hsi/h=
si_char.h
> index 91623b0398b1..5ef72f0daf94 100644
> --- a/include/uapi/linux/hsi/hsi_char.h
> +++ b/include/uapi/linux/hsi/hsi_char.h
> @@ -5,20 +5,6 @@
>   * Copyright (C) 2010 Nokia Corporation. All rights reserved.
>   *
>   * Contact: Andras Domokos <andras.domokos at nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
>   */
> =20
>  #ifndef __HSI_CHAR_H
> --=20
> 2.34.1
>=20

--3n3g2mza2t5gm3ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNyrLsACgkQ2O7X88g7
+prmNw//VOkEp8ZlcxfkiNuIqGZAzDKkT7pG+L24GMvuJ/aj/8Tt4owlMwih9Cbq
FX+EaZVyroTRh8IjSmkexENMCpavULqgeRYO1N1lOXNeTanwYLc1/DkIzRgo2C6w
0Hiap2hiWN4rM5KCUkeDUZPIx2kWr2wdvhidj1Fy2ex6IdRWKgob3TY9+M2mW8QM
whmHsEPcVcuL2Kwuk7ZmmuhVIpKtP3waciYoMzQgHnaaIpg99x0I/TB28sN8ZXsr
KPZ7/y87WWH3Il7WyNPMmenFDq89QBH66UgMI/cdUIbwOut5lWVgWpEUBF/WENUt
KirnUTOHM9gX2+WLsN/8+svKCIDv2c2NcCK+TEqJa2APaYUanTZs85HWC+gJ138l
y47hddk1MrJAK2hov7q4MOJqsL/CFeXA0WFo37SVpVhfMiZrQ/JVsWMUTRHXqqhc
N+y4RQapZ/yDuCaNTSXkubIC/LENa+a/hNxmf8luOG9Cpc0/a3lG2SESkYKSz677
ctYjycPTPWZSLKbp836lXrG3BXzysrfctpvBcaUDPWXy7vc9JFoO5r0Pwwi2qWtL
1VkzEfuqMhBc9c90pq4EzFKC6AxAFfm9aOOng4NdAAG9P/iU9pRRvr4d1BvlCeHm
lDhyWpLEp+sk8+T2myZ/CvCuUm4aG0m1o4Za2BDC98P7DKvnVeE=
=ZL4q
-----END PGP SIGNATURE-----

--3n3g2mza2t5gm3ai--
