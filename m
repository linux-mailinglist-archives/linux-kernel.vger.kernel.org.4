Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1D633257
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiKVBqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiKVBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:46:27 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8CC695A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:46:26 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g62so12976379pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVHrNvmN2aKc4xwWxCNYKIFTFpQYBYiPFTCfwC3xsW8=;
        b=G/z6TQzB2xX/UeJGfPJ90z8DHKYOhsUZ9iGd6p+kIBndZj/htaZ86BJIYgelduK8na
         gMmniUO5ITM9E54+jjYQWpDvF40GbAak8BYQTi+uIZQk6dHbtOsBxGm2oT9QdBaopne7
         RuZfU2zrSOnAyG1GGRsCsFqEwU882/3KIc5Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVHrNvmN2aKc4xwWxCNYKIFTFpQYBYiPFTCfwC3xsW8=;
        b=D0c0TLpm7vX6wlOnwzFGPk5ThmNTpCSIcc7/AH98D+qnkUqo/+HhzrlXH0UcnLPaMO
         Mw0YGHPUEno+2F+d3DOi+bOov8nrJV77mimQf7fa9WqJd4Ewy3hIA42QPlyeFBk9Mu5R
         l9+etg5pL2ZjW0yCt5AavIiXtTuKGpUYdl3SEiKCHUzOKPi6qH0MBhKVYQP42AaXKwz1
         Ch/Uv/nYOjIkAv3K11E3B1vN+QMioUg99Myhpf1e+FAmXtfsqfkJF7vSbZTHNRAY85JM
         wkvpQe0ksd/MOVm5fF+9TTq/jhmjtag+RmcGpUn6yNw90TOvX1+BUkfJl81DJfRvn7dA
         67RQ==
X-Gm-Message-State: ANoB5pmUcrrs6rCrYLh1D6WuSCN9ojifMu0emvwec60F9TPT/+huZqsK
        0uczq4jM5YihTyTwdOQAf9VV+g==
X-Google-Smtp-Source: AA0mqf6pZsf3WZs/zHNwvoQGScEpwoTIAQHPQkJRqetfeC0UkOw6KbHhMELosyYGDDGhIPLJpam87g==
X-Received: by 2002:a05:6a00:3004:b0:56c:dba2:30b with SMTP id ay4-20020a056a00300400b0056cdba2030bmr23051360pfb.72.1669081586274;
        Mon, 21 Nov 2022 17:46:26 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b0018853416bbcsm10452842plj.7.2022.11.21.17.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:46:25 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:46:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 2/6] zpool: clean out dead code
Message-ID: <Y3wp7IiVkq032pmi@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
> There is a lot of provision for flexibility that isn't actually needed
> or used. Zswap (the only zpool user) always passes zpool_ops with an
> .evict method set. The backends who reclaim only do so for zswap, so
> they can also directly call zpool_ops without indirection or checks.
> 
> Finally, there is no need to check the retries parameters and bail
> with -EINVAL in the reclaim function, when that's called just a few
> lines below with a hard-coded 8. There is no need to duplicate the
> evictable and sleep_mapped attrs from the driver in zpool_ops.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
