Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72563366D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKVH5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiKVH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:57:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5032B9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:57:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k7so12869495pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZFqS8rV1UpKXhqS4qjbdfU7A+0OkMKlBfPACFG6d30=;
        b=qd+a5OMGfqEq2VDbL2vEJtnjSpZYzyqxvUzhN8ueTAP83XypAttXbpQALoF6TH8jCX
         arBvXv6ds72oGcgMkRkVR74c69krCzQicOGUE8jb0d4u2Uz86YkfnOyPFYt+gO7Eyi5g
         uVIPmTfRd0GhlQsV+QY1JRHFNWOJmNZtfqyYXc7eunxZtvxT0e0ItKdwhc0DjHdcvi7M
         DFTI/HNEp+CT/ysxfxbVKkUz0sc2f59rpK2R0u535w9Y3+Dbjvl8CvQIitrpsgSK4kxe
         qZNWC2QzdCjf9cQh/k8qfB6AB/+gsTWI+4SMmiy7cXSw49ATt6PlWHpkdUg51pLaYzmO
         QL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZFqS8rV1UpKXhqS4qjbdfU7A+0OkMKlBfPACFG6d30=;
        b=lMyP84HO16pXsnb29mEi3gnTaZqSk4+cuj1w2TorJZlSz8qOMgPmibBDNkLypcNy2d
         qrWset25mO8/mKoktYV86NJlPX5WWakGpM9Wit9n19AriEyw3gsjTUnvK608hd8J4tVA
         3UmmXddJdodEf4GxIDSFOnBIdFd/3e71mwaWcTetSmzzEeKmdujQxfWAKZbLeYi8Bx4O
         1az+5BA/7C/o3CBXulsunNDUIaKjRlQGOMkdLIpnkdVXtX6EYYETmmM9poQFRT0GChji
         BH057gM6Z4bpKsjVeQoVeWiQNRKyga85Vjl6h0ewRvCmtzJH2cE9v0pmxlXw8GM1NZ2E
         MErg==
X-Gm-Message-State: ANoB5plWysqvvFegIIa/GuaksxG/UXriSAvAZe7fgiIjbmI7zzHhFCpK
        g17hQuHsjCBlHiPMpdhVPeE1zoyD9Jk=
X-Google-Smtp-Source: AA0mqf55yasdwGFfdhMgRKzYf4BQlbiEn7WTau6Xn9AZU5SPVz8b8avyKFm6sODjDJwhkpaehetG/w==
X-Received: by 2002:a17:90a:8683:b0:210:c10a:b703 with SMTP id p3-20020a17090a868300b00210c10ab703mr2957537pjn.241.1669103825967;
        Mon, 21 Nov 2022 23:57:05 -0800 (PST)
Received: from debian.me (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id 85-20020a621858000000b00572c12a1e91sm10026119pfy.48.2022.11.21.23.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:57:05 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 50B78103240; Tue, 22 Nov 2022 14:56:57 +0700 (WIB)
Date:   Tue, 22 Nov 2022 14:56:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wang Honghui <honghui.wang@139.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Correct syntax error
Message-ID: <Y3yAyQfCQjRlEV7n@debian.me>
References: <Y3w8JZjR5LygcClz@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xJKgfB23nJOZvxI1"
Content-Disposition: inline
In-Reply-To: <Y3w8JZjR5LygcClz@TP-P15V.lan>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xJKgfB23nJOZvxI1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2022 at 11:04:05AM +0800, Wang Honghui wrote:
> printk_ringbuffer.c

Welcome to LKML! If you want to contribute to Linux kernel, please
see Documentation/process/submitting-patches.rst.

> >From 8d1e2b96c62d06bb691802a06501762da606e97e Mon Sep 17 00:00:00 2001
> From: Wang Honghui <honghui.wang@139.com>
> Date: Mon, 21 Nov 2022 16:58:00 +0800
> Subject: [PATCH] Correct syntax error.
>=20
> Signed-off-by: Wang Honghui <honghui.wang@139.com>
> ---
>  kernel/printk/printk_ringbuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_rin=
gbuffer.c
> index 2b7b6ddab4f7..2dc4d5a1f1ff 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -203,7 +203,7 @@
>   *	prb_rec_init_wr(&r, 5);
>   *
>   *	// try to extend, but only if it does not exceed 32 bytes
> - *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id()), 32) {
> + *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id(), 32)) {
>   *		snprintf(&r.text_buf[r.info->text_len],
>   *			 r.text_buf_size - r.info->text_len, "hello");
>   *
=20
Your patch is attached, please send it inline using git-send-email(1)
instead. Use also scripts/get_maintainer.pl to determine appropriate
recipient for the patch.

Also, you need to describe about what and (especially important) why you
made the patch. Write it in imperative mood ("Do foo" instead of "This
patch/commit does foo").

Last but not least, build the kernel with your changes, preferably also
cross-compile it.

PS: I send this reply from mutt, which treats text attachments as inline
message body. Other MUAs may handle them differently.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--xJKgfB23nJOZvxI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3yAxAAKCRD2uYlJVVFO
o5zTAP48Iu3i2oXlRiuPxDk9k9tXOroTRMvba4Wh25F+SP+H/wEA1vu+mfKAxiet
Acck0jwHmZavIkRAZnQZ/+ptDY2ZeQc=
=pOE4
-----END PGP SIGNATURE-----

--xJKgfB23nJOZvxI1--
