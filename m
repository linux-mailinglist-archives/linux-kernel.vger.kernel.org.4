Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81015EDCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiI1Mbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiI1Mb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:31:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2B332BAA;
        Wed, 28 Sep 2022 05:31:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a26so26832925ejc.4;
        Wed, 28 Sep 2022 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pkJY3E60tKc+Ziw9SF/ifXgY5oNH2L56Txy864KHVUE=;
        b=FlN96cnPL1siFhMe/ksRuplO0v2Zn0o+azPmp42M+bnAPniEsnYn79/04gnGFm8eds
         Pl1HcRqv8AuZiR1b4CuOuYdyTYhpbWWFCigeqD9B+ZhshoiAKNr+c9P05LpTJxKZCo5c
         P7i4UzR8r6uJBNrTNahVrQJrStTwRkF+VqqaZyJcRBlq9CDFgCL+jOjYVx+lBhnbQtSg
         p2kK+DAfRX0Z1Uk3P0UhUZClswcxHmB+379dKN36p2LB9CKeAQERd+z5F/xThsbttYyZ
         2KYl+BryONgVqD5NDX2XGTvflHVZQqmiIumk/0OYBIcj9bdTlPyI0xSYSQrMv/NtMTlJ
         HZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pkJY3E60tKc+Ziw9SF/ifXgY5oNH2L56Txy864KHVUE=;
        b=zOwWUQcqJKr7U4SnhBtJe6NbCS8DlQGdJaDo0z8BI8+18G+8CHD61cGW6oHwo+qDUg
         kQuj+SJLxR9MEY2WBHa+gNGkVZaweshucRCuAarr/3z2+YTkb1uEjaA2VLh8OXDa+1WD
         f67jUDwxZmp3+pUb4hOdTXxhvExAAFzzzxxEyfshjiQzUbnUMJYj8kLm+R32yvO+rcKL
         l8yifMB6UKQPyKAwQsNbqaO6a04THAxlVMeBO0Lyo5v3G9IaT8XOeAFJSnpqSAQlRXot
         Wfq3QemdvxWPbPKX2j53WjBiAiD12/J/aSN/VDS5vzA+qZpffhFXNhiIK0CAKZYwKTE1
         WXcA==
X-Gm-Message-State: ACrzQf0yW/PWZFk0ISglTm+o+2v7x7WQ66xLEtVxC//D3RfGRtSZRqn8
        y813QUwdwDPK+avoLZRBR3S6wsAKgRM=
X-Google-Smtp-Source: AMsMyM5190a5iR4NZYzUuL+wUFb77raM6VobL5R5MWX6f53g+jkYJELQD8aTLAFsdMPP6xq5Q9btYA==
X-Received: by 2002:a17:907:7202:b0:783:1bed:c5db with SMTP id dr2-20020a170907720200b007831bedc5dbmr17358688ejc.124.1664368286178;
        Wed, 28 Sep 2022 05:31:26 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s20-20020a50d494000000b00454546561cfsm3309766edi.82.2022.09.28.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:31:25 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:31:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/4] pwm: sysfs: Return directly from the for-loop in
 PM callbacks
Message-ID: <YzQ+m3jjh6tOyXmS@orome>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OJvMDxpU+PUz+EL"
Content-Disposition: inline
In-Reply-To: <20220826170716.6886-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OJvMDxpU+PUz+EL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 08:07:14PM +0300, Andy Shevchenko wrote:
> There is no need to assign ret to 0 and then break the loop just
> for returning the error to the caller. Instead, return directly
> from the for-loop, and 0 otherwise.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> v2: added tag (Uwe)
>  drivers/pwm/sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I fail to see how this is an improvement. The outcome is exactly the
same and this doesn't even make the code shorter. Why bother?

Thierry

--0OJvMDxpU+PUz+EL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0PpsACgkQ3SOs138+
s6FHRBAAwv1k7/AwjxCRHCFgtOcAzsfaD+u5MVvcsu+RPQFkPMXr6VrDYD4uCRUb
a7K+MDpEcHDqDE7SFaum+fA72u02ZBGYGEDfwtZgfYiydRvTZ9Vhjo6dirJOGjZq
cwCXlpOMXdLiHKIXjA3C9PvA8rNwg4s078K4ELA0CuvfMAoGwhiRz5vu/CdrNsRi
Q7Ej1tfTk5YlGLorduU/n8CUnW2ubX3lfjK1/43mp0WdkrrvW9ilfDYEzfz5uz6q
N4Ge5Xc03PetmOIz2G+M5z6EQWhBQ6hBLZqrB2M9p7Asu6FyVH5tbsfqHTwSzaQQ
85unl60/Cupg7yob3/RBHRuzDuc60YqTv4XiORnMNxsRZ8nJW9yhgM3w4eWhJh4m
61LWTNFzW+LfhyMn5MJ4CU0iByn1mTUX9YUqwCcNjKNsmG0+e63TC/W0LNIwpxvL
EUN3WZvG01fg4IyafYpNCdNj6Wu6bJfu3Oly85ijyXJjGOduloj/PkLfw8AuowCE
k1mFaopDDsSD48Uc5T6VX+sizPV63P8VCkb7AFr0C64idnWXaNjnQ+rXPiec1C81
qYTqeiFGR118g5A/XLoA/7uUqafD5WcMPjFs8SBCl6weMYPq7aTY5JoZlLOWQzNU
w8i04uKa2gKxKVIyiI1vA0S6lN7vkeSgHZ+z6Uq3y5ccT9/aEbg=
=xKsY
-----END PGP SIGNATURE-----

--0OJvMDxpU+PUz+EL--
