Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F24623606
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKIVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKIVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:47:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CEA2FC16
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:46:59 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v3so17346223pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hp4QvFm+k+5c4Ejq+3JB+myGkwBJdStU8ykSojC7Cmw=;
        b=nOFnuOnb+jf3mboPSPEZTlr97ZS1UEmtec/QQ51W/aJSq1f7Lx1s1OjKsgaWp/RLw1
         BeYnedl3LuKsSVtSEzLLrj3t1pm57zkw2vhF2zQ5Z5RfFPLNwpuxvGNaeuR0w41wQhhD
         GDFx056O6bF6ze5no/gJJrkTn8xWAqm9TnT2ZBGCTmGY6fj5lKfmgL694ekGUFwUTHwW
         oxGQOUNpv+DscowMGBcRxZueX5sjRCn1ZB8wRh1heq+LRy9VPHpMwcqbZXIpV2oFfNnL
         wC9irPhoBmZ64CV32cDo4IjTk/gpqY/rixQawROsDVExART8uWqeW7lD9TdCV9KML955
         mUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp4QvFm+k+5c4Ejq+3JB+myGkwBJdStU8ykSojC7Cmw=;
        b=AyJWM+8JsI/A7KWZl+jmnyUH0u+lvA7hQXEhP8IVp7OOgifSTOdRPyNqt+xDawk+ph
         m6IdsDMzTZIC6X9NMzRQahR6WLgrQJitp1y64tPgtbTfiY/qFXGVph2VSZfwHqZu5jQs
         pR1sXQsJfLQmtTYJkB/UvkUBkAjz2kZ06xJnLZ3vaRURjKyuWZ+z+zYqo3mEqhOx6XjQ
         yxmLdtFQsqImosbhqDyZ/WRmPMhfDz8sLP8mGTKeRehbCZ3vvcfhTAp/hxXc/7XQsrl5
         9C2S1puxbFoVE5ludBL3ZhjZUCQlA9iyKCxB2c9WLtfOCvaQtVaBsu8DHyaw5I/r1PQI
         4ECw==
X-Gm-Message-State: ACrzQf09gefkTbNE+qlsYtNG96wvcnLH0jghsVtQuUj6v3vFNjjcLykF
        TuzEV3LziNDgbyrS3RNx4Ag=
X-Google-Smtp-Source: AMsMyM586i2msH6Zyafndg+P109+NA9tqUjnF7EXoxFGx1SjpUL8W+vcOOAV3eMtD22LdmxlljmdSw==
X-Received: by 2002:a63:fc55:0:b0:46f:81ca:66d2 with SMTP id r21-20020a63fc55000000b0046f81ca66d2mr53636220pgk.179.1668030418339;
        Wed, 09 Nov 2022 13:46:58 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8514:5da3:d38f:7bd])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b0018699e6afd8sm9498817pll.265.2022.11.09.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:46:57 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 9 Nov 2022 13:46:56 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 00/13] zram: Support multiple compression streams
Message-ID: <Y2wf0EnFLZwLYMS8@google.com>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:50:34PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> 	This series adds support for multiple compression streams.
> The main idea is that different compression algorithms have different
> characteristics and zram may benefit when it uses a combination of
> algorithms: a default algorithm that is faster but have lower
> compression rate and a secondary algorithm that can use higher
> compression rate at a price of slower compression/decompression.
> 
> 	There are several use-case for this functionality:
> 
> - huge pages re-compression: zstd or deflate can successfully
> compress huge pages (~50% of huge pages on my synthetic ChromeOS
> tests), IOW pages that lzo was not able to compress.
> 
> - idle pages re-compression: idle/cold pages sit in the memory
> and we may reduce zsmalloc memory usage if we recompress those
> idle pages.
> 
> 	User-space has a number of ways to control the behavior
> and impact of zram recompression: what type of pages should be
> recompressed, size watermarks, etc. Please refer to documentation
> patch.
> 
> v5:
> -- Addressed (very valuable) review feedback from Minchan
> -- Extended documentation
> -- We now do chain recompression, tryin algos in order of their priority
> -- Support up to 4 compression streams
> -- Added named parameters to recomp_algorithm and recompress sysfs knobs
> -- Cherry-picked patch from Alexey
> -- Store algo priority in mete flags
> -- Renamed some fo the flags
> -- Added incompressible bit to block state output
> -- Added incompressible writeback
> -- etc.
> 
> v4:
> -- added IS_ERR_VALUE patch (Andrew)
> -- documented SIZE units (bytes) (Andrew)
> -- re-phrased writeback BIO error comment (Andrew)
> -- return zs_malloc() error code from zram_recompress()
> -- do not lose zram_recompress() error in recompress_store()
> -- corrected a typo
> -- fixed previous rebase errors
> -- rebased the series
> 
> v3:
> -- conditionally reschedule during recompression loop so that
>    we don't stall RCU grace periods
> -- fixed a false-positive WARN_ON
> 
> v2:
> -- rebased
> -- mark completely incompressible pages (neither default nor secondary
>    algorithm can compress them) with a new flag so that we don't attempt
>    to recompress them all the time
> 
> Alexey Romanov (1):
>   zram: add size class equals check into recompression
> 
> Sergey Senozhatsky (12):
>   zram: Preparation for multi-zcomp support
>   zram: Add recompression algorithm sysfs knob
>   zram: Factor out WB and non-WB zram read functions
>   zram: Introduce recompress sysfs knob
>   zram: Add recompress flag to read_block_state()
>   zram: Clarify writeback_store() comment
>   zram: Use IS_ERR_VALUE() to check for zs_malloc() errors
>   zram: remove redundant checks from zram_recompress()
>   zram: Add algo parameter support to zram_recompress()
>   documentation: Add zram recompression documentation
>   zram: add incompressible writeback
>   zram: Add incompressible flag to read_block_state()
> 
>  Documentation/admin-guide/blockdev/zram.rst | 100 +++-
>  drivers/block/zram/Kconfig                  |   9 +
>  drivers/block/zram/zcomp.c                  |   6 +-
>  drivers/block/zram/zcomp.h                  |   2 +-
>  drivers/block/zram/zram_drv.c               | 604 +++++++++++++++++---
>  drivers/block/zram/zram_drv.h               |  22 +-
>  include/linux/zsmalloc.h                    |   2 +
>  mm/zsmalloc.c                               |  21 +
>  8 files changed, 685 insertions(+), 81 deletions(-)

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
