Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F8702784
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbjEOIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjEOIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:48:10 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067AE75
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:48:06 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-452f317e304so2904330e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684140485; x=1686732485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1IBAn714ocZSNONKKCgtmlbf3ZTeCcDIYb+iNULuMvA=;
        b=NnhqoxfgqOuyxsLeWYsvVwYVWaqmx9+Uk271TUX/ZBTUJuoAPWFnST2GmpSj/GrW/5
         dJRaXkrTkFQS/xfFBSKZRhWYdMTmVwn2OGZrOHkkPd0QF/Tl4sb93/SVQsQRc6WJC1Gl
         JhLQ3zqqAQ8Tz88GxdrNdMEX5VS4kBjgawH4z0caSMVMXiLBFheGfFqkWJ+vTbrn63Ti
         xv4oaRYfK8eb5+/ZkgWZ8R4TOvMONgk3FRBiqM7Ptkv3T83rTQjsO8loKXfNuiVAA71o
         a49D7KFseST/so+MPAn1Z3Wxuz30Tkj8WjRiHrcjLNWs+I8F5qU3XQpmX3aFR5HzYPTh
         I6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684140485; x=1686732485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IBAn714ocZSNONKKCgtmlbf3ZTeCcDIYb+iNULuMvA=;
        b=LQz9mLPXblyebIN4V3MdVEV0pPA2o4OCNhclu8WQUdflT/m6CjcbKelsa+4Pi55+s6
         k1I013pGcnaFGtsZA2V7LjRFJf+Y2a9XiDDzjwVag5cGUXINiL13s2fGGbCqlWYMh0D/
         o15MuBaeKahdz7IQBGO8Od+gFD0aDStnv4n2XtLL8cpTTldDPu3ICz2C74rnjmK/SofK
         cmouizhcAECOV0AOhZd1iDCpDZ727LenZbvc0F0emit0fMkvdJce4bgxexkW55XsfHh6
         p5mVwhie6cmi0bNUD8PBzr+FLyWfsZxIv3kDA0hINoQUK9DsC5HR+JcO6N34PLP+ZNsd
         VNPw==
X-Gm-Message-State: AC+VfDzJz1SediwVAAHa6RVSnqT0Mqe8wgOn1NQU2VJ8/aK/X9Tj76m6
        Wgy9qz6POhaSLlXXVw4+xiPhh34Bd46gi70AptJvJl2hy5xhm4I7OV0=
X-Google-Smtp-Source: ACHHUZ4opmmzxfaUfDCzedB4T7j/BDtCPaf1Q097BlSZ4eQtuqbRZwk6xAXkzpnk9X4bYQmVST6t5aEcKGuqvA1sEck=
X-Received: by 2002:a1f:d405:0:b0:44f:b9a8:be0c with SMTP id
 l5-20020a1fd405000000b0044fb9a8be0cmr11715084vkg.1.1684140485408; Mon, 15 May
 2023 01:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <20230505173012.881083-3-etienne.carriere@linaro.org> <CAFA6WYN4yjjedmsS4nAgR5L7OOTRAcKs7STW0YjCC7XsdfYzkA@mail.gmail.com>
 <CAN5uoS8eSfeu-BaV5dhbB15q_iGjcd9BKDpp_hEBaBdb4_qbAg@mail.gmail.com>
 <CAN5uoS99hfjE404_UCm+F4bdVgSfB6Eg_3d1JvHCc2GgSzdUog@mail.gmail.com>
 <CAFA6WYPUWjK97H5DL-eOT2bjsa79Zrvk4wet2AW0Qb0NOVqt7Q@mail.gmail.com>
 <CAN5uoS8HF5ymsjkLthFnoQxBHQ3TOVonycTH3g5K76qKzUniuA@mail.gmail.com>
 <CAFA6WYMBoUom6yr-BGzfJKLsuQLPEkkcS021mf-KjCfkt-ejJw@mail.gmail.com> <CAN5uoS8mj35qXdhHaHVsiuEJ4PtZWCRn=OmNUDrQM=JjFc7P0w@mail.gmail.com>
In-Reply-To: <CAN5uoS8mj35qXdhHaHVsiuEJ4PtZWCRn=OmNUDrQM=JjFc7P0w@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 15 May 2023 14:17:54 +0530
Message-ID: <CAFA6WYMTtxt4XCbHuoj9gJyxLeAK=a98C5e2JtPHvTtB527MEw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tee: optee: support tracking system threads
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

On Fri, 12 May 2023 at 10:27, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> On Thu, 11 May 2023 at 13:31, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 11 May 2023 at 13:49, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > >
> > > On Thu, 11 May 2023 at 09:27, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > (snip)
> > > > > > > >
> > > > > > > > +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> > > > > > > > +{
> > > > > > > > +       bool rc = false;
> > > > > > > > +
> > > > > > > > +       mutex_lock(&cq->mutex);
> > > > > > > > +
> > > > > > > > +       /* Leave at least 1 normal (non-system) thread */
> > > > > > >
> > > > > > > IMO, this might be counter productive. As most kernel drivers open a
> > > > > > > session during driver probe which are only released in the driver
> > > > > > > release method.
> > > > > >
> > > > > > It is always the case?
> > > > >
> > > > > This answer of mine is irrelevant. Sorry,
> > > > > Please read only the below comments of mine, especially:
> > > > > | Note that an OP-TEE thread is not bound to a TEE session but rather
> > > > > | bound to a yielded call to OP-TEE.
> > > > >
> > > > > >
> > > > > > > If the kernel driver is built-in then the session is
> > > > > > > never released. Now with system threads we would reserve an OP-TEE
> > > > > > > thread for that kernel driver as well which will never be available to
> > > > > > > regular user-space clients.
> > > > > >
> > > > > > That is not true. No driver currently requests their TEE thread to be
> > > > > > a system thread.
> > > > > > Only SCMI does because it needs to by construction.
> > > > > >
> > > >
> > > > Yes that's true but what prevents future/current kernel TEE drivers
> > > > from requesting a system thread once we have this patch-set landed.
> > >
> > > Only clients really needing this system_thread attribute should request it.
> > > If they really need, the OP-TEE firmware in secure world should
> > > provision sufficient thread context.
> >
> > How do we quantify it? We definitely need a policy here regarding
> > normal vs system threads.
> >
> > One argument in favor of kernel clients requiring system threads could
> > be that we don't want to compete with user-space for OP-TEE threads.
>
> Sorry I don't understand. What do you mean qualifying this?

I mean we have to fairly allocate threads among system and non-system
thread invocations.

> In an ideal situation, we would have OP-TEE provisioned with largely
> sufficient thread contexts. However there are systems with constraints
> memory resource that do lower at most the number of OP-TEE thread
> contexts.
>

Yeah, I think we are on the same page here.

>
>
> >
> > >
> > > >
> > > > > >
> > > > > > > So I would rather suggest we only allow a
> > > > > > > single system thread to be reserved as a starting point which is
> > > > > > > relevant to this critical SCMI service. We can also make this upper
> > > > > > > bound for system threads configurable with default value as 1 if
> > > > > > > needed.
> > > > >
> > > > > Note that SCMI server can expose several SCMI channels (at most 1 per
> > > > > SCMI protocol used) and each of them will need to request a
> > > > > system_thread to TEE driver.
> > > > >
> > > > > Etienne
> > > > >
> > > > > >
> > > > > > Reserving one or more system threads depends on the number of thread
> > > > > > context provisioned by the TEE.
> > > > > > Note that the implementation proposed here prevents Linux kernel from
> > > > > > exhausting TEE threads so user space always has at least a TEE thread
> > > > > > context left available.
> > > >
> > > > Yeah but on the other hand user-space clients which are comparatively
> > > > larger in number than kernel clients. So they will be starved for
> > > > OP-TEE thread availability. Consider a user-space client which needs
> > > > to serve a lot of TLS connections just waiting for OP-TEE thread
> > > > availability.
> > >
> > > Note that OP-TEE default configuration provisions (number of CPUs + 1)
> > > thread context, so the situation is already present before these
> > > changes on systems that embedded an OP-TEE without a properly tuned
> > > configuration. As I said above, Linux kernel cannot be responsible for
> > > the total number of thread contexts provisioned in OP-TEE. If the
> > > overall system requires a lot of TEE thread contexts, one should embed
> > > a suitable OP-TEE firmware.
> >
> > Wouldn't the SCMI deadlock problem be solved with just having a lot of
> > OP-TEE threads? But we are discussing the system threads solution here
> > to make efficient use of OP-TEE threads. The total number of OP-TEE
> > threads is definitely in control of OP-TEE but the control of how to
> > schedule and efficiently use them lies with the Linux OP-TEE driver.
> >
> > So, given our overall discussion in this thread, how about the upper
> > bound for system threads being 50% of the total number of OP-TEE
> > threads?
>
> What would be a shame if the system does not use any Linux kernel
> client sessions, only userland clients. This information cannot be
> knwon be the linux optee driver.
> Instead of leaving at least 1 TEE thread context for regular session,
> what if this change enforce 2? or 3? Which count?
> I think 1 is a fair choice: it allows to support OP-TEE firmwares with
> a very small thread context pool (when running in small secure
> memory), embedding only 2 or 3 contextes.

IMO, leaving only 1 thread for user-space will starve TLS based
applications. How about the following change on top of this patchset?

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 8b8181099da7..1deb5907d075 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -182,8 +182,8 @@ bool optee_cq_inc_sys_thread_count(struct
optee_call_queue *cq)

        mutex_lock(&cq->mutex);

-       /* Leave at least 1 normal (non-system) thread */
-       if (cq->res_sys_thread_count + 1 < cq->total_thread_count) {
+       /* Leave at least 50% for normal (non-system) threads */
+       if (cq->res_sys_thread_count < cq->total_thread_count/2) {
                cq->free_normal_thread_count--;
                cq->res_sys_thread_count++;
                rc = true;

>
> >
> > >
> > > >
> > > > > >
> > > > > > Note that an OP-TEE thread is not bound to a TEE session but rather
> > > > > > bound to a yielded call to OP-TEE.
> > > >
> > > > tee_client_open_session()
> > > >   -> optee_open_session()
> > > >
> > > > tee_client_system_session()
> > > >   -> optee_system_session()
> > > >     -> optee_cq_inc_sys_thread_count()       <- At this point you
> > > > reserve a system thread corresponding to a particular kernel client
> > > > session
> > > >
> > > > All tee_client_invoke_func() invocations with a system thread capable
> > > > session will use that reserved thread.
> > > >
> > > > tee_client_close_session()
> > > >   -> optee_close_session()
> > > >     -> optee_close_session_helper()
> > > >       -> optee_cq_dec_sys_thread_count()    <- At this point the
> > > > reserved system thread is released
> > > >
> > > > Haven't this tied the system thread to a particular TEE session? Or am
> > > > I missing something?
> > >
> > > These changes do not define an overall single system thread.
> > > If several sessions requests reservation of TEE system thread, has
> > > many will be reserved.
> > > Only the very sessions with its sys_thread attribute set will use a
> > > reserved thread. If such a kernel client issues several concurrent
> > > calls to OP-TEE over that session, it will indeed consume more
> > > reserved system threads than what is actually reserved. Here I think
> > > it is the responsibility of such client to open as many sessions as
> > > requests. This is what scmi/optee driver does (see patch v6 4/4). An
> > > alternative would be to have a ref count of sys_thread in session
> > > contexts rather than a boolean value. I don't think it's worth it.
> >
> > Ah, I missed that during the review. The invocations with system
> > threads should be limited by res_sys_thread_count in a similar manner
> > as we do with normal threads via free_normal_thread_count. Otherwise,
> > it's unfair for normal thread scheduling.
> >
> > I suppose there isn't any interdependency among SCMI channels itself
> > such that a particular SCMI invocation can wait until the other SCMI
> > invocation has completed.
>
> I think that would over complexify the logic.
>

We shouldn't allow system thread invocations to be greater than what
is actually reserved count for system threads. One thing I am not able
to understand here is why do you need a lot of system threads? Are
SCMI operations too expensive? I suppose those should just involve
configuring some register bits and using a single OP-TEE thread which
is invoked sequentially should be enough.

-Sumit

> Note I will send a patch v8 series but feel free to continue the discussion.
> It will at least address other comments you shared.
>
> Best regards,
> Etienne
>
> >
> > -Sumit
