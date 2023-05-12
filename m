Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F31700AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbjELPBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbjELPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:01:25 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869910E73
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:01:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-763970c9a9eso35552639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683903670; x=1686495670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLakCHeOGL3BTNkuhVC5tzE0mMDF0pgQvcM5N/M1Q2w=;
        b=q56dH0t0F4mVLwbIa36nRH+cVgEhZhZ9WruCY0PXl17/I/dKs8t4GC0KCRNIWfP0tO
         h+jGwj8sUehha8hP871X8MJywqho6LSmr9rcsPGa6jTVFty+BcZMJAaXgCdvuD2HCSps
         38tMD0GSeCcUrdPJEfgWST4iSFNL8WPn4abEI8LTI1+f++WTYcKlwo5kyG7yhORjA/9f
         TR4N7zVZEi4bumda1Pfvm/QpuIbj37L2ySzYOQ+j9ffL8sA4uD6Q0aB0+NAH7eJWL9+Y
         aOOz9NBnFv2sw/zNxIUR9oSR1Ya+517FiLTeRmfrEf3fyYZ6PRm7H479NTXHmlT1h8Ob
         8mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903670; x=1686495670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLakCHeOGL3BTNkuhVC5tzE0mMDF0pgQvcM5N/M1Q2w=;
        b=Rn8eTXv29b2xr9gscyCOiSMZQGBnqPe18NwuI2/FGB2vk3E7JrdzcoV7/Y7MAOjxD8
         jvIPN/rXQ1M8VJnnthXCqtRnpqefriULz6BfQ2BjA+IaDLwOX569QfNPPEdbrv6rgSS/
         dsP3WfHrUyeQ12lmDxVwxROVRyvt8S38douSzIYAM74kU4ZVFqbMnudtPuhSJ0w938uw
         pYTE4xHGgqXNBiorf+41ZuVprJf9a6U8M8euMZalRg3XMHijFdxN6vax3GBVAwjWb68R
         kL69NEbE2kU8Qjs3QcmTCR5UXUTF7ac7pxFeifDl+YzQcDEnsfKuQsUDdrpi5BapkaMk
         ZpFQ==
X-Gm-Message-State: AC+VfDzI/lchGVJmksf1G5aH4HCSyYRCgkn+MuYByN2nsZlPZHaf0M8J
        vZmOfPss9Yd2/pBAYsOHEhAzlw==
X-Google-Smtp-Source: ACHHUZ7xHlFjVPoGXyuKWZldv47ynrF8n0i7/CKSn3rmFx2lk5ht8GcPs2bvxnnKEQVthSsUZkW0GA==
X-Received: by 2002:a6b:b4ce:0:b0:76c:6fa4:4df4 with SMTP id d197-20020a6bb4ce000000b0076c6fa44df4mr4396467iof.2.1683903670350;
        Fri, 12 May 2023 08:01:10 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cc6-20020a056602424600b0076c3189a8d9sm4480811iob.38.2023.05.12.08.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:01:09 -0700 (PDT)
Message-ID: <1c9a152e-fac1-ac9e-c871-bbec5f176bda@kernel.dk>
Date:   Fri, 12 May 2023 09:01:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/2] blk-mq: Convert request->csd to
 call_single_data_t and reposition it
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230511085836.579679-1-leobras@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230511085836.579679-1-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 2:58?AM, Leonardo Bras wrote:
> Currently, request->csd has type struct __call_single_data.
> 
> call_single_data_t is defined in include/linux/smp.h :
> 
> /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
> typedef struct __call_single_data call_single_data_t
> 	__aligned(sizeof(struct __call_single_data));
> 
> As the comment above the typedef suggests, having this struct split between
> 2 cachelines causes the need to fetch / invalidate / bounce 2 cachelines
> instead of 1 when the cpu receiving the request gets to run the requested
> function. This is usually bad for performance, due to one extra memory
> access and 1 extra cacheline usage.
> 
> Changing request->csd was previously attempted in commit
> 966a967116e6 ("smp: Avoid using two cache lines for struct call_single_data")
> but at the time the union that contains csd was positioned near the top of
> struct request, only below a struct list_head, and this caused the issue of
> holes summing up 24 extra bytes in struct request.
> 
> The struct size was restored back to normal by
> commit 4ccafe032005 ("block: unalign call_single_data in struct request")
> but it caused the csd to be possibly split in 2 cachelines again.
> 
> As an example with a 64-bit machine with
> CONFIG_BLK_RQ_ALLOC_TIME=y
> CONFIG_BLK_WBT=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_INLINE_ENCRYPTION=y
> 
> Will output pahole with:
> struct request {
> [...]
> 	union {
> 		struct __call_single_data csd;           /*   240    32 */
> 		u64                fifo_time;            /*   240     8 */
> 	};                                               /*   240    32 */
> [...]
> }
> 
> At this config, and any cacheline size between 32 and 256, will cause csd
> to be split between 2 cachelines: csd->node (16 bytes) in the first
> cacheline, and csd->func (8 bytes) & csd->info (8 bytes) in the second.
> 
> During blk_mq_complete_send_ipi(), csd->func and csd->info are getting
> changed, and when it calls __smp_call_single_queue() csd->node will get
> changed.
> 
> On the cpu which got the request, csd->func and csd->info get read by
> __flush_smp_call_function_queue() and csd->node gets changed by
> csd_unlock(), meaning the two cachelines containing csd will get accessed.
> 
> To avoid this, it would be necessary to change request->csd back to
> csd_single_data_t, which may end up increasing the struct size.
> (In above example, it increased from 288 to 320 -> 32 bytes).
> 
> In order to keep the csd_single_data_t and avoid the struct's size
> increase, move request->csd to the end of the struct.
> The rationale of this strategy is that for cachelines >= 32 bytes, there
> will never be used an extra cacheline for struct request:
> 
> - If request->csd is 32-byte aligned, there is no change in the object.
> - If request->csd is not 32-byte aligned, and part of it is in a different
>   cacheline, the whole csd is moved to that cacheline.
> - If request->csd is not 32-byte aligned, but it's all contained in the
>   same cacheline (> 32 bytes), aligning it to 32 will just put it a few
>   bytes forward in this cacheline.
> 
> (In above example, the change kept the struct's size in 288 bytes).
> 
> Convert request->csd to csd_single_data_t and move it to the end of
> struct request, so csd is never split between cachelines and don't use any
> extra cachelines.

This is going the wrong way imho. It'd be nice to get struct request
down to 256 bytes at some point, and then this would get in the way. The
patch is also attempting to do two things at once, which is a bad idea.

Why not just rearrange it a bit so that we don't split a cacheline with
the csd?

-- 
Jens Axboe

