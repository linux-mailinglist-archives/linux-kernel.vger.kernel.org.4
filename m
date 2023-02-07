Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60068D091
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBGH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBGH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:27:05 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4040732E7F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:27:04 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id x21so1160523uaf.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8k42l9wNujiO01M39YWwUFqLBeOk7UwESnP0zgjVsB4=;
        b=I4OGc+jo9R/2DXMBKzpQ9ncJX7EMQh0qMP+F3PBR69J1dSvqjEdxgl2MDeMdHq+yN/
         I3JyExMIv+MOxjtzCPyCmWPAaX0YVzPp6OUWHtQxPb4/lur1duBu5bZgWJNguADa50I1
         DcIHgD4rS/zRcU/XGNK1rSfpbnHw2EOz47wo5/gvT6qI+YBnbP4mfMVfYNmB5L/HQTCd
         ss+VTk70n+X3g/ZEDbp+bh/drCKFRdMP5GzsPRbLRn2evdfyF7oPt+uupW+QhTxOcfDT
         OJxUHwW20Ou2KitHR+oEQEyNu7S6SWDF62QB/2C0fqDFWO3JzK5V3u6vcfM3mZ9+KGCE
         Dp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k42l9wNujiO01M39YWwUFqLBeOk7UwESnP0zgjVsB4=;
        b=p5p7ePmucnL+uy2KSsuDfRkUWaTfJIhh4RuHfdj3smEDbPjaBYohFnIa6k7/15xThj
         QCcuV/ODP5nflBv5bYjsIOpIYXREAEq68kDG4pF8IVlj8fZvRc2O1hSZ6nmOtz7+zRjP
         WLN+Kycr5Yc8Ju3606tmJx2wt4qfBBTXPJaVvCuxz5U1xFd9Q/mOD5QDVVUFivhU2OwC
         TqAkBuxNrPnEc1vxTHdsfIhpilBjpIhLJIpali+fJAa/pF2cIqw8KcGC2w9FNosMfQTO
         n0HS94zi5udveACsIPIZr2B5s2Jmk/COXAZhzxd2oOzoBPexMNP8tsA3eaxY8Q7Yy9Mt
         zpZg==
X-Gm-Message-State: AO0yUKUR4yTpPymnM4NUgSTkLFB+73F2NXAVTEMX0E1s2v5tK/RrtGN2
        hoZq7evwfU+8ITnj99EUo66RPieJSdsJIgkasRLCYD04L0w3/ELX
X-Google-Smtp-Source: AK7set9cjTwP1r6CmTpiAyeT/FXzKXW7clVhwJ0Nzza5GrnFWC64xqxi0E3jNeA4vuXfJyc73hWTPcpAGs25X3wB+sU=
X-Received: by 2002:ab0:6391:0:b0:609:baa9:7704 with SMTP id
 y17-20020ab06391000000b00609baa97704mr394140uao.31.1675754823298; Mon, 06 Feb
 2023 23:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
In-Reply-To: <20230130094157.1082712-1-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 7 Feb 2023 12:56:51 +0530
Message-ID: <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: system invocation
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
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

Hi Etienne,

On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds TEE context flag sys_service to be enabled for invocation contexts
> that should used TEE provisioned system resources. OP-TEE SMC ABI entry

s/used/use/

> rely this information to use a dedicated entry function to request
> allocation of a system thread from a dedicated system context pool.
>
> This feature is needed when a TEE invocation cannot afford to wait for
> a free TEE thread when all TEE threads context are used and suspended
> as these may be suspended waiting for a system service, as an SCMI clock
> or voltage regulator, to be enabled. An example is when OP-TEE invokes
> a Linux OS remove service (RPC) to access an eMMC RPMB partition and

s/remove/remote/

> the eMMC device is supplied by an OP-TEE SCMI regulator.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/tee/optee/optee_smc.h | 14 +++++++++++---
>  drivers/tee/optee/smc_abi.c   |  6 +++++-
>  include/linux/tee_drv.h       |  4 ++++
>  3 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 73b5e7760d10..7c7eedf183c5 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
>   * Call with struct optee_msg_arg as argument
>   *
>   * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> - * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> + * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
> + * in a0 there is one RPC struct optee_msg_arg
>   * following after the first struct optee_msg_arg. The RPC struct
>   * optee_msg_arg has reserved space for the number of RPC parameters as
>   * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> @@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
>   * a4-6        Not used
>   * a7  Hypervisor Client ID register
>   *
> - * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> - * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG:
> + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
>   * a1  Upper 32 bits of a 64-bit shared memory cookie
>   * a2  Lower 32 bits of a 64-bit shared memory cookie
>   * a3  Offset of the struct optee_msg_arg in the shared memory with the
> @@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
>         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
>  #define OPTEE_SMC_CALL_WITH_REGD_ARG \
>         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> +#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
> +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
>
>  /*
>   * Get Shared Memory Config
> @@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
>  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
>  /* Secure world supports pre-allocating RPC arg struct */
>  #define OPTEE_SMC_SEC_CAP_RPC_ARG              BIT(6)
> +/* Secure world provisions thread for system service invocation */
> +#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD                BIT(7)
>
>  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
>  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> @@ -426,6 +431,9 @@ struct optee_smc_disable_shm_cache_result {
>  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
>  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG    19
>
> +/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
> +#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG     20
> +
>  /*
>   * Resume from RPC (for example after processing a foreign interrupt)
>   *
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..513038a138f6 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -889,7 +889,11 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>         }
>
>         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> +               if (ctx->sys_service &&
> +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> +               else
> +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;

This system thread flag should also be applicable to platforms without
registered arguments support. IOW, we need similar equivalents for
OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
too. So I would rather suggest that we add following flag to all 3
call types:

#define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000

-Sumit

>                 reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
>                 param.a3 = offs;
>         } else {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 17eb1c5205d3..1ff292ba7679 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -47,6 +47,9 @@ struct tee_shm_pool;
>   *              non-blocking in nature.
>   * @cap_memref_null: flag indicating if the TEE Client support shared
>   *                   memory buffer with a NULL pointer.
> + * @sys_service: flag set by the TEE Client to indicate that it is part of
> + *              a system service and that the TEE may use resources reserved
> + *              for this.
>   */
>  struct tee_context {
>         struct tee_device *teedev;
> @@ -55,6 +58,7 @@ struct tee_context {
>         bool releasing;
>         bool supp_nowait;
>         bool cap_memref_null;
> +       bool sys_service;
>  };
>
>  struct tee_param_memref {
> --
> 2.25.1
>
