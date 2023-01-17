Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CA66E763
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjAQUFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAQUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:01:00 -0500
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 10:53:17 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96164DE18;
        Tue, 17 Jan 2023 10:53:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673981230; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HFSQpNTekvX+wFqqpqxz/aXmgPGzBSIUQhHCALyDt+oPyNKJmTvahoZylAowQigosg
    WktDpwAuYoHAhUO17ypIQfJG7m6oQnQb9E3Z2EJkK9cyRZenHpJ6h8KBCzaUn/4HK60x
    cobcLYoni0gXJUSy3x42O1Dot7TMgzPW9Ff8Py5mlat1mmqO/WGhifXz1U/O+jjo2GQG
    FzopCvdodr2LKfbelmb82UQmST0mS91O4m24krkvqZsPKGzxD7jx522/FkuLd29M0ZN6
    YTCNZD09KY0mWJ2pvlKAFc2Yw/T752LPvjZMIeULoCNBB03aIyP+4v3JVOo0s2KpSpcy
    NekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1673981230;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VTtIscZoPH6qVhA3IKK5aIsGEbPXdZi3nR9I+EQcJmU=;
    b=Q/NOlRMTyDcTdLhcJBRSvxTYD+m7OKDD62S2CQlWsWM6llwNHWspUsqlObr/p0kXgS
    44EBLMZ8aFU2jvBDcQDLm7L3INcVewJpD89HDLxNdANK83IBRxo5QSxi1+XUFdVmGIw8
    W5u1h/JaMi/YBJVXUDZgGJuUmCmjbXTqk+EWxdt/CWm9daPul0LI76XfSkKakXg2u/q/
    bnyXYQT4JcfKUKtVm6g21d7Q1n00BPQ5ikQRX6ZNkbKpRNHz7FX030tT48UmrJloBn4s
    8ZSPO2HwuyoZULw+ioRIlHqRNdFW9eMPbP06a65wSz1PlXJA0r94tSb2eXOY1djnhWu5
    XmiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673981230;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VTtIscZoPH6qVhA3IKK5aIsGEbPXdZi3nR9I+EQcJmU=;
    b=WrrA9ZbGAmZ1rvIeRS5q8ZMJpz71uPZEuv7FTzy62s068tQaTtSRktDu6OKXMVNV2E
    JI8Ca6dwIOM6xZOvPf4mVFsDeGohI+4BQ1J5F3vwcySV4J8ezwPQ79gMdzSKPE3STuCC
    QxpWf/JmPgujyaE8dUO0YunLGv2GdT0KfXCIGzQkZSq2dw4ZBAj1CK7v10GAFo/D0jXE
    jFHVWpKmhkNhL3qfnKrVgM7sH7Iuk5sotRPEsqm+whVEctEMZ4ccIuq8X7njlNzQBL67
    hlnbhdRu3glHzq0BiqmQobOu2PnhWB/D74TgSqniX3Go/Vtm1xDBMGRHbii1TP5tS3Gt
    fJcQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnjFHXPaJ/Sc8sY="
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id 35c3cez0HIl9X9m
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 17 Jan 2023 19:47:09 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vladis Dronov <vdronov@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] crypto: testmgr - disallow certain DRBG hash functions in FIPS
 mode
Date:   Tue, 17 Jan 2023 19:47:08 +0100
Message-ID: <12136143.O9o76ZdvQC@positron.chronox.de>
In-Reply-To: <20230117172006.8912-1-vdronov@redhat.com>
References: <20230117172006.8912-1-vdronov@redhat.com>
MIME-Version: 1.0
Autocrypt: addr=smueller@chronox.de;
 keydata=
 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
 kBFBHm+xdudNab2U0OpfqrWerOw3WcGd2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. Januar 2023, 18:20:06 CET schrieb Vladis Dronov:

Hi Vladis,

> According to FIPS 140-3 IG, section D.R "Hash Functions Acceptable for
> Use in the SP 800-90A DRBGs", modules certified after May 16th, 2023
> must not support the use of: SHA-224, SHA-384, SHA512-224, SHA512-256,
> SHA3-224, SHA3-384. Disallow HMAC and HASH DRBGs using SHA-384 in FIPS
> mode.
>=20
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>

Thank you very much for the patch!

Reviewed-by: Stephan M=FCller <smueller@chronox.de>

> ---
> Some details:
>=20
> The following DRBG algos are defined in testmgr.c as of now:
>=20
> drbg_{no,}pr_ctr_aes128
> drbg_{no,}pr_ctr_aes192
> drbg_{no,}pr_ctr_aes256
>=20
> drbg_{no,}pr_hmac_sha1
> drbg_{no,}pr_hmac_sha256
> drbg_{no,}pr_hmac_sha384 (disallow)
> drbg_{no,}pr_hmac_sha512
>=20
> drbg_{no,}pr_sha1
> drbg_{no,}pr_sha256
> drbg_{no,}pr_sha384 (disallow)
> drbg_{no,}pr_sha512
>=20
> Marked DRBGs should be disallowed in FIPS mode according to
> the requirements above.
> ---
>  crypto/testmgr.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 4476ac97baa5..fbb53d961ea9 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -4782,7 +4782,6 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
> }, {
>  		/* covered by drbg_nopr_hmac_sha256 test */
>  		.alg =3D "drbg_nopr_hmac_sha384",
> -		.fips_allowed =3D 1,
>  		.test =3D alg_test_null,
>  	}, {
>  		.alg =3D "drbg_nopr_hmac_sha512",
> @@ -4805,7 +4804,6 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
> }, {
>  		/* covered by drbg_nopr_sha256 test */
>  		.alg =3D "drbg_nopr_sha384",
> -		.fips_allowed =3D 1,
>  		.test =3D alg_test_null,
>  	}, {
>  		.alg =3D "drbg_nopr_sha512",
> @@ -4841,7 +4839,6 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
> }, {
>  		/* covered by drbg_pr_hmac_sha256 test */
>  		.alg =3D "drbg_pr_hmac_sha384",
> -		.fips_allowed =3D 1,
>  		.test =3D alg_test_null,
>  	}, {
>  		.alg =3D "drbg_pr_hmac_sha512",
> @@ -4861,7 +4858,6 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
> }, {
>  		/* covered by drbg_pr_sha256 test */
>  		.alg =3D "drbg_pr_sha384",
> -		.fips_allowed =3D 1,
>  		.test =3D alg_test_null,
>  	}, {
>  		.alg =3D "drbg_pr_sha512",


Ciao
Stephan


