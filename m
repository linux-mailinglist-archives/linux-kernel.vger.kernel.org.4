Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B0615B64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKBEYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKBEYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:24:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79523BF4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:24:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 130so15360093pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SExWvkw5fblAZBuZ5szl7gHC9oLutfdZTMJ4YDCiIdw=;
        b=XXNaO0Zwwh0jX4fRWuAxxBN7bAA0igYyIveiz1wT569yDgHw1qvANiFHagpr2ZutGs
         x+fmcOhvz+2lXBv0TjNqJlJ829WysGtix6eibMcitdKgWis5rYPtTifw+2WrSRkrS8pE
         LuFK/c24tcR5W7zcLv/rvoDJSMxYtYYXpNzA6mMMlEMvpC07axhLdyrZ8tzJMmig+Dpp
         GiUZI+Ycrs6YysSujjWqdLBY0/QohbyjrvnvkFE0PpkGBEzEQxXSJkrAAAEd+M4s/rI0
         ZHc63jrLYwJexUpvDnlYFUQcS04lF47E0qNbaWOVgBab8tdKw90XgLOQ0ipQWgP5rzkI
         joUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SExWvkw5fblAZBuZ5szl7gHC9oLutfdZTMJ4YDCiIdw=;
        b=YxnAUkGUStbDjj4Mg8hWHf1Tb+DfKdKVZJ27RkZAGOBPwFihjunV6E0Y4vj3rPZS+t
         2H2yqGoCyQaL1EJaRd+E8D4PgzmF7l15/GEkTqwlta1fk4xoRrp1SqNu/3+gLBrPPNm/
         SYNq/MK0kxI/lVmx+PsIUiJAohh9RpOw4p4NXR5P+CIBEViaR8NlgMJuBHZNme1uYUcH
         Au7/CVa+UsB0Mnu3zCBVcXtG/qAarHdDfaSosD+z4Sk/CMdvgcSSUvtZ6CY1kla3Y5MR
         ivHeHaAVExcE2ncdw0VYD0GgCwWkmZk9knaBhnhjHFjaTtkHkOt8qU1ESTUqqJkk7ES0
         IMEw==
X-Gm-Message-State: ACrzQf2Ui1ZZSnmqx5NggjbrONS+6xn4Yt2o1zWsj/0v25Qfc+N69ckO
        otnprUikv9g5VnlTTGbGs5N5EvuqHTxuPQ==
X-Google-Smtp-Source: AMsMyM4jMGMw6kOslrfmYOsWoIsC5YPfDAZFHhi/sVeYTsL+QMzZ+k3a+1bhXSWv4+tK+nQhtgMT0w==
X-Received: by 2002:a63:570d:0:b0:44e:3268:6cf5 with SMTP id l13-20020a63570d000000b0044e32686cf5mr19289393pgb.346.1667363039569;
        Tue, 01 Nov 2022 21:23:59 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-86.three.co.id. [180.214.233.86])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090ad58400b002132f3e71c6sm356227pju.52.2022.11.01.21.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 21:23:59 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EBB6C1039B6; Wed,  2 Nov 2022 11:23:55 +0700 (WIB)
Date:   Wed, 2 Nov 2022 11:23:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        chenzhang_0901@163.com, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] platform/x86: ISST: Fix typo in comments
Message-ID: <Y2Hw24CE8/nyucPS@debian.me>
References: <20221102032940.24912-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lS7130D365nKFGxl"
Content-Disposition: inline
In-Reply-To: <20221102032940.24912-1-chenzhang@kylinos.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lS7130D365nKFGxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 11:29:40AM +0800, chen zhang wrote:
> Fix spelling typo in comments.
>=20

What typofix and what comment does it fix? I have to see the actual diff
below.

Also, why do you also Cc your @163.com address?

> @@ -623,7 +623,7 @@ static long isst_if_def_ioctl(struct file *file, unsi=
gned int cmd,
> =20
>  /* Lock to prevent module registration when already opened by user space=
 */
>  static DEFINE_MUTEX(punit_misc_dev_open_lock);
> -/* Lock to allow one share misc device for all ISST interace */
> +/* Lock to allow one share misc device for all ISST interface */

s/interace/interface/ in isst_if_def_ioctl() comment, right?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--lS7130D365nKFGxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2Hw1wAKCRD2uYlJVVFO
o3CHAQCcUl3yds4alpLREKsD3bLtAsPfqbTHHrtQNBroICVqwAD6A01Ev6DjjEQs
LAga9oWJy4OIMLcFzjPu1KDoaEXW4Ak=
=4GyC
-----END PGP SIGNATURE-----

--lS7130D365nKFGxl--
