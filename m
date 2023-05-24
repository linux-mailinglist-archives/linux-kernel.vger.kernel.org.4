Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3370EF73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbjEXHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEXHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:32:06 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7578F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:32:04 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-457201c47f6so251177e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684913523; x=1687505523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLkU6OSVP4u1TGTSrobiqBnALvD7urgOWG7UmhaSjK0=;
        b=S6GCmUOTnQaygwzlmQSJizaQ0qVionEBzcOpG7bOSWbvK6PcyyDTogcihkp9WyG7Dq
         Vj7XW2IJKxiNyo2vcQ+JnLFDKhDDaKt23EWSBzOu30++p8ECrA/R/OBjOnh4A+6N2mw4
         rDQaphwzUDGmZzBa+0fQU8OTrai9L2xHRB/oINhcNZ+O+rUWuvCgw9OvW/dCbrGQiRBc
         rxEocPe6SPKQU2g6PhXEisQ+Xc22ENIHrf40x4+tfoxy6JWuluuzFvVhNVfTMHkClF0E
         tEO3t4OHeeWeEjzdN4taHX/pCcanONyIKGMU8o60rskSoIfDw8vJVhpWe9S/j7wWoLeg
         elPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684913523; x=1687505523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLkU6OSVP4u1TGTSrobiqBnALvD7urgOWG7UmhaSjK0=;
        b=XIhB49zBOnIuTdw24gaP8vNAU8F184mcIef3/ergZgy5bCRl7THa4StzBROcSFe0MB
         fOtWPF1H+3zFkTmAQmqGahNRxC81souSPZjFJ5hyNJ0VU3f60f9KDSPzkrFxBtGDutuq
         RCyENiaefXdVWP/nXjqUiWzDiF3FukXY7fnK6YSNgoOIipZpqSoe3HJ7fSvxFmGhlfFq
         p84PGTX0+CApB20W8FVuOmRUkHtTSmXEjxzc7cE9UF4VFn8yyY++5jH5XnCU/tvybdyR
         fUcXJtTqDk+FOsWWUsFAblMpJ0348GKWF1ICBRSoqDl1Uto0GhJIHvl+OJXHVkweO44D
         sdEQ==
X-Gm-Message-State: AC+VfDw5bmsOIXoM6a5+rqiF+w1El+gc+rhNNQxx7058RcjWiOihLId0
        d2MotpE6TxUTWO/Uanzern2gWfqb/dbJSHMl2mzJ1g==
X-Google-Smtp-Source: ACHHUZ6xj27SeRhKxZe6B9Oz9l14143MF9T0C68M2A8TJ5SpaUKT+GjQN151QpQqJerHN1UiF4BX7HieLYs+/+R11FE=
X-Received: by 2002:a1f:5e07:0:b0:457:400a:f3fc with SMTP id
 s7-20020a1f5e07000000b00457400af3fcmr3975468vkb.2.1684913523270; Wed, 24 May
 2023 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org> <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
In-Reply-To: <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 May 2023 13:01:52 +0530
Message-ID: <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, jens.wiklander@linaro.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        vincent.guittot@linaro.org,
        etienne carriere <Etienne.carriere@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 at 12:41, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello Sumit,
>
>
> On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > From: Etienne Carriere <etienne.carriere@linaro.org>
> >
> > Adds support in the OP-TEE driver to keep track of reserved system
> > threads. The optee_cq_*() functions are updated to handle this if
> > enabled. The SMC ABI part of the driver enables this tracking, but the
> > FF-A ABI part does not.
> >
> > The logic allows atleast 1 OP-TEE thread can be reserved to TEE system
> > sessions. For sake of simplicity, initialization of call queue
> > management is factorized into new helper function optee_cq_init().
> >
> > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Disclaimer: Compile tested only
> >
> > Hi Etienne,
> >
> > Overall the idea we agreed upon was okay but the implementation looked
> > complex to me. So I thought it would be harder to explain that via
> > review and I decided myself to give a try at simplification. I would
> > like you to test it if this still addresses the SCMI deadlock problem or
> > not. Also, feel free to include this in your patchset if all goes fine
> > wrt testing.
>
> With these changes, there is no more a specific waiting list for TEE
> system threads hence when a waiting queue can complete, we'll pick any
> TEE thread, not a TEE system thread first..

I had thought about this but I can't see any value in having a
separate wait queue for system threads. Here we only need to provide
an extra privileged thread for system sessions (kernel clients) such
that user-space doesn't contend for that thread. This prevents kernel
client's starvation or deadlock like in the SCMI case.

> Also, as stated in a below answer, these change unconditionally
> reserve a TEE thread for TEE system calls even if no TEE client
> reserved such.

I don't think we should make thread reservations based on the presence
of TEE clients. You never know how much user-space or kernel TEE
clients you are dealing with. And reserving a single privileged thread
unconditionally for system sessions shouldn't be much of a burden for
memory constrained devices too.

Also, this way we would enable every kernel TEE client to leverage
system sessions as it's very likely they wouldn't like to compete with
user-space for thread availability. Two other kernel TEE clients that
are on top of my head are HWRNG and Trusted Keys which can benefit
from this feature.

> >
> > Changes since v8:
> > - Simplified system threads tracking implementation.
> >
> >  drivers/tee/optee/call.c          | 72 +++++++++++++++++++++++++++++--
> >  drivers/tee/optee/ffa_abi.c       |  3 +-
> >  drivers/tee/optee/optee_private.h | 16 +++++++
> >  drivers/tee/optee/smc_abi.c       | 16 ++++++-
> >  4 files changed, 99 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 42e478ac6ce1..09e824e4dcaf 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -39,9 +39,27 @@ struct optee_shm_arg_entry {
> >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> >  };
> >
> > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > +{
> > +       mutex_init(&cq->mutex);
> > +       INIT_LIST_HEAD(&cq->waiters);
> > +       /*
> > +        * If cq->total_thread_count is 0 then we're not trying to keep
> > +        * track of how many free threads we have, instead we're relying on
> > +        * the secure world to tell us when we're out of thread and have to
> > +        * wait for another thread to become available.
> > +        */
> > +       cq->total_thread_count = thread_count;
> > +       cq->free_thread_count = thread_count;
> > +}
> > +
> >  void optee_cq_wait_init(struct optee_call_queue *cq,
> >                         struct optee_call_waiter *w, bool sys_thread)
> >  {
> > +       bool need_wait = false;
> > +
> > +       memset(w, 0, sizeof(*w));
> > +
> >         /*
> >          * We're preparing to make a call to secure world. In case we can't
> >          * allocate a thread in secure world we'll end up waiting in
> > @@ -53,15 +71,43 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
> >         mutex_lock(&cq->mutex);
> >
> >         /*
> > -        * We add ourselves to the queue, but we don't wait. This
> > -        * guarantees that we don't lose a completion if secure world
> > -        * returns busy and another thread just exited and try to complete
> > -        * someone.
> > +        * We add ourselves to a queue, but we don't wait. This guarantees
> > +        * that we don't lose a completion if secure world returns busy and
> > +        * another thread just exited and try to complete someone.
> >          */
> >         init_completion(&w->c);
> >         list_add_tail(&w->list_node, &cq->waiters);
> >
> > +       if (cq->total_thread_count && sys_thread) {
> > +               if (cq->free_thread_count > 0)
> > +                       cq->free_thread_count--;
> > +               else
> > +                       need_wait = true;
> > +       } else if (cq->total_thread_count) {
> > +               if (cq->free_thread_count > 1)
>
> This unconditionally reserves a TEE thread for TEE system calls, even
> if no client has claimed such system thread reservation.

See my response above.

>
>
> > +                       cq->free_thread_count--;
> > +               else
> > +                       need_wait = true;
> > +       }
> > +
> >         mutex_unlock(&cq->mutex);
> > +
> > +       while (need_wait) {
> > +               optee_cq_wait_for_completion(cq, w);
> > +               mutex_lock(&cq->mutex);
> > +               if (sys_thread) {
> > +                       if (cq->free_thread_count > 0) {
> > +                               cq->free_thread_count--;
> > +                               need_wait = false;
> > +                       }
> > +               } else {
> > +                       if (cq->free_thread_count > 1) {
> > +                               cq->free_thread_count--;
> > +                               need_wait = false;
> > +                       }
> > +               }
> > +               mutex_unlock(&cq->mutex);
> > +       }
> >  }
> >
> >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > @@ -104,6 +150,8 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
> >         /* Get out of the list */
> >         list_del(&w->list_node);
> >
> > +       cq->free_thread_count++;
> > +
> >         /* Wake up one eventual waiting task */
> >         optee_cq_complete_one(cq);
> >
> > @@ -361,6 +409,22 @@ int optee_open_session(struct tee_context *ctx,
> >         return rc;
> >  }
> >
> > +int optee_system_session(struct tee_context *ctx, u32 session)
> > +{
> > +       struct optee_context_data *ctxdata = ctx->data;
> > +       struct optee_session *sess;
> > +
> > +       mutex_lock(&ctxdata->mutex);
> > +
> > +       sess = find_session(ctxdata, session);
> > +       if (sess && !sess->use_sys_thread)
> > +               sess->use_sys_thread = true;
> > +
> > +       mutex_unlock(&ctxdata->mutex);
> > +
> > +       return 0;
>
> Nitpicking: should rather return 0 only upon session is valid
> (sess!=NULL here)  and system thread reservation is supported
> (total_thread_count > 0).
> But that's not a big deal I guess, can be addressed.

Thanks for pointing it out. If this approach works for you then it can
be addressed while integrating in your patch-set.

-Sumit

>
>
>
>
> > +}
> > +
> >  int optee_close_session_helper(struct tee_context *ctx, u32 session,
> >                                bool system_thread)
> >  {
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 5fde9d4100e3..0c9055691343 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >         if (rc)
> >                 goto err_unreg_supp_teedev;
> >         mutex_init(&optee->ffa.mutex);
> > -       mutex_init(&optee->call_queue.mutex);
> > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > +       optee_cq_init(&optee->call_queue, 0);
> >         optee_supp_init(&optee->supp);
> >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> >         ffa_dev_set_drvdata(ffa_dev, optee);
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index b68273051454..6dcecb83c893 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -40,15 +40,29 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
> >                                 unsigned long, unsigned long,
> >                                 struct arm_smccc_res *);
> >
> > +/*
> > + * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
> > + * @list_node          Reference in waiters list
> > + * @c                  Waiting completion reference
> > + */
> >  struct optee_call_waiter {
> >         struct list_head list_node;
> >         struct completion c;
> >  };
> >
> > +/*
> > + * struct optee_call_queue - OP-TEE call queue management
> > + * @mutex                      Serializes access to this struct
> > + * @waiters                    List of threads waiting to enter OP-TEE
> > + * @total_thread_count         Overall number of thread context in OP-TEE or 0
> > + * @free_thread_count          Number of threads context free in OP-TEE
> > + */
> >  struct optee_call_queue {
> >         /* Serializes access to this struct */
> >         struct mutex mutex;
> >         struct list_head waiters;
> > +       int total_thread_count;
> > +       int free_thread_count;
> >  };
> >
> >  struct optee_notif {
> > @@ -254,6 +268,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
> >  int optee_open_session(struct tee_context *ctx,
> >                        struct tee_ioctl_open_session_arg *arg,
> >                        struct tee_param *param);
> > +int optee_system_session(struct tee_context *ctx, u32 session);
> >  int optee_close_session_helper(struct tee_context *ctx, u32 session,
> >                                bool system_thread);
> >  int optee_close_session(struct tee_context *ctx, u32 session);
> > @@ -303,6 +318,7 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
> >         mp->u.value.c = p->u.value.c;
> >  }
> >
> > +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
> >  void optee_cq_wait_init(struct optee_call_queue *cq,
> >                         struct optee_call_waiter *w, bool sys_thread);
> >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index e2763cdcf111..3314ffeb91c8 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1209,6 +1209,7 @@ static const struct tee_driver_ops optee_clnt_ops = {
> >         .release = optee_release,
> >         .open_session = optee_open_session,
> >         .close_session = optee_close_session,
> > +       .system_session = optee_system_session,
> >         .invoke_func = optee_invoke_func,
> >         .cancel_req = optee_cancel_req,
> >         .shm_register = optee_shm_register,
> > @@ -1356,6 +1357,16 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >         return true;
> >  }
> >
> > +static unsigned int optee_msg_get_thread_count(optee_invoke_fn *invoke_fn)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, &res);
> > +       if (res.a0)
> > +               return 0;
> > +       return res.a1;
> > +}
> > +
> >  static struct tee_shm_pool *
> >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  {
> > @@ -1609,6 +1620,7 @@ static int optee_probe(struct platform_device *pdev)
> >         struct optee *optee = NULL;
> >         void *memremaped_shm = NULL;
> >         unsigned int rpc_param_count;
> > +       unsigned int thread_count;
> >         struct tee_device *teedev;
> >         struct tee_context *ctx;
> >         u32 max_notif_value;
> > @@ -1636,6 +1648,7 @@ static int optee_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >         }
> >
> > +       thread_count = optee_msg_get_thread_count(invoke_fn);
> >         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> >                                              &max_notif_value,
> >                                              &rpc_param_count)) {
> > @@ -1725,8 +1738,7 @@ static int optee_probe(struct platform_device *pdev)
> >         if (rc)
> >                 goto err_unreg_supp_teedev;
> >
> > -       mutex_init(&optee->call_queue.mutex);
> > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > +       optee_cq_init(&optee->call_queue, thread_count);
> >         optee_supp_init(&optee->supp);
> >         optee->smc.memremaped_shm = memremaped_shm;
> >         optee->pool = pool;
> > --
> > 2.34.1
> >
