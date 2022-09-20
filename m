Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528E75BDEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiITHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiITHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:46:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BAEE37
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:46:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso1653025pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ofrSUBwHj0NfDL7/4OpZdl7qygj1PrA532lfio/4jhs=;
        b=lkta8/dweehjY5XgTHqsJY/c32ELVi2VUyZSArZvWkZuX4xoZ88CWuhTlWQt4EB5eG
         fkIbTGqleHmkSpRlq6jii/oglIsxigMJA4BkqhDDTGxliCEkOW4K7qW8bDZxW4xNdURx
         x9/SKwq51qzeBYQ73kS2n9DQ4hFL9JrCggratIkxtr2CjbZFqnon+CfbszyNHwsnBi0g
         RLoACY0fL0QmBDyCgh3PLBAEFBAdpRE9o8vVUIyDP4c/GgwE4tn+zdDwKuXYTFy8SPV6
         eVxEywuyzViONLK3Id4u8+kq1H2nAQ8otvnPQcEgIH6M6XAzPg6DHtm8t2zlIXhLdByU
         PfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ofrSUBwHj0NfDL7/4OpZdl7qygj1PrA532lfio/4jhs=;
        b=HYIv9AoEccerjZO4rrRZeFanYJEArpoUgwITbzsi741HiFlwy4p32Zxbri69mU/ZIj
         /ugwuTIY0MoZD9erV8BFZKcXypLK+2xjPyNMhcipBOVODGFUQnUX8+tFSLT4fBbiGdNz
         /bgBQOZYqGRz30jyI6mz/8pjVo77ZRPfiyUl0JltO0ITwTnfyp732Egsnunn0l2aRXAl
         dpc2c+v0sBLd/vLyFdhos8B4/uZSBhwNm3s6yETNpQ1Vj5i7QVFdFkFcJn7fhQOr4IVJ
         mlTT4ZM/tFEm36WG45/3l9bXmxMkYN0aCLMaljile5D4mAkcluz1HTxVspoUQOBDLf3Z
         AvNw==
X-Gm-Message-State: ACrzQf23FRbRjgCyBznCpJcyZAXZkUdU2oJKR7evR0VBfcBneFKizK2U
        JShAGHOV0e73iVmLOhM9K30=
X-Google-Smtp-Source: AMsMyM4d/TkqJTxG4OlN7aA8vCeRP9ueZ1ErnhTr0ulMBWNQRksrIvXzDEASXZcz16CmyCLfYOC4vg==
X-Received: by 2002:a17:90b:4b03:b0:202:eab3:e174 with SMTP id lx3-20020a17090b4b0300b00202eab3e174mr2456851pjb.12.1663660007365;
        Tue, 20 Sep 2022 00:46:47 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090aa60c00b001fd8316db51sm755689pjq.7.2022.09.20.00.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:46:46 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:46:41 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     vbabka@suse.cz, linux-mm@kvack.org, rientjes@google.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH V3] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <Yylv4TRbrhwCrCnR@hyeyoo>
References: <20220919163929.351068-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919163929.351068-1-mlombard@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 06:39:29PM +0200, Maurizio Lombardi wrote:
> Commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
> __free_slab() invocations out of IRQ context") moved all flush_cpu_slab()
> invocations to the global workqueue to avoid a problem related
> with deactivate_slab()/__free_slab() being called from an IRQ context
> on PREEMPT_RT kernels.
> 
> When the flush_all_cpu_locked() function is called from a task context
> it may happen that a workqueue with WQ_MEM_RECLAIM bit set ends up
> flushing the global workqueue, this will cause a dependency issue.
> 
>  workqueue: WQ_MEM_RECLAIM nvme-delete-wq:nvme_delete_ctrl_work [nvme_core]
>    is flushing !WQ_MEM_RECLAIM events:flush_cpu_slab
>  WARNING: CPU: 37 PID: 410 at kernel/workqueue.c:2637
>    check_flush_dependency+0x10a/0x120
>  Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
>  RIP: 0010:check_flush_dependency+0x10a/0x120[  453.262125] Call Trace:
>  __flush_work.isra.0+0xbf/0x220
>  ? __queue_work+0x1dc/0x420
>  flush_all_cpus_locked+0xfb/0x120
>  __kmem_cache_shutdown+0x2b/0x320
>  kmem_cache_destroy+0x49/0x100
>  bioset_exit+0x143/0x190
>  blk_release_queue+0xb9/0x100
>  kobject_cleanup+0x37/0x130
>  nvme_fc_ctrl_free+0xc6/0x150 [nvme_fc]
>  nvme_free_ctrl+0x1ac/0x2b0 [nvme_core]
> 
> Fix this bug by creating a workqueue for the flush operation with
> the WQ_MEM_RECLAIM bit set.
> 
> v2: Create a workqueue with WQ_MEM_RECLAIM
>     instead of trying to revert the changes.
> 
> v3: replace create_workqueue() with alloc_workqueue() and BUG_ON() with
>     WARN_ON()
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  mm/slub.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..016da09608fb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -310,6 +310,11 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
>   */
>  static nodemask_t slab_nodes;
>  
> +/*
> + * Workqueue used for flush_cpu_slab().
> + */
> +static struct workqueue_struct *flushwq;
> +
>  /********************************************************************
>   * 			Core slab cache functions
>   *******************************************************************/
> @@ -2730,7 +2735,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
>  		INIT_WORK(&sfw->work, flush_cpu_slab);
>  		sfw->skip = false;
>  		sfw->s = s;
> -		schedule_work_on(cpu, &sfw->work);
> +		queue_work_on(cpu, flushwq, &sfw->work);

Hi. what happens here if flushwq failed?

I think avoiding BUG_ON() makes sense,
but shouldn't we have fallback method?

>  	}
>  
>  	for_each_online_cpu(cpu) {
> @@ -4858,6 +4863,8 @@ void __init kmem_cache_init(void)
>  
>  void __init kmem_cache_init_late(void)
>  {
> +	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
> +	WARN_ON(!flushwq);
>  }

>  
>  struct kmem_cache *
> -- 
> 2.31.1
> 
> 

-- 
Thanks,
Hyeonggon
