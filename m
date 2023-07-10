Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3374D315
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjGJKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGJKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:13:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3A213D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:12:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-38c35975545so3844714b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1688983905; x=1691575905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM+BniYoRZfJRDJS4q/JXBjRLklHXdx5WeIeuyCUukM=;
        b=OKYm3nmYqAJOOYWcwXFJd26RlpwOf8iJGYMQMvLHogscvlnN0fYhhdJ9Q4KpRCykBe
         JizkvutIHdXM607qzd4CBw/N26FH4tIF7yUScyEavMwh6C5agZvIW8zIa2E8bR4BL6vr
         NgH/YMkB/lj8vyhnhS7anSju+NiHiRlpsP6xgBSS4Sf3YBkmDO4P1mRneX2JBFkwHeAA
         ncA6Xp+1psmsjgRHGRyYpptTadA29OTUqXe6o9nkmkyt1lGxhg8voa0Bl/xIakVIejmj
         mk1H/0/uAXvn6Z8AKoqJaaKk6o2HFRKyQBftXPsYfa3nf33lZynIjd5xeRQ6g/38WB6s
         a6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983905; x=1691575905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PM+BniYoRZfJRDJS4q/JXBjRLklHXdx5WeIeuyCUukM=;
        b=F+YKLqN5mTEbNUcrYKnxe5SpdBhSMlEhLiWtoJx7vzO9IOrkuxuxeYzYlbJTjxoO4A
         uFx9LftQbkpCAkLt6EUYaj/7Ib4G95zf0+vCxruOIIJW22u0Uvo/DagAnpfE7mpvuVzI
         lokfvG4p+IfyZAe7/YPWsTeu8kebkyfMpGbzZMRW4ItO0fFTZeDETmE6SlWzU5tGsvHY
         sEXLOFfh3nVPUoX6M8XXcByNyIPGOuMO2GIbKDZ7d6+G9HV6ZL+C29POYqrS3lU+qwnu
         /aWbGXXiA1wkAtMd6mZextmZCwpUQirGwmQUbfqBCY6cD4S1FyiZh5LrA8xH0eDEmD5O
         cYew==
X-Gm-Message-State: ABy/qLaNG3IWj6COqXe5FnwQqpVk1lSuLrogT714X29t9IsaqED9sNio
        I0j9tUftD1Ci/lInLIlmKquFxGJJwepfk0IcKcU+dQ==
X-Google-Smtp-Source: APBJJlF1LcZk4rK6NNyvWapxIVwZUBS3stIYsqQ4Gk1Ef66TZenRE0C7Rlc2sCAdCz4cNysLZWA+Aw==
X-Received: by 2002:a05:6358:c09:b0:135:544c:4dc8 with SMTP id f9-20020a0563580c0900b00135544c4dc8mr8120343rwj.16.1688983905492;
        Mon, 10 Jul 2023 03:11:45 -0700 (PDT)
Received: from [10.54.24.10] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id x5-20020a654145000000b0054fe7736ac1sm6331423pgp.76.2023.07.10.03.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:11:45 -0700 (PDT)
Message-ID: <5f5a3d4c-34fb-9d9b-444f-da8f7389ab76@shopee.com>
Date:   Mon, 10 Jul 2023 18:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] signal: remove duplicate include header in signal.c
To:     ye.xingchen@zte.com.cn, rafael.j.wysocki@intel.com
Cc:     peterz@infradead.org, ebiederm@xmission.com, elver@google.com,
        tglx@linutronix.de, michael.christie@oracle.com,
        viro@zeniv.linux.org.uk, mcgrof@kernel.org, dvyukov@google.com,
        vincent.whitchurch@axis.com, linux-kernel@vger.kernel.org
References: <202307101523409041269@zte.com.cn>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <202307101523409041269@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/10 15:23, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> linux/file.h is included more than once.

Can you point out which files have contained file.h?
Though file.h is included more than once, but it has used the macro "#ifndef / #define" to avoid redefinition.
So what’s your concern about this?

Thanks, Haifeng.

> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  kernel/signal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9a3ff8157ceb..b1da4e81bde6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -25,7 +25,6 @@
>  #include <linux/mm.h>
>  #include <linux/proc_fs.h>
>  #include <linux/tty.h>
> -#include <linux/file.h>
>  #include <linux/binfmts.h>
>  #include <linux/coredump.h>
>  #include <linux/security.h>
