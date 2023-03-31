Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC06D2369
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjCaPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjCaPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:01:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F07687;
        Fri, 31 Mar 2023 08:01:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so90781953edd.5;
        Fri, 31 Mar 2023 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680274915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiyDYoXm1nKLroTm/ush+45oj0adft7fwuaN8p1GJx4=;
        b=eWB0/YNQT0RRiu1Gk2XvsBGAKbQO17UdKs71pDdyAFV8kQ2qX5lwPerzqALZe+Aaw0
         dpLgUTj72M+Jdg7lRZgliHGnTjH+JQme1L1eHQBoae7iT6omb14J6mCw+I+Da9FwPHiy
         JnSt7lLdLqrXXjqkbb322yR7yHEtpZVVs4/aloG5zBrV8XcbDu2R1rCO5bjlvoaDQ2Me
         bCJNfpr8uIQI1gPNO9be/DDsfq41wf99d3sewUJbvyo0v8P2LTKwpup8zIoT2PiiWAUn
         JE6PvvGh3YV3oNGwhvm0rN3gkO7/aTgR1VeQKgIVmtoTTC4YzBd+ySNfjlQpGK5t005M
         9/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiyDYoXm1nKLroTm/ush+45oj0adft7fwuaN8p1GJx4=;
        b=48pvc7dSBSx3lNvN/nAX02uohCE17iAR34usaLBmImXhn3X2Zj1x9X+8o8Pz0EEz+P
         fumvrnN6J+nK+khSrpgZ6n+t54rdiXAZw9muG8gQEoRvJ1wldHp3KzwukvIv4GjVJ+A1
         PY+90UGQ5//LPv2Xd3BLJSH503lfmzjnqoK+ChJc/moRFmuSmanBcfyARXY1HTdYHYIw
         RjeiqwG1yIfxL39lJ9dDj6nL+la/gA8MjuoD7r3ztMKhTSa/C3RWhJ9NzpC6mw62MoH2
         Pmcnu2EI6x/VztP9aaUdzV4FDW2hZvIv/EHS6cJvU7yIq5tunDY7aistlTfmajmXKzYO
         jYnA==
X-Gm-Message-State: AAQBX9cPM9dgrqA/s+tXPThNY9pzuFM4Y0G3HiivxfZUaJsUwKmyrGIX
        6ZJ2QkX5rp4/Gj0cjE+GpmvQheTuvG5d1Q==
X-Google-Smtp-Source: AKy350bSD+E9a7/iTBOl5LY53jNV3FCXyArehSOs29woM9lkSSKLLhrmStucXPt6ejyhx2wk0t+FZQ==
X-Received: by 2002:a17:906:ae82:b0:931:a164:8efa with SMTP id md2-20020a170906ae8200b00931a1648efamr27640353ejb.70.1680274914916;
        Fri, 31 Mar 2023 08:01:54 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id xc2-20020a170907074200b00947a6d84fefsm851162ejb.75.2023.03.31.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:01:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 31 Mar 2023 17:01:52 +0200
To:     Ziwei Dai <ziwei.dai@unisoc.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuang.wang@unisoc.com, yifan.xin@unisoc.com, ke.wang@unisoc.com,
        xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [PATCH V2] rcu: Make sure new krcp free business is handled
 after the wanted rcu grace period.
Message-ID: <ZCb14DWFDKyuuhyi@pc638.lan>
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:42:09PM +0800, Ziwei Dai wrote:
> In kfree_rcu_monitor(), new free business at krcp is attached to any free
> channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
> business is handled after the rcu grace period. But if there is any none-free
> channel at krwp already, that means there is an on-going rcu work,
> which will cause the kvfree_call_rcu()-triggered free business is done
> before the wanted rcu grace period ends.
> 
> This commit ignore krwp which has non-free channel at kfree_rcu_monitor(),
> to fix the issue that kvfree_call_rcu() loses effectiveness.
> 
> Below is the css_set obj "from_cset" use-after-free case caused by
> kvfree_call_rcu() losing effectiveness.
> CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes,
> the task is schedule out.
> CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
> But "from_cset" is freed right after current gp end. "from_cset" is reallocated.
> CPU 0 's task arrives back, references "from_cset"'s member, which causes crash.
> 
> CPU 0					CPU 1
> count_memcg_event_mm()
> |rcu_read_lock()  <---
> |mem_cgroup_from_task()
>  |// css_set_ptr is the "from_cset" mentioned on CPU 1
>  |css_set_ptr = rcu_dereference((task)->cgroups)
>  |// Hard irq comes, current task is scheduled out.
> 
> 					cgroup_attach_task()
> 					|cgroup_migrate()
> 					|cgroup_migrate_execute()
> 					|css_set_move_task(task, from_cset, to_cset, true)
> 					|cgroup_move_task(task, to_cset)
> 					|rcu_assign_pointer(.., to_cset)
> 					|...
> 					|cgroup_migrate_finish()
> 					|put_css_set_locked(from_cset)
> 					|from_cset->refcount return 0
> 					|kfree_rcu(cset, rcu_head) // means to free from_cset after new gp
> 					|add_ptr_to_bulk_krc_lock()
> 					|schedule_delayed_work(&krcp->monitor_work, ..)
> 
> 					kfree_rcu_monitor()
> 					|krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
> 					|queue_rcu_work(system_wq, &krwp->rcu_work)
> 					|if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
> 					|call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request a new gp
> 
> 					// There is a perious call_rcu(.., rcu_work_rcufn)
> 					// gp end, rcu_work_rcufn() is called.
> 					rcu_work_rcufn()
> 					|__queue_work(.., rwork->wq, &rwork->work);
> 
> 					|kfree_rcu_work()
> 					|krwp->bulk_head_free[0] bulk is freed before new gp end!!!
> 					|The "from_cset" is freed before new gp end.
> 
> // the task is scheduled in after many ms.
>  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.
> 
> v2: Use helper function instead of inserted code block at kfree_rcu_monitor().
> 
> Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of kfree_rcu() work")
> Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e880c0..7b95ee9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3024,6 +3024,18 @@ static void kfree_rcu_work(struct work_struct *work)
>  	return !!READ_ONCE(krcp->head);
>  }
>  
> +static bool
> +need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
> +{
> +	int i;
> +
> +	for (i = 0; i < FREE_N_CHANNELS; i++)
> +		if (!list_empty(&krwp->bulk_head_free[i]))
> +			return true;
> +
> +	return !!krwp->head_free;
> +}
> +
>  static int krc_count(struct kfree_rcu_cpu *krcp)
>  {
>  	int sum = atomic_read(&krcp->head_count);
> @@ -3107,15 +3119,14 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	for (i = 0; i < KFREE_N_BATCHES; i++) {
>  		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
>  
> -		// Try to detach bulk_head or head and attach it over any
> -		// available corresponding free channel. It can be that
> -		// a previous RCU batch is in progress, it means that
> -		// immediately to queue another one is not possible so
> -		// in that case the monitor work is rearmed.
> -		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
> -			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
> -				(READ_ONCE(krcp->head) && !krwp->head_free)) {
> +		// Try to detach bulk_head or head and attach it, only when
> +		// all channels are free.  Any channel is not free means at krwp
> +		// there is on-going rcu work to handle krwp's free business.
> +		if (need_wait_for_krwp_work(krwp))
> +			continue;
>  
> +		// kvfree_rcu_drain_ready() might handle this krcp, if so give up.
> +		if (need_offload_krc(krcp)) {
>  			// Channel 1 corresponds to the SLAB-pointer bulk path.
>  			// Channel 2 corresponds to vmalloc-pointer bulk path.
>  			for (j = 0; j < FREE_N_CHANNELS; j++) {
> -- 
> 1.9.1
> 
It looks correct to me. I will test it over weekend.

--
Uladzislau Rezki
