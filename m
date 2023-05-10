Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9E6FDC80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjEJLTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:19:16 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA4AB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:19:15 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-77d53b41485so1866185241.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683717554; x=1686309554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0rxn7yjUQBL3cbcVPmdIqJT/Pb8kMk5CCwtWmgzh5c=;
        b=gGqU+U+0OJG/fkRdxOh9RaAefuV6RVWSQScJXxuxLYgThpPvP95h68E+QEk1dJ64FW
         n//JhnuqL9lSEcMEwHrFczFlESBIZMSl6w69UUBflwtKPlvgXtkglNkIz+3JnZsOA1SS
         3QIotbeQ56VF+GycqtE6QkSUa7hiqXpJTrgXZHLnX8ffXdkdJ82tJEfp6fYFkWx5JsSw
         AblCJLzoW9SOBFK00Ai29gX1O8XIr/5s4RUfFL/r5gTGYQXmh29ABbJMVmsxUjNqlKih
         oqYLMhXuqe5emM5F5fwmpqa66weJKBBDAh1ZUOZdC0m3i+ZYb4O+e/+ZK5+6l7Cl3ZuN
         ky+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683717554; x=1686309554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0rxn7yjUQBL3cbcVPmdIqJT/Pb8kMk5CCwtWmgzh5c=;
        b=QDBOnPakae7CKahEsnhvdtjR4nIN1d7W7Lua/0vfF+2rvKNFesIVkxo3KGRaw7gjIK
         cNN54b78TQ2AaDsCYSttTDV6GJAuMb0K9X9e3Vwvs+D7xLg2nA9DQW2M3EAsFDN178Jp
         p0SHfnXR3+G5nyUoHMPTSoYgiyHk5zYHI/gmPCaoiBNe+ZHzlZxZ465i5L4KPAS6+s+S
         KVYT/UCicwff38rF9jdPfDT432819dKwQM4KDa/LLXhqNtOEm3/ypt1rNeFc3GncUvha
         DNUQ8cKvrAHeOqyrEU0jEFvs9MkYFURuM/8RGeTaUKZMxNIPlCYSyETLVtrfWCTnabyZ
         elCg==
X-Gm-Message-State: AC+VfDwB2A5dN5fycNpoQHjrwy2PtTZIS3opnFi1CfebopI92HuWlMYh
        vcVs+7wOcbRadaJJjosAA9a9xHEE/wX+ihKgBfE/Pg==
X-Google-Smtp-Source: ACHHUZ6iEVbwGClp2RRNrPQESKr7qZwT74Mw9gt4GtOHFJBuV+LEa/nYOE/OFnUQ83brUfbou7aA+b0XMWkxtRdzJpo=
X-Received: by 2002:a67:eb53:0:b0:434:66e3:74b4 with SMTP id
 x19-20020a67eb53000000b0043466e374b4mr5605280vso.8.1683717554117; Wed, 10 May
 2023 04:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <a52cd6075f806eed82d577a6d437c705c7f36a26.1683617412.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <a52cd6075f806eed82d577a6d437c705c7f36a26.1683617412.git.Rijo-john.Thomas@amd.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 May 2023 16:49:03 +0530
Message-ID: <CAFA6WYNOjkU_4Kg=khuki3qv95f+bUB5hJUjRy2CoPXDvqW0Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Dabros <jsd@semihalf.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        stable@vger.kernel.org, Sourabh Das <sourabh.das@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>
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

On Tue, 9 May 2023 at 13:03, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
> value in 'return_origin' argument passed by open_session() call. To do
> so, add 'return_origin' field to the structure tee_cmd_load_ta. The
> Trusted OS shall update return_origin as part of TEE processing.
>
> This change to 'struct tee_cmd_load_ta' interface requires a similar update
> in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.
>
> This patch has been verified on Phoenix Birman setup. On older APUs,
> return_origin value will be 0.
>
> Cc: stable@vger.kernel.org
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Tested-by: Sourabh Das <sourabh.das@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
> v2:
>  * Added Fixes tag.
>
>  drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
>  drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 17 deletions(-)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
> index ff48c3e47375..e2014e21530a 100644
> --- a/drivers/tee/amdtee/amdtee_if.h
> +++ b/drivers/tee/amdtee/amdtee_if.h
> @@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
>
>  /**
>   * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
> - * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
> - * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
> - * @size:        [in] size of TA binary in bytes
> - * @ta_handle:   [out] return handle of the loaded TA
> + * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
> + * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
> + * @size:           [in] size of TA binary in bytes
> + * @ta_handle:      [out] return handle of the loaded TA
> + * @return_origin:  [out] origin of return code after TEE processing
>   */
>  struct tee_cmd_load_ta {
>         u32 low_addr;
>         u32 hi_addr;
>         u32 size;
>         u32 ta_handle;
> +       u32 return_origin;
>  };
>
>  /**
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index e8cd9aaa3467..e9b63dcb3194 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>         if (ret) {
>                 arg->ret_origin = TEEC_ORIGIN_COMMS;
>                 arg->ret = TEEC_ERROR_COMMUNICATION;
> -       } else if (arg->ret == TEEC_SUCCESS) {
> -               ret = get_ta_refcount(load_cmd.ta_handle);
> -               if (!ret) {
> -                       arg->ret_origin = TEEC_ORIGIN_COMMS;
> -                       arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> -
> -                       /* Unload the TA on error */
> -                       unload_cmd.ta_handle = load_cmd.ta_handle;
> -                       psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> -                                           (void *)&unload_cmd,
> -                                           sizeof(unload_cmd), &ret);
> -               } else {
> -                       set_session_id(load_cmd.ta_handle, 0, &arg->session);
> +       } else {
> +               arg->ret_origin = load_cmd.return_origin;
> +
> +               if (arg->ret == TEEC_SUCCESS) {
> +                       ret = get_ta_refcount(load_cmd.ta_handle);
> +                       if (!ret) {
> +                               arg->ret_origin = TEEC_ORIGIN_COMMS;
> +                               arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> +
> +                               /* Unload the TA on error */
> +                               unload_cmd.ta_handle = load_cmd.ta_handle;
> +                               psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> +                                                   (void *)&unload_cmd,
> +                                                   sizeof(unload_cmd), &ret);
> +                       } else {
> +                               set_session_id(load_cmd.ta_handle, 0, &arg->session);
> +                       }
>                 }
>         }
>         mutex_unlock(&ta_refcount_mutex);
> --
> 2.25.1
>
