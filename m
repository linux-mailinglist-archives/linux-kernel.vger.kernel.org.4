Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC546FEB82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjEKGDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjEKGDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:03:40 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C095448C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:03:36 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-77d3a10d19fso2456244241.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683785015; x=1686377015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o10g7UX+EjjTgiesOScCmWtyaElcBhyMmxpom012ELo=;
        b=HDDpjixRB6pwujzqwKj5F3rxiU+jFwOCvjJvEnv8YCPb6aA3Y7lME0QIrJluf0SUrH
         5uRTsDntHTNsZNipj4X/68OhmPxKDVK0JQHkBTZMcrW34z+n8sEroEoGyuYkO8l1cFsr
         94ohNTgMPE/uwZRKpbatvaA20gCLmTF+25ks+Tv0oe340fGhbzeLftoToutZbRSLCtTC
         tAI0p/7b3bqlucpQrf+sfv5oXusCsnB57rhSHq5a2G7OGtLWSLh1UHN7b4HPM8uegjoL
         hdNkUZRTJowfvJMULC1mQgfEkFb5hKyPAp058gGhRgD9ocrWUXCUCaU82K8+nAVrq6Zm
         oFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683785015; x=1686377015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o10g7UX+EjjTgiesOScCmWtyaElcBhyMmxpom012ELo=;
        b=ayQknzr+hWaURlXAjRk8/hfz/X2pYFonVWA7Upd1eGs3rybIX3wdiC+8ueWnZj7bFL
         G3HiBLeQiQWXG2yTAxbmSbWp16B3IKh1PO35vnSqs3oqa3SwWc5VwjMzS/A+o+o0AYUV
         oJOHul0KlhqNkJaAGauwa5UhwWmDsfRyURp4t7M40VFm3YtdZbutICuLySMmrWL6Km47
         ypZoHIYkHKWhd1w91bnNU/sb8ERR/PVEIkxTjLBItElgsay+DC+KPQeoYnjBFlSbH27m
         jOWV1zMldFev6VMAqQXpItFUDQolDn2PzL1kL5nANhspqDmPmpq3GlW9tRegEnqRjQvl
         VlAQ==
X-Gm-Message-State: AC+VfDz8T9f+EJXmmyDJzC8pUrslts4YVCamM+Bt3vD6TjQjjriy2UyN
        WtGRqlUhTllAnkYYiIJFu4Rpg5W8dRovWK4sA9iUYw==
X-Google-Smtp-Source: ACHHUZ7oNzrS9PSA82ulijQKG7YQ5B8SYLNMTvUCMYsKFQDHWpufREUH/9Uz7CC0jMTujLsfiFHSbYos09PBanE1/X0=
X-Received: by 2002:a67:bb02:0:b0:434:47ea:b02 with SMTP id
 m2-20020a67bb02000000b0043447ea0b02mr6889659vsn.10.1683785015347; Wed, 10 May
 2023 23:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <CAFA6WYMGw5Dh09BfZwmYtdWQOLGvft4DPuQt4mUByk55vQwjJg@mail.gmail.com> <CAN5uoS9QZCRiN=USbSNm1vz34vg_9+msT0NP9B3mCAx9evesYQ@mail.gmail.com>
In-Reply-To: <CAN5uoS9QZCRiN=USbSNm1vz34vg_9+msT0NP9B3mCAx9evesYQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 11 May 2023 11:33:24 +0530
Message-ID: <CAFA6WYPL9MadOp1DYcMWcjD34wnwD+bRVtBmHS+hR=976HsopA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] tee: optee: system call property
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
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

On Wed, 10 May 2023 at 20:33, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello Sumit,
>
> On Wed, 10 May 2023 at 10:22, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Etienne,
> >
> > Apologies for the late re-review for this patchset. It has been quite
> > a busy last month for me.
> >
> > As a side note, I would appreciate it if you add a cover letter to
> > your patchset. A cover letter is generally preferred if there is a
> > patchset containing 2 or more patches.
>
> Ok, I'll do in patch v7.
>
> >
> > On Fri, 5 May 2023 at 23:01, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > >
> > > Adds an argument to do_call_with_arg() handler to tell whether the call
> > > is a system call or nor. This change always sets this info to false
> > > hence no functional change.
> > >
> > > This change prepares management of system invocation proposed in a later
> > > change.
> > >
> > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > > No changes since v5
> > >
> > > Changes since v4:
> > > - New change, extracted from PATCH v4 1/2 (tee: system invocation") and
> > >   revised to cover preparatory changes in optee driver for system session
> > >   support with contribution from Jens.
> > > ---
> > >  drivers/tee/optee/call.c          | 22 ++++++++++++++++------
> > >  drivers/tee/optee/core.c          |  5 +++--
> > >  drivers/tee/optee/ffa_abi.c       |  3 ++-
> > >  drivers/tee/optee/optee_private.h |  7 +++++--
> > >  drivers/tee/optee/smc_abi.c       |  9 +++++----
> > >  5 files changed, 31 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > index df5fb5410b72..dba5339b61ae 100644
> > > --- a/drivers/tee/optee/call.c
> > > +++ b/drivers/tee/optee/call.c
> > > @@ -328,7 +328,8 @@ int optee_open_session(struct tee_context *ctx,
> > >                 goto out;
> > >         }
> > >
> > > -       if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
> > > +       if (optee->ops->do_call_with_arg(ctx, shm, offs,
> > > +                                        sess->use_sys_thread)) {
> > >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> > >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> > >         }
> > > @@ -360,7 +361,8 @@ int optee_open_session(struct tee_context *ctx,
> > >         return rc;
> > >  }
> > >
> > > -int optee_close_session_helper(struct tee_context *ctx, u32 session)
> > > +int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > > +                              bool system_thread)
> > >  {
> > >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> > >         struct optee_shm_arg_entry *entry;
> > > @@ -374,7 +376,7 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session)
> > >
> > >         msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> > >         msg_arg->session = session;
> > > -       optee->ops->do_call_with_arg(ctx, shm, offs);
> > > +       optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
> > >
> > >         optee_free_msg_arg(ctx, entry, offs);
> > >
> > > @@ -385,6 +387,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
> > >  {
> > >         struct optee_context_data *ctxdata = ctx->data;
> > >         struct optee_session *sess;
> > > +       bool system_thread;
> > >
> > >         /* Check that the session is valid and remove it from the list */
> > >         mutex_lock(&ctxdata->mutex);
> > > @@ -394,9 +397,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
> > >         mutex_unlock(&ctxdata->mutex);
> > >         if (!sess)
> > >                 return -EINVAL;
> > > +       system_thread = sess->use_sys_thread;
> > >         kfree(sess);
> > >
> > > -       return optee_close_session_helper(ctx, session);
> > > +       return optee_close_session_helper(ctx, session, system_thread);
> > >  }
> > >
> > >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > > @@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > >         struct optee_msg_arg *msg_arg;
> > >         struct optee_session *sess;
> > >         struct tee_shm *shm;
> > > +       bool system_thread;
> > >         u_int offs;
> > >         int rc;
> > >
> > >         /* Check that the session is valid */
> > >         mutex_lock(&ctxdata->mutex);
> > >         sess = find_session(ctxdata, arg->session);
> > > +       if (sess)
> >
> > This check is redundant if we move the assignment below...
>
> Here we change the sesssion attribute while the mutex is locked, in
> case some equivalent call with that session is issued.
> Below we return to caller once mutex is unlocked.
> I think it is the safer behavior. What do you think?

Aren't we only reading session attribute in order to capture value in
a local variable: system_thread? I don't think that it would require a
mutex.

-Sumit

>
> Best regards,
> Etienne
>
> >
> > > +               system_thread = sess->use_sys_thread;
> > >         mutex_unlock(&ctxdata->mutex);
> > >         if (!sess)
> > >                 return -EINVAL;
> >
> > ...here as:
> >            system_thread = sess->use_sys_thread;
> >
> > > @@ -432,7 +439,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > >         if (rc)
> > >                 goto out;
> > >
> > > -       if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
> > > +       if (optee->ops->do_call_with_arg(ctx, shm, offs, system_thread)) {
> > >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> > >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> > >         }
> > > @@ -457,12 +464,15 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> > >         struct optee_shm_arg_entry *entry;
> > >         struct optee_msg_arg *msg_arg;
> > >         struct optee_session *sess;
> > > +       bool system_thread;
> > >         struct tee_shm *shm;
> > >         u_int offs;
> > >
> > >         /* Check that the session is valid */
> > >         mutex_lock(&ctxdata->mutex);
> > >         sess = find_session(ctxdata, session);
> > > +       if (sess)
> >
> > Ditto.
> >
> > -Sumit
> >
> > > +               system_thread = sess->use_sys_thread;
> > >         mutex_unlock(&ctxdata->mutex);
> > >         if (!sess)
> > >                 return -EINVAL;
> > > @@ -474,7 +484,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> > >         msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
> > >         msg_arg->session = session;
> > >         msg_arg->cancel_id = cancel_id;
> > > -       optee->ops->do_call_with_arg(ctx, shm, offs);
> > > +       optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
> > >
> > >         optee_free_msg_arg(ctx, entry, offs);
> > >         return 0;
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index 2a258bd3b6b5..d01ca47f7bde 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -129,7 +129,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
> > >
> > >  static void optee_release_helper(struct tee_context *ctx,
> > >                                  int (*close_session)(struct tee_context *ctx,
> > > -                                                     u32 session))
> > > +                                                     u32 session,
> > > +                                                     bool system_thread))
> > >  {
> > >         struct optee_context_data *ctxdata = ctx->data;
> > >         struct optee_session *sess;
> > > @@ -141,7 +142,7 @@ static void optee_release_helper(struct tee_context *ctx,
> > >         list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
> > >                                  list_node) {
> > >                 list_del(&sess->list_node);
> > > -               close_session(ctx, sess->session_id);
> > > +               close_session(ctx, sess->session_id, sess->use_sys_thread);
> > >                 kfree(sess);
> > >         }
> > >         kfree(ctxdata);
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > index 0828240f27e6..52cec9d06041 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -612,7 +612,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
> > >   */
> > >
> > >  static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> > > -                                     struct tee_shm *shm, u_int offs)
> > > +                                     struct tee_shm *shm, u_int offs,
> > > +                                     bool system_thread)
> > >  {
> > >         struct ffa_send_direct_data data = {
> > >                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > > index 72685ee0d53f..3da7960ab34a 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -154,7 +154,8 @@ struct optee;
> > >   */
> > >  struct optee_ops {
> > >         int (*do_call_with_arg)(struct tee_context *ctx,
> > > -                               struct tee_shm *shm_arg, u_int offs);
> > > +                               struct tee_shm *shm_arg, u_int offs,
> > > +                               bool system_thread);
> > >         int (*to_msg_param)(struct optee *optee,
> > >                             struct optee_msg_param *msg_params,
> > >                             size_t num_params, const struct tee_param *params);
> > > @@ -204,6 +205,7 @@ struct optee {
> > >  struct optee_session {
> > >         struct list_head list_node;
> > >         u32 session_id;
> > > +       bool use_sys_thread;
> > >  };
> > >
> > >  struct optee_context_data {
> > > @@ -252,7 +254,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
> > >  int optee_open_session(struct tee_context *ctx,
> > >                        struct tee_ioctl_open_session_arg *arg,
> > >                        struct tee_param *param);
> > > -int optee_close_session_helper(struct tee_context *ctx, u32 session);
> > > +int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > > +                              bool system_thread);
> > >  int optee_close_session(struct tee_context *ctx, u32 session);
> > >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > >                       struct tee_param *param);
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > index 49702cb08f4f..56ebbb96ac97 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -507,7 +507,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> > >         msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
> > >           (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> > >
> > > -       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
> > > +       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
> > >             msg_arg->ret != TEEC_SUCCESS)
> > >                 rc = -EINVAL;
> > >
> > > @@ -550,7 +550,7 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> > >         msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> > >         msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
> > >
> > > -       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
> > > +       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
> > >             msg_arg->ret != TEEC_SUCCESS)
> > >                 rc = -EINVAL;
> > >  out:
> > > @@ -885,7 +885,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
> > >   * Returns return code from secure world, 0 is OK
> > >   */
> > >  static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> > > -                                     struct tee_shm *shm, u_int offs)
> > > +                                     struct tee_shm *shm, u_int offs,
> > > +                                     bool system_thread)
> > >  {
> > >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> > >         struct optee_call_waiter w;
> > > @@ -977,7 +978,7 @@ static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
> > >                 return PTR_ERR(msg_arg);
> > >
> > >         msg_arg->cmd = cmd;
> > > -       optee_smc_do_call_with_arg(ctx, shm, offs);
> > > +       optee_smc_do_call_with_arg(ctx, shm, offs, false);
> > >
> > >         optee_free_msg_arg(ctx, entry, offs);
> > >         return 0;
> > > --
> > > 2.25.1
> > >
