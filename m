Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A515F2886
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJCGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:18:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76C2A246
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 23:18:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so8901668pgb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RvW7NqWWcmsZSOmiqcmfGnzINMQt2bw0vz9RsBO9kPs=;
        b=HXb3QAu2zKmNgf7gcgI3SCkJyErQhqouY5lkfPhocgQOtCQKCNyq57wJ9ncZNM7I/e
         rEuT3hCHAvdQm+WtfinCBuu3TVo7pvSc0YzaimSu9awPZFi/Ru/VHe2ImbfEfO3AePGV
         DwNeCQU+5ys1FtQludDCUj1R7axXNS8PJQXh5YpKrTuAaImyZoeWZr5gbxqGE4rViZTK
         WpbZP3lbDJYhihKcEA3rM8WLrhHZhJwEwuQ32FnTrkn1dyC6BGUF0En9Bs3T8ZbCyFvw
         +gf+gfrYNi1Mi2mCbqDIfBWzqywXnunO7Z5xcGRXr30PQqU4unEIetPwdIRfxKIYeZWt
         HCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RvW7NqWWcmsZSOmiqcmfGnzINMQt2bw0vz9RsBO9kPs=;
        b=E5MMBju2O3L0owS3COiMwVymsNqHjxR95ecXqp98PTGHxjBZ/fiHPz8pKHfu4J+ayS
         QkWXfgxUOgmMezV0CaEM+lI+m9VXn1lelrTGuq/lUd0Bln24n3W0pNhdS8UlH0X0XbTZ
         WRsPGLUB4OH0yKQVUGJa2o+DI//+IWeHs0XB05Gt/Gleo85KznlKAF/D+PE9RyZQnyFn
         3D7TIEzKHIqOMdiu/Hb68ttZ7I9Mews145brD0/4KYX3bJRFrsNqgCZOiMMC+NSKUWHP
         uFxB2nhDdhTKgnrV8qxnIOIwBB5ZV+9FlI7ySyJVBe4SsWPnIGkAPsdNPYSr+XeLvKgi
         JwkA==
X-Gm-Message-State: ACrzQf3La57QbOjH+oXgqC+DklH5qfO1lmzJovL0YX4cmzk8C9ZY7/bQ
        IHtosJsevdcE3ZZ02FdcNURWHcUI2SzYs9+Z
X-Google-Smtp-Source: AMsMyM7+2PlYiGHAqlP0quWhZ+Moh87Ezx8cHWOsO4fWe2zjII533A6lbECVW6gCU/qHSwma7mjJ2Q==
X-Received: by 2002:a05:6a00:180a:b0:540:a7f6:4393 with SMTP id y10-20020a056a00180a00b00540a7f64393mr21440326pfa.65.1664777894701;
        Sun, 02 Oct 2022 23:18:14 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b005615beef41fsm1768695pfr.187.2022.10.02.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 23:18:13 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:18:09 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: initialize damon_target->list in
 damon_new_target()
Message-ID: <Yzp+oTYs4s7stUIC@hyeyoo>
References: <20221002193130.8227-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002193130.8227-1-sj@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 07:31:30PM +0000, SeongJae Park wrote:
> 'struct damon_target' creation function, 'damon_new_target()' is not
> initializing its '->list' field, unlike other DAMON structs creator
> functions such as 'damon_new_region()'.  Normal users of
> 'damon_new_target()' initializes the field by adding the target to DAMON
> context's targets list, but some code could access the uninitialized
> field.
> 
> This commit avoids the case by initializing the field in
> 'damon_new_target()'.
> 
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Fixes: f23b8eee1871 ("mm/damon/core: implement region-based sampling")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> 
>  mm/damon/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 1d952fa7ba3e..1e6691771a95 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -345,6 +345,7 @@ struct damon_target *damon_new_target(void)
>  	t->pid = NULL;
>  	t->nr_regions = 0;
>  	INIT_LIST_HEAD(&t->regions_list);
> +	INIT_LIST_HEAD(&t->list);
>  
>  	return t;
>  }

I tried again with it and this fixes the bug I reported.
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thank you for such a quick fix!

> -- 
> 2.25.1
> 

-- 
Thanks,
Hyeonggon
