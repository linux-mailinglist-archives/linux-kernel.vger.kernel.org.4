Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFDA60211B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJRCWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJRCWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:22:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C578C45D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:22:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so12770332pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2UmYtYjB3AxW1v3oEIm4p6bkGOjTrsw0+F1/l8EfQ4=;
        b=b1hu7ojoi04IWcUltg0vD2rHPPCwbkSM7u1EyZVNvOKIkRf0CR2h6GHUVQzmndNmGJ
         7zOa40s5AyDbIAjPUJr/RpeULlFt3kI6O1C4C0Vc3K/spnhczvyrg3FCLKgeBCQoocIy
         gPi6CZMHhqDoVhrOBetW71xHW1rScgaN31mjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2UmYtYjB3AxW1v3oEIm4p6bkGOjTrsw0+F1/l8EfQ4=;
        b=0Q36NOkxjDTgZuNT1HHRhcC602EfGNY9FVXwZSIPeQ+99yukk184uCXtNwK3ki5kWr
         iD1KjnI34SRFzzRkONirlX6sJ1ZjVQlCtQ46BQqCnWzsA3FM8Jq2nrXpJyKw3Uv1WdYV
         I9vEGeT+Scxmu8cgA1JuH6BJgJX5fPQfYRaEICYr2vsV5lY7vkwAkB6Mf8vnbZJd44Iq
         3VZfcbvgmYPYS+OM5dVh6k4ZeBuNM86djzhloSEOHCg6SGIQbhHSCa28WXJJ5Pq+0tXJ
         jqogNxpd6LHjwLZtlc7VFoazs4Fhx0qSeRhj36tjCU+UwoG/3SeQUiZPi6Om5mt5XrfJ
         2ClA==
X-Gm-Message-State: ACrzQf1qbtzRm0zsWP6ybldFAaM5wFKu31VUtDK2/6XSXII00ITjAdQe
        TGXDNlsd6ZnCkqfSn8weQ+nVNw==
X-Google-Smtp-Source: AMsMyM7A8XtbcwUptDkHdwZmNanZOncg2z0TA8C/gn+eXyyK7g3TV09fnICR487iCCKWbWayaKjYLg==
X-Received: by 2002:a63:1165:0:b0:44d:e5ba:5603 with SMTP id 37-20020a631165000000b0044de5ba5603mr732838pgr.68.1666059750422;
        Mon, 17 Oct 2022 19:22:30 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00178b06fea7asm7337236plg.148.2022.10.17.19.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:22:30 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:22:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 5/8] documentation: Add recompression documentation
Message-ID: <Y04N4YkBFl2+STBB@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
 <20221009090720.1040633-6-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009090720.1040633-6-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/09 18:07), Sergey Senozhatsky wrote:
[..]
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 12368e773f3d..143c33bd6783 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1623,9 +1623,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>   *
>   * Corresponding ZRAM slot should be locked.
>   */
> -static int zram_recompress(struct zram *zram,
> -			   u32 index,
> -			   struct page *page,
> +static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  			   int size_watermark)
>  {
>  	unsigned long handle_prev;
> @@ -1708,8 +1706,7 @@ static int zram_recompress(struct zram *zram,
>  
>  static ssize_t recompress_store(struct device *dev,
>  				struct device_attribute *attr,
> -				const char *buf,
> -				size_t len)
> +				const char *buf, size_t len)
>  {
>  	struct zram *zram = dev_to_zram(dev);
>  	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;

D'oh, this patch should not contain any code changes, only
documentation updates. It's the previous patch in the series
that should contain these coding-style tweaks. Rebasing did
not go spectacularly well here...

Andrew, what's the best way to handle this?
