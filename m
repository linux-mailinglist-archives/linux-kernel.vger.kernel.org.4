Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7396FF08B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjEKLb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjEKLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:31:55 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C8171C
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:31:53 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-44fd6c24d5aso3059183e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683804712; x=1686396712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yiXiGgppZtsek08EVGdw+fXrDarA5uolv0KQ6tl8vpI=;
        b=fwAIAhfUZepCvaMEX8qq/+bWbMrn7FaOnit4sosvTYJCYi7g3Kg3DAAcN2cz5lF+xT
         gl52UOIGmizv4/vuPBQljtS2IWMccHXBFuwNuWt6rkEaIvAiDS7PyxLAO4pvMPHw7Cee
         XZJoN8MavvUW9/rGBiphmLE4X4vySwCycUA2fbJJ7EHO8eSd5INjGHzt+xfZfpcsa4Q2
         X4Cu543My87Cq8VlMY6XoMPzd+YsSj5zqJpeFRjsz+WtKc+QO72d0xWLHBehI1/bWaxZ
         acwhZ2Dj4Gmi3MArJLvCLH4480zX/MH4Osy9w2NYO7Tj4EZpvNMWcFN4vEmpLixSivLN
         Q7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683804712; x=1686396712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiXiGgppZtsek08EVGdw+fXrDarA5uolv0KQ6tl8vpI=;
        b=c+6JGwzGrDUGpTQghv+k7lTAUZ06642EZz3Zc67YJ+gBJDEvp5fSoOIcNY20PWE39E
         eWhI7eIkAjST9pcRJIzmtnsdsKmVh9BU+V1i6MNq2vaMcdLPqiTtvBjgyKWN5GcXi57Z
         ehRDJDFDt/eP7FK4NWaiyRFi18LQf7s6BoCE/DusdWWFMohJcSx4X7EUKZ3eiHknqwIa
         20Gj/Ccn1aoDRPbrClabtw0FNy/NnDIBJ5gs5XIi2QYMqZvsCkaEfz3SQ46hlt6REKdt
         pIGxZ0Cln8rZjThQfZUINov/toDAbswaQOtTpyDHZc3vyJWD6gBDr1mS8Ovw6xFvvagc
         RqAw==
X-Gm-Message-State: AC+VfDzTTh7fQcUBgW0kkyKSTlUWgv1lp2H6UIyNN0mI1VyTLzNnv0Hb
        GI16VNKHb9oU+58VUbab7ODLJORVjdjFsXpn0afLuXc6t0rvBhgiYns=
X-Google-Smtp-Source: ACHHUZ7ziPT1IfZ6NaTKwqolaqneEg7dpe5lQ6xbNM4u3NjO2lPg3wJvJXKUpSIo+ovGa5dpAZ8yiCEIRUO8n8eyJE4=
X-Received: by 2002:a1f:5081:0:b0:43f:b6d2:39c4 with SMTP id
 e123-20020a1f5081000000b0043fb6d239c4mr5866125vkb.9.1683804712672; Thu, 11
 May 2023 04:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <20230505173012.881083-3-etienne.carriere@linaro.org> <CAFA6WYN4yjjedmsS4nAgR5L7OOTRAcKs7STW0YjCC7XsdfYzkA@mail.gmail.com>
 <CAN5uoS8eSfeu-BaV5dhbB15q_iGjcd9BKDpp_hEBaBdb4_qbAg@mail.gmail.com>
 <CAN5uoS99hfjE404_UCm+F4bdVgSfB6Eg_3d1JvHCc2GgSzdUog@mail.gmail.com>
 <CAFA6WYPUWjK97H5DL-eOT2bjsa79Zrvk4wet2AW0Qb0NOVqt7Q@mail.gmail.com> <CAN5uoS8HF5ymsjkLthFnoQxBHQ3TOVonycTH3g5K76qKzUniuA@mail.gmail.com>
In-Reply-To: <CAN5uoS8HF5ymsjkLthFnoQxBHQ3TOVonycTH3g5K76qKzUniuA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 11 May 2023 17:01:41 +0530
Message-ID: <CAFA6WYMBoUom6yr-BGzfJKLsuQLPEkkcS021mf-KjCfkt-ejJw@mail.gmail.com>
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

On Thu, 11 May 2023 at 13:49, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> On Thu, 11 May 2023 at 09:27, Sumit Garg <sumit.garg@linaro.org> wrote:
> > (snip)
> > > > > >
> > > > > > +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> > > > > > +{
> > > > > > +       bool rc = false;
> > > > > > +
> > > > > > +       mutex_lock(&cq->mutex);
> > > > > > +
> > > > > > +       /* Leave at least 1 normal (non-system) thread */
> > > > >
> > > > > IMO, this might be counter productive. As most kernel drivers open a
> > > > > session during driver probe which are only released in the driver
> > > > > release method.
> > > >
> > > > It is always the case?
> > >
> > > This answer of mine is irrelevant. Sorry,
> > > Please read only the below comments of mine, especially:
> > > | Note that an OP-TEE thread is not bound to a TEE session but rather
> > > | bound to a yielded call to OP-TEE.
> > >
> > > >
> > > > > If the kernel driver is built-in then the session is
> > > > > never released. Now with system threads we would reserve an OP-TEE
> > > > > thread for that kernel driver as well which will never be available to
> > > > > regular user-space clients.
> > > >
> > > > That is not true. No driver currently requests their TEE thread to be
> > > > a system thread.
> > > > Only SCMI does because it needs to by construction.
> > > >
> >
> > Yes that's true but what prevents future/current kernel TEE drivers
> > from requesting a system thread once we have this patch-set landed.
>
> Only clients really needing this system_thread attribute should request it.
> If they really need, the OP-TEE firmware in secure world should
> provision sufficient thread context.

How do we quantify it? We definitely need a policy here regarding
normal vs system threads.

One argument in favor of kernel clients requiring system threads could
be that we don't want to compete with user-space for OP-TEE threads.

>
> >
> > > >
> > > > > So I would rather suggest we only allow a
> > > > > single system thread to be reserved as a starting point which is
> > > > > relevant to this critical SCMI service. We can also make this upper
> > > > > bound for system threads configurable with default value as 1 if
> > > > > needed.
> > >
> > > Note that SCMI server can expose several SCMI channels (at most 1 per
> > > SCMI protocol used) and each of them will need to request a
> > > system_thread to TEE driver.
> > >
> > > Etienne
> > >
> > > >
> > > > Reserving one or more system threads depends on the number of thread
> > > > context provisioned by the TEE.
> > > > Note that the implementation proposed here prevents Linux kernel from
> > > > exhausting TEE threads so user space always has at least a TEE thread
> > > > context left available.
> >
> > Yeah but on the other hand user-space clients which are comparatively
> > larger in number than kernel clients. So they will be starved for
> > OP-TEE thread availability. Consider a user-space client which needs
> > to serve a lot of TLS connections just waiting for OP-TEE thread
> > availability.
>
> Note that OP-TEE default configuration provisions (number of CPUs + 1)
> thread context, so the situation is already present before these
> changes on systems that embedded an OP-TEE without a properly tuned
> configuration. As I said above, Linux kernel cannot be responsible for
> the total number of thread contexts provisioned in OP-TEE. If the
> overall system requires a lot of TEE thread contexts, one should embed
> a suitable OP-TEE firmware.

Wouldn't the SCMI deadlock problem be solved with just having a lot of
OP-TEE threads? But we are discussing the system threads solution here
to make efficient use of OP-TEE threads. The total number of OP-TEE
threads is definitely in control of OP-TEE but the control of how to
schedule and efficiently use them lies with the Linux OP-TEE driver.

So, given our overall discussion in this thread, how about the upper
bound for system threads being 50% of the total number of OP-TEE
threads?

>
> >
> > > >
> > > > Note that an OP-TEE thread is not bound to a TEE session but rather
> > > > bound to a yielded call to OP-TEE.
> >
> > tee_client_open_session()
> >   -> optee_open_session()
> >
> > tee_client_system_session()
> >   -> optee_system_session()
> >     -> optee_cq_inc_sys_thread_count()       <- At this point you
> > reserve a system thread corresponding to a particular kernel client
> > session
> >
> > All tee_client_invoke_func() invocations with a system thread capable
> > session will use that reserved thread.
> >
> > tee_client_close_session()
> >   -> optee_close_session()
> >     -> optee_close_session_helper()
> >       -> optee_cq_dec_sys_thread_count()    <- At this point the
> > reserved system thread is released
> >
> > Haven't this tied the system thread to a particular TEE session? Or am
> > I missing something?
>
> These changes do not define an overall single system thread.
> If several sessions requests reservation of TEE system thread, has
> many will be reserved.
> Only the very sessions with its sys_thread attribute set will use a
> reserved thread. If such a kernel client issues several concurrent
> calls to OP-TEE over that session, it will indeed consume more
> reserved system threads than what is actually reserved. Here I think
> it is the responsibility of such client to open as many sessions as
> requests. This is what scmi/optee driver does (see patch v6 4/4). An
> alternative would be to have a ref count of sys_thread in session
> contexts rather than a boolean value. I don't think it's worth it.

Ah, I missed that during the review. The invocations with system
threads should be limited by res_sys_thread_count in a similar manner
as we do with normal threads via free_normal_thread_count. Otherwise,
it's unfair for normal thread scheduling.

I suppose there isn't any interdependency among SCMI channels itself
such that a particular SCMI invocation can wait until the other SCMI
invocation has completed.

-Sumit
