Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34086897B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjBCL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:27:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407699D51
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:27:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r27so539720wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FFBYH09ayq+VESnvthOJ3r4O5jKQcWmITgikqHdArPo=;
        b=qwn5vw1KHU3xNws5NklNIr5M1FGm0X0csMy3C/E/hFqhmCUgAE9G3lddLH5eDKbcqK
         AAH9Ao213q22Dbbs4wLKKiyvWQBLaRWUDEZzmeELIfWtmAIiPC/7q8vWOSZWE3JkV6qV
         GqWy0lKRklPh9GJo7Ji/i2IrUCF2daoF/sN7wCkn1WnGpqqGGzCqLWWMb/XeESHHF6qP
         c6KOSxbIGPgq+E130S7bVYV/mOGum3ndkutxt2NOdEeK7lZGZZOqqzn3ZoQ9FQv3ek75
         YtGUKKzQirZg392KnMOk5aX8He5ln+a8VHrl+AAOFGYjJJx3ct2vxVbwYQ2Z+cxO7Ntm
         N4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFBYH09ayq+VESnvthOJ3r4O5jKQcWmITgikqHdArPo=;
        b=3p7J2RilTFZsuw7jQ5/CcdiK3Y49axw01ridf3MMLKuVsaIKI2xM5Le5xBepLP+4wU
         Ln2uETHDm841aGGH0S7PL+Hbm2ktpsB27db2PXB1nwe0Qce4wmQHVToMddqawt2ANpL9
         pgIz0a/Z2hKbQ5hF4INr4+1hLdePsJqrz1eIr6/QGNkILDyACzn+FivQZ5QexNfPrWLN
         SB8v/sfPHcE2RoP+xBk091o2yYnDdQQNpbU96CaHZ20IcPf0zse+8fZhD7NohR0c+QKu
         5HLaTZ599fB46jfWdQB0twVAvL+cFiL8tG+5ZDOmtYpZnoQeknRAmB0COvJL9o68Ax0i
         NiVg==
X-Gm-Message-State: AO0yUKXlzmmOXfFZpNYtLCLizwdEHYTXQl5sH0KZvJ7dGJ2a9oT8Zb9T
        5aGyRnYOlV0jjQIagjZiv5j0TSttg/2b50KQ46UMCA==
X-Google-Smtp-Source: AK7set/4c+FAHjS6YgqG9I+XSHUsnaqXvaJLjIgMfPas0yF/meUjdfF6oM6Kq6FjY7KjRs0Xrb6hm+Zni1NybNsI7Yw=
X-Received: by 2002:a5d:5641:0:b0:2c3:da3f:1dec with SMTP id
 j1-20020a5d5641000000b002c3da3f1decmr15640wrw.315.1675423659899; Fri, 03 Feb
 2023 03:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
In-Reply-To: <20230130094157.1082712-1-etienne.carriere@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 3 Feb 2023 12:27:28 +0100
Message-ID: <CAHUa44EJ4avGWAPGqJHTcXXa8Z7p0C9D9BxPqmR7sDMZiyQKAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: system invocation
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
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

On Mon, Jan 30, 2023 at 10:42 AM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds TEE context flag sys_service to be enabled for invocation contexts
> that should used TEE provisioned system resources. OP-TEE SMC ABI entry
> rely this information to use a dedicated entry function to request
> allocation of a system thread from a dedicated system context pool.
>
> This feature is needed when a TEE invocation cannot afford to wait for
> a free TEE thread when all TEE threads context are used and suspended
> as these may be suspended waiting for a system service, as an SCMI clock
> or voltage regulator, to be enabled. An example is when OP-TEE invokes
> a Linux OS remove service (RPC) to access an eMMC RPMB partition and
> the eMMC device is supplied by an OP-TEE SCMI regulator.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/tee/optee/optee_smc.h | 14 +++++++++++---
>  drivers/tee/optee/smc_abi.c   |  6 +++++-
>  include/linux/tee_drv.h       |  4 ++++
>  3 files changed, 20 insertions(+), 4 deletions(-)

Looks good to me.

Thanks,
Jens

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
