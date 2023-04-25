Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED11E6ED91D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 02:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjDYADp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjDYADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 20:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD115274;
        Mon, 24 Apr 2023 17:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A7D462A62;
        Tue, 25 Apr 2023 00:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB5C433A0;
        Tue, 25 Apr 2023 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682381020;
        bh=trnIgor0xX4q/91c1oebGULzgj8kBzmPIz2WyUUR4fs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dsfphbNwZy7ol45+HO89fFOFBVmbtLKbVFYU0+3lRL47HiJpa9sHbkNeu0acGZDcH
         RaYMGES44ByO2JY0pyqpUsucD8TQJvyhwHquSnu5mfTOK1ctKl8hspfTPmvrC7rOWo
         vXjmS/s7bRIP7nWuDV0rzNvUpqk84YX7PSDz9xeJFZul4hjgd981THJWdaIunfBQm3
         tV5eImY6lSCVLEmgQR3bRqFmecC9WtkV0X18EuXi/1DjcadULIAB5j3JW9g7dUwOku
         uM1ppt6wnHBzvVfN16WWpQmSgvphrlVCkEFR9E9PKIgClRUTtyRqmaIHg+d9sAK9B3
         Dj/gTmXGNB8UQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so49564221fa.2;
        Mon, 24 Apr 2023 17:03:40 -0700 (PDT)
X-Gm-Message-State: AAQBX9eSaF3AgWXHPbCRyhrvNV7pO94+A9L6ZbAVBIXogDMvyKQKxJ3k
        ziNb1c3pQjIcjRtRjjiYbmVtXyduESEINkWRsOA=
X-Google-Smtp-Source: AKy350ZiHWzjvuohgc2eExj8R1+yFM6oSnpZL9ryV43iQZLSMYrd9ACKtxWUQihomvfECH65Xw2YSp2gSRleLGF+78g=
X-Received: by 2002:a2e:9595:0:b0:2a8:c249:63a4 with SMTP id
 w21-20020a2e9595000000b002a8c24963a4mr2976379ljh.47.1682381018366; Mon, 24
 Apr 2023 17:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com> <20230420112946.2869956-3-yukuai1@huaweicloud.com>
In-Reply-To: <20230420112946.2869956-3-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Apr 2023 17:03:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6QSuB3vVCPN3Dt3tab-_4C8_7+kmAAe05GB0oBNX-bSA@mail.gmail.com>
Message-ID: <CAPhsuW6QSuB3vVCPN3Dt3tab-_4C8_7+kmAAe05GB0oBNX-bSA@mail.gmail.com>
Subject: Re: [PATCH -next 2/8] md/raid1-10: rename raid1-10.c to raid1-10.h
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@osdl.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 4:31=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> raid1-10.c contains definitions that are used both for raid1 and raid10,
> it's werid to use ".c" suffix.

type: weird.

Please see the original discussion about raid1-10.c here:

https://lore.kernel.org/linux-raid/20170712082912.491-1-ming.lei@redhat.com=
/

Let's keep raid1-10.c for now.

Thanks,
Song

>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/{raid1-10.c =3D> raid1-10.h} | 10 +++++++---
>  drivers/md/raid1.c                    |  2 --
>  drivers/md/raid1.h                    |  2 ++
>  drivers/md/raid10.c                   |  2 --
>  drivers/md/raid10.h                   |  2 ++
>  5 files changed, 11 insertions(+), 7 deletions(-)
>  rename drivers/md/{raid1-10.c =3D> raid1-10.h} (92%)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.h
> similarity index 92%
> rename from drivers/md/raid1-10.c
> rename to drivers/md/raid1-10.h
> index e61f6cad4e08..04beef35142d 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.h
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#ifndef _RAID1_10_H
> +#define _RAID1_10_H
> +
>  /* Maximum size of each resync request */
>  #define RESYNC_BLOCK_SIZE (64*1024)
>  #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
> @@ -33,7 +36,7 @@ struct raid1_plug_cb {
>         struct bio_list         pending;
>  };
>
> -static void rbio_pool_free(void *rbio, void *data)
> +static inline void rbio_pool_free(void *rbio, void *data)
>  {
>         kfree(rbio);
>  }
> @@ -91,8 +94,8 @@ static inline struct resync_pages *get_resync_pages(str=
uct bio *bio)
>  }
>
>  /* generally called after bio_reset() for reseting bvec */
> -static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pag=
es *rp,
> -                              int size)
> +static inline void md_bio_reset_resync_pages(struct bio *bio,
> +                                            struct resync_pages *rp, int=
 size)
>  {
>         int idx =3D 0;
>
> @@ -109,3 +112,4 @@ static void md_bio_reset_resync_pages(struct bio *bio=
, struct resync_pages *rp,
>                 size -=3D len;
>         } while (idx++ < RESYNC_PAGES && size > 0);
>  }
> +#endif
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 2f1011ffdf09..84724b9b20b8 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -49,8 +49,6 @@ static void lower_barrier(struct r1conf *conf, sector_t=
 sector_nr);
>  #define raid1_log(md, fmt, args...)                            \
>         do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid1 " fmt=
, ##args); } while (0)
>
> -#include "raid1-10.c"
> -
>  #define START(node) ((node)->start)
>  #define LAST(node) ((node)->last)
>  INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, _subtree_last,
> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
> index 468f189da7a0..80de4d66f010 100644
> --- a/drivers/md/raid1.h
> +++ b/drivers/md/raid1.h
> @@ -2,6 +2,8 @@
>  #ifndef _RAID1_H
>  #define _RAID1_H
>
> +#include "raid1-10.h"
> +
>  /*
>   * each barrier unit size is 64MB fow now
>   * note: it must be larger than RESYNC_DEPTH
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index a116b7c9d9f3..50d56b6af42f 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -77,8 +77,6 @@ static void end_reshape(struct r10conf *conf);
>  #define raid10_log(md, fmt, args...)                           \
>         do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid10 " fm=
t, ##args); } while (0)
>
> -#include "raid1-10.c"
> -
>  #define NULL_CMD
>  #define cmd_before(conf, cmd) \
>         do { \
> diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
> index 63e48b11b552..63e88dd774f7 100644
> --- a/drivers/md/raid10.h
> +++ b/drivers/md/raid10.h
> @@ -2,6 +2,8 @@
>  #ifndef _RAID10_H
>  #define _RAID10_H
>
> +#include "raid1-10.h"
> +
>  /* Note: raid10_info.rdev can be set to NULL asynchronously by
>   * raid10_remove_disk.
>   * There are three safe ways to access raid10_info.rdev.
> --
> 2.39.2
>
