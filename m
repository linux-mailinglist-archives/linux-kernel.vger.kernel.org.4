Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C295B5C46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiILOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:34:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D707822BF6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:34:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so20732471ejy.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uYOwHPrZ9XyxTOtlccDn6qOFmzbJ7UDLZC4VbrgDT+4=;
        b=FwzaUyY5CeDqKxBd3UW5N6QM+f168AEPUer0x1lMKzVEpDhfS4e/jcc6bhNyrw7gWp
         8PZ8jeXPCbicqQ3TfwKikEPuXLyyegysZSbthowWLCp9Vn1bUQILsGOQD45cWYnlXRuN
         HHgbbEoPrSwfqSkP9g9aSrAo5EvHil34lqilXBgyY96W11rNZfaStRWziqiY+eLrGcVs
         jAhf4lNnaxUS0hDZBzXuIuBeRe44nL/Jjuuv/xlYtX8AxrdK16wajYqbWnccOMKLye6W
         J5uXC4vuXTsSU+r87VlrNLhgUEFVxXZlsEWNf27cL69b4u3xauf3AjbwBDvR1xjJeG9m
         GERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uYOwHPrZ9XyxTOtlccDn6qOFmzbJ7UDLZC4VbrgDT+4=;
        b=oVW1SVT2TPA5cK+s4QvzLvi4RfAM2J8Eyy7PeXZhgcfT9wbEtbgxF+wfiGib7nfURx
         gabJmUJGIUpNs2Z2MTn3GDsTwiZj32Ioly5WQ0cQ0oXfFj4hQnG6dLwagK4nphXOIP3S
         eoNlMiAeRnyBW53ZPoXCruUcU/CpJ0h27x1rHlyro2EW1C42rmw8/THsGuA/+MRvbT4j
         Wi8Z5vNc38T1AnaYKbjnkH6UyRVV+WZOn5n7RWAMzSGeLYovbpPXy3nkmY/8PtAKD04u
         d4MOWhIBnxgYxYgZXLp5gyle7GFuh3BeAa8W+i0BvkTqpOasOeSFjy7MZlFRDG5rffLv
         3gLA==
X-Gm-Message-State: ACgBeo0/d6voep4LjPtYENzgZVmwq0wGYT+6RlCcnnkHGvXYmQkBWnkX
        amUQdg4/qmAb6WpfGmeFsB3AV7FWqgo5zI7u3FTurw==
X-Google-Smtp-Source: AA6agR4WbTLWBC3++mrdPKVefwJu91nONFi64/qq9hSZUhPzqsqEg8yyFaqkCXg7N6cZDHgG1lAADDeiJ2ODzq5Qggk=
X-Received: by 2002:a17:907:3fa5:b0:77d:41c0:e2f3 with SMTP id
 hr37-20020a1709073fa500b0077d41c0e2f3mr4055186ejc.741.1662993242447; Mon, 12
 Sep 2022 07:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220912154219.162eb9d3@canb.auug.org.au>
In-Reply-To: <20220912154219.162eb9d3@canb.auug.org.au>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 12 Sep 2022 08:33:50 -0600
Message-ID: <CANLsYkyRkWSitRQRJxHxy_S8013pef0YXCftU8SZvNknbRLszQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the coresight tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sept 2022 at 23:42, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the coresight tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/hwtracing/ptt/hisi_ptt.c:13:10: fatal error: linux/dma-iommu.h: No such file or directory
>    13 | #include <linux/dma-iommu.h>
>       |          ^~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
>
> interacting with commit
>
>   f2042ed21da7 ("iommu/dma: Make header private")
>
> from the iommu tree.
>
> Since the public interfaces in dna-iommu.h were moved to iommu.h, I have
> applied the following merge fix patch:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 12 Sep 2022 15:35:37 +1000
> Subject: [PATCH] hwtracing: hihi_ptt: fix up for "iommu/dma: Make header private"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for the leg work on this.  I will apply this patch to the CS tree.

Mathieu

>
>
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 666a0f14b6c4..5d5526aa60c4 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -10,7 +10,6 @@
>  #include <linux/bitops.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/delay.h>
> -#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> --
> 2.35.1
>
> --
> Cheers,
> Stephen Rothwell
