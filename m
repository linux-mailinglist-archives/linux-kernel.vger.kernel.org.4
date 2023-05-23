Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEE70E131
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbjEWP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbjEWP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:57:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD818E;
        Tue, 23 May 2023 08:57:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38dec65ab50so4297229b6e.2;
        Tue, 23 May 2023 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684857434; x=1687449434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRQKQx8o7pYZMBO/dPIhBa/weTc59LxA8RBQRRvbAww=;
        b=nIEgy4xsmB+3hYy0CDH3MPkPWE5BrLDU5tN7cSIz3IzgJBvUH63E7oD9+J8dFGHW9L
         FBZbFIgKNh8FcUIK+6hwQfqH84IMyWxuYNPVjHn+W1EB9utNHces2xfBTPye8n7jt8Tq
         0M8B3LQCzG2nX5FKJV/Tgx3TrxVg+uNFPJ6ZBLP0xSSdPeXhuv+JU9S7B+REPf7DKtFJ
         KEvlWJocc0Ml50bYDpWW+Qn4erdWJqgeHE9UPd/j4CCJUhgFIZzzEVhqh5p3fCV+rOIV
         uwSe4xyITKa9BhftK4hXho1frTE+zqE820is8Ci3xzkG9ZEEVVaL4jV5XuDAqCDQDU5x
         kxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857434; x=1687449434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRQKQx8o7pYZMBO/dPIhBa/weTc59LxA8RBQRRvbAww=;
        b=DdddIgC0CgC0ti5zaJDZ6/9dZKFEwVEuWvmCJG/zNQV97v49RZBvrgH9TZh8jncW9R
         aABbJ092jtcAt7iffn/qfPMn9Zx2hJJBFJ1VZCcFZJTwXV8rbFMPKR0D/Z/4wbYK++1V
         /F/igp3cZCZy2aAMCusrMChyAWg9qQ7K6A/6PLGcDONifN48XBhqXXXJkbiuAZOP6u3K
         zETTDNfe6mUTom1XOHfFK7x961qJHZ1jKAeKoQAS/wysEZ8DmXfpVHDDFBHX8Q/VkFz7
         dIINP/OoVcDlHapQW/ccY9l6A/8LtZcu8xHpbwixcGrqbFvK/qZFUL4pPnlMyle+HbFj
         +FcQ==
X-Gm-Message-State: AC+VfDzIOGVQlxA3n6QE3a0JtmAMlL0nfci32L2VqsiPHBGchLd+rxSi
        IivZ03J+xX7fvUWHgPwV+cWXVBx8s00EGQ1DZoI=
X-Google-Smtp-Source: ACHHUZ7DHxeQXuGbDyGY66H9cdMMYdFh6mTJpvChsFzqktlYAXoSFaO4ugdpNPumCfSnl1H7T26HF1Xrnt8cWO29BAg=
X-Received: by 2002:a05:6808:6393:b0:398:af5:a18a with SMTP id
 ec19-20020a056808639300b003980af5a18amr3200495oib.59.1684857434503; Tue, 23
 May 2023 08:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230523031709.19673-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230523031709.19673-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 May 2023 11:57:03 -0400
Message-ID: <CADnq5_NKuq8ZO0mBMmogwTesr1gWa=aXO9BJFp0bnfWhYj7X7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Modify mismatched function name
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, linaro-mm-sig@lists.linaro.org,
        llvm@lists.linux.dev, trix@redhat.com, Xinhui.Pan@amd.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, sumit.semwal@linaro.org,
        nathan@kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, May 22, 2023 at 11:17=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:426: warning: expecting prototyp=
e for sdma_v4_4_2_gfx_stop(). Prototype was for sdma_v4_4_2_inst_gfx_stop()=
 instead.
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:457: warning: expecting prototyp=
e for sdma_v4_4_2_rlc_stop(). Prototype was for sdma_v4_4_2_inst_rlc_stop()=
 instead.
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:470: warning: expecting prototyp=
e for sdma_v4_4_2_page_stop(). Prototype was for sdma_v4_4_2_inst_page_stop=
() instead.
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:506: warning: expecting prototyp=
e for sdma_v4_4_2_ctx_switch_enable(). Prototype was for sdma_v4_4_2_inst_c=
tx_switch_enable() instead.
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:561: warning: expecting prototyp=
e for sdma_v4_4_2_enable(). Prototype was for sdma_v4_4_2_inst_enable() ins=
tead.
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:798: warning: expecting prototyp=
e for sdma_v4_4_2_rlc_resume(). Prototype was for sdma_v4_4_2_inst_rlc_resu=
me() instead.
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:814: warning: expecting prototyp=
e for sdma_v4_4_2_load_microcode(). Prototype was for sdma_v4_4_2_inst_load=
_microcode() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5283
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index bf47eb33c12e..590b08585901 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -415,7 +415,7 @@ static void sdma_v4_4_2_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr, u64
>
>
>  /**
> - * sdma_v4_4_2_gfx_stop - stop the gfx async dma engines
> + * sdma_v4_4_2_inst_gfx_stop - stop the gfx async dma engines
>   *
>   * @adev: amdgpu_device pointer
>   *
> @@ -446,7 +446,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_d=
evice *adev,
>  }
>
>  /**
> - * sdma_v4_4_2_rlc_stop - stop the compute async dma engines
> + * sdma_v4_4_2_inst_rlc_stop - stop the compute async dma engines
>   *
>   * @adev: amdgpu_device pointer
>   *
> @@ -459,7 +459,7 @@ static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_d=
evice *adev,
>  }
>
>  /**
> - * sdma_v4_4_2_page_stop - stop the page async dma engines
> + * sdma_v4_4_2_inst_page_stop - stop the page async dma engines
>   *
>   * @adev: amdgpu_device pointer
>   *
> @@ -494,7 +494,7 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_=
device *adev,
>  }
>
>  /**
> - * sdma_v4_4_2_ctx_switch_enable - stop the async dma engines context sw=
itch
> + * sdma_v4_4_2_inst_ctx_switch_enable - stop the async dma engines conte=
xt switch
>   *
>   * @adev: amdgpu_device pointer
>   * @enable: enable/disable the DMA MEs context switch.
> @@ -548,7 +548,7 @@ static void sdma_v4_4_2_inst_ctx_switch_enable(struct=
 amdgpu_device *adev,
>  }
>
>  /**
> - * sdma_v4_4_2_enable - stop the async dma engines
> + * sdma_v4_4_2_inst_enable - stop the async dma engines
>   *
>   * @adev: amdgpu_device pointer
>   * @enable: enable/disable the DMA MEs.
> @@ -786,7 +786,7 @@ static void sdma_v4_4_2_init_pg(struct amdgpu_device =
*adev)
>  }
>
>  /**
> - * sdma_v4_4_2_rlc_resume - setup and start the async dma engines
> + * sdma_v4_4_2_inst_rlc_resume - setup and start the async dma engines
>   *
>   * @adev: amdgpu_device pointer
>   *
> @@ -802,7 +802,7 @@ static int sdma_v4_4_2_inst_rlc_resume(struct amdgpu_=
device *adev,
>  }
>
>  /**
> - * sdma_v4_4_2_load_microcode - load the sDMA ME ucode
> + * sdma_v4_4_2_inst_load_microcode - load the sDMA ME ucode
>   *
>   * @adev: amdgpu_device pointer
>   *
> --
> 2.20.1.7.g153144c
>
