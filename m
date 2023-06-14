Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA372F16F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjFNBOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFNBO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:14:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286481BE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 18:14:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6584553892cso1454020b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686705267; x=1689297267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqfH+/eIFFxiGH9Q57a91INWozGJNqdtq4CLXi5rBYs=;
        b=25R1wwfmrgHRk3Hm7uD0PIUbulPBr2SK0tTI11IrctVv2S4+syeujEArMbRSEJhYGV
         sQ5n/xOR7Q0r6EC+O/OmJ+4ywmeynD4syxg9vroOuGQbrs9UBeNMSm7Pi0IADj5PJF/a
         QIBQjqcNjRk23FYK4FuqEChglEblY2oriKNxfYTawnXOH5AvKfTRhbMhBPJopEbr+gX1
         0cxEyK/pnxAuLoKZ4EOQ3z2ZrXe8Zh3spPuq+ABjuXfYe6vFk5Tdl+9sCbCYvsJxQsfM
         +iWS1wXpM9AD3qRIlu4GzQltQTLkU4yZOt2cewc7+hAVlhBILqnjGyocX4VgstLmRSGw
         5EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686705267; x=1689297267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqfH+/eIFFxiGH9Q57a91INWozGJNqdtq4CLXi5rBYs=;
        b=efUkly1UsInLqkvsr46HNDLo5/3gp6UhlwWtZpFgxST+it0QCu4ddkw8OEd5iQAJ8R
         1LxMJkhujcrFCb6123P7co3IxA00D1n/chNGjxfgh1BSenAy05PKvYh2HYbyxJE0ps94
         zPxeIawlAM2Iw2IgBV1zdIxE8XpE3A8BdjYo0G91wxgnIUOTbNNP6YkCf2Eq5nbD+kuT
         9G7N2t9HDZmgbJVzjjKN1O6FvQAQtUucaV0pibefxf/xzFIa+wYIeRHzKBsdsB/ZS6Kq
         nf1QePT+g5rlsArpzhkBde5B2ZiLZOGIYqTPvYu2ITh4OgX+H5GZmZU+St6SgA2o3W1u
         LaJQ==
X-Gm-Message-State: AC+VfDyhk6XUcmVFbPciMwvO65CPhnyQKtYE5tBz4OB+XxViCgAsKIZh
        ZYq3N8xhkiBmIUXiUB3DbLPSTQ==
X-Google-Smtp-Source: ACHHUZ5ipPjXRyGe4Azn8FcTcmhqjLFIO4jYUU+DAGVkRUqI70p7S91QOBrSr3PiiQXD9B5s1qADdw==
X-Received: by 2002:a05:6a20:42a5:b0:116:696f:1dd1 with SMTP id o37-20020a056a2042a500b00116696f1dd1mr17644666pzj.4.1686705267493;
        Tue, 13 Jun 2023 18:14:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b0063b85893633sm9142471pfh.197.2023.06.13.18.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 18:14:26 -0700 (PDT)
Message-ID: <5d5ccbb1-784c-52b3-3748-2cf7b5cf01ef@kernel.dk>
Date:   Tue, 13 Jun 2023 19:14:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] io_uring/io-wq: don't clear PF_IO_WORKER on exit
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
References: <2392dcb4-71f4-1109-614b-4e2083c0941e@kernel.dk>
 <20230614005449.awc2ncxl5lb2eg6m@zlang-mailbox>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230614005449.awc2ncxl5lb2eg6m@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 6:54?PM, Zorro Lang wrote:
> On Mon, Jun 12, 2023 at 12:11:57PM -0600, Jens Axboe wrote:
>> A recent commit gated the core dumping task exit logic on current->flags
>> remaining consistent in terms of PF_{IO,USER}_WORKER at task exit time.
>> This exposed a problem with the io-wq handling of that, which explicitly
>> clears PF_IO_WORKER before calling do_exit().
>>
>> The reasons for this manual clear of PF_IO_WORKER is historical, where
>> io-wq used to potentially trigger a sleep on exit. As the io-wq thread
>> is exiting, it should not participate any further accounting. But these
>> days we don't need to rely on current->flags anymore, so we can safely
>> remove the PF_IO_WORKER clearing.
>>
>> Reported-by: Zorro Lang <zlang@redhat.com>
>> Reported-by: Dave Chinner <david@fromorbit.com>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Link: https://lore.kernel.org/all/ZIZSPyzReZkGBEFy@dread.disaster.area/
>> Fixes: f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
> 
> Hi,
> 
> This patch fix the issue I reported. The bug can be reproduced on v6.4-rc6,
> then test passed on v6.4-rc6 with this patch.
> 
> But I found another KASAN bug [1] on aarch64 machine, by running generic/388.
> I hit that 3 times. And hit a panic [2] (once after that kasan bug) on a x86_64
> with pmem device (mount with dax=never), by running geneirc/388 too.

Can you try with this? I suspect the preempt dance isn't really
necessary, but I can't quite convince myself that it isn't. In any case,
I think this should fix it and this was exactly what I was worried about
but apparently not able to easily trigger or prove...


diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index fe38eb0cbc82..878ec3feeba9 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -220,7 +220,9 @@ static void io_worker_exit(struct io_worker *worker)
 	list_del_rcu(&worker->all_list);
 	raw_spin_unlock(&wq->lock);
 	io_wq_dec_running(worker);
-	worker->flags = 0;
+	preempt_disable();
+	current->worker_private = NULL;
+	preempt_enable();
 
 	kfree_rcu(worker, rcu);
 	io_worker_ref_put(wq);

-- 
Jens Axboe

