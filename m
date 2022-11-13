Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA326270E1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiKMQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:41:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061310561
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:41:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y13so8992407pfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QrikNB/GMZeY3ufdrYnFiRrHx7b40lntxGNUYf5p3U=;
        b=DEsPXPkx4VzqvFb/BNADTLQhtFuR2MiVR6MQA/nq9lpHzO3CRtZw1rrdnZXcAUnZln
         uNtFnG1jMSD7MbPvszAtMSvtYiQe3kVI8zn6phL6ldMUlNTajEkJT4D1jMXe7yMTQ7Uj
         KQzJzP9UxB2sZUGQiwtB2R5J/8+uN8KUgAPkHwDfdX9d4GdcWf9xquF1Pp7DfzPMsBZq
         LQIX1jqb3v6SFTIxFr3drmEHE4p89UB2VMtW8+u58oVfmpMxw7bq4woCtZPTaOL9uRZT
         ebdYqvS0JiXc/02HFlybd8IU9Pp4/xcVhIg3dyEHdbuFZiNeRXLCwL8wDQtDD9W3jxsX
         o05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QrikNB/GMZeY3ufdrYnFiRrHx7b40lntxGNUYf5p3U=;
        b=1fHA07WlxEfMNzsvKASPs2bpXa7JKwW16q5bdD5aIKgQg+uc1FzpOE7UfPU5DSZMqV
         bphEFeEjl+ABu1unkBTWIjCFBjDdPW01cuRIAxwuTz3kNpgASYWuTEJoNo/inFzyZpPc
         8FJqfPEQOE/BmkRhFn7IXsYR9OR1YsOZeok6SImbck3LbGHRW60Dh5xNTcMBt3DmYULo
         2Wjq53UHhu9nNKgVDfwW8R18fiRP44YI6mTzE+FgcvrQO2GTvzGlIn/Ltf1DUMnluwJe
         kG2q+trcSWvAZPi4opI4GCPBs9zsbkT81KaP3RGxqZ6B81x2tvlEXILEXQC3WUcqf99k
         PcWQ==
X-Gm-Message-State: ANoB5plIi4++9SwB6qu9cz527RVdRqHKe0zZXVoEKE18rbEFVY6r8SBi
        JkejYcMxRK0eXbrFDnHZEJteVg==
X-Google-Smtp-Source: AA0mqf61Hhi23BxOCwNEasLV8GXX2B6mVAH7ThC0PZPXQNtBDFDI4bOxR0Hn5F0usudfIlB4j7q4SQ==
X-Received: by 2002:a65:49c6:0:b0:46f:ed3a:ac42 with SMTP id t6-20020a6549c6000000b0046fed3aac42mr9107496pgs.617.1668357687296;
        Sun, 13 Nov 2022 08:41:27 -0800 (PST)
Received: from [10.4.223.134] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090ab80300b00210c84b8ae5sm4772471pjr.35.2022.11.13.08.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 08:41:26 -0800 (PST)
Message-ID: <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
Date:   Mon, 14 Nov 2022 00:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, thanks for your replay.

> This sounds a bit suspicious.  Please share much more detail about
> these races.  If we proced with this design then mpol_put_async()
> shouild have comments which fully describe the need for the async free.
> 
> How do we *know* that these races are fully prevented with this
> approach?  How do we know that mpol_put_async() won't free the data
> until the race window has fully passed?

A mempolicy can be either associated with a process or with a VMA.
All vma manipulation is somewhat protected by a down_read on
mmap_lock.In process context there is no locking because only
the process accesses its own state before.

Now  we need to change the process context mempolicy specified
in pidfd. the mempolicy may about to be freed by
pidfd_set_mempolicy() while alloc_pages() is using it,
the race condition appears.

process context mempolicy is used in:
alloc_pages()
alloc_pages_bulk_array_mempolicy()
policy_mbind_nodemask()
mempolicy_slab_node()
.....

Say something like the following：

pidfd_set_mempolicy()        target task stack:
                                 alloc_pages:
                                 mpol = p->mempolicy;
task_lock(task);
  old = task->mempolicy;
  task->mempolicy = new;
  task_unlock(task);
  mpol_put(old);
                               /*old mpol has been freed.*/
                               policy_node(...., mpol)
    	           __alloc_pages(mpol);
To reduce the use of locks and atomic operations(mpol_get/put)
in the hot path,task_work is used in mpol_put_async(),
when the target task exit to user mode,	the process context
mempolicy is not used anymore, mpol_free_async()
will be called as task_work to free mempolicy in
target context.			


> Also, in some situations mpol_put_async() will free the data
> synchronously anyway, so aren't these races still present?
> If the task has run exit_task_work(),task_work_add() will fail.
we can free the mempolicy directly because mempolicy is not used.

> 
> Secondly, why was the `flags' argument added?  We might use it one day?
> For what purpose?  I mean, every syscall could have a does-nothing
> `flags' arg, but we don't do that.  What's the plan here?
> 
I found that some functions use 'flags' for scalability, such
as process_madvise(), set_mempolicy_home_node(). back to our case, This 
operation has per-thread rather than per-process semantic ,we could use 
flags to switch for future extension if any. but I'm not sure.

Thanks.
