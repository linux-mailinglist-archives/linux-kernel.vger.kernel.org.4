Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F4B65766D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiL1MaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiL1M37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:29:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE60EA3;
        Wed, 28 Dec 2022 04:29:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso6324524pjc.2;
        Wed, 28 Dec 2022 04:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xva4+JODa1CXmxrrNEoeJGKgbbb6AVhHbz9b3pDdu3Y=;
        b=LSTQpTjJPDYXXfQgBFygaBnBXhiDHGw8nySZOPSt8FTS+JN/iPOuTa+aHzokSyIjeA
         yETYvBEjlaQbziFflOlzDKih6/eoiSRb7U97HPJvLGKWiOV8mLGHZ7xRopYi+jf1uuXy
         NnyL2BYLrVt14Z4lkVj8vslSwKGDRrvc0Q5uBHMLMvyHBoexl0OdlMeWKPOGitxeSweO
         SbwtmkMSLFy1tLTNj69xQegSyxxU+jLXOWzoA/u5Ku3nxguClAR6rtWleX1FH7awXDTn
         +kj22wptp8k2w390UzXBmcErwlOyyF2xn2Aa0spFG6WKv8+WJ3y9HD/VdwBP3r2UD3vI
         V4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xva4+JODa1CXmxrrNEoeJGKgbbb6AVhHbz9b3pDdu3Y=;
        b=AEf9N5/XC7kjU/BEL/Z5UoNuI+94PMl+FYn4t4NgGR0dIKLzr5gd3QUeIQXg4dDbG8
         tIntDuzy0N0UIyVN3xZqm5kmTGIyCEh+CKxGBovadKCIP9yFHbQS+old8h0Edu1hxg1i
         xJOBdr6vCH35RilOSKE1zeFAtxyu3En//GkmLkhkyfm03VbocON8KINT0BHPiN0U8HQJ
         rzJfjecO6I36V9XtHX0ogjXcy4U2X5TGuea1Yb5a1yPMjk7qwMWIiGR2AKNfV6u2R3WY
         jkH2nW+xnmFCA5omra4rP1X2ctNNE5hlNt5Db+vOG5depnRDbHhJkV9P16oy1qGJgQXH
         iOAw==
X-Gm-Message-State: AFqh2krpwL1Nsk5Zc21mfNzEaDZoba/GiQO/mjGtncPa25anQiKE+7zc
        hIN9UegJBEOWYP4/7b6YStWxVnderK8=
X-Google-Smtp-Source: AMrXdXtsBi80DY9iwPR5JpBM2gQ0nTOt8eV/7FcOW3HG2JFpwq9o0rV1ylg2c4EWuyxfXExCDG7uBg==
X-Received: by 2002:a17:902:b402:b0:188:d434:9c67 with SMTP id x2-20020a170902b40200b00188d4349c67mr24625787plr.32.1672230598294;
        Wed, 28 Dec 2022 04:29:58 -0800 (PST)
Received: from debian.me (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b001782398648dsm10932255ple.8.2022.12.28.04.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 04:29:57 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 6EBF8100504; Wed, 28 Dec 2022 19:29:52 +0700 (WIB)
Date:   Wed, 28 Dec 2022 19:29:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
Subject: Re: [V2] media: jpeg: Fix multi-hw judgement
Message-ID: <Y6w2wG2MlIiHlkr/@debian.me>
References: <20221216035247.18816-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KTfqalsCkhxWe9vh"
Content-Disposition: inline
In-Reply-To: <20221216035247.18816-1-irui.wang@mediatek.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KTfqalsCkhxWe9vh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2022 at 11:52:47AM +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
>=20
> some chips have multi-hw, but others have only one,
> modify the condition of multi-hw judgement

nit: s/judgement/conditional block/ ...

> -	if (list_empty(&pdev->dev.devres_head)) {
> +	if (!jpeg->variant->hw_arch) {

=2E.. like here (if block).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--KTfqalsCkhxWe9vh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6w2ugAKCRD2uYlJVVFO
oxnoAQDF4eixtonmpeiSzrrnq0P464jpGvONKLB03PJ+hcYvmgEAkL0nfkqyljuU
uDlPj3WP1suLVtrYWPvRsjvpYhBOvws=
=vr87
-----END PGP SIGNATURE-----

--KTfqalsCkhxWe9vh--
