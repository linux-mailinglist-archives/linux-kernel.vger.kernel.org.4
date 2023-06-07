Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63D725DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbjFGMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjFGMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:05:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527911BC3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:05:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b00ed75e34so5751025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686139546; x=1688731546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS7Z42EW7XAxMcgq+p13mhi//7uS3x6SIlxeyKA+EP4=;
        b=oqrC3TFUhcvR0ossp4ZlDHB0xJtWulZlf7h2soXjDUkv7blm6R1WfFN449YIiuKuDz
         mgdti/K6xzdIVMux2rGCtKA8uXcn7V0s5HHYi51T0mXga6rVkXYvNSVLPA3AklvOrxiL
         n1Lt8N5F/nofr6Pmc6pc8N+JZ22BIQZ2PqCAqC0ebvUC3JErVDH6PAe0WObcKTS/WX04
         1xn0dYujX5eH2mrqSIOOecCXbzRbeSxfNxvj2c0KTXeX4NAIp/gaPEFMeLzcWTVXUFTf
         8xCuXZn0y0Qioy8vakU7v9Nkl5jIBHb5JkfKeAR137JH8Vi0M4bxKL+kom5B3NA7zjWN
         PPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686139546; x=1688731546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS7Z42EW7XAxMcgq+p13mhi//7uS3x6SIlxeyKA+EP4=;
        b=BBSDkI/VUARV67Y8C5inz8Xqx6X1Wjb1sbsV2+e8aYEF0JU7XKGBnGTIBC2UxXQtGG
         pSaxTHUyh+qLzzLTdlO3D9vpRI0ySWiBJiPSx8Bu0n9idr5ZofJdQI7g2OBoNFdSJh2X
         3z3gUQ4AXP9RIH5WLLw5mt7hP+9xgFM1DwxGTLQJFrDSXPMqs1tSCT9jpIMT7wAaHLqw
         WgmRs/HoCLc48UI0nDjSDJuQl/Zz7Vh2aZhcsTuMCFZBypE6U9j90WqpSrQv5LLqNnVv
         VGp8wYvKxYIAprb6Oqsrybu6yyMvconXpGghntkxBO3LMSNPxuvO9Ui5H/48h/MV413s
         JiyA==
X-Gm-Message-State: AC+VfDxJXbufQcNEigXi8Z9k/f10aBebpFZ0R2nBElDqTXG8x3CGjNdJ
        PYOPdNKo3LAOBO0AMPOQRi2Enom7H7J5Cj3hWrY23Pm5axc=
X-Google-Smtp-Source: ACHHUZ5efRAX0SL46b5H6Q6gr1oZrJor/3uT2D9/aV6Sb58RAQTJO2WSIRHYsYmv6RkmPW1F1DmXt9i7xU/zyE4MM5U=
X-Received: by 2002:a17:902:e807:b0:1ae:8595:14b with SMTP id
 u7-20020a170902e80700b001ae8595014bmr1860873plg.6.1686139545547; Wed, 07 Jun
 2023 05:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5A6MoDDLmQHoFCvewjpuPhC8_nbOVrKZR9d8Fn1d+3VgQ@mail.gmail.com>
 <20230607053758.GA20425@lst.de>
In-Reply-To: <20230607053758.GA20425@lst.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Jun 2023 09:05:33 -0300
Message-ID: <CAOMZO5AmGHHs-aiBJz5rDO6bV0f2sNjOYkqQDewGPOvw_zQ=5w@mail.gmail.com>
Subject: Re: rootwait regression in linux-next
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Jun 7, 2023 at 2:38=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Hi Fabio,
>
> can you try this patch?
>
> diff --git a/block/early-lookup.c b/block/early-lookup.c
> index 3ff0d2e4dcbfb8..ca3b4f494c9330 100644
> --- a/block/early-lookup.c
> +++ b/block/early-lookup.c
> @@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name,=
 dev_t *devt)
>         while (p > s && isdigit(p[-1]))
>                 p--;
>         if (p =3D=3D s || !*p || *p =3D=3D '0')
> -               return -EINVAL;
> +               return -ENOENT;

Unfortunately, it does not help.

I have added some debug prints:

--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -157,15 +157,21 @@ static int __init devt_from_devname(const char
*name, dev_t *devt)

        if (strlen(name) > 31)
                return -EINVAL;
+
+       pr_err("***** %s: 1\n", __func__);
        strcpy(s, name);
        for (p =3D s; *p; p++) {
                if (*p =3D=3D '/')
                        *p =3D '!';
        }
+
+       pr_err("***** %s: 2\n", __func__);

        *devt =3D blk_lookup_devt(s, 0);
        if (*devt)
                return 0;
+
+       pr_err("***** %s: 3\n", __func__);

        /*
         * Try non-existent, but valid partition, which may only exist afte=
r
@@ -174,7 +180,9 @@ static int __init devt_from_devname(const char
*name, dev_t *devt)
        while (p > s && isdigit(p[-1]))
                p--;
        if (p =3D=3D s || !*p || *p =3D=3D '0')
-               return -EINVAL;
+               return -ENOENT;
+
+       pr_err("***** %s: 4\n", __func__);

        /* try disk name without <part number> */
        part =3D simple_strtoul(p, NULL, 10);
@@ -182,14 +190,18 @@ static int __init devt_from_devname(const char
*name, dev_t *devt)
        *devt =3D blk_lookup_devt(s, part);
        if (*devt)
                return 0;
+
+       pr_err("***** %s: 5\n", __func__);

        /* try disk name without p<part number> */
        if (p < s + 2 || !isdigit(p[-2]) || p[-1] !=3D 'p')
                return -EINVAL;
+       pr_err("***** %s: 6\n", __func__);
        p[-1] =3D '\0';
        *devt =3D blk_lookup_devt(s, part);
        if (*devt)
                return 0;
+       pr_err("***** %s: 7\n", __func__);
        return -EINVAL;
 }

[    1.627144] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using =
ADMA
[    1.629380] mmcblk2rpmb: mmc2:0001 DG4016 4.00 MiB, chardev (241:0)
[    1.664895] ***** devt_from_devname: 1
[    1.668681] ***** devt_from_devname: 2
[    1.672467] ***** devt_from_devname: 3
[    1.676230] ***** devt_from_devname: 4
[    1.680011] ***** devt_from_devname: 5
[    1.683778] ***** devt_from_devname: 6
[    1.687546] ***** devt_from_devname: 7
[    1.691314] Disabling rootwait; root=3D is invalid.
[    1.696842] /dev/root: Can't open blockdev
[    1.700988] VFS: Cannot open root device "/dev/mmcblk1p1" or
unknown-block(0,0): error -6

Let me know if you need me to run more debugging tests.
