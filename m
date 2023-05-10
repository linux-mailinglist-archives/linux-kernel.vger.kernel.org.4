Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3C6FDB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjEJKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjEJKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:14:40 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6DA1FE3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:14:37 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-43612ffa82fso609082137.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713676; x=1686305676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyxVh6Bn3n5sF3blHhR2SMLSrwGlWm6CrpKH8IXQruk=;
        b=HHN+OeUM82c1krqfQ6MHczVzsN+73g7gPQHvTAAIaNM8L5gGQdN1XZIbDnnRKEwUEC
         AicqQ4Vm5pkXWeP8/UF65ABzf0E2etYl0y4YnC29Q3lwigk+rtGhA6FGrPcoM8W1WGj6
         ieXIUkdky4Xg1jpzSyLEgpEcdYt1+ELJq57GaUxkId8T+iU+4EgPD81mi5Zi0o/UEnj5
         YAWl0kG60VWFh47yZqBnUaY/WDm3Cf3ZGyKJB8UGhir4pi+kIH7gGZGTAG1InoLxRlRQ
         LwoRbX2HlykHILABUZjCW5iked4wrhf/OKE/StWgp1tUKk2ZnPyWfWwsNddW2XVf13RQ
         +r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713676; x=1686305676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyxVh6Bn3n5sF3blHhR2SMLSrwGlWm6CrpKH8IXQruk=;
        b=kSWDWGxuICHaKQwMHcAoxunbGnc7IJTvpFgtFf6Lny6rWnSdOYnVkTd1JkGsFNZVTm
         2vJ7aj4C56z4keu24xr2RWj/ZN7ywg8t4+dF9XS2S1UR69PhIk+hvryaXqSS2/6Yk9Gf
         atBLkPp3g68j5fcrBJOcCC2VaM2Nr7jhctvAfkj0do45bTDS/PuVk9af+gw8/+dklc9z
         PpIfgf+aTy0VxxDnVFQvXQYOdk86x+m81sJ1OF5XFZVelrqhJqMp0FzOaGi3BieLJ90p
         BDDuGI0FvEU/V+1OHnXm30MRxkHkWbFa1nlfo1j0ElSYCkbQk3NLXAN0HwRVH+PXTP8O
         HQQw==
X-Gm-Message-State: AC+VfDzO1X2WQKXHun/6Z508D1jGL8zgo+p0aurKG8PM+rRbXDrDSmcb
        +7LmmYRpPVoWanpUV3EVFxFMf99MRR1CbVa5Kq46yA==
X-Google-Smtp-Source: ACHHUZ4ci5AeFP/wGYzXq/glgfJYeGQTOfOiLiltAurW+oVfwMLsJcpiv1S5t1Pshl1vXfUDGpiwhwAGPh3/595Y9uo=
X-Received: by 2002:a05:6102:3a57:b0:435:ffcc:cdd2 with SMTP id
 c23-20020a0561023a5700b00435ffcccdd2mr3032160vsu.35.1683713676582; Wed, 10
 May 2023 03:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org> <20230505173012.881083-2-etienne.carriere@linaro.org>
In-Reply-To: <20230505173012.881083-2-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 May 2023 15:44:25 +0530
Message-ID: <CAFA6WYPC36vqQLzOfArvy2GnVJAXLwbDGenhBARzJ7-Fri-sVA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] tee: system session
To:     Etienne Carriere <etienne.carriere@linaro.org>
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

On Fri, 5 May 2023 at 23:01, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds kernel client API function tee_client_system_session() for a client
> to request a system service entry in TEE context.
>
> This feature is needed to prevent a system deadlock when several TEE
> client applications invoke TEE, consuming all TEE thread contexts
> available in the secure world. The deadlock can happen in the OP-TEE
> driver for example if all these TEE threads issue an RPC call from TEE
> to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
> device clock or regulator controller is accessed through an OP-TEE SCMI
> services. In that case, Linux SCMI driver must reach OP-TEE SCMI service
> without waiting one of the consumed TEE thread is freed.
>

s/waiting one/waiting until one/
s/thread/threads/

> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v5
>

With above typos fixes, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Changes since v4:
> - Changes extracted from "[PATCH v4 1/2] tee: system invocation" and
>   revised with Jens contribution to cover only definition of tee driver
>   new API function tee_client_system_session() for kernel clients to
>   register their session as a system session.
> - Commit message rephrased, including header line changed from
>   "tee: system invocation" to "tee: system session" has the feature
>   relates to system attributes of tee sessions.
>
> Changes since v3:
> - Fixed new SMC funcIDs to reserved/unreserve OP-TEE thread contexts:
>   minor renaming + define as fastcall funcIDs.
> - Moved system_ctx_count from generic struct tee_context to optee's
>   private struct optee_context_data. This changes optee smc_abi.c
>   to release reserved thread contexts when the optee device is released.
> - Fixed inline description comments.
>
> No change since v2
>
> Change since v1
> - Addressed comment on Linux client to claim reservation on TEE context.
>   This brings 2 new operations from client to TEE to request and release
>   system thread contexts: 2 new tee_drv.h API functions, 2 new ops
>   functions in struct tee_driver_ops. The OP-TEE implement shall implement
>   2 new fastcall SMC funcIDs.
> - Fixed typos in commit message.
> ---
>  drivers/tee/tee_core.c  |  8 ++++++++
>  include/linux/tee_drv.h | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 0eb342de0b00..91932835d0f7 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1170,6 +1170,14 @@ int tee_client_close_session(struct tee_context *ctx, u32 session)
>  }
>  EXPORT_SYMBOL_GPL(tee_client_close_session);
>
> +int tee_client_system_session(struct tee_context *ctx, u32 session)
> +{
> +       if (!ctx->teedev->desc->ops->system_session)
> +               return -EINVAL;
> +       return ctx->teedev->desc->ops->system_session(ctx, session);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_system_session);
> +
>  int tee_client_invoke_func(struct tee_context *ctx,
>                            struct tee_ioctl_invoke_arg *arg,
>                            struct tee_param *param)
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 17eb1c5205d3..911ddf92dcee 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -84,6 +84,7 @@ struct tee_param {
>   * @release:           release this open file
>   * @open_session:      open a new session
>   * @close_session:     close a session
> + * @system_session:    declare session as a system session
>   * @invoke_func:       invoke a trusted function
>   * @cancel_req:                request cancel of an ongoing invoke or open
>   * @supp_recv:         called for supplicant to get a command
> @@ -100,6 +101,7 @@ struct tee_driver_ops {
>                             struct tee_ioctl_open_session_arg *arg,
>                             struct tee_param *param);
>         int (*close_session)(struct tee_context *ctx, u32 session);
> +       int (*system_session)(struct tee_context *ctx, u32 session);
>         int (*invoke_func)(struct tee_context *ctx,
>                            struct tee_ioctl_invoke_arg *arg,
>                            struct tee_param *param);
> @@ -429,6 +431,20 @@ int tee_client_open_session(struct tee_context *ctx,
>   */
>  int tee_client_close_session(struct tee_context *ctx, u32 session);
>
> +/**
> + * tee_client_system_session() - Declare session as a system session
> + * @ctx:       TEE Context
> + * @session:   Session id
> + *
> + * This function requests TEE to provision an entry context ready to use for
> + * that session only. The provisioned entry context is used for command
> + * invocation and session closure, not for command cancelling requests.
> + * TEE releases the provisioned context upon session closure.
> + *
> + * Return < 0 on error else 0 if an entry context has been provisioned.
> + */
> +int tee_client_system_session(struct tee_context *ctx, u32 session);
> +
>  /**
>   * tee_client_invoke_func() - Invoke a function in a Trusted Application
>   * @ctx:       TEE Context
> --
> 2.25.1
>
