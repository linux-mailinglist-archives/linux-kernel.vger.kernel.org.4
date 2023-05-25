Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44F710F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbjEYPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjEYPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:20:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE7A3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:20:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so5601535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685028036; x=1687620036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlaG3iTWzV5VDwhkTm0563kUTJ+9Koh8FjM3M0elxt8=;
        b=WfUtDV3lHR1ThDFbsCAVPsVRYMVt/tF2CJkV2fc54A7IFbtulA/nD0V5lc7xzZ8Ztq
         Rh89ZHsKe9nN6IsWvAHVQyApXCOYv+fBa/CjEaBOi4xSwuusplxAy8tY/JROPvxWHi+O
         70w/gerLSnBXwIQFTF68aeGaxMrayFBArpw/n5y1I14vujbohDOttjGcVBZhkh7YKlzd
         tqkCVMxeLfx+vX+gOIDeW2M5Do32K1F5wVyO6pFIFY6lOGoB1lZZKMOvqY8PK8h7fSvy
         LD2bvI4XS+EEqJk70eAKmHvrkSh3Ez+DeD4sB7iP36TGMN0DnI7dYDR5FEVwfc2DwQub
         0U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685028036; x=1687620036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlaG3iTWzV5VDwhkTm0563kUTJ+9Koh8FjM3M0elxt8=;
        b=jBoE7O84GVjO4Km1fUzaTwRu2Xy2/51kGZL6x3N5nvutyFNvCwxi3EdzLjy/tzlkA0
         Ks/IrN3EcCr9zriQDPqUfLPsmNrU7kP3AWNH7lTqSpkMT6alO7KwhwMMzIPIEw9m49cR
         PDUpq969Uq8P/3HpKVFWXgtWjdmfKm6ABCLNWVpiUzz5fN81WEV8dJurpt0Ju3nJhkEo
         eJ7Sq8TX1Cse8ZbRmdLjUHKL7ayMeyeqDOwvBffn1cPY50K0NLq9HIyMfqqTE/JB+GsU
         4elCmy6oJfMUHTcDiDcCHUCWFVEHe8H2SxiKZe1ArHH3DNj3cG0xG6+mBZ70j10syZgV
         qGCQ==
X-Gm-Message-State: AC+VfDw/fL4S8WMjcIXh2i8RNi4vRe7xz2K9A/xV9j7u06DYnyUojdln
        woMhwm24smw5GMSS8NwpqaqSN5ZPqV0lRp5GJUWaUQ==
X-Google-Smtp-Source: ACHHUZ55RPA8V5gQnas3imjApG0ofzwRXm0QToemwl1iXJTjtlgiu/fSz1MNwJkSuVmHuO1NVfX4zlRm7TdxizVW6Ok=
X-Received: by 2002:a7b:c4da:0:b0:3f6:c8c:7048 with SMTP id
 g26-20020a7bc4da000000b003f60c8c7048mr2833650wmk.20.1685028035893; Thu, 25
 May 2023 08:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com> <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 25 May 2023 17:20:24 +0200
Message-ID: <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Etienne CARRIERE <etienne.carriere@st.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
<etienne.carriere@st.com> wrote:
>
> >
> > De : Sumit Garg <sumit.garg@linaro.org>
> > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > > Hello Sumit,
> > >
> > >
> > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > > >
> > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > >
> > > > Adds support in the OP-TEE driver to keep track of reserved system
> > > > threads. The optee_cq_*() functions are updated to handle this if
> > > > enabled. The SMC ABI part of the driver enables this tracking, but =
the
> > > > FF-A ABI part does not.
> > > >
> > > > The logic allows atleast 1 OP-TEE thread can be reserved to TEE sys=
tem
> > > > sessions. For sake of simplicity, initialization of call queue
> > > > management is factorized into new helper function optee_cq_init().
> > > >
> > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Disclaimer: Compile tested only
> > > >
> > > > Hi Etienne,
> > > >
> > > > Overall the idea we agreed upon was okay but the implementation loo=
ked
> > > > complex to me. So I thought it would be harder to explain that via
> > > > review and I decided myself to give a try at simplification. I woul=
d
> > > > like you to test it if this still addresses the SCMI deadlock probl=
em or
> > > > not. Also, feel free to include this in your patchset if all goes f=
ine
> > > > wrt testing.
> > >
> > > With these changes, there is no more a specific waiting list for TEE
> > > system threads hence when a waiting queue can complete, we'll pick an=
y
> > > TEE thread, not a TEE system thread first..
> >
> > I had thought about this but I can't see any value in having a
> > separate wait queue for system threads. Here we only need to provide
> > an extra privileged thread for system sessions (kernel clients) such
> > that user-space doesn't contend for that thread. This prevents kernel
> > client's starvation or deadlock like in the SCMI case.
> >
> > > Also, as stated in a below answer, these change unconditionally
> > > reserve a TEE thread for TEE system calls even if no TEE client
> > > reserved such.
> >
> > I don't think we should make thread reservations based on the presence
> > of TEE clients. You never know how much user-space or kernel TEE
> > clients you are dealing with. And reserving a single privileged thread
> > unconditionally for system sessions shouldn't be much of a burden for
> > memory constrained devices too.
> >
> > Also, this way we would enable every kernel TEE client to leverage
> > system sessions as it's very likely they wouldn't like to compete with
> > user-space for thread availability. Two other kernel TEE clients that
> > are on top of my head are HWRNG and Trusted Keys which can benefit
> > from this feature.
>
> Trusted Keys is an interesting use case. When OP-TEE accesses Trusted Key=
s, it may need to access the eMMC/RPMB using the Linux OS tee-supplicant wh=
ichj may repuire an eMMC clock or voltage regulator to be enabled. If that =
clock or regulator is under an SCMI control, then we need 2 reserved TEE th=
read: one for invoking the Trusted Key TA and another for the SCMI request =
to reach the TEE will the Trusted Key TA invocation still consumes a thread=
.

Why would the Trusted Keys session need a system thread? To me, it
seems that the session could use the normal client priority.

Thanks,
Jens

>
> BR,
> Etienne
>
> >
> > > >
> > > > Changes since v8:
> > > > - Simplified system threads tracking implementation.
> > > >
> > > >  drivers/tee/optee/call.c          | 72 +++++++++++++++++++++++++++=
++--
> > > >  drivers/tee/optee/ffa_abi.c       |  3 +-
> > > >  drivers/tee/optee/optee_private.h | 16 +++++++
> > > >  drivers/tee/optee/smc_abi.c       | 16 ++++++-
> > > >  4 files changed, 99 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > > index 42e478ac6ce1..09e824e4dcaf 100644
> > > > --- a/drivers/tee/optee/call.c
> > > > +++ b/drivers/tee/optee/call.c
> > > > @@ -39,9 +39,27 @@ struct optee_shm_arg_entry {
> > > >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> > > >  };
> > > >
> > > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > > > +{
> > > > +       mutex_init(&cq->mutex);
> > > > +       INIT_LIST_HEAD(&cq->waiters);
> > > > +       /*
> > > > +        * If cq->total_thread_count is 0 then we're not trying to =
keep
> > > > +        * track of how many free threads we have, instead we're re=
lying on
> > > > +        * the secure world to tell us when we're out of thread and=
 have to
> > > > +        * wait for another thread to become available.
> > > > +        */
> > > > +       cq->total_thread_count =3D thread_count;
> > > > +       cq->free_thread_count =3D thread_count;
> > > > +}
> > > > +
> > > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > > >                         struct optee_call_waiter *w, bool sys_threa=
d)
> > > >  {
> > > > +       bool need_wait =3D false;
> > > > +
> > > > +       memset(w, 0, sizeof(*w));
> > > > +
> > > >         /*
> > > >          * We're preparing to make a call to secure world. In case =
we can't
> > > >          * allocate a thread in secure world we'll end up waiting i=
n
> > > > @@ -53,15 +71,43 @@ void optee_cq_wait_init(struct optee_call_queue=
 *cq,
> > > >         mutex_lock(&cq->mutex);
> > > >
> > > >         /*
> > > > -        * We add ourselves to the queue, but we don't wait. This
> > > > -        * guarantees that we don't lose a completion if secure wor=
ld
> > > > -        * returns busy and another thread just exited and try to c=
omplete
> > > > -        * someone.
> > > > +        * We add ourselves to a queue, but we don't wait. This gua=
rantees
> > > > +        * that we don't lose a completion if secure world returns =
busy and
> > > > +        * another thread just exited and try to complete someone.
> > > >          */
> > > >         init_completion(&w->c);
> > > >         list_add_tail(&w->list_node, &cq->waiters);
> > > >
> > > > +       if (cq->total_thread_count && sys_thread) {
> > > > +               if (cq->free_thread_count > 0)
> > > > +                       cq->free_thread_count--;
> > > > +               else
> > > > +                       need_wait =3D true;
> > > > +       } else if (cq->total_thread_count) {
> > > > +               if (cq->free_thread_count > 1)
> > >
> > > This unconditionally reserves a TEE thread for TEE system calls, even
> > > if no client has claimed such system thread reservation.
> >
> > See my response above.
> >
> > >
> > >
> > > > +                       cq->free_thread_count--;
> > > > +               else
> > > > +                       need_wait =3D true;
> > > > +       }
> > > > +
> > > >         mutex_unlock(&cq->mutex);
> > > > +
> > > > +       while (need_wait) {
> > > > +               optee_cq_wait_for_completion(cq, w);
> > > > +               mutex_lock(&cq->mutex);
> > > > +               if (sys_thread) {
> > > > +                       if (cq->free_thread_count > 0) {
> > > > +                               cq->free_thread_count--;
> > > > +                               need_wait =3D false;
> > > > +                       }
> > > > +               } else {
> > > > +                       if (cq->free_thread_count > 1) {
> > > > +                               cq->free_thread_count--;
> > > > +                               need_wait =3D false;
> > > > +                       }
> > > > +               }
> > > > +               mutex_unlock(&cq->mutex);
> > > > +       }
> > > >  }
> > > >
> > > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > > @@ -104,6 +150,8 @@ void optee_cq_wait_final(struct optee_call_queu=
e *cq,
> > > >         /* Get out of the list */
> > > >         list_del(&w->list_node);
> > > >
> > > > +       cq->free_thread_count++;
> > > > +
> > > >         /* Wake up one eventual waiting task */
> > > >         optee_cq_complete_one(cq);
> > > >
> > > > @@ -361,6 +409,22 @@ int optee_open_session(struct tee_context *ctx=
,
> > > >         return rc;
> > > >  }
> > > >
> > > > +int optee_system_session(struct tee_context *ctx, u32 session)
> > > > +{
> > > > +       struct optee_context_data *ctxdata =3D ctx->data;
> > > > +       struct optee_session *sess;
> > > > +
> > > > +       mutex_lock(&ctxdata->mutex);
> > > > +
> > > > +       sess =3D find_session(ctxdata, session);
> > > > +       if (sess && !sess->use_sys_thread)
> > > > +               sess->use_sys_thread =3D true;
> > > > +
> > > > +       mutex_unlock(&ctxdata->mutex);
> > > > +
> > > > +       return 0;
> > >
> > > Nitpicking: should rather return 0 only upon session is valid
> > > (sess!=3DNULL here)  and system thread reservation is supported
> > > (total_thread_count > 0).
> > > But that's not a big deal I guess, can be addressed.
> >
> > Thanks for pointing it out. If this approach works for you then it can
> > be addressed while integrating in your patch-set.
> >
> > -Sumit
> >
> > > (snip)
>
> ST Restricted
