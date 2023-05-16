Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398D77046DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjEPHtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjEPHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:49:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419201FCC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:49:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965e93f915aso2466108066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684223371; x=1686815371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9MeMI4M1yE9VAFv/Uu8XvJq52cKiBIHNdS2LuQU034=;
        b=fmlndFJZ6zTztaSTW4ikX1ZZ9GU3mr5IGv/2yPL3g/n6hrtyll5hNRVWPSzh/bu0vk
         yMsGAHo6ufA9OJ1Dh8HaTAmbnneMgfwcLP4aRVYJwiB6sX5ih6SY5hC4edTxaO6fk+fR
         GIadiZ3ZTK5788BfR8lItXzSWWsCPIwSiHTDfipPCJWtnfon/08tuqG+WKDvo2VUTrts
         hAF0NnTTt5lwUoGilwb7dF7zUcWTz1d0LZ5/Ph7XYpMTxA34v73WxstrA9GoW3po9L1z
         efW89cF9lHjSTPk4otG9fbgVeuD6eVWlZscV+HLFYUFybMw762TULIzoxmDOC2MoWPkE
         ivcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223371; x=1686815371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9MeMI4M1yE9VAFv/Uu8XvJq52cKiBIHNdS2LuQU034=;
        b=Puqimybh1cUTgIBwrt06Mcsa/8Yf3z9nQ2nHVV86wjvkN1nW4mDP5kUQLR4mkyIAli
         e65v32pT56MwdISdRtazIpO26EtfJWp4keIBpowrS1Ojt3kTID+jzFXFXuQy9s0WIu98
         4EhqivI6vyHsQqZ9H8/CBVWuqN0vjJxpmPL/OkDEWJ0ZuDtitCH5kXCeTzApWbQ/MKbG
         xEWDRw/SxSzUWecGtEx36rrTRstzCLzOJ4lPVBYFjN95H30XpR/9O6rieVhpt6kTCY8Q
         ku6Xe5qtXQ6lKDviZrPJ6E6f7yZ6VrKpvVHtSjFE1Esqm9lDDtLqt+QznfsbnEaxrA4M
         EhNg==
X-Gm-Message-State: AC+VfDzZvRCq3yGbViN1PSnbIHHQ1XXv5qROATeErUwEy9GthNV2z33K
        qVdAwHizCnhchKz3iDFOavVi9DqCTUlsjrDEG/ng/A==
X-Google-Smtp-Source: ACHHUZ6flr188Ins4PCZV6HJTpyrl9abssnnk9/twTOF86oVhK4ennGAhXLLE96bivWkD5Wae7O9kekCFWoXuPz6dQg=
X-Received: by 2002:a17:906:7949:b0:96a:d916:cb31 with SMTP id
 l9-20020a170906794900b0096ad916cb31mr9762444ejo.29.1684223370604; Tue, 16 May
 2023 00:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <20230505173012.881083-3-etienne.carriere@linaro.org> <CAFA6WYN4yjjedmsS4nAgR5L7OOTRAcKs7STW0YjCC7XsdfYzkA@mail.gmail.com>
 <CAN5uoS8eSfeu-BaV5dhbB15q_iGjcd9BKDpp_hEBaBdb4_qbAg@mail.gmail.com>
 <CAN5uoS99hfjE404_UCm+F4bdVgSfB6Eg_3d1JvHCc2GgSzdUog@mail.gmail.com>
 <CAFA6WYPUWjK97H5DL-eOT2bjsa79Zrvk4wet2AW0Qb0NOVqt7Q@mail.gmail.com>
 <CAN5uoS8HF5ymsjkLthFnoQxBHQ3TOVonycTH3g5K76qKzUniuA@mail.gmail.com>
 <CAFA6WYMBoUom6yr-BGzfJKLsuQLPEkkcS021mf-KjCfkt-ejJw@mail.gmail.com>
 <CAN5uoS8mj35qXdhHaHVsiuEJ4PtZWCRn=OmNUDrQM=JjFc7P0w@mail.gmail.com>
 <CAFA6WYMTtxt4XCbHuoj9gJyxLeAK=a98C5e2JtPHvTtB527MEw@mail.gmail.com>
 <CAN5uoS8jacBOfBxSWkPrc7+MjoG3zJPjXCOiJwhGM4gBQUypow@mail.gmail.com> <CAFA6WYOTCNAfr6QYmR_F3qOzxB4qJKQQSBu9qEdv=Dfzn1oH3Q@mail.gmail.com>
In-Reply-To: <CAFA6WYOTCNAfr6QYmR_F3qOzxB4qJKQQSBu9qEdv=Dfzn1oH3Q@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 16 May 2023 09:49:19 +0200
Message-ID: <CAN5uoS_B+-641ALRdyVPpxXrGw29a_Hn1vtSZr0NRsHtacwk2A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tee: optee: support tracking system threads
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

> > > > > >
> > > > > > These changes do not define an overall single system thread.
> > > > > > If several sessions requests reservation of TEE system thread, has
> > > > > > many will be reserved.
> > > > > > Only the very sessions with its sys_thread attribute set will use a
> > > > > > reserved thread. If such a kernel client issues several concurrent
> > > > > > calls to OP-TEE over that session, it will indeed consume more
> > > > > > reserved system threads than what is actually reserved. Here I think
> > > > > > it is the responsibility of such client to open as many sessions as
> > > > > > requests. This is what scmi/optee driver does (see patch v6 4/4). An
> > > > > > alternative would be to have a ref count of sys_thread in session
> > > > > > contexts rather than a boolean value. I don't think it's worth it.
> > > > >
> > > > > Ah, I missed that during the review. The invocations with system
> > > > > threads should be limited by res_sys_thread_count in a similar manner
> > > > > as we do with normal threads via free_normal_thread_count. Otherwise,
> > > > > it's unfair for normal thread scheduling.
> > > > >
> > > > > I suppose there isn't any interdependency among SCMI channels itself
> > > > > such that a particular SCMI invocation can wait until the other SCMI
> > > > > invocation has completed.
> > > >
> > > > I think that would over complexify the logic.
> > > >
> > >
> > > We shouldn't allow system thread invocations to be greater than what
> > > is actually reserved count for system threads. One thing I am not able
> > > to understand here is why do you need a lot of system threads? Are
> > > SCMI operations too expensive? I suppose those should just involve
> > > configuring some register bits and using a single OP-TEE thread which
> > > is invoked sequentially should be enough.
> >
> > Ok, I get your point.
> > I think you're right, reserving at most 1 TEE thread for system
> > sessions should be enough to prevent TEE entry calls deadlocks which
> > is the purpose of these changee.
> >
> > Would you be ok if the following logic: optee driver would reserve at
> > most 1 TEE call entry for system sessions.
> > If at least 1 kernel client claims a system session, a TEE call entry
> > is reserved to that purpose.
> > Once all system sessions are closed, the TEE reserved system call
> > entry is released.
> > When a system thread calls the TEE, if the TEE system thread context
> > is not already in use, then that client consumes the reserved entry.
> > If the system thread context is already in use, then that client call
> > is treated as a regular call: it calls the TEE and would return
> > waiting for a free thread if no TEE thread context is available.
>
> Yeah this sounds reasonable to me.
>

Ok, i'll address that in patch v8.

Thanks.
Etienne

> -Sumit
>
> >
> > Etienne
> >
> >
> > >
> > > -Sumit
> > >
> > > > Note I will send a patch v8 series but feel free to continue the discussion.
> > > > It will at least address other comments you shared.
> > > >
> > > > Best regards,
> > > > Etienne
> > > >
> > > > >
> > > > > -Sumit

On Tue, 16 May 2023 at 08:32, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 16 May 2023 at 11:28, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Hello Sumit,
> >
> > On Mon, 15 May 2023 at 10:48, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On Fri, 12 May 2023 at 10:27, Etienne Carriere
> > > <etienne.carriere@linaro.org> wrote:
> > > >
> > > > On Thu, 11 May 2023 at 13:31, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > On Thu, 11 May 2023 at 13:49, Etienne Carriere
> > > > > <etienne.carriere@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, 11 May 2023 at 09:27, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > > > (snip)
> > > > > > > > > > >
> > > > > > > > > > > +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> > > > > > > > > > > +{
> > > > > > > > > > > +       bool rc = false;
> > > > > > > > > > > +
> > > > > > > > > > > +       mutex_lock(&cq->mutex);
> > > > > > > > > > > +
> > > > > > > > > > > +       /* Leave at least 1 normal (non-system) thread */
> > > > > > > > > >
> > > > > > > > > > IMO, this might be counter productive. As most kernel drivers open a
> > > > > > > > > > session during driver probe which are only released in the driver
> > > > > > > > > > release method.
> > > > > > > > >
> > > > > > > > > It is always the case?
> > > > > > > >
> > > > > > > > This answer of mine is irrelevant. Sorry,
> > > > > > > > Please read only the below comments of mine, especially:
> > > > > > > > | Note that an OP-TEE thread is not bound to a TEE session but rather
> > > > > > > > | bound to a yielded call to OP-TEE.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > If the kernel driver is built-in then the session is
> > > > > > > > > > never released. Now with system threads we would reserve an OP-TEE
> > > > > > > > > > thread for that kernel driver as well which will never be available to
> > > > > > > > > > regular user-space clients.
> > > > > > > > >
> > > > > > > > > That is not true. No driver currently requests their TEE thread to be
> > > > > > > > > a system thread.
> > > > > > > > > Only SCMI does because it needs to by construction.
> > > > > > > > >
> > > > > > >
> > > > > > > Yes that's true but what prevents future/current kernel TEE drivers
> > > > > > > from requesting a system thread once we have this patch-set landed.
> > > > > >
> > > > > > Only clients really needing this system_thread attribute should request it.
> > > > > > If they really need, the OP-TEE firmware in secure world should
> > > > > > provision sufficient thread context.
> > > > >
> > > > > How do we quantify it? We definitely need a policy here regarding
> > > > > normal vs system threads.
> > > > >
> > > > > One argument in favor of kernel clients requiring system threads could
> > > > > be that we don't want to compete with user-space for OP-TEE threads.
> > > >
> > > > Sorry I don't understand. What do you mean qualifying this?
> > >
> > > I mean we have to fairly allocate threads among system and non-system
> > > thread invocations.
> > >
> > > > In an ideal situation, we would have OP-TEE provisioned with largely
> > > > sufficient thread contexts. However there are systems with constraints
> > > > memory resource that do lower at most the number of OP-TEE thread
> > > > contexts.
> > > >
> > >
> > > Yeah, I think we are on the same page here.
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > So I would rather suggest we only allow a
> > > > > > > > > > single system thread to be reserved as a starting point which is
> > > > > > > > > > relevant to this critical SCMI service. We can also make this upper
> > > > > > > > > > bound for system threads configurable with default value as 1 if
> > > > > > > > > > needed.
> > > > > > > >
> > > > > > > > Note that SCMI server can expose several SCMI channels (at most 1 per
> > > > > > > > SCMI protocol used) and each of them will need to request a
> > > > > > > > system_thread to TEE driver.
> > > > > > > >
> > > > > > > > Etienne
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Reserving one or more system threads depends on the number of thread
> > > > > > > > > context provisioned by the TEE.
> > > > > > > > > Note that the implementation proposed here prevents Linux kernel from
> > > > > > > > > exhausting TEE threads so user space always has at least a TEE thread
> > > > > > > > > context left available.
> > > > > > >
> > > > > > > Yeah but on the other hand user-space clients which are comparatively
> > > > > > > larger in number than kernel clients. So they will be starved for
> > > > > > > OP-TEE thread availability. Consider a user-space client which needs
> > > > > > > to serve a lot of TLS connections just waiting for OP-TEE thread
> > > > > > > availability.
> > > > > >
> > > > > > Note that OP-TEE default configuration provisions (number of CPUs + 1)
> > > > > > thread context, so the situation is already present before these
> > > > > > changes on systems that embedded an OP-TEE without a properly tuned
> > > > > > configuration. As I said above, Linux kernel cannot be responsible for
> > > > > > the total number of thread contexts provisioned in OP-TEE. If the
> > > > > > overall system requires a lot of TEE thread contexts, one should embed
> > > > > > a suitable OP-TEE firmware.
> > > > >
> > > > > Wouldn't the SCMI deadlock problem be solved with just having a lot of
> > > > > OP-TEE threads? But we are discussing the system threads solution here
> > > > > to make efficient use of OP-TEE threads. The total number of OP-TEE
> > > > > threads is definitely in control of OP-TEE but the control of how to
> > > > > schedule and efficiently use them lies with the Linux OP-TEE driver.
> > > > >
> > > > > So, given our overall discussion in this thread, how about the upper
> > > > > bound for system threads being 50% of the total number of OP-TEE
> > > > > threads?
> > > >
> > > > What would be a shame if the system does not use any Linux kernel
> > > > client sessions, only userland clients. This information cannot be
> > > > knwon be the linux optee driver.
> > > > Instead of leaving at least 1 TEE thread context for regular session,
> > > > what if this change enforce 2? or 3? Which count?
> > > > I think 1 is a fair choice: it allows to support OP-TEE firmwares with
> > > > a very small thread context pool (when running in small secure
> > > > memory), embedding only 2 or 3 contextes.
> > >
> > > IMO, leaving only 1 thread for user-space will starve TLS based
> > > applications. How about the following change on top of this patchset?
> > >
> > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > index 8b8181099da7..1deb5907d075 100644
> > > --- a/drivers/tee/optee/call.c
> > > +++ b/drivers/tee/optee/call.c
> > > @@ -182,8 +182,8 @@ bool optee_cq_inc_sys_thread_count(struct
> > > optee_call_queue *cq)
> > >
> > >         mutex_lock(&cq->mutex);
> > >
> > > -       /* Leave at least 1 normal (non-system) thread */
> > > -       if (cq->res_sys_thread_count + 1 < cq->total_thread_count) {
> > > +       /* Leave at least 50% for normal (non-system) threads */
> > > +       if (cq->res_sys_thread_count < cq->total_thread_count/2) {
> > >                 cq->free_normal_thread_count--;
> > >                 cq->res_sys_thread_count++;
> > >                 rc = true;
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > Note that an OP-TEE thread is not bound to a TEE session but rather
> > > > > > > > > bound to a yielded call to OP-TEE.
> > > > > > >
> > > > > > > tee_client_open_session()
> > > > > > >   -> optee_open_session()
> > > > > > >
> > > > > > > tee_client_system_session()
> > > > > > >   -> optee_system_session()
> > > > > > >     -> optee_cq_inc_sys_thread_count()       <- At this point you
> > > > > > > reserve a system thread corresponding to a particular kernel client
> > > > > > > session
> > > > > > >
> > > > > > > All tee_client_invoke_func() invocations with a system thread capable
> > > > > > > session will use that reserved thread.
> > > > > > >
> > > > > > > tee_client_close_session()
> > > > > > >   -> optee_close_session()
> > > > > > >     -> optee_close_session_helper()
> > > > > > >       -> optee_cq_dec_sys_thread_count()    <- At this point the
> > > > > > > reserved system thread is released
> > > > > > >
> > > > > > > Haven't this tied the system thread to a particular TEE session? Or am
> > > > > > > I missing something?
> > > > > >
> > > > > > These changes do not define an overall single system thread.
> > > > > > If several sessions requests reservation of TEE system thread, has
> > > > > > many will be reserved.
> > > > > > Only the very sessions with its sys_thread attribute set will use a
> > > > > > reserved thread. If such a kernel client issues several concurrent
> > > > > > calls to OP-TEE over that session, it will indeed consume more
> > > > > > reserved system threads than what is actually reserved. Here I think
> > > > > > it is the responsibility of such client to open as many sessions as
> > > > > > requests. This is what scmi/optee driver does (see patch v6 4/4). An
> > > > > > alternative would be to have a ref count of sys_thread in session
> > > > > > contexts rather than a boolean value. I don't think it's worth it.
> > > > >
> > > > > Ah, I missed that during the review. The invocations with system
> > > > > threads should be limited by res_sys_thread_count in a similar manner
> > > > > as we do with normal threads via free_normal_thread_count. Otherwise,
> > > > > it's unfair for normal thread scheduling.
> > > > >
> > > > > I suppose there isn't any interdependency among SCMI channels itself
> > > > > such that a particular SCMI invocation can wait until the other SCMI
> > > > > invocation has completed.
> > > >
> > > > I think that would over complexify the logic.
> > > >
> > >
> > > We shouldn't allow system thread invocations to be greater than what
> > > is actually reserved count for system threads. One thing I am not able
> > > to understand here is why do you need a lot of system threads? Are
> > > SCMI operations too expensive? I suppose those should just involve
> > > configuring some register bits and using a single OP-TEE thread which
> > > is invoked sequentially should be enough.
> >
> > Ok, I get your point.
> > I think you're right, reserving at most 1 TEE thread for system
> > sessions should be enough to prevent TEE entry calls deadlocks which
> > is the purpose of these changee.
> >
> > Would you be ok if the following logic: optee driver would reserve at
> > most 1 TEE call entry for system sessions.
> > If at least 1 kernel client claims a system session, a TEE call entry
> > is reserved to that purpose.
> > Once all system sessions are closed, the TEE reserved system call
> > entry is released.
> > When a system thread calls the TEE, if the TEE system thread context
> > is not already in use, then that client consumes the reserved entry.
> > If the system thread context is already in use, then that client call
> > is treated as a regular call: it calls the TEE and would return
> > waiting for a free thread if no TEE thread context is available.
>
> Yeah this sounds reasonable to me.
>
> -Sumit
>
> >
> > Etienne
> >
> >
> > >
> > > -Sumit
> > >
> > > > Note I will send a patch v8 series but feel free to continue the discussion.
> > > > It will at least address other comments you shared.
> > > >
> > > > Best regards,
> > > > Etienne
> > > >
> > > > >
> > > > > -Sumit
