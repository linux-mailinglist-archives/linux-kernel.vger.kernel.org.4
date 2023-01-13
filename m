Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D36689CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjAMC6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAMC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:58:00 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0E13C;
        Thu, 12 Jan 2023 18:58:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c85so11942551pfc.8;
        Thu, 12 Jan 2023 18:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mee5x+TzKZU45VGjFqeVteM5ZCKLRyiZXfLHukw8M3k=;
        b=oYWPJzP238s97TSXJag1xwjIiVYJxo/G0/LL7JwXWVT35sWx499HniPLgQsyc4Yrhk
         C9BnQZiwAvm4FzQrgv7qEqbqs+AWOmGxCDZekSjimd7EIaQyJVVvlyPBBom7vLEPzHjg
         FXpolbq/rXpVoHSUDCQD51h0M3WdTUPIRqjlqEgXK2ykerqbVtiXrq4NqVfxSzuJEF3g
         64MmbQqF2edpbF0n5NKAQ1eENITINSx0LqGQ/xb9dxzqsmlCGWX3nW705JxUGn26CHMS
         4iARacNl1EvZDCOnkuR6uLqT4aJ23snbJGvu8xIsX+TPAlmFy7fLP4bUA+b5nzABqHe6
         TnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mee5x+TzKZU45VGjFqeVteM5ZCKLRyiZXfLHukw8M3k=;
        b=yLMXDBZBLUHxXOVa4sRa8yKoECyUXkDb01zHRoyToM6SP0V3NSwbbMRduj7qG/WkaC
         4WdmzmRTzZeYnJwKRqZpBGLYYxa/FLedzrom6wXXAxUX7KxgKMCJJaMjUouwQeM+ZbFw
         u6AVkOvqX79dIeSUP0fqQVN7sz3swYPwjjfdJjgOQt1ojtHK15TKUmWV9cPdUKtNz8b7
         BIME2kFlJIgFwV+NuKbZmEC+AOhHey7hIGuWdA1HIfe5KidM1n6Wc2byAsu9fRqOmYIZ
         LNMXOPEcEnT4IBbkKsLxJ1SDO5rgjz0C70Q7HVGtLDtD+l0fDomlyMH9/ghW4oayiCf8
         Yuwg==
X-Gm-Message-State: AFqh2kr1ERN76QqPGgnd9H8Hmkw9Am+AZq3OC6PFtsChHUdZxQRko7Yd
        JQKfC0ofUlDeEiGG52m1hME=
X-Google-Smtp-Source: AMrXdXuZya7ZgKdKnlxEW/kpPEjRJRcz4KdAIgfIiKih5OjloRHoW0IVJKtkZdwDaIidqUCt0KxeMg==
X-Received: by 2002:a62:2544:0:b0:589:8fac:cfe5 with SMTP id l65-20020a622544000000b005898faccfe5mr13779054pfl.13.1673578679595;
        Thu, 12 Jan 2023 18:57:59 -0800 (PST)
Received: from debian.me (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79611000000b00575b6d7c458sm897877pfg.21.2023.01.12.18.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 18:57:58 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5A7F0104054; Fri, 13 Jan 2023 09:57:55 +0700 (WIB)
Date:   Fri, 13 Jan 2023 09:57:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Gongwei Li <lifangpi@hotmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 972624427@qq.com,
        Gongwei Li <ligongwei@kylinos.cn>
Subject: Re: [PATCH V2] usb: Fix typo in comment
Message-ID: <Y8DIslifX/8cN98K@debian.me>
References: <SI2PR02MB4603F6E3B7E062EF76656956DDED9@SI2PR02MB4603.apcprd02.prod.outlook.com>
 <Y6wZ+FWhuV8pVl1E@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1TqxldWz8/riEIdb"
Content-Disposition: inline
In-Reply-To: <Y6wZ+FWhuV8pVl1E@kroah.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1TqxldWz8/riEIdb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 11:27:04AM +0100, Greg KH wrote:
> On Tue, Dec 27, 2022 at 02:59:30PM +0800, Gongwei Li wrote:
> > From: Gongwei Li <ligongwei@kylinos.cn>
>=20
> Please fix your corporate email systems so that you do not have to use
> a hotmail.com account.  Otherwise how can we verify that this email
> address really is the one to be attributed to this change?
>=20

Hi Greg,

I have seen an example of reply message sent from @kylinos.cn at [1].
The Received: header contains reference to mailgw:

> Received: from [192.168.1.105] [(183.242.54.212)] by mailgw
>         (envelope-from <jianghaoran@kylinos.cn>)
>         (Generic MTA)
>         with ESMTP id 1962507765; Sat, 01 Oct 2022 08:47:44 +0800

However, mailgw [2] is a "10-minute mail" temporary mail inbox service.
The mailbox expires and refreshes every 10 minutes. That means, people have=
 to
reply within 10 minutes window before messages there will be permanently
deleted. Consequently, for @kylinos.cn people, they have to either Cc: (or
Reply-to:) their personal addresses or send patches from such addresses in
order to keep receiving ML traffic.

Thanks.

[1]: https://lore.kernel.org/lkml/7b707ba4-c3f2-dd17-e3f2-e4d143b76245@kyli=
nos.cn/raw
[2]: https://mail.gw/en/

--=20
An old man doll... just what I always wanted! - Clara

--1TqxldWz8/riEIdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8DIqAAKCRD2uYlJVVFO
o5UjAP4rgmABJ5PAthRmHCAbqASDYVQv+Q5LAbyQ+IDE42PiPwD+JRNVGT3/4cCE
lqaJU4Ne3SYr8MfGWSTnJKo6H7pFXA4=
=lKrD
-----END PGP SIGNATURE-----

--1TqxldWz8/riEIdb--
