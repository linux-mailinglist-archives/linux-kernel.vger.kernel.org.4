Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657F0615B85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKBEgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKBEgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:36:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07DF1FCFF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:36:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1061586pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlv1Bdms+TGh7HRishBi7AL/M17q/GtZqMeMMOzK0zw=;
        b=n6BgtQ0l4s+izOjDnQPVaGG9g/QG4dlw3OUPyehypoZ53rQ3KDABpsw5YOTTBtAOaQ
         wGjyL4IG4CHTSV8gFO+yczEMdBUqXgz4Rq1pHGBwOc1Vhmy6R6xg6W7jgoNKoKzYQC8y
         5UxgeAhnR8f1gY45OCc5biZAQx+Tt3XEGDhliuIqozNKoAxdCPJ6nvQcqvxoqq1p7DrV
         YGqzvxUDUnMOH/Q5DMwXkJwSIGZWfFb/EYX4vXZwi9z4V8UKG5hk1nOjrKwUfPf5Khbb
         sKQYHRoG0lEGGwR3S4kCoHaSBfubMFp3RY9qV7iQeTvGTKm9fKjL3Z+p4SCQZyToCRCw
         2FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlv1Bdms+TGh7HRishBi7AL/M17q/GtZqMeMMOzK0zw=;
        b=gYxpnjWrrB9n1QbZO3bqhSA8XYD/MLdRvJalOga/ZTgqLg5H7RpwPDuw1QS8upS3L1
         e0OHeduVZ927KnDMl6ypunbaDBCVh63q4irN8HbFoI9L07A+uF/1rGD5mZGcWlJEQuYS
         hHCHzI17nYzFgGRSLM051SgxbAAhXRWc2ezlftOhDODr9jngKPfYgB0q8JHaKqaglKwz
         yX8rmR4okx4x63Tv4N4GRbrfehQHtZT2yRNRe6JnyciiEeZlSgJ0CID/czhA6WRg1Gcs
         HIwoHmGqOQDDYUMIHiGDBmPsIpcNrlRjgNq94F5F4NSwk3atvEuZKgcK100iVKpl511q
         YcUw==
X-Gm-Message-State: ACrzQf2XwpJ46pCpPUouDWwRKk8wGbaLiS68fD06DA6h8LtVAmlo40Fj
        QGX8uYVxnOXKB5nMi7XjoUU=
X-Google-Smtp-Source: AMsMyM4DyHp/kjqej/Y5tS5uY2KbKgfh9Dn0Y4gyCScMl6RqrCpobiIKjWLIxV2UX2DlZftZIPhG/w==
X-Received: by 2002:a17:902:d2c4:b0:187:a4e:f9c1 with SMTP id n4-20020a170902d2c400b001870a4ef9c1mr19877908plc.168.1667363771992;
        Tue, 01 Nov 2022 21:36:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-86.three.co.id. [180.214.233.86])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00176ba091cd3sm7114888plb.196.2022.11.01.21.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 21:36:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 66E27103CEE; Wed,  2 Nov 2022 11:36:08 +0700 (WIB)
Date:   Wed, 2 Nov 2022 11:36:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     gregkh@linuxfoundation.org, error27@gmail.com, ztong0001@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v2] staging: rtl8192u: Fix typo in comments
Message-ID: <Y2HzuCP9CJVs/jUp@debian.me>
References: <20221102030330.22049-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dG04XqkRS/88ZThX"
Content-Disposition: inline
In-Reply-To: <20221102030330.22049-1-chenzhang@kylinos.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dG04XqkRS/88ZThX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 11:03:30AM +0800, chen zhang wrote:
> Fix spelling typo in comments.
>=20
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl=
8192u/r8192U_core.c
> index 0a60ef20107c..f6a0992b059b 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4574,7 +4574,7 @@ static int rtl8192_usb_probe(struct usb_interface *=
intf,
>  	return ret;
>  }
> =20
> -/* detach all the work and timer structure declared or inititialize
> +/* detach all the work and timer structure declared or initialize
>   * in r8192U_init function.
>   */
>  static void rtl8192_cancel_deferred_work(struct r8192_priv *priv)

Hi,

Greg has already NAKed v1 of your patch due to him can't sure that your
patch was from @kylinos.cn domain. I also ask: why do you also Cc: your
other email addresses?

[1]: https://lore.kernel.org/lkml/Y2HNKwutTJh6kHXS@kroah.com/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--dG04XqkRS/88ZThX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2HztAAKCRD2uYlJVVFO
o2xEAP4oMVx8RDIo6MSUgetAKYbaXl4BXKRY6AiJX/LwOKQP4wEAzvPpCTmL2SIb
xVfcQwnad9qTU/LiYPwzNkK+uamAoww=
=NEPS
-----END PGP SIGNATURE-----

--dG04XqkRS/88ZThX--
