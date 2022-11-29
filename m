Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748E63C06F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiK2Mzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiK2MzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:55:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0C61758
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id h28so17492pfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftiXgz+B+vOpBcYXy4A3YnZ9vOuM4Xrk8do1SJNwvNw=;
        b=S5fONXt/GZUX+VPNjQ8wjwvgj1L5o3FEQEHgHst+0zUCcE6FDhY9qA+zTRXofJWDW+
         c1oAAENRW4wu99+WAh4Vgan0DVieGb0G6LKgnn02xsYsYbMRyY3yLSKgwC2bkcWKRmBc
         bDrqshM+GcRK37/bOVIsjF6lyTdj5wKLTGcm4VCfF62BOI32ewCviQll4UrgRSE+EDuz
         /KABiRD982+xl3jCI0U/eSW2IVTUNnwtk/DEmuMjN03fbb/IpniiTCXHrxJzRH8eNa0b
         twd+x0dflgEk2FVaQ4LlbfaHNgCE5dodml94qdwNYMYbgXLNU0muZ/UOfp/iKmHP+LbU
         mD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftiXgz+B+vOpBcYXy4A3YnZ9vOuM4Xrk8do1SJNwvNw=;
        b=zt/7rICMHDbM0F2b7bMLnoNRKN/h3fx05MJVxVer64U0oqmeI2Nakrgj9ItsdaVWhD
         NhKALVARFRqC8/R7nP1h/6VomRhtMhE8NWNC4O8uwh31S1KSvwvq0fjy5DySRJIP2T1B
         Kv+ZllzeXRSPc1qNpEKuD+Lqq/JSI8Ki9MyC+7D6aQ8uonLTR4engxWGWTERV3tUKdH5
         JCD/Oov8ZoNAVdFxtE2W0tVKGJ2dSaaviLKb2IHiLvfJORI1ixvD/IpD5vk+BWpU7aBv
         Ky+S+L/Ocsmgi0wx6v0j6nDLa3JxJmswUKypjY9TXJs1wa5+TosPZCJoYGuXaPCG0pXp
         5CpA==
X-Gm-Message-State: ANoB5pnmBMueIShBxHZo1NRw8ircaWKFglUbGCSbEodDjOzxPXZgjh7C
        1d3jaNny6SrANxKNFns/HaYVTYXiV1Mt1xQ+tpwupA==
X-Google-Smtp-Source: AA0mqf4tRavSghmd641vpAo8y9apdqARGkKzA4fKbaIkdh0gUAGATXJxxpWIxwsXpsKsxP6JAgnBU3+euq7f+fKIv6s=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr31160049pgb.541.1669726512135; Tue, 29
 Nov 2022 04:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:35 +0100
Message-ID: <CAPDyKFo6jyL+A82w+ixBgHdAjTry4LiqOU6i0yFzoS-0nntMtg@mail.gmail.com>
Subject: Re: [PATCH v2] memstick/ms_block: Add check for alloc_ordered_workqueue
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     error27@gmail.com, maximlevitsky@gmail.com, oakad@yahoo.com,
        christophe.jaillet@wanadoo.fr, axboe@kernel.dk, hare@suse.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 at 02:26, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_ordered_workqueue may return NULL pointer,
> it should be better to add check for the return
> value.
> Moreover, the msb->io_queue should be freed if error occurs later.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for next (replaced the earlier applied v1 with v2), thanks!

Kind regards
Uffe


> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Assign error number to rc if alloc_ordered_workqueue fails.
> 2. Free msb->io_queue if error occurs later.
> ---
>  drivers/memstick/core/ms_block.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index ba8414519515..04115cd92433 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2116,6 +2116,11 @@ static int msb_init_disk(struct memstick_dev *card)
>         dbg("Set total disk size to %lu sectors", capacity);
>
>         msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
> +       if (!msb->io_queue) {
> +               rc = -ENOMEM;
> +               goto out_cleanup_disk;
> +       }
> +
>         INIT_WORK(&msb->io_work, msb_io_work);
>         sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
>
> @@ -2125,10 +2130,12 @@ static int msb_init_disk(struct memstick_dev *card)
>         msb_start(card);
>         rc = device_add_disk(&card->dev, msb->disk, NULL);
>         if (rc)
> -               goto out_cleanup_disk;
> +               goto out_destroy_workqueue;
>         dbg("Disk added");
>         return 0;
>
> +out_destroy_workqueue:
> +       destroy_workqueue(msb->io_queue);
>  out_cleanup_disk:
>         put_disk(msb->disk);
>  out_free_tag_set:
> --
> 2.25.1
>
