Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F467DF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjA0IcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjA0Ib6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:31:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB722D44;
        Fri, 27 Jan 2023 00:31:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so4263615pjl.0;
        Fri, 27 Jan 2023 00:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66V2H9uMWCTRaA6bOL7mqSHGYaXxw+3xsRWEjcD/2LM=;
        b=o8qKotc6mv5djGUSZBx7HMqCut5Uci/7TO/HXrO8MwQfLzYWKDhHany+YqWhFPCouk
         N8keiS3DEGjSjPx0W/goa7dRJEkP3YtG7EHlNmPO4rpKTx0O+tema9z3vXmB0IjvCwLB
         gDyxrr9dpgCQpIBgbb1nffY6UZanmbeIzHd/7czyTYZSnF8h7Fe4nMIGeXUVLNetGnEm
         K+rqTeYrA/dgbOamyU21xTNkyTiggduQjjmu2IzrMdkkP7gd2haNyUl1hZjuKstEsURg
         x4EFRAgvjYoswIwAX/D2c/INUfCZBn9Z7quE1UFdCx5koIn2t9ngi/aqNbzBEMvMgoLF
         FkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66V2H9uMWCTRaA6bOL7mqSHGYaXxw+3xsRWEjcD/2LM=;
        b=59MNSkLKKdGTIyINnZWEgxG2F7QM+rrG/ea51+6/MnohInbGSs2Guc3rvtuu2bdJjE
         FEZwtJ2rjCH959OTxcxFZhwvN2fxlcYO3DcnUSsAP+kbMdQqwvTAPajfU98nuTHpLXKE
         j6+aILXh3lLsywy3k+XWBOhi467qjDvVHAa6UCSgeECaXAgvYDwpeUqDATJc7/pltuvj
         K2NAYp1JFn6gDI8PcQVU2j4Z7mHio4CTVU6aMvZvVyyLHmkJe9eBx5xZfZ7efu5cMdMr
         uCkDqgKroBrP0g8H/Ap8LH6p+iY0XwiigxaYbUJtsKUK9c7BQm7g3KUSdWPfRWcNBMlk
         7Tcg==
X-Gm-Message-State: AFqh2koY4Jy8E1xBlVHxYHRokQIn+Zcl1i+LCLopVO5iNBXYZaro1UQS
        mjc7eSgJoWdMRKFOBYIcHVQ=
X-Google-Smtp-Source: AMrXdXti7dHUxR9YyF0XMct43cHAokzIPXS0vuTmMdtdMzfF/iOKXsOUAfhSvb1n13BWc7Qut7Yudw==
X-Received: by 2002:a05:6a20:4392:b0:b6:e9:d3d1 with SMTP id i18-20020a056a20439200b000b600e9d3d1mr37989353pzl.11.1674808316854;
        Fri, 27 Jan 2023 00:31:56 -0800 (PST)
Received: from debian.me (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00196077ba463sm2263467plg.123.2023.01.27.00.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:31:56 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 15528105582; Fri, 27 Jan 2023 15:31:54 +0700 (WIB)
Date:   Fri, 27 Jan 2023 15:31:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 03/35] Documentation: block: correct spelling
Message-ID: <Y9OL+iyaQtXLSCKc@debian.me>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-4-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NFcrGMdwwynsd7VO"
Content-Disposition: inline
In-Reply-To: <20230127064005.1558-4-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NFcrGMdwwynsd7VO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2023 at 10:39:33PM -0800, Randy Dunlap wrote:
> diff -- a/Documentation/block/data-integrity.rst b/Documentation/block/da=
ta-integrity.rst
> --- a/Documentation/block/data-integrity.rst
> +++ b/Documentation/block/data-integrity.rst
> @@ -209,7 +209,7 @@ will require extra work due to the appli
>        sector must be set, and the bio should have all data pages
>        added.  It is up to the caller to ensure that the bio does not
>        change while I/O is in progress.
> -      Complete bio with error if prepare failed for some reson.
> +      Complete bio with error if prepare failed for some reason.
> =20

So if prepare returns error, bio is completed not successfully but also
errored?

--=20
An old man doll... just what I always wanted! - Clara

--NFcrGMdwwynsd7VO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9OL+QAKCRD2uYlJVVFO
o88fAQCsOKd9AplfKaQndXR99PSk8FdWs2KbBUgWCZEF6c/hFAEA6xJGzGugAh97
CphKXaFwCAZgHkStr9ZWEjyHP6G9Vwg=
=uQna
-----END PGP SIGNATURE-----

--NFcrGMdwwynsd7VO--
