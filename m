Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0B68F403
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBHRJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:09:31 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BB4B771
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:09:29 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-52bf58b417fso15560037b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EO+bwkZW6Abz75fcTQ8qhH6t4997621C94XEErkn3AM=;
        b=XiryAklD8Gk/4czGXjFRg7gGC/rAuGTnPbQeJXMm54RzaIv7sUFSLG5OQumKornYXf
         yO4Ssjv68221u8aFd6DbSa5cOTBmy2VqTbcatXwLkQjtGXfbUzMrzohgiD8nbKl5zn9A
         FkrbWBwrrmjhrfoZQM+q83863ch6bNnutU3FVvlwjea3IZrhPhw9O6g18TTIhJhvcOtJ
         bQa+Hze4SjO6PnGXRrRtyW520ZBt+6lK3CFVUea/Uv7mYbhwPUwAmdhoBp4jfmWlSkW3
         S+VZTjGzbm3a8pUlYZfwGAsmbqWBGIcSDQUme5/XGfeYThjsIQN03bWlgbBFyJcoAuZY
         563A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO+bwkZW6Abz75fcTQ8qhH6t4997621C94XEErkn3AM=;
        b=lPTA0RrPrRuStg/fGxO2YjGw/0J34zUYqj7re8trpfrUYO8RWOXMA9tc/1GrtoEcqa
         HbSuMvEQhVHHMrweDxopt3XcQAv7mIJ+D2Osyn1V/wx+WsF9hHQQFIcuP9QPhpOJ1vOp
         KN2gQ1oSDG+1XKaTLziaiqJa9VYXr2G1BTaGpbEVHYhOu0NjppYvHyOoumRReUGN0ier
         gtMPkVKF1D0Ql025yP31ifI2w/Tx6lkebBd+U2Nd6lg7S5WREbEL4cLal69OY/2qCjWi
         FozG0x2Q2MXyHFbrYDwYgpx6cRGdatsFtOywOuJbE8jJ4EOEfzvKHjZKkHNW4+6jcG6X
         4Spw==
X-Gm-Message-State: AO0yUKWuufKjkbSw4TOsgFlHenTBmoYXUn6i5TmKVYpb2/S1+YISq/QT
        g+J7Ul+6bB5QyRwEbIe7AYoh94raaBKeavQbDfnMHRuFRJ1ftJrr
X-Google-Smtp-Source: AK7set9soB3CmlFHOzaMzkWNRPAoHi53Y3+QNHGPWTH+3695xUqhc1W5IxVzAXILZEN/45LoI7gw5y6xD4zPyGnjLQU=
X-Received: by 2002:a81:4f46:0:b0:52b:f225:c92 with SMTP id
 d67-20020a814f46000000b0052bf2250c92mr234465ywb.452.1675876168938; Wed, 08
 Feb 2023 09:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
 <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
 <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com> <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
In-Reply-To: <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 8 Feb 2023 18:09:17 +0100
Message-ID: <CAN5uoS_M4uMWkf=Q8XFLCrNSvyUdjLgCPixqonKv3mRwRTr-nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: system invocation
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit, Jens,

On Tue, 7 Feb 2023 at 11:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Tue, Feb 7, 2023 at 10:52 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Tue, 7 Feb 2023 at 14:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Feb 7, 2023 at 8:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi Etienne,
> > > >
> > > > On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
> > > > <etienne.carriere@linaro.org> wrote:
> > > > >
> > > > > Adds TEE context flag sys_service to be enabled for invocation contexts
> > > > > that should used TEE provisioned system resources. OP-TEE SMC ABI entry
> > > >
> > > > s/used/use/
> > > >
> > > > > rely this information to use a dedicated entry function to request
> > > > > allocation of a system thread from a dedicated system context pool.
> > > > >
> > > > > This feature is needed when a TEE invocation cannot afford to wait for
> > > > > a free TEE thread when all TEE threads context are used and suspended
> > > > > as these may be suspended waiting for a system service, as an SCMI clock
> > > > > or voltage regulator, to be enabled. An example is when OP-TEE invokes
> > > > > a Linux OS remove service (RPC) to access an eMMC RPMB partition and
> > > >
> > > > s/remove/remote/
> > > >
> > > > > the eMMC device is supplied by an OP-TEE SCMI regulator.
> > > > >
> > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > ---
> > > > >  drivers/tee/optee/optee_smc.h | 14 +++++++++++---
> > > > >  drivers/tee/optee/smc_abi.c   |  6 +++++-
> > > > >  include/linux/tee_drv.h       |  4 ++++
> > > > >  3 files changed, 20 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > > > index 73b5e7760d10..7c7eedf183c5 100644
> > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > @@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
> > > > >   * Call with struct optee_msg_arg as argument
> > > > >   *
> > > > >   * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> > > > > - * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> > > > > + * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> > > > > + * in a0 there is one RPC struct optee_msg_arg
> > > > >   * following after the first struct optee_msg_arg. The RPC struct
> > > > >   * optee_msg_arg has reserved space for the number of RPC parameters as
> > > > >   * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> > > > > @@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
> > > > >   * a4-6        Not used
> > > > >   * a7  Hypervisor Client ID register
> > > > >   *
> > > > > - * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> > > > > - * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> > > > > + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG:
> > > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> > > > >   * a1  Upper 32 bits of a 64-bit shared memory cookie
> > > > >   * a2  Lower 32 bits of a 64-bit shared memory cookie
> > > > >   * a3  Offset of the struct optee_msg_arg in the shared memory with the
> > > > > @@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
> > > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> > > > >  #define OPTEE_SMC_CALL_WITH_REGD_ARG \
> > > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> > > > > +#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
> > > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
> > > > >
> > > > >  /*
> > > > >   * Get Shared Memory Config
> > > > > @@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
> > > > >  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
> > > > >  /* Secure world supports pre-allocating RPC arg struct */
> > > > >  #define OPTEE_SMC_SEC_CAP_RPC_ARG              BIT(6)
> > > > > +/* Secure world provisions thread for system service invocation */
> > > > > +#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD                BIT(7)
> > > > >
> > > > >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
> > > > >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > > > > @@ -426,6 +431,9 @@ struct optee_smc_disable_shm_cache_result {
> > > > >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> > > > >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG    19
> > > > >
> > > > > +/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
> > > > > +#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG     20
> > > > > +
> > > > >  /*
> > > > >   * Resume from RPC (for example after processing a foreign interrupt)
> > > > >   *
> > > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > > > index a1c1fa1a9c28..513038a138f6 100644
> > > > > --- a/drivers/tee/optee/smc_abi.c
> > > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > > @@ -889,7 +889,11 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> > > > >         }
> > > > >
> > > > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > +               if (ctx->sys_service &&
> > > > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > > > +               else
> > > > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > >
> > > > This system thread flag should also be applicable to platforms without
> > > > registered arguments support. IOW, we need similar equivalents for
> > > > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > > > too. So I would rather suggest that we add following flag to all 3
> > > > call types:
> > > >
> > > > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
> > >
> > > The main reason platforms don't support registered arguments is that
> > > they haven't been updated since this was introduced. So if a platform
> > > needs system threads it could update to use registered arguments too.
> >
> > Are we hinting at deprecating reserved shared memory support? If yes,
> > wouldn't it be better to be explicit about it with a boot time warning
> > message about its deprecation?
> >
> > Otherwise it will be difficult to debug for the end user to find out
> > why system thread support isn't activated.
> >
> > > The Linux kernel already supports registered arguments. An advantage
> > > with the current approach is that the ABI is easier to implement
> > > since we have distinct SMC IDs for each function.
> >
> > I see your point but my initial thought was that we don't end up
> > making that list too large that it becomes cumbersome to maintain,
> > involving all the combinatorial.
>
> You have a point. Etienne, do you think we could give it a try at
> https://github.com/OP-TEE/optee_os/pull/5789 to better see how this
> would play out?
>

Indeed I miss that...
With the patch proposed here, indeed if OP-TEE does not support
dynamic shared memory then Linux will never use the provisioned TEE
thread. This is weird as in such a case OP-TEE provisions resources
that will never be used, which is the exact opposite goal of this
feature. Verified on our qemu-arm setup.

For simplicity, I think this system invocation should require OP-TEE
supports dyn shm.

If OP-TEE could know when Linux does not support TEE system
invocation, then OP-TEE could let any invocation use these provisioned
resources so that they are not wasted.
I think a good way would be Linux to expose if it supports this
capability, during capabilities exchange.
Would you agree with this approach?

Etienne



> Cheers,
> Jens
