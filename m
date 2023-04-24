Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3B6ED19E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjDXPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjDXPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:43:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE50F449C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:43:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so34517680a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682350994; x=1684942994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Et3nJmRSNCb1Vw6f+DrCEwNWp2TX5DpfAd48y1Pjtg4=;
        b=LxDlDuuhL5zVWaXMSDMxd7041DmlAjfIdH+cFhGlhbvKXvu8i9kxB1XTs8c2+okjFd
         EH00k+VHb8SzK+SDTaemsrvr0MBhAE373Oka94x2fxGNVbFVwVnWYHkfq4vvq4FyDh8G
         21l4eRSw25lK2dpdU90Wijv4yStff3RJGUDWqig6JM7m/9dlUskY1iPQ8MzNaWTN6gZ7
         iMP7kmPPgPBIJ5/3ibJqc2dnwQ77l0bdB8lAoyd0Kfn6gaC2U/rHitQZ7Qn37XXlg6dz
         g6TfKaFgDe4cS+oL6oLshmNukjUsgO77pi6obBog1w2WmjF9ac+mE9F/VU3D5TMHrMDn
         HU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682350994; x=1684942994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et3nJmRSNCb1Vw6f+DrCEwNWp2TX5DpfAd48y1Pjtg4=;
        b=WZ6ffQ1fQK/uDDqN1Qo14jh9o4Az3QnUO3zez4+MTmjSDkA37Gbb1P2GncMu5vIjV2
         DJZbTBxDNHs1uzNFanhwW7Af9j7UbNvhr+oO3QotunXVl7stYZ0XNDQDqeIvb5O88Ep6
         KBEB6mIk1ZU0pmDjuZssGT6ARPQiFvhDTsM28Q+uyqMAXq/VSAJq837HqVt9EO65blzI
         WofmtI337/pclynze1VoGloQhsRFN8foDPCvkhg25xrCQv/sLTdU4/r/uvVEX8K01zCC
         yQRNN0aUbGN8w/gBk4mfRv/7MVA72rR+FcvPQqCQYU7Nt/N8F87APP9I3Yhomnl/Vy5u
         tl7A==
X-Gm-Message-State: AAQBX9efC6RoGlUGAODHCCmMgh4isZLgABr/va2eg9gdZb7pP+wYYoqw
        EX669qZcTh8m70htVFG5CQgYLA==
X-Google-Smtp-Source: AKy350ZAEHEglJIcuQqyFHzfUehIb1i8l3hxDMVyaNYKoWNEOyTPbCx/pXdkvBF7CP6o+HD40UwjmA==
X-Received: by 2002:a17:906:7e42:b0:94a:8771:fb60 with SMTP id z2-20020a1709067e4200b0094a8771fb60mr9386371ejr.37.1682350994253;
        Mon, 24 Apr 2023 08:43:14 -0700 (PDT)
Received: from fedora ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709064a0b00b0094f614e43d0sm5678803eju.8.2023.04.24.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:43:13 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:43:11 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 v4 4/5] counter: 104-quad-8: Fix race condition
 between FLAG and CNTR reads
Message-ID: <ZEajjyUDN9z8FXYP@fedora>
References: <20230423232047.12589-1-william.gray@linaro.org>
 <20230423232047.12589-4-william.gray@linaro.org>
 <2023042454-cahoots-rotten-f3f7@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BcBXM3mkZPra247M"
Content-Disposition: inline
In-Reply-To: <2023042454-cahoots-rotten-f3f7@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BcBXM3mkZPra247M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 08:33:18AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 23, 2023 at 07:20:46PM -0400, William Breathitt Gray wrote:
> > commit 4aa3b75c74603c3374877d5fd18ad9cc3a9a62ed upstream.
> >=20
> > The Counter (CNTR) register is 24 bits wide, but we can have an
> > effective 25-bit count value by setting bit 24 to the XOR of the Borrow
> > flag and Carry flag. The flags can be read from the FLAG register, but a
> > race condition exists: the Borrow flag and Carry flag are instantaneous
> > and could change by the time the count value is read from the CNTR
> > register.
> >=20
> > Since the race condition could result in an incorrect 25-bit count
> > value, remove support for 25-bit count values from this driver.
> >=20
> > Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 10=
4-QUAD-8")
> > Cc: <stable@vger.kernel.org> # 5.10.x
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> > ---
> >  drivers/counter/104-quad-8.c | 18 +++---------------
> >  1 file changed, 3 insertions(+), 15 deletions(-)
>=20
> This patch breaks the build:
>=20
>   CC [M]  drivers/counter/104-quad-8.o
> drivers/counter/104-quad-8.c: In function =E2=80=98quad8_read_raw=E2=80=
=99:
> drivers/counter/104-quad-8.c:117:34: error: =E2=80=98QUAD8_FLAG_BT=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98QUAD8_FL=
AG_E=E2=80=99?
>   117 |                 borrow =3D flags & QUAD8_FLAG_BT;
>       |                                  ^~~~~~~~~~~~~
>       |                                  QUAD8_FLAG_E
> drivers/counter/104-quad-8.c:117:34: note: each undeclared identifier is =
reported only once for each function it appears in
> drivers/counter/104-quad-8.c:118:36: error: =E2=80=98QUAD8_FLAG_CT=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98QUAD8_FL=
AG_E=E2=80=99?
>   118 |                 carry =3D !!(flags & QUAD8_FLAG_CT);
>       |                                    ^~~~~~~~~~~~~
>       |                                    QUAD8_FLAG_E
>=20
>=20

Ah, the 5.4 and 5.10 patches are missing the IIO changes from the 4.19
patch. I'll adjust and resubmit these two patches.

William Breathitt Gray

--BcBXM3mkZPra247M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEajjwAKCRC1SFbKvhIj
K4QzAQDAlZG4LRjGl4P3p6a+rXLGeBAsv7SfStWTU+de+505hgD8CkvoHgUUJYA5
QGrxZFt6xOarz/9S70ib0HzfgJFVjQ0=
=DY7f
-----END PGP SIGNATURE-----

--BcBXM3mkZPra247M--
