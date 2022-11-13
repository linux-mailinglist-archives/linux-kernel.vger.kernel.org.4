Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB02626E06
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 08:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiKMH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 02:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 02:26:00 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BBC10065;
        Sat, 12 Nov 2022 23:25:58 -0800 (PST)
Date:   Sun, 13 Nov 2022 15:25:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668324356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mz+c7bDfBITFSR5HC38ZwOgrGSPmlbfAQ0X/qyW26Fk=;
        b=f4DSiagQBQeUOW7Yvl1g06KXkTjIEyIpAFKj24T5M6NLN9SLB/8lP6dnFWHcIcQQexW/5D
        zEI8Y8Q8cZzJ0Gi771xPPOdN/tWzp6yU5KOJGm+v1NXYpFvsxO1lu01UATVL6rK4ExbLYC
        WYJqS8G3GlRy92cRZQJsqzc9Qyn0W8k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: Add userspace-api/accelerators/ocxl
 Chinese translation
Message-ID: <Y3Cb7832GOpFEpJz@bobwxc.mipc>
References: <20221113071554.476980-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmLIoSnqXZaqPB6V"
Content-Disposition: inline
In-Reply-To: <20221113071554.476980-1-me@lirui.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmLIoSnqXZaqPB6V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2022-11-13 (=E6=97=A5) 15:15:54 +0800 Rui Li =E6=9B=B0=EF=BC=9A
> Translate the following documents into Chinese:
>=20
> - userspace-api/accelerators/ocxl.rst
>=20
> Signed-off-by: Rui Li <me@lirui.org>

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,

> ---
> Changes since v1:
> - Correct translations.
> ---
>  .../zh_CN/userspace-api/accelerators/ocxl.rst | 168 ++++++++++++++++++
>  .../zh_CN/userspace-api/index.rst             |   2 +-
>  2 files changed, 169 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/accele=
rators/ocxl.rst

--=20
Wu XiangCheng	0x32684A40BCA7AEA7


--nmLIoSnqXZaqPB6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmNwm+oACgkQtlsoEiKC
sIUzeAv/UVssAxCndpCsKFSWx0t2dnA1OhktPzpWIKo3JODSC+9Sg/DbiO8T1Rcv
BzR9WvrE7TgbigYCzfJBRthFj6EwV4JkyVU3qgL6Kas9SWmw2zWy66B1szQfZhMA
W9+0Xmv0Qfe+dBoRGQYOkLenbyNer1kJ8XuCXkd5ZGQIwgIHItszCcaw7MaHHeAo
9tqYc/eViZrmJ9QSWXKRoCThuQQYd3daGAGFrAynSiaxdha6e6/BzRINjGZx+LKv
1W0saa1e4+uFzSB4ow061DuXCReczRjaAH30npk3VEuWCEnWvRK9KUkbsvdFhVt5
KPaqr2NIbcGqg7R230nQFVmFGdndFMzFYepq/uVNSDEncSX9DsiTdchF6oG9FXIV
GjYjVl7pKA3KnUBiI8QicaN8jtd3K9lwpYGJyTBzWHWMwwgh3yO774sGRDrmv+0l
4Hkhsrz/c3LYG/f062QSuhrEjA4PFT1Oitjq7KRy+7K/vSHwTlR+b3QVghXB6qFR
77jB0HIm
=KgLs
-----END PGP SIGNATURE-----

--nmLIoSnqXZaqPB6V--
