Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD66068D46E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjBGKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjBGKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:37:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CE24CA8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:36:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso12805495wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SzGDt+F6+IgGhsMpDbhgaPeDdq+5IYlRA61ZoFd5Fco=;
        b=X3yf1akD8z6u4RRwrXmSseFGy0c4AFnpAWTssyl8u+VbQw0HzyMrXZHtZV3rv8dKlW
         pdESoGg8nAcp1Twnvk3OFM/wnLw95YwghDktZSVpiFJmNX8qs8G5EOxiWAud+sKHK57f
         I0uUnXICa46GjmxEmFUzpSRBGf6Mz3fwBg6Xju2zn/4YY5+MzG3SImy8hNKlTxBn0kUy
         4gXWkr7tjkulmMjP29w62/Qq+fvDQVL2rQYdy8Ns/Ydwii8DXzXP2e4qehvjrFzUnM6G
         z8bdnVVnffo3GY3xMVGntERK97Sac7uGtov02NHFu4RFH+l3Khq/F/SMrafcu5DRIi/f
         8Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzGDt+F6+IgGhsMpDbhgaPeDdq+5IYlRA61ZoFd5Fco=;
        b=2Srwt46qNSTknbZJ7tNbHQnalSm6gS9btvyflVPe2ouR/NvitLnAwTvSuOesGw3uGc
         rGhyp2HkJskS97fFjHJQHSfvu5NfMu1HKWhyI8VhYahtsMS9fjeh6GKswQpCLJveiu8N
         oK5kDsJOl+tJ0msNU3uDHAn599hvbpCIPRSnpzHOV4QKYmiUTD5zk7Y2NnpYesrn0cBn
         bdaN9rErD5Nasd+yFgJ6JSIrEpvPSl8W9TqOM9G7bHgtfxHxafl8gddKf4QaLzTFvNp2
         0zwKTmwOYBCN9FqDYFVTaAkQOOr8gGmjNyp5EHHGaTQtJQtfR3rNy8/nlERSLBixhEmo
         pC1A==
X-Gm-Message-State: AO0yUKWbMyOQ3Yfx5KOo3anFF7IYYNH5WL2FRV31ip8LlsVdJj/H3bki
        sN3uIP2opUwPiNIvvKt4j50UYqOf5YnYnIhrIp1+7g==
X-Google-Smtp-Source: AK7set9irTBsmwE+WQKRpEnozI5HfKhLx3ditFyGE2bQT5QfpQ84Qm7wnJZfmN0YAD7YYBce/qA/Lai1Y5mLEnoBR5E=
X-Received: by 2002:a05:600c:c0e:b0:3dd:1a1e:fa58 with SMTP id
 fm14-20020a05600c0c0e00b003dd1a1efa58mr918693wmb.99.1675766196838; Tue, 07
 Feb 2023 02:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
 <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com> <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
In-Reply-To: <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 7 Feb 2023 11:36:25 +0100
Message-ID: <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: system invocation
To:     Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Tue, Feb 7, 2023 at 10:52 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 7 Feb 2023 at 14:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi,
> >
> > On Tue, Feb 7, 2023 at 8:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Etienne,
> > >
> > > On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
> > > <etienne.carriere@linaro.org> wrote:
> > > >
> > > > Adds TEE context flag sys_service to be enabled for invocation contexts
> > > > that should used TEE provisioned system resources. OP-TEE SMC ABI entry
> > >
> > > s/used/use/
> > >
> > > > rely this information to use a dedicated entry function to request
> > > > allocation of a system thread from a dedicated system context pool.
> > > >
> > > > This feature is needed when a TEE invocation cannot afford to wait for
> > > > a free TEE thread when all TEE threads context are used and suspended
> > > > as these may be suspended waiting for a system service, as an SCMI clock
> > > > or voltage regulator, to be enabled. An example is when OP-TEE invokes
> > > > a Linux OS remove service (RPC) to access an eMMC RPMB partition and
> > >
> > > s/remove/remote/
> > >
> > > > the eMMC device is supplied by an OP-TEE SCMI regulator.
> > > >
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/optee_smc.h | 14 +++++++++++---
> > > >  drivers/tee/optee/smc_abi.c   |  6 +++++-
> > > >  include/linux/tee_drv.h       |  4 ++++
> > > >  3 files changed, 20 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > > index 73b5e7760d10..7c7eedf183c5 100644
> > > > --- a/drivers/tee/optee/optee_smc.h
> > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > @@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
> > > >   * Call with struct optee_msg_arg as argument
> > > >   *
> > > >   * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> > > > - * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> > > > + * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> > > > + * in a0 there is one RPC struct optee_msg_arg
> > > >   * following after the first struct optee_msg_arg. The RPC struct
> > > >   * optee_msg_arg has reserved space for the number of RPC parameters as
> > > >   * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> > > > @@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
> > > >   * a4-6        Not used
> > > >   * a7  Hypervisor Client ID register
> > > >   *
> > > > - * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> > > > - * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> > > > + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG:
> > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> > > >   * a1  Upper 32 bits of a 64-bit shared memory cookie
> > > >   * a2  Lower 32 bits of a 64-bit shared memory cookie
> > > >   * a3  Offset of the struct optee_msg_arg in the shared memory with the
> > > > @@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
> > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> > > >  #define OPTEE_SMC_CALL_WITH_REGD_ARG \
> > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> > > > +#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
> > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
> > > >
> > > >  /*
> > > >   * Get Shared Memory Config
> > > > @@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
> > > >  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
> > > >  /* Secure world supports pre-allocating RPC arg struct */
> > > >  #define OPTEE_SMC_SEC_CAP_RPC_ARG              BIT(6)
> > > > +/* Secure world provisions thread for system service invocation */
> > > > +#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD                BIT(7)
> > > >
> > > >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
> > > >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > > > @@ -426,6 +431,9 @@ struct optee_smc_disable_shm_cache_result {
> > > >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> > > >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG    19
> > > >
> > > > +/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
> > > > +#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG     20
> > > > +
> > > >  /*
> > > >   * Resume from RPC (for example after processing a foreign interrupt)
> > > >   *
> > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > > index a1c1fa1a9c28..513038a138f6 100644
> > > > --- a/drivers/tee/optee/smc_abi.c
> > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > @@ -889,7 +889,11 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> > > >         }
> > > >
> > > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > +               if (ctx->sys_service &&
> > > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > > +               else
> > > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > >
> > > This system thread flag should also be applicable to platforms without
> > > registered arguments support. IOW, we need similar equivalents for
> > > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > > too. So I would rather suggest that we add following flag to all 3
> > > call types:
> > >
> > > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
> >
> > The main reason platforms don't support registered arguments is that
> > they haven't been updated since this was introduced. So if a platform
> > needs system threads it could update to use registered arguments too.
>
> Are we hinting at deprecating reserved shared memory support? If yes,
> wouldn't it be better to be explicit about it with a boot time warning
> message about its deprecation?
>
> Otherwise it will be difficult to debug for the end user to find out
> why system thread support isn't activated.
>
> > The Linux kernel already supports registered arguments. An advantage
> > with the current approach is that the ABI is easier to implement
> > since we have distinct SMC IDs for each function.
>
> I see your point but my initial thought was that we don't end up
> making that list too large that it becomes cumbersome to maintain,
> involving all the combinatorial.

You have a point. Etienne, do you think we could give it a try at
https://github.com/OP-TEE/optee_os/pull/5789 to better see how this
would play out?

Cheers,
Jens
