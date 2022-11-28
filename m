Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B178B63AA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiK1OOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiK1OOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:14:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643AF5596
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:14:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so5277056plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSAoMPL7GoXdvi2uqHoiRe+EA22FtKTEJJ1PVxlye2M=;
        b=jgvFSL7jpl9MqLgAG6fh4zKofcwxR+/eoEoZWF/ym/LrF4fLxXEQxRLZAstmlCbqpG
         nMpiwsjL1fRDSlJmD0MHKW9gTfTjZVdQBno5hAZlMaWaeACszvKP/wx8QZpvbzNUIV3H
         bcPYyTTrny+NDOoszf8U8N1sJwKg3ibV+Q6O7XF0xWAuNAl9ZFCDKPWBC53W22952bfD
         hx2wOQyXm8IkSwtBlDs8f08Chogp6iM40tAmOO3+l9bWfELea6Z1M3qeLPjSeGMLfDoP
         Ky+sdx4pCdqhXZRA0RVg9YQQds2CJJlEDyP6tTSqeqIS6Ut4fM3+w9JSx0/apa4WJJFI
         XjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSAoMPL7GoXdvi2uqHoiRe+EA22FtKTEJJ1PVxlye2M=;
        b=k40HFsMEgBwJSkAdRgf2hno7jGblZxgRst0GJSHbR5/vVzxCmCTOXWFn9H5yNYmLsT
         Uu6D3nhRc2ep1gsdEARoAZfbI85IyAxSETlbBiv4Is7Xt+v0CMToJbraiBrYeztcKeNU
         A7A75TPs7En1qmpu7WnBD5KBGs7jIxUFXkKkgjZtfQZCkSJVohH1ms3mgD27CvEyWzpD
         Twm4luemyAyJH4uiU08fXFHFyvTYiZmVbtBqSgJ7Z2Y5QRSD8sLAPjGv0dnAjlYi57ks
         eNYg1B2IWFeKU8rZZG2BUPl1glaaLRUosnGS2JDiEhNDdi3MHbDP41gqddJVEbVv0ejY
         1a9A==
X-Gm-Message-State: ANoB5pmCpqM7WuBIoyp901td4c2tdmFz+eBskhk3ED1JPL/ZkG5Q2Vhz
        KBelt3e1pz2NzZlpS0gW6RrWZA==
X-Google-Smtp-Source: AA0mqf42bAFjdasxPY2lCmOFI93Ik9+Kku4PHtRgmzeR0hIj/0zBODaqQ3rA85YnXs6vWnHM22hVpw==
X-Received: by 2002:a17:902:8217:b0:186:a5a7:cc3d with SMTP id x23-20020a170902821700b00186a5a7cc3dmr31543252pln.42.1669644879656;
        Mon, 28 Nov 2022 06:14:39 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b00213c7cf21c0sm7679415pjt.5.2022.11.28.06.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:14:39 -0800 (PST)
Message-ID: <427068db-6695-a1e2-4aa2-033220680eb9@kernel.dk>
Date:   Mon, 28 Nov 2022 07:14:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221128033057.1279383-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 8:30 PM, Waiman Long wrote:
> Commit 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction
> path") incorrectly assumes that css_get() will always succeed. That may
> not be true if there is no blkg associated with the blkcg. If css_get()
> fails, the subsequent css_put() call may lead to data corruption as
> was illustrated in a test system that it crashed on bootup when that
> commit was included. Also blkcg may be freed at any time leading to
> use-after-free. Fix it by using css_tryget() instead and bail out if
> the tryget fails.
> 
> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  block/blk-cgroup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 57941d2a8ba3..74fefc8cbcdf 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1088,7 +1088,12 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>  
>  	might_sleep();
>  
> -	css_get(&blkcg->css);
> +	/*
> +	 * If css_tryget() fails, there is no blkg to destroy.
> +	 */
> +	if (!css_tryget(&blkcg->css))
> +		return;
> +
>  	spin_lock_irq(&blkcg->lock);
>  	while (!hlist_empty(&blkcg->blkg_list)) {
>  		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,

This doesn't seem safe to me, but maybe I'm missing something. A tryget
operation can be fine if we're under RCU lock and the entity is freed
appropriately, but what makes it safe here? Could blkcg already be gone
at this point?

-- 
Jens Axboe


