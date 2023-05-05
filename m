Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA96F7DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjEEHay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjEEHar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:30:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2C17FC6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:30:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so14251515e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683271840; x=1685863840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttzbup9NrLAqf5VRgfV11m9AJvPpzl1o7U2c5sJYuUM=;
        b=obeURiwMzSfEfMcqsk2U3BoIAd+lNjwPW8Su0WTwXWe8V59YyZqnIWIfMHOUG77AmL
         nyBDb2L+p9ClnnOb6EBDPTbw12kOz2jMMat1pY8CJulTi8AMMHyxE9sdzVBsffoUieBV
         tWHuee/+wGYjWpWyctPFEaygGPihCAQfRqtMAgAN3blqVc17Otz085aX9ALTNOHL74Uo
         x5KVfJbWcxXCG88HQWYPIE94MUtXrfOueoMWvdTSiJfF8BUuFSXgvjTLbKZAQaI6f5Y8
         iaGS/5aJeLNW310zDorBxXed6vaivqpYqDd5mY6nD2s7RuC1ef7kwsMKHXrHSc2Edmoy
         Tuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683271840; x=1685863840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttzbup9NrLAqf5VRgfV11m9AJvPpzl1o7U2c5sJYuUM=;
        b=Vt0S5HGoGdfK33f7D4OqBYFgh4wnujaG4jvYAGRtY2uBL2k2WI5lDXlnjHYip4ljB3
         Jq7bC+XpBUu8qiWkvFX8mUW9lMHybKMZKJKO7MD2uyca31w9tqBGbHx/zG50tLMmSwuP
         +YhUHQ0bo0u9Dj32fcDJ1CZJZJ1ldZWnRQ9suOi2qW6TMpLJeHkxkwsfxjdQ6lA0TYzF
         Skxcxaqfo+2xCv5R8uOIRhkiEZ7eNgiM8DFA4+oBpqaG4ZAyPo9Vh8zzJsrmyFaua8an
         VGeRHR7YMOIc5heaHPMzZyAgilEoyWlzShVdeLhV9aFM9uBM8XZOSkzxntpgTz4C5DyL
         4TNw==
X-Gm-Message-State: AC+VfDxsDg3OIvUec1y+PfVH7vItXxQaa+8xJCBhIAxWufB3INjMpKEj
        oznIkwrCAurP7HL2lmWZL5tW1pYkI5MtQqEnmDAzfg==
X-Google-Smtp-Source: ACHHUZ7wi3ql6LFKIE0hgLVVZnNoOzdJu+oPbNztv1KpNhL6c4/ThMshNMXbsHJ1+Q/ujEUtGcc0jHd5l7GwIubpXbM=
X-Received: by 2002:a5d:42c9:0:b0:306:2d45:a8e0 with SMTP id
 t9-20020a5d42c9000000b003062d45a8e0mr722047wrr.15.1683271839652; Fri, 05 May
 2023 00:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <6a25613e87158947b4d102be4859f406edcb3f0b.1683008188.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <6a25613e87158947b4d102be4859f406edcb3f0b.1683008188.git.Rijo-john.Thomas@amd.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 5 May 2023 09:30:28 +0200
Message-ID: <CAHUa44Gm5jmm=mEfowcmabaoWFFbCLiDd5NdPSArCPHsjcpOBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 2, 2023 at 8:25=E2=80=AFAM Rijo Thomas <Rijo-john.Thomas@amd.co=
m> wrote:
>
> After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
> value in 'return_origin' argument passed by open_session() call. To do
> so, add 'return_origin' field to the structure tee_cmd_load_ta. The
> Trusted OS shall update return_origin as part of TEE processing.
>
> This change to 'struct tee_cmd_load_ta' interface requires a similar upda=
te
> in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.

This is an ABI change, but it's not clear if it's an incompatible ABI
change or not. What happens if the AMD-TEE Trusted OS isn't updated?

>
> This patch has been verified on Phoenix Birman setup. On older APUs,
> return_origin value will be 0.

Why, because MD-TEE Trusted OS will not be updated on the older APUs?

>
> Cc: stable@vger.kernel.org

Which stable kernels are you targeting? A Fixes tag might answer that.

Thanks,
Jens

> Tested-by: Sourabh Das <sourabh.das@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
>  drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_i=
f.h
> index ff48c3e47375..e2014e21530a 100644
> --- a/drivers/tee/amdtee/amdtee_if.h
> +++ b/drivers/tee/amdtee/amdtee_if.h
> @@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
>
>  /**
>   * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TE=
E
> - * @low_addr:    [in] bits [31:0] of the physical address of the TA bina=
ry
> - * @hi_addr:     [in] bits [63:32] of the physical address of the TA bin=
ary
> - * @size:        [in] size of TA binary in bytes
> - * @ta_handle:   [out] return handle of the loaded TA
> + * @low_addr:       [in] bits [31:0] of the physical address of the TA b=
inary
> + * @hi_addr:        [in] bits [63:32] of the physical address of the TA =
binary
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
> @@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee=
_ioctl_open_session_arg *arg)
>         if (ret) {
>                 arg->ret_origin =3D TEEC_ORIGIN_COMMS;
>                 arg->ret =3D TEEC_ERROR_COMMUNICATION;
> -       } else if (arg->ret =3D=3D TEEC_SUCCESS) {
> -               ret =3D get_ta_refcount(load_cmd.ta_handle);
> -               if (!ret) {
> -                       arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> -
> -                       /* Unload the TA on error */
> -                       unload_cmd.ta_handle =3D load_cmd.ta_handle;
> -                       psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> -                                           (void *)&unload_cmd,
> -                                           sizeof(unload_cmd), &ret);
> -               } else {
> -                       set_session_id(load_cmd.ta_handle, 0, &arg->sessi=
on);
> +       } else {
> +               arg->ret_origin =3D load_cmd.return_origin;
> +
> +               if (arg->ret =3D=3D TEEC_SUCCESS) {
> +                       ret =3D get_ta_refcount(load_cmd.ta_handle);
> +                       if (!ret) {
> +                               arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> +                               arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> +
> +                               /* Unload the TA on error */
> +                               unload_cmd.ta_handle =3D load_cmd.ta_hand=
le;
> +                               psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> +                                                   (void *)&unload_cmd,
> +                                                   sizeof(unload_cmd), &=
ret);
> +                       } else {
> +                               set_session_id(load_cmd.ta_handle, 0, &ar=
g->session);
> +                       }
>                 }
>         }
>         mutex_unlock(&ta_refcount_mutex);
> --
> 2.25.1
>
