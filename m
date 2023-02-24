Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5B6A1B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBXLIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBXLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:07:46 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA8448A;
        Fri, 24 Feb 2023 03:06:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id bn17so1691808pgb.10;
        Fri, 24 Feb 2023 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F5kh1fzvUgUk/w1qLsxSxKG9Kl1fSNnNnBOIZOF4L7I=;
        b=WHBcrjNROiRHnYaDmxtq5sA1nFH8Bz5pluH7c+KV+iml30dLeMmLhRgwndHtgvhn4q
         j/aLvAo0qGL6lkhr6FzY2SwLNtnIoPhe6gAN3Y1yzBmb4LWdyZV3zpARtgj7vs3kRBpQ
         rRNFYQUaa2AiFqJzR2pFMAs1JHayazuJeops4W9XiMoEH8owevSoYVjQhYuRJF1xd9RR
         jT7IcPUspt1BhOEvK77XMN4vyFT+FuuhGweOZIEiCKDJP4W+pfryBCWXAetj9ILnlZDk
         56RpxxyjVdB8/OtTYLnx3aWE/+votCpEVvRK9vX/ZVmXa8u7ba8/wl87w3kvjUTs3E5F
         qTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5kh1fzvUgUk/w1qLsxSxKG9Kl1fSNnNnBOIZOF4L7I=;
        b=NYXaI4e1+bP2AYqivH4n7cG0agJNBYQxAxvq1Lf1Fc5FHR5appFJ2QgJxJ9qCjqHPu
         tauJNtQqiqPCbDVTNVg/eSi8LrLAtshJmsxm92xgihfBHAcaObA8lLHyg5tFSiQng+/W
         exuz5gs2VWwfv/vf3/kzaA97O+Yhgjxh1e7cF3D+ksnZd+ZN9VVh5GWi2UXVLrC+cTgc
         ve54D24cfW8lBMCadSeYVbvhPM46PgyS9PG5rAuRF4h4Du6M9fXRTbcquRqCvjeie0gc
         i/AibWAy7RtP6TokLx2Q9brI1dW2XYqgga/ko9iv8E4A9HBTNzrvCv6uEcSH7NcwYCKm
         OAVg==
X-Gm-Message-State: AO0yUKVOL5cHuDzzh0ccu2HGzCDGZVm+Yr1WL19cz7z7WUguqAnyxDBx
        LBA+dopsmfnlQPxP0lqspgl+qaZoXPvZav3+qfnhXZzZ+pWadw2lsVk=
X-Google-Smtp-Source: AK7set+e+TsRwRrzJh5Bc2e6/7zacw4W3BBD+1YIP0OY61aC9aEfrQT4F0JhVm0U1yHDLsuoReiVriaBzQ+ADmFReUY=
X-Received: by 2002:a63:3687:0:b0:4fb:a28e:fa50 with SMTP id
 d129-20020a633687000000b004fba28efa50mr2743073pga.8.1677236775261; Fri, 24
 Feb 2023 03:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20230224092044.3332374-1-void0red@gmail.com>
In-Reply-To: <20230224092044.3332374-1-void0red@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 24 Feb 2023 19:03:27 +0800
Message-ID: <CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: add return value check of kzalloc in mv_udc_probe
To:     void0red <void0red@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 5:28 PM void0red <void0red@gmail.com> wrote:
>
> From: Kang Chen <void0red@gmail.com>
>
> Even an 8-byte kzalloc will fail when we don't have enough memory,
> so we need a nullptr check and do the cleanup when it fails.
>
> Reported-by: eriri <1527030098@qq.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081
>
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index b397f3a84..6dd6d52de 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2230,6 +2230,10 @@ static int mv_udc_probe(struct platform_device *pdev)
>
>         /* allocate a small amount of memory to get valid address */
>         udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);

Hi Kang and gregkh,

I think there is a memory leak in this kzalloc. It seems there is no
deallocation for this allocated object.

As the surrounding allocation statements suggest,
we should turn kzalloc to devm_kzalloc.

> +       if (!udc->status_req->req.buf) {
> +               retval = -ENOMEM;
> +               goto err_destroy_dma;
> +       }
>         udc->status_req->req.dma = DMA_ADDR_INVALID;
>
>         udc->resume_state = USB_STATE_NOTATTACHED;
> --
> 2.34.1
>
