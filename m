Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A116FE111
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjEJPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbjEJPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:03:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BC7AA7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:03:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso1331113566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683730985; x=1686322985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Aj3khfB4oFZTwxaYbEjDJrO0uv67VTLSjoT8NZPEmU=;
        b=EX0G5gg2XByS44t0Uji1qKhNfuR9P0xB0tEQ7CeXx6UrLT0GwJRu46llaaWeampzLC
         8Ot6BpTuj4hjSePWaSKJSrwSA2MOqN73J4jCCzoJYnWCytYBcpqGLU6FsksYBD66oeSt
         EXonrvbZvrbTzwNTjUaTKWep1xheQ/k+qpXfjfuUZGpqc2dZbgqvCIPKwPvf9vWrpZeQ
         YRaxCpAX7vU290Ehp47DfxspPXr/cQBf1iVprVJ1Nptj+JhG4LovBC/qePd6KtuUyjF/
         Ob1DKomzBUo/peTKZcYkD3GYslQWMkh+rx6DWXX//Jh8D9gJohgcQ+x1gm/dsq2GYXCD
         B8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730985; x=1686322985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Aj3khfB4oFZTwxaYbEjDJrO0uv67VTLSjoT8NZPEmU=;
        b=HUHpL0LkhFCG1DOjU7+LCmmRlStQIGj2rDOloyl1GmKXe1XfHBFjTOVtnMCnBw50hf
         pqhAO7c0GJ3KNPc/9w31mhcwsYFLy7WtpEZmO3rR3vbpQ/Fxj3AAyFiFKA1UowoIfpKD
         Bfe16ahYVsdjfvY9F8+ZYtyo+3gPjAoln91JjGDuDFV2pHhlD3LbB4V7bqTQ7JpnwyqR
         hKQYGBXA0qT1ynw55BAr5cj8r01wtxBi+4iyO9+aROhSdIOt+28/dnZfrHF5oXBTpiAW
         EcSQm/OidA+jU7sN46i0u2yGbtGOL6HEBE/X3SXQp0sPGvREvUgfr9yRKeh5z0sgXGAr
         QxGQ==
X-Gm-Message-State: AC+VfDxQsrCCva+3vNvNRVDmtMsiTuRhcyYnvRIDWjRIctcikWX5FPy6
        3OKilAgDXx9g0uYwTsnVQmutAwUxjPA3m5i8g+NTJmRRNdoqVTSN
X-Google-Smtp-Source: ACHHUZ7zI2VXfPaCfhVQ2RVRCF59swKfW62/U3UZKe80fhIZkkcVBHusYE3g8TNlFDUuyhdcafwNk3UQWHy7XWYA7uc=
X-Received: by 2002:a17:907:26c2:b0:94f:720b:1b14 with SMTP id
 bp2-20020a17090726c200b0094f720b1b14mr14808965ejc.29.1683730984492; Wed, 10
 May 2023 08:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org> <CAFA6WYMGw5Dh09BfZwmYtdWQOLGvft4DPuQt4mUByk55vQwjJg@mail.gmail.com>
In-Reply-To: <CAFA6WYMGw5Dh09BfZwmYtdWQOLGvft4DPuQt4mUByk55vQwjJg@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 10 May 2023 17:02:53 +0200
Message-ID: <CAN5uoS9QZCRiN=USbSNm1vz34vg_9+msT0NP9B3mCAx9evesYQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] tee: optee: system call property
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit,

On Wed, 10 May 2023 at 10:22, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Etienne,
>
> Apologies for the late re-review for this patchset. It has been quite
> a busy last month for me.
>
> As a side note, I would appreciate it if you add a cover letter to
> your patchset. A cover letter is generally preferred if there is a
> patchset containing 2 or more patches.

Ok, I'll do in patch v7.

>
> On Fri, 5 May 2023 at 23:01, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Adds an argument to do_call_with_arg() handler to tell whether the call
> > is a system call or nor. This change always sets this info to false
> > hence no functional change.
> >
> > This change prepares management of system invocation proposed in a later
> > change.
> >
> > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > No changes since v5
> >
> > Changes since v4:
> > - New change, extracted from PATCH v4 1/2 (tee: system invocation") and
> >   revised to cover preparatory changes in optee driver for system session
> >   support with contribution from Jens.
> > ---
> >  drivers/tee/optee/call.c          | 22 ++++++++++++++++------
> >  drivers/tee/optee/core.c          |  5 +++--
> >  drivers/tee/optee/ffa_abi.c       |  3 ++-
> >  drivers/tee/optee/optee_private.h |  7 +++++--
> >  drivers/tee/optee/smc_abi.c       |  9 +++++----
> >  5 files changed, 31 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index df5fb5410b72..dba5339b61ae 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -328,7 +328,8 @@ int optee_open_session(struct tee_context *ctx,
> >                 goto out;
> >         }
> >
> > -       if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
> > +       if (optee->ops->do_call_with_arg(ctx, shm, offs,
> > +                                        sess->use_sys_thread)) {
> >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> >         }
> > @@ -360,7 +361,8 @@ int optee_open_session(struct tee_context *ctx,
> >         return rc;
> >  }
> >
> > -int optee_close_session_helper(struct tee_context *ctx, u32 session)
> > +int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > +                              bool system_thread)
> >  {
> >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_shm_arg_entry *entry;
> > @@ -374,7 +376,7 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session)
> >
> >         msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> >         msg_arg->session = session;
> > -       optee->ops->do_call_with_arg(ctx, shm, offs);
> > +       optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
> >
> >         optee_free_msg_arg(ctx, entry, offs);
> >
> > @@ -385,6 +387,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
> >  {
> >         struct optee_context_data *ctxdata = ctx->data;
> >         struct optee_session *sess;
> > +       bool system_thread;
> >
> >         /* Check that the session is valid and remove it from the list */
> >         mutex_lock(&ctxdata->mutex);
> > @@ -394,9 +397,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
> >         mutex_unlock(&ctxdata->mutex);
> >         if (!sess)
> >                 return -EINVAL;
> > +       system_thread = sess->use_sys_thread;
> >         kfree(sess);
> >
> > -       return optee_close_session_helper(ctx, session);
> > +       return optee_close_session_helper(ctx, session, system_thread);
> >  }
> >
> >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > @@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >         struct optee_msg_arg *msg_arg;
> >         struct optee_session *sess;
> >         struct tee_shm *shm;
> > +       bool system_thread;
> >         u_int offs;
> >         int rc;
> >
> >         /* Check that the session is valid */
> >         mutex_lock(&ctxdata->mutex);
> >         sess = find_session(ctxdata, arg->session);
> > +       if (sess)
>
> This check is redundant if we move the assignment below...

Here we change the sesssion attribute while the mutex is locked, in
case some equivalent call with that session is issued.
Below we return to caller once mutex is unlocked.
I think it is the safer behavior. What do you think?

Best regards,
Etienne

>
> > +               system_thread = sess->use_sys_thread;
> >         mutex_unlock(&ctxdata->mutex);
> >         if (!sess)
> >                 return -EINVAL;
>
> ...here as:
>            system_thread = sess->use_sys_thread;
>
> > @@ -432,7 +439,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >         if (rc)
> >                 goto out;
> >
> > -       if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
> > +       if (optee->ops->do_call_with_arg(ctx, shm, offs, system_thread)) {
> >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> >         }
> > @@ -457,12 +464,15 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >         struct optee_shm_arg_entry *entry;
> >         struct optee_msg_arg *msg_arg;
> >         struct optee_session *sess;
> > +       bool system_thread;
> >         struct tee_shm *shm;
> >         u_int offs;
> >
> >         /* Check that the session is valid */
> >         mutex_lock(&ctxdata->mutex);
> >         sess = find_session(ctxdata, session);
> > +       if (sess)
>
> Ditto.
>
> -Sumit
>
> > +               system_thread = sess->use_sys_thread;
> >         mutex_unlock(&ctxdata->mutex);
> >         if (!sess)
> >                 return -EINVAL;
> > @@ -474,7 +484,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >         msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
> >         msg_arg->session = session;
> >         msg_arg->cancel_id = cancel_id;
> > -       optee->ops->do_call_with_arg(ctx, shm, offs);
> > +       optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
> >
> >         optee_free_msg_arg(ctx, entry, offs);
> >         return 0;
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 2a258bd3b6b5..d01ca47f7bde 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -129,7 +129,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
> >
> >  static void optee_release_helper(struct tee_context *ctx,
> >                                  int (*close_session)(struct tee_context *ctx,
> > -                                                     u32 session))
> > +                                                     u32 session,
> > +                                                     bool system_thread))
> >  {
> >         struct optee_context_data *ctxdata = ctx->data;
> >         struct optee_session *sess;
> > @@ -141,7 +142,7 @@ static void optee_release_helper(struct tee_context *ctx,
> >         list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
> >                                  list_node) {
> >                 list_del(&sess->list_node);
> > -               close_session(ctx, sess->session_id);
> > +               close_session(ctx, sess->session_id, sess->use_sys_thread);
> >                 kfree(sess);
> >         }
> >         kfree(ctxdata);
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 0828240f27e6..52cec9d06041 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -612,7 +612,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
> >   */
> >
> >  static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> > -                                     struct tee_shm *shm, u_int offs)
> > +                                     struct tee_shm *shm, u_int offs,
> > +                                     bool system_thread)
> >  {
> >         struct ffa_send_direct_data data = {
> >                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 72685ee0d53f..3da7960ab34a 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -154,7 +154,8 @@ struct optee;
> >   */
> >  struct optee_ops {
> >         int (*do_call_with_arg)(struct tee_context *ctx,
> > -                               struct tee_shm *shm_arg, u_int offs);
> > +                               struct tee_shm *shm_arg, u_int offs,
> > +                               bool system_thread);
> >         int (*to_msg_param)(struct optee *optee,
> >                             struct optee_msg_param *msg_params,
> >                             size_t num_params, const struct tee_param *params);
> > @@ -204,6 +205,7 @@ struct optee {
> >  struct optee_session {
> >         struct list_head list_node;
> >         u32 session_id;
> > +       bool use_sys_thread;
> >  };
> >
> >  struct optee_context_data {
> > @@ -252,7 +254,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
> >  int optee_open_session(struct tee_context *ctx,
> >                        struct tee_ioctl_open_session_arg *arg,
> >                        struct tee_param *param);
> > -int optee_close_session_helper(struct tee_context *ctx, u32 session);
> > +int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > +                              bool system_thread);
> >  int optee_close_session(struct tee_context *ctx, u32 session);
> >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >                       struct tee_param *param);
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 49702cb08f4f..56ebbb96ac97 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -507,7 +507,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >         msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
> >           (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> >
> > -       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
> > +       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
> >             msg_arg->ret != TEEC_SUCCESS)
> >                 rc = -EINVAL;
> >
> > @@ -550,7 +550,7 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> >         msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> >         msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
> >
> > -       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
> > +       if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
> >             msg_arg->ret != TEEC_SUCCESS)
> >                 rc = -EINVAL;
> >  out:
> > @@ -885,7 +885,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
> >   * Returns return code from secure world, 0 is OK
> >   */
> >  static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> > -                                     struct tee_shm *shm, u_int offs)
> > +                                     struct tee_shm *shm, u_int offs,
> > +                                     bool system_thread)
> >  {
> >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_call_waiter w;
> > @@ -977,7 +978,7 @@ static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
> >                 return PTR_ERR(msg_arg);
> >
> >         msg_arg->cmd = cmd;
> > -       optee_smc_do_call_with_arg(ctx, shm, offs);
> > +       optee_smc_do_call_with_arg(ctx, shm, offs, false);
> >
> >         optee_free_msg_arg(ctx, entry, offs);
> >         return 0;
> > --
> > 2.25.1
> >
