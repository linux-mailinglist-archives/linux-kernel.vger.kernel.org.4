Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C581707A38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjERGWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERGWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:22:30 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B8198
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:22:28 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-456d241fcdcso247887e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684390947; x=1686982947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc2uwncm06rQJU8W39ANTgEsgmThgA+lhl8KpPzTYXY=;
        b=XZMTdFzwFncKBuxZ19ekxindWobbrxlAh/NYEql9V4nvD/rGGAPDBoGzwnKLHocMu6
         YRhYlTYYq8VEGnpwYY5JbCwwLGV4+16goJG8QOuakPxcHQUbSWnQ1+xv7JS4aPpT3HsM
         jfJ8XhnzOYupVgf+a9ZAO21SfuEddsjz4OvtbNNkZj06+joM2/lqK2Kl9mOrMLKsh3sc
         OgLLXh7X9kCoIp8BXkB9JZaJyBwEHE1Yt8A8h8BKXkYdzu2Y51fxYvnvJ/vbpIgpvujJ
         4kuKa9LffcdJl91LYKoql7QcFRbds7yWNCfZov9kzRO0nc2gcfG3PYiKZb4FgK+02QXT
         Kdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684390947; x=1686982947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gc2uwncm06rQJU8W39ANTgEsgmThgA+lhl8KpPzTYXY=;
        b=NaeD3YV+NsXk/IRlN+E7XttiEy9K2S/PkBsxkgXHDlNzDjTcbWNMJuyXgsVfmFDBFr
         L7G1cn+c8dPVYu7hRwQiTok64YEwvaeYTkRtN9wyKNGUQXH0CFrguIHQcE2yI3I/UXls
         /nkBFKgZAsaqOpbergtysgWWO2/oht1SaAE9H04rtOLGrz/vOg+oA7jB+4ASuZeMWLO0
         eZXkASpxIlghR25c0jHLgXVx8p+aiEiRzZZ61WYyZy7jWFpcVmP5hv29iNHBT1K+qWyU
         ZtCd3aZzWKf3TxJ1GBLFx3EvCtKj9cl+dHWSl5t2BmtQkQsXYpSXFhp3sl3Bl0MsOOLl
         nyxg==
X-Gm-Message-State: AC+VfDwYcYw+0zs15H2fdzYsze5S0Go4+d/0Fr0AMLvz20Rsych673Os
        +V6p5Tnp/qwaHTuZU3nu6UE37nPOerCMDYfhaRPySQ==
X-Google-Smtp-Source: ACHHUZ7LKVO3s049SPtn/qWtTa+Dtr4NQ3mlL2g/1AZJ+dUzqTEmFvSkmtdcgv4zt2PKRUafqqACODnNGHxioouOH3A=
X-Received: by 2002:a67:f2ca:0:b0:434:8401:beb5 with SMTP id
 a10-20020a67f2ca000000b004348401beb5mr153249vsn.35.1684390946974; Wed, 17 May
 2023 23:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230516125111.2690204-1-etienne.carriere@linaro.org> <20230516125111.2690204-2-etienne.carriere@linaro.org>
In-Reply-To: <20230516125111.2690204-2-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 May 2023 11:52:16 +0530
Message-ID: <CAFA6WYMwWFRUo719wHHsjaAUOSdo4cMa8gdHBMWidP4vC4z31g@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] tee: optee: system call property
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
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

On Tue, 16 May 2023 at 18:24, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds an argument to do_call_with_arg() handler to tell whether the call
> is a system call or nor. This change always sets this info to false

s/nor/not/

> hence no functional change.
>
> This change prepares management of system invocation proposed in a later
> change.
>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v7

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Changes since v6:
> - Squashed a part of patch v6 3/4 changes into this patch v7 1/4
>   related to adding boolean system thread attribute into optee
>   driver call queue and SMC/FF-A ABIs API functions.
> - Removed local variable sys_thread set to constant false value
>   and use false straight as function argument instead.
> - Comment on struct optee_session::use_sys_thread being read with
>   optee mutex locked is not addressed as still under discussion.
>
> No changes since v5
>
> Changes since v4:
> - New change, extracted from PATCH v4 1/2 (tee: system invocation") and
>   revised to cover preparatory changes in optee driver for system session
>   support with contribution from Jens.
> ---
>  drivers/tee/optee/call.c          | 24 +++++++++++++++++-------
>  drivers/tee/optee/core.c          |  5 +++--
>  drivers/tee/optee/ffa_abi.c       | 10 ++++++----
>  drivers/tee/optee/optee_private.h |  9 ++++++---
>  drivers/tee/optee/smc_abi.c       | 15 ++++++++-------
>  5 files changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index df5fb5410b72..152ae9bb1785 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -40,7 +40,7 @@ struct optee_shm_arg_entry {
>  };
>
>  void optee_cq_wait_init(struct optee_call_queue *cq,
> -                       struct optee_call_waiter *w)
> +                       struct optee_call_waiter *w, bool sys_thread)
>  {
>         /*
>          * We're preparing to make a call to secure world. In case we can't
> @@ -328,7 +328,8 @@ int optee_open_session(struct tee_context *ctx,
>                 goto out;
>         }
>
> -       if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
> +       if (optee->ops->do_call_with_arg(ctx, shm, offs,
> +                                        sess->use_sys_thread)) {
>                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
>                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
>         }
> @@ -360,7 +361,8 @@ int optee_open_session(struct tee_context *ctx,
>         return rc;
>  }
>
> -int optee_close_session_helper(struct tee_context *ctx, u32 session)
> +int optee_close_session_helper(struct tee_context *ctx, u32 session,
> +                              bool system_thread)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_shm_arg_entry *entry;
> @@ -374,7 +376,7 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session)
>
>         msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
>         msg_arg->session = session;
> -       optee->ops->do_call_with_arg(ctx, shm, offs);
> +       optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
>
>         optee_free_msg_arg(ctx, entry, offs);
>
> @@ -385,6 +387,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
>  {
>         struct optee_context_data *ctxdata = ctx->data;
>         struct optee_session *sess;
> +       bool system_thread;
>
>         /* Check that the session is valid and remove it from the list */
>         mutex_lock(&ctxdata->mutex);
> @@ -394,9 +397,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
>         mutex_unlock(&ctxdata->mutex);
>         if (!sess)
>                 return -EINVAL;
> +       system_thread = sess->use_sys_thread;
>         kfree(sess);
>
> -       return optee_close_session_helper(ctx, session);
> +       return optee_close_session_helper(ctx, session, system_thread);
>  }
>
>  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> @@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>         struct optee_msg_arg *msg_arg;
>         struct optee_session *sess;
>         struct tee_shm *shm;
> +       bool system_thread;
>         u_int offs;
>         int rc;
>
>         /* Check that the session is valid */
>         mutex_lock(&ctxdata->mutex);
>         sess = find_session(ctxdata, arg->session);
> +       if (sess)
> +               system_thread = sess->use_sys_thread;
>         mutex_unlock(&ctxdata->mutex);
>         if (!sess)
>                 return -EINVAL;
> @@ -432,7 +439,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>         if (rc)
>                 goto out;
>
> -       if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
> +       if (optee->ops->do_call_with_arg(ctx, shm, offs, system_thread)) {
>                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
>                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
>         }
> @@ -457,12 +464,15 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
>         struct optee_shm_arg_entry *entry;
>         struct optee_msg_arg *msg_arg;
>         struct optee_session *sess;
> +       bool system_thread;
>         struct tee_shm *shm;
>         u_int offs;
>
>         /* Check that the session is valid */
>         mutex_lock(&ctxdata->mutex);
>         sess = find_session(ctxdata, session);
> +       if (sess)
> +               system_thread = sess->use_sys_thread;
>         mutex_unlock(&ctxdata->mutex);
>         if (!sess)
>                 return -EINVAL;
> @@ -474,7 +484,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
>         msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
>         msg_arg->session = session;
>         msg_arg->cancel_id = cancel_id;
> -       optee->ops->do_call_with_arg(ctx, shm, offs);
> +       optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
>
>         optee_free_msg_arg(ctx, entry, offs);
>         return 0;
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a258bd3b6b5..d01ca47f7bde 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -129,7 +129,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
>
>  static void optee_release_helper(struct tee_context *ctx,
>                                  int (*close_session)(struct tee_context *ctx,
> -                                                     u32 session))
> +                                                     u32 session,
> +                                                     bool system_thread))
>  {
>         struct optee_context_data *ctxdata = ctx->data;
>         struct optee_session *sess;
> @@ -141,7 +142,7 @@ static void optee_release_helper(struct tee_context *ctx,
>         list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
>                                  list_node) {
>                 list_del(&sess->list_node);
> -               close_session(ctx, sess->session_id);
> +               close_session(ctx, sess->session_id, sess->use_sys_thread);
>                 kfree(sess);
>         }
>         kfree(ctxdata);
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 0828240f27e6..5fde9d4100e3 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -528,7 +528,8 @@ static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
>
>  static int optee_ffa_yielding_call(struct tee_context *ctx,
>                                    struct ffa_send_direct_data *data,
> -                                  struct optee_msg_arg *rpc_arg)
> +                                  struct optee_msg_arg *rpc_arg,
> +                                  bool system_thread)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
> @@ -541,7 +542,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
>         int rc;
>
>         /* Initialize waiter */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
>         while (true) {
>                 rc = msg_ops->sync_send_receive(ffa_dev, data);
>                 if (rc)
> @@ -612,7 +613,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
>   */
>
>  static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> -                                     struct tee_shm *shm, u_int offs)
> +                                     struct tee_shm *shm, u_int offs,
> +                                     bool system_thread)
>  {
>         struct ffa_send_direct_data data = {
>                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> @@ -642,7 +644,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>         if (IS_ERR(rpc_arg))
>                 return PTR_ERR(rpc_arg);
>
> -       return optee_ffa_yielding_call(ctx, &data, rpc_arg);
> +       return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
>  }
>
>  /*
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 72685ee0d53f..b68273051454 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -154,7 +154,8 @@ struct optee;
>   */
>  struct optee_ops {
>         int (*do_call_with_arg)(struct tee_context *ctx,
> -                               struct tee_shm *shm_arg, u_int offs);
> +                               struct tee_shm *shm_arg, u_int offs,
> +                               bool system_thread);
>         int (*to_msg_param)(struct optee *optee,
>                             struct optee_msg_param *msg_params,
>                             size_t num_params, const struct tee_param *params);
> @@ -204,6 +205,7 @@ struct optee {
>  struct optee_session {
>         struct list_head list_node;
>         u32 session_id;
> +       bool use_sys_thread;
>  };
>
>  struct optee_context_data {
> @@ -252,7 +254,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> -int optee_close_session_helper(struct tee_context *ctx, u32 session);
> +int optee_close_session_helper(struct tee_context *ctx, u32 session,
> +                              bool system_thread);
>  int optee_close_session(struct tee_context *ctx, u32 session);
>  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>                       struct tee_param *param);
> @@ -301,7 +304,7 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
>  }
>
>  void optee_cq_wait_init(struct optee_call_queue *cq,
> -                       struct optee_call_waiter *w);
> +                       struct optee_call_waiter *w, bool sys_thread);
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
>                                   struct optee_call_waiter *w);
>  void optee_cq_wait_final(struct optee_call_queue *cq,
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 49702cb08f4f..e2763cdcf111 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -283,7 +283,7 @@ static void optee_enable_shm_cache(struct optee *optee)
>         struct optee_call_waiter w;
>
>         /* We need to retry until secure world isn't busy. */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, false);
>         while (true) {
>                 struct arm_smccc_res res;
>
> @@ -308,7 +308,7 @@ static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
>         struct optee_call_waiter w;
>
>         /* We need to retry until secure world isn't busy. */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, false);
>         while (true) {
>                 union {
>                         struct arm_smccc_res smccc;
> @@ -507,7 +507,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>         msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
>           (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
>
> -       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
> +       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
>             msg_arg->ret != TEEC_SUCCESS)
>                 rc = -EINVAL;
>
> @@ -550,7 +550,7 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
>         msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
>         msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
>
> -       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
> +       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
>             msg_arg->ret != TEEC_SUCCESS)
>                 rc = -EINVAL;
>  out:
> @@ -885,7 +885,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
>   * Returns return code from secure world, 0 is OK
>   */
>  static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> -                                     struct tee_shm *shm, u_int offs)
> +                                     struct tee_shm *shm, u_int offs,
> +                                     bool system_thread)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_call_waiter w;
> @@ -926,7 +927,7 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>                 reg_pair_from_64(&param.a1, &param.a2, parg);
>         }
>         /* Initialize waiter */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
>         while (true) {
>                 struct arm_smccc_res res;
>
> @@ -977,7 +978,7 @@ static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
>                 return PTR_ERR(msg_arg);
>
>         msg_arg->cmd = cmd;
> -       optee_smc_do_call_with_arg(ctx, shm, offs);
> +       optee_smc_do_call_with_arg(ctx, shm, offs, false);
>
>         optee_free_msg_arg(ctx, entry, offs);
>         return 0;
> --
> 2.25.1
>
