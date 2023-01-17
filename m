Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9424066D4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjAQDXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjAQDXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:23:48 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5A1ABCC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:23:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 20so4878821plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9SJzG3T1WTFrSpslWTUYlzbc2Fk3qfwj1AXBQ8D6lk=;
        b=gPDVpx7NOcjKo/e/2gu7+waMnPlH3sV6KMbIM4+gLSv7YAW8gKHVMYq/m64BuR1vFk
         vxmq63nHapZcoyz2sOuCjXoMsrsh0qZGusdjKl5HtrrPrq4lInCmh5vOkqkmWM7XDCF3
         iHcMpDcG2BYG3kEPMeYypUEycg5QBTu+nGkosnNnGDkKSPGpkSxV2tB01eCbtZMEEFRY
         FNBO3jXBiEUUof3nDXd3SGOIdf0JSGIC/mzGt6VEOImfuAaWycgJZWyLtR9ItuxeZgRV
         pkClyGM9gyFgZrApVB9SZ6fpZTJYO4Zv7Tds4i91ki+PkidRsOyzUjOavcLT94t24mWa
         oxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9SJzG3T1WTFrSpslWTUYlzbc2Fk3qfwj1AXBQ8D6lk=;
        b=AIN1M3q9W2FtvaUCVdHcwafTYn9gcWA2bpnXSDRFc62ULHQCfmPnDU9uv32VR6pzfe
         2+YatTE5PvE3MXNmE1FPMlKRRxVo7lr5gqK5aooXh9QyvQI7p4xNxADsuPeWwgB9f/9U
         W0P8bEIcvNZFt4xvCoMuF5px1KBgArs5tBU3NECz3aOjhEn96j/8gLxJDCYiIn1EjKIM
         q+6uqtfUe93hSQuN06Lraixq/jF7c3PKtQsLMfVI08sMwYrcAdixp1HVdSpPyw+jp70G
         1xmqSQ1jaJnE0sVllih5E4fnW4pT0aW4R7aaCIUwajjhRERLSHZ+tRxGBzhktJEBjjvI
         PzvA==
X-Gm-Message-State: AFqh2kpvWrZ38ppgEyTsxmvOKzYcSK9VZ7CIZBvoViUfdpl22P2nWtL8
        E67U/42ZBPD/yK+NJA8ho+IkZnG41XU/tA==
X-Google-Smtp-Source: AMrXdXu2S35xjNKVjDpKW5GX9uQlkG3TWgu6HFaZ0IhYg6jLp2DaSuV2vzVKaXW0wCVkK6Hv++gZ1Q==
X-Received: by 2002:a17:902:8a8a:b0:194:480d:6afc with SMTP id p10-20020a1709028a8a00b00194480d6afcmr1713962plo.48.1673925826721;
        Mon, 16 Jan 2023 19:23:46 -0800 (PST)
Received: from debian.me (subs03-180-214-233-20.three.co.id. [180.214.233.20])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b00189c536c72asm20076783plh.148.2023.01.16.19.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 19:23:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4B8ED100300; Tue, 17 Jan 2023 10:23:43 +0700 (WIB)
Date:   Tue, 17 Jan 2023 10:23:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Semen Zhydenko <semen.zhydenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typo in comments
Message-ID: <Y8YUvsLVZZvGZo3T@debian.me>
References: <20230116222254.74479-1-semen.zhydenko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AD3yerrt9pfHvLjN"
Content-Disposition: inline
In-Reply-To: <20230116222254.74479-1-semen.zhydenko@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AD3yerrt9pfHvLjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2023 at 11:22:54PM +0100, Semen Zhydenko wrote:
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 63a8ce7177dd..6430c00b05a9 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1324,7 +1324,7 @@ static int __timer_delete(struct timer_list *timer,=
 bool shutdown)
>  	 * If @shutdown is set then the lock has to be taken whether the
>  	 * timer is pending or not to protect against a concurrent rearm
>  	 * which might hit between the lockless pending check and the lock
> -	 * aquisition. By taking the lock it is ensured that such a newly
> +	 * acquisition. By taking the lock it is ensured that such a newly
>  	 * enqueued timer is dequeued and cannot end up with
>  	 * timer->function =3D=3D NULL in the expiry code.
>  	 *

No patch description, really?

Also please read Documentation/process/submitting-patches.rst for how to
properly submit kernel patches.

--=20
An old man doll... just what I always wanted! - Clara

--AD3yerrt9pfHvLjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8YUugAKCRD2uYlJVVFO
o/N6AQC3i10tp6N0K7qWRDdOBlPoa0P3Z3IuCCazmV1dbhuG9wEAgjrLstwM7GPQ
OAL91lkSKTNzuJPEeV04COm/RMNDPAk=
=W5uy
-----END PGP SIGNATURE-----

--AD3yerrt9pfHvLjN--
