Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E151862E3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiKQSHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiKQSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:07:06 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622E697D2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:07:04 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e15so1620417qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HPIXQbIrPnuqK125OGbmjGgvwi+I/0K6FJ7sbpZHi0=;
        b=nAEb4V+rPllk4yYfIKmhZuBLFGuUNzw4u9T5qf6/naX6NI/vvSZsg6P9EQXt0HvJCn
         3cPXYuiUgg7ZM8+T+N+/C4WEs4m5Jm/RPrO7DLtmw1XV+94gVpFMLDi8qfyWUbSOtCmg
         YZv4roOTmITs4+PiJVPVdX7z71XMOYCkF6+p67ml48vveURuDGWswXGSnWNkSFtEzOow
         /2EEi2WJKFL/2GQAlIB+ALJ2D1yuSNie57I6z+BENl2rLkgfYQE/LN5i3aVziADhGWJY
         5GxzMqekQeJMlU2SlBJMQJU43fLHyG02Oy0KJ1YtAAUoB3d7C13rrsCygGBGZCFANdiv
         MeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HPIXQbIrPnuqK125OGbmjGgvwi+I/0K6FJ7sbpZHi0=;
        b=MVLD0Z+LqzRuElesN+2poczkKGHj0cswb+SSeS6Qi0uhpOP/czi+/RK4FoUvU2BiOT
         J3VHqzaseGtJF9fbrQgFjRpnucdgMPGYnbgsVryO7y9aEU7XYW+GESbV4NElpczOEhr5
         F53YZHt6tCvGwBoGq0+4+6L5UVkU7N70oRtvYNTYL5P6Gl6KhpzwTRLiG0RstneNgSK6
         1d5HC24G3Gh/9Jrv/62BgmfpJ5nBIsG9ZIIFHKm7Pl3s/oTXYBkctS2Uw0LsC/lyf3TN
         ok9hCXFtto7u/2YNA0mDdaQeOnSAjQZjlRBmjv41NufzrO1DbYouIgN68WWn/39cmMRl
         bSQg==
X-Gm-Message-State: ANoB5plKLlg52zv3192wWb8VmkKsQoSSbPGuhcOh4OLmyXS2A7A46T1n
        EiYj5Zh91WtHmDGjatB2dT3hHCX4dV8MYQ==
X-Google-Smtp-Source: AA0mqf4CgakhwYHpec/A0fPHzxBoFCwV3ijijJ39AMA/ov/Z3Txnly7AUnen6dCUMERwaQfYlsO/sA==
X-Received: by 2002:ac8:108d:0:b0:391:6892:16cb with SMTP id a13-20020ac8108d000000b00391689216cbmr3310779qtj.332.1668708423959;
        Thu, 17 Nov 2022 10:07:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fb8239db65sm813592qkp.43.2022.11.17.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:07:01 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:07:24 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chao Xu <amos.xuchao@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chao Xu <Chao.Xu9@zeekrlife.com>,
        yu@cmpxchg.org
Subject: Re: [PATCH v1] mm/vmscan: simplify the nr assignment logic for pages
 to scan
Message-ID: <Y3Z4XMKvcBOAwZvU@cmpxchg.org>
References: <20221110113130.284290-1-Chao.Xu9@zeekrlife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110113130.284290-1-Chao.Xu9@zeekrlife.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 07:31:30PM +0800, Chao Xu wrote:
> By default the assignment logic of anonymouns or file inactive
> pages and active pages to scan using the same duplicated code
> snippet. To simplify the logic, merge the same part.
> 
> Signed-off-by: Chao Xu <Chao.Xu9@zeekrlife.com>
> ---
>  mm/vmscan.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04d8b88e5216..69e458e51c81 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5932,14 +5932,11 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  		 * scan target and the percentage scanning already complete
>  		 */
>  		lru = (lru == LRU_FILE) ? LRU_BASE : LRU_FILE;
> -		nr_scanned = targets[lru] - nr[lru];
> -		nr[lru] = targets[lru] * (100 - percentage) / 100;
> -		nr[lru] -= min(nr[lru], nr_scanned);
> -
> -		lru += LRU_ACTIVE;
> -		nr_scanned = targets[lru] - nr[lru];
> -		nr[lru] = targets[lru] * (100 - percentage) / 100;
> -		nr[lru] -= min(nr[lru], nr_scanned);
> +		for ( ; lru <= lru + LRU_ACTIVE; lru += LRU_ACTIVE) {

As Yu points out, this will loop until lru overflows.

NAK.
