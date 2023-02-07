Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A468D344
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjBGJwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjBGJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:52:37 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1D0EFB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:52:35 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z22so1708817vsq.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YM1xsh4TtEAKli7TV9h1YLDIJAaoxDq8ib0dT0SpAKY=;
        b=ocdd2+KDk0KBDGs879EKzZ4cDCS6X2lDhZnfaaGOS+67i4VDfWwIJQ/3f13FPdvLwk
         bA6/JYVPYQ7cbkVRx8/4Z7lFeHc73LQIEmnYQYaT5NzpLoeqoMJYdYDx9gHi8A2lUd8W
         OqrdzwI3CXGYwhJLJmPzOtVtvvu15XWJ6SF03jXuxmZIogArtUViYqKjdnDKmWbNrw8S
         QgRSFQ/4v8HKczaa2jLF/O5C5vy/LGECi9cgOAfDDpKLnZAsaoKe0UEbF8hODEVg4r0i
         H2mIHU2cBojtAZDNa9iHslzTSfofGN3IqzUBaVJzAB0LNGQ72HHUEnSN3kzCQfBjW/UF
         TOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YM1xsh4TtEAKli7TV9h1YLDIJAaoxDq8ib0dT0SpAKY=;
        b=o6vtvi9R+iRNL2bGnv82V/TqoYOfJb4pfJ46rxt8ODksfTauBVGbh75kV3ZCnh8ObV
         WIQMspQjPA8Wr69ZEbUb4KJEJGAk7D5JRxvcgqQ1jsZgKXwzeeGMV0sVzyK+76xvOQuB
         mUKBwZYtvaYEiWZZ9igexI1XqNLK7Jkcc8oYIzUtKEcT4L/MQwb+3TBp+wzbvZtSiS5o
         6YDeNuMV2awCUKBV62T5a12S1Qwoy8I7twmngKWcrpDSI9Sf55ikHs33H7S5cRW7uQ8F
         ptNMWHzDQZNQ435A+5T0HLrZQEhQLf538y7JFlvARMCTtHVN45ZfJSUwNugtrEblgnZ5
         nq+g==
X-Gm-Message-State: AO0yUKVsCBcdnpJ/K4YLnaEHyrRXV3bxyg3Sy3YhFlxc5eCPAQXXpDCr
        1aQq/nukiH9f/DFWcp23ZWGFVwp3Ia4aiKSAP/lP2w==
X-Google-Smtp-Source: AK7set/0+7VwWz0l3BQYyKYfnjDDYfzLDfDY1qEY4wR9u4y0EAHop4LhNrGoQcHGh2Z/1ilFq9nMk5zXVaVACF5BBs4=
X-Received: by 2002:a67:ea45:0:b0:3ce:8835:de03 with SMTP id
 r5-20020a67ea45000000b003ce8835de03mr557596vso.50.1675763554112; Tue, 07 Feb
 2023 01:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com> <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
In-Reply-To: <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 7 Feb 2023 15:22:22 +0530
Message-ID: <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: system invocation
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Tue, 7 Feb 2023 at 14:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Tue, Feb 7, 2023 at 8:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Etienne,
> >
> > On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > >
> > > Adds TEE context flag sys_service to be enabled for invocation contexts
> > > that should used TEE provisioned system resources. OP-TEE SMC ABI entry
> >
> > s/used/use/
> >
> > > rely this information to use a dedicated entry function to request
> > > allocation of a system thread from a dedicated system context pool.
> > >
> > > This feature is needed when a TEE invocation cannot afford to wait for
> > > a free TEE thread when all TEE threads context are used and suspended
> > > as these may be suspended waiting for a system service, as an SCMI clock
> > > or voltage regulator, to be enabled. An example is when OP-TEE invokes
> > > a Linux OS remove service (RPC) to access an eMMC RPMB partition and
> >
> > s/remove/remote/
> >
> > > the eMMC device is supplied by an OP-TEE SCMI regulator.
> > >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > >  drivers/tee/optee/optee_smc.h | 14 +++++++++++---
> > >  drivers/tee/optee/smc_abi.c   |  6 +++++-
> > >  include/linux/tee_drv.h       |  4 ++++
> > >  3 files changed, 20 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > index 73b5e7760d10..7c7eedf183c5 100644
> > > --- a/drivers/tee/optee/optee_smc.h
> > > +++ b/drivers/tee/optee/optee_smc.h
> > > @@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
> > >   * Call with struct optee_msg_arg as argument
> > >   *
> > >   * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> > > - * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> > > + * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> > > + * in a0 there is one RPC struct optee_msg_arg
> > >   * following after the first struct optee_msg_arg. The RPC struct
> > >   * optee_msg_arg has reserved space for the number of RPC parameters as
> > >   * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> > > @@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
> > >   * a4-6        Not used
> > >   * a7  Hypervisor Client ID register
> > >   *
> > > - * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> > > - * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> > > + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG:
> > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> > >   * a1  Upper 32 bits of a 64-bit shared memory cookie
> > >   * a2  Lower 32 bits of a 64-bit shared memory cookie
> > >   * a3  Offset of the struct optee_msg_arg in the shared memory with the
> > > @@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
> > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> > >  #define OPTEE_SMC_CALL_WITH_REGD_ARG \
> > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> > > +#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
> > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
> > >
> > >  /*
> > >   * Get Shared Memory Config
> > > @@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
> > >  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
> > >  /* Secure world supports pre-allocating RPC arg struct */
> > >  #define OPTEE_SMC_SEC_CAP_RPC_ARG              BIT(6)
> > > +/* Secure world provisions thread for system service invocation */
> > > +#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD                BIT(7)
> > >
> > >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
> > >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > > @@ -426,6 +431,9 @@ struct optee_smc_disable_shm_cache_result {
> > >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> > >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG    19
> > >
> > > +/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
> > > +#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG     20
> > > +
> > >  /*
> > >   * Resume from RPC (for example after processing a foreign interrupt)
> > >   *
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > index a1c1fa1a9c28..513038a138f6 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -889,7 +889,11 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> > >         }
> > >
> > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > +               if (ctx->sys_service &&
> > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > +               else
> > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> >
> > This system thread flag should also be applicable to platforms without
> > registered arguments support. IOW, we need similar equivalents for
> > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > too. So I would rather suggest that we add following flag to all 3
> > call types:
> >
> > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
>
> The main reason platforms don't support registered arguments is that
> they haven't been updated since this was introduced. So if a platform
> needs system threads it could update to use registered arguments too.

Are we hinting at deprecating reserved shared memory support? If yes,
wouldn't it be better to be explicit about it with a boot time warning
message about its deprecation?

Otherwise it will be difficult to debug for the end user to find out
why system thread support isn't activated.

> The Linux kernel already supports registered arguments. An advantage
> with the current approach is that the ABI is easier to implement
> since we have distinct SMC IDs for each function.

I see your point but my initial thought was that we don't end up
making that list too large that it becomes cumbersome to maintain,
involving all the combinatorial.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >                 reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
> > >                 param.a3 = offs;
> > >         } else {
> > > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > > index 17eb1c5205d3..1ff292ba7679 100644
> > > --- a/include/linux/tee_drv.h
> > > +++ b/include/linux/tee_drv.h
> > > @@ -47,6 +47,9 @@ struct tee_shm_pool;
> > >   *              non-blocking in nature.
> > >   * @cap_memref_null: flag indicating if the TEE Client support shared
> > >   *                   memory buffer with a NULL pointer.
> > > + * @sys_service: flag set by the TEE Client to indicate that it is part of
> > > + *              a system service and that the TEE may use resources reserved
> > > + *              for this.
> > >   */
> > >  struct tee_context {
> > >         struct tee_device *teedev;
> > > @@ -55,6 +58,7 @@ struct tee_context {
> > >         bool releasing;
> > >         bool supp_nowait;
> > >         bool cap_memref_null;
> > > +       bool sys_service;
> > >  };
> > >
> > >  struct tee_param_memref {
> > > --
> > > 2.25.1
> > >
