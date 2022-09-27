Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2AD5EC301
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiI0Mkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiI0Mka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:40:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2657857F2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:40:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z20so2078194plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fdeeFZM1wKl4V8zC/olXgdGV0f2Qbxk4eTHbaWP3r2I=;
        b=QwGgWJpZ7qCWF8kt+929DIvg7TNUgJc/TBnqZtC9ZiAH4UDa4QLfmqzDyHwqGlTOcq
         LQ4rzWmmdP4YmA2aZXhN9ZS++F4CyN2FZhxmrEJ0A+N8JeyGYSc7mdPNIcqqsVNk35jM
         AYm7yef4R8pUZKTIap0VH47240c6SeJAAKv1dFbVj9xJVlW+sTTAbcoqrRPMo2FUxSz6
         wdH4ytrt5xsD/C/9+srfVqoImF032tURggf9GuDhheAqEFy5+GUHH3aifeuCV1f3bC6Y
         7DzDCAQVV3eZbgVp4FqXCqCbg9PLvk6DkgP1GxMdBzm80jXLvDu3+D18zmppyHpBCrGx
         0mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fdeeFZM1wKl4V8zC/olXgdGV0f2Qbxk4eTHbaWP3r2I=;
        b=g7yQDFb9uge3YFmO5DUQQ5UzIUHbGqgEoMmerhuS3YsFEC1+4mkGfkU330ZfLIBzYn
         A5UrfDUR11ctN8131OimH4ZWtmuBSqoHaecNKjAYZ/W+jjTWIsaDDX4Xn99p6hOvKwjs
         C68aOJG69bW8ApML3XEbX0Z7Nug1jK2HJJ4jw09UnzBFjMc3YOHthcACWu7YmggsJ7+v
         mxIHSrTcbnvZpHG1mOe6x5CWOYMYpHHFFOb0f5voRQJMQzl7O2Kl9rqLHym2LzFQ9OD2
         2L6E+A2GE7g0+wLbSY4Af2qYLiq4fmKDrAezdLKNIqyOtWIEm6WOCNcqQy59pn9IbBtS
         bcQA==
X-Gm-Message-State: ACrzQf1JbHPAQUCDqBN2rMQJemmxJF6auN8gvF+ge7tPPQZkOXJqjpTu
        0Ajqq5Pkr1aJvPWb/EsGivewl2Hq9Hc=
X-Google-Smtp-Source: AMsMyM598kqa/KJxtsUc/EtWzv9KFEz57XOHYOqQHT3ShAeozg7wCJbL9JONr8nmDOG2w1MVau0zkg==
X-Received: by 2002:a17:90b:3745:b0:205:e53a:41d8 with SMTP id ne5-20020a17090b374500b00205e53a41d8mr257013pjb.11.1664282422526;
        Tue, 27 Sep 2022 05:40:22 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id w11-20020aa79a0b000000b0052d4b0d0c74sm1614389pfj.70.2022.09.27.05.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 05:40:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 82F481004A5; Tue, 27 Sep 2022 19:40:18 +0700 (WIB)
Date:   Tue, 27 Sep 2022 19:40:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.orgc, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: pxa: fix repeated words in comments
Message-ID: <YzLvMvouCIcXCJlU@debian.me>
References: <20220914083746.29370-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x2W0I6QEJGunPxLY"
Content-Disposition: inline
In-Reply-To: <20220914083746.29370-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x2W0I6QEJGunPxLY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 04:37:46PM +0800, Jilin Yuan wrote:
> -/* The actual GPIO offsets get filled in in the palm27x_udc_init() call =
*/
> +/* The actual GPIO offsets get filled in the palm27x_udc_init() call */
>  static struct gpiod_lookup_table palm27x_udc_gpiod_table =3D {
>  	.dev_id =3D "gpio-vbus",
>  	.table =3D {
=20
NAK!

The reasons:
  * I read the comment above (without the patch) as "The actual offsets get
    set in the function call". Both ins are of different parts of speech
    (adverbial and preposition).
  * As I stated to other developers (see [1] and [2]), you and other
    @cdjrlc.com developers ignore critical code reviews (no reply to
    them).

Thanks.

[1]: https://lore.kernel.org/lkml/ca8efe3b-1aeb-8a4e-79e9-3f3f9281ff34@gmai=
l.com/
[2]: https://lore.kernel.org/lkml/YzJaIolrTarQ4Qdn@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--x2W0I6QEJGunPxLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzLvLgAKCRD2uYlJVVFO
o6BbAQDlgP+b5CdnnCdmGktrJHpWvvdiFHeybuljqtSTafLxVAEA+SuSGUY/ah4+
PO5b6+8SKhntHDG208cJXS+ltF1WtQc=
=Tjq2
-----END PGP SIGNATURE-----

--x2W0I6QEJGunPxLY--
