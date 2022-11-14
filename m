Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD06278F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiKNJZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiKNJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:24:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E79417422
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:24:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13189722pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2148sqylEkmjswFsMWG1hvqqLaO0xyf1SiCUhyBRhaQ=;
        b=wDmXeMBBM5jSJ/rpe94OT8vmZBocQzSOc2asE4+zf3/rv3ent4zKaT8mtg8PyjCFU5
         2RUzEpAC+0zcOMEnW/et/WDcoJYvUN3Uvq9sskGvYTdlE6Pn39zd81tE9UNAfHBNEtx4
         avQW9asTBmZiES1iB7Ux0C/jRhSnPPEPtLujUGby6LtECk1fjNAXPHIErxjf/S2/CqD7
         xoJHNK/933wBWaLG6toe5+DU8eAEIVkxat/mjG+0jU/ZSCn76zQR+CX6SLIDT6wLeAhg
         E+WK5T3IsQI62HF7yVJSqeyH9SWca57H0s5Zj38EUCAlKgbXpujmmr4YSUotKeezKjS6
         FM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2148sqylEkmjswFsMWG1hvqqLaO0xyf1SiCUhyBRhaQ=;
        b=OuDlxvbHJNHJ95k6RVJxNvjzJgmX7m7KyEi1/Fg4C3q7ZLHaxVxgpUvRW8AOb3azHr
         MybQb4IMpoD1Uqria4PouCkY9SN9n6RuojpEsqJxzgMTHugtQBWN/YLB1qznJ12z5gcx
         v2345p/jcx+n5UuFA7dfcJORV4q8oJzH3dsEzsQR/BXv9neYvlBjgvHvvSFJaFG3MW8Y
         tbjh6oktZqL454iXrLBQoW3NLxH3Ra2nkPg7Ims7UdlyFCsqwW2CWuRkZ2rJBd94v13G
         IXi67gUhG9JYH8IVxh5yalv0ISEnT0KPwL7iQGubx9lX5A5OzBWt62ZM553ZKBtPc6gP
         fiMw==
X-Gm-Message-State: ANoB5pkeoFAu7OIh4fTWYt1X9zjL/gzPG9nL9N+D5A2WlViFbH5/QK3V
        3f7x6qGzNZRd30Mo0b9q3P0z5Q==
X-Google-Smtp-Source: AA0mqf4JWvsDijQPfo/kXXptsIS2yyDPC0lc7dAS8Ff3VNNyq4RT1WTyw4YINmHAKX/obSA93DCkqA==
X-Received: by 2002:a17:90a:6d8f:b0:214:2ee7:3dc with SMTP id a15-20020a17090a6d8f00b002142ee703dcmr12797742pjk.105.1668417897845;
        Mon, 14 Nov 2022 01:24:57 -0800 (PST)
Received: from [10.68.76.92] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00176b3c9693esm6852376plf.299.2022.11.14.01.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:24:57 -0800 (PST)
Message-ID: <404735fb-023d-df37-e88e-8b05981bc1d5@bytedance.com>
Date:   Mon, 14 Nov 2022 17:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
> This sounds a bit suspicious.  Please share much more detail about
> these races.  If we proced with this design then mpol_put_async()
> shouild have comments which fully describe the need for the async free.
> 

Add some comments for async free, and use the TWA_SIGNAL_NO_IPI to
notify the @task.


-/*
- * mpol destructor for pidfd_set_mempolicy().
+/**
+ * mpol_put_async - free mempolicy asynchronously.
+ * @task: the target task to free mempolicy.
+ * @p : mempolicy to free
+ *
+ * @task must be specified by user.
   * free mempolicy directly if task is null or task_work_add() failed.
+ *
+ * A mempolicy can be either associated with a process or with a VMA.
+ * All vma manipulation is protected by mmap_lock.In process context
+ * there is no locking. If we need to apply mempolicy to other's
+ * task specified in pidfd, the original mempolicy may about to be
+ * freed by pidfd_set_mempolicy() while target task is using it.
+ * So,mpol_put_async() is used for free old mempolicy asynchronously.
   */
-void mpol_put_async(struct task_struct *task, struct mempolicy *p)
+static void mpol_put_async(struct task_struct *task, struct mempolicy *p)
  {
-       enum task_work_notify_mode notify = TWA_RESUME;
-
         if (!atomic_dec_and_test(&p->refcnt))
                 return;

@@ -333,10 +342,8 @@ void mpol_put_async(struct task_struct *task, 
struct mempolicy *p)
                 goto out;

         init_task_work(&p->w.cb_head, mpol_free_async);
-       if (task_work_pending(task))
-               notify = TWA_SIGNAL; /* free memory in time */

-       if (!task_work_add(task, &p->w.cb_head, notify))
+       if (!task_work_add(task, &p->w.cb_head, TWA_SIGNAL_NO_IPI))
                 return;
  out:
         kmem_cache_free(policy_cache, p);



Thanks.
