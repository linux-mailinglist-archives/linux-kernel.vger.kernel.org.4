Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D067D6BF23A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCQUQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCQUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:16:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4B3800A;
        Fri, 17 Mar 2023 13:16:50 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17786581fe1so6906938fac.10;
        Fri, 17 Mar 2023 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU4zAnrBSArmTn9XkYtMm4tlOOONjI66zlgaRxaRc2U=;
        b=h+Tg1fUeV3dUAxs/Bi8Ma5z5YKbULT93DkXk4MknB11o0s7K7bUtw7WwiTCGmzLO1N
         9rtPg85SUNu6+lcO2OTXDMyZdS5dM2epOg0pdSBBlejUGWWO403qdX2irSX+8WFDmqzG
         JGg+oyLM7HV8qGS6befsvU6P3GFyAlGjfWPaxg9+V/grsoPbxH5SCNX7Ev59ArGj9VWr
         4H06WZ66Id9hZ7xfDH0cjguCzaZEQcN5hMcR1HA0cxm1Ow/vl6aSXI3cVLrCUQJi3StQ
         SJE9RcSZR0gsqMA9i7j7Qe/a7+BsWrW1bfQpj66JJlHsHeHLkdYAPihwIzXNKEIkql4c
         Zgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU4zAnrBSArmTn9XkYtMm4tlOOONjI66zlgaRxaRc2U=;
        b=sEXVHSYIrhubNiYAOnDF33xIzGBP5Kb/H+Ku0zQ3jZ2m3+5f4a3+zAod8zv2FsBvYr
         6w18SkxbUt+zX/BXZVMDEOXBleMkfnTNhCEzIKDQhazFrUlxxhRlghd7Jrcj6xFhAyai
         di0diKuOUnSxfTt1X5LGfsYSW2qHAvBdrBxVPggptR07N5sbAuJvANr+5Oa+WFMR9F8Z
         LfYAHS3IYod8xYWpVa96HsykBqyVyOqFBa1ycRL45CeJaL4ke/g/e62l3N9Wlm2TeRAT
         TjVw+6Gz2heYPMPpWSzqnmvLRUqmidH59s+Fn5FZ7peAIEiVdAou7xna5vWhGwYTLz8b
         mOFg==
X-Gm-Message-State: AO0yUKW/pgAFBvkWp0PxWMhQ36tRKBtgB2hq6hS7LZJS32Mmc2f5Oaor
        sJRwsK0g3pKw7E0Ot/vOTsfWKfIACUTz54T3199/kftG
X-Google-Smtp-Source: AK7set+hgyDIxODQ1HpKvvctXRdJYouhJjfOaV7GujAUKXtOOfVz7wx7IEd/zYgoBBSWvGbON6Dc74JDF6R5s/Xnr+M=
X-Received: by 2002:a05:6870:1099:b0:17c:29d8:61ee with SMTP id
 25-20020a056870109900b0017c29d861eemr1596oaq.3.1679084208509; Fri, 17 Mar
 2023 13:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-4-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-4-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:16:37 -0400
Message-ID: <CADnq5_PV2O3txzF7a2J4XYM6DWDPNqXWbBdJW8hi9ShS7L8EtA@mail.gmail.com>
Subject: Re: [PATCH 03/37] drm/amd/amdgpu/amdgpu_device: Provide missing
 kerneldoc entry for 'reset_context'
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Mar 17, 2023 at 4:22=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5152:
>    warning: Function parameter or member 'reset_context' not described in=
 'amdgpu_device_gpu_recover'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d4519fbd526f2..ef0b2787796da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5145,6 +5145,7 @@ static inline void amdgpu_device_stop_pending_reset=
s(struct amdgpu_device *adev)
>   *
>   * @adev: amdgpu_device pointer
>   * @job: which job trigger hang
> + * @reset_context: amdgpu reset context pointer
>   *
>   * Attempt to reset the GPU if it has hung (all asics).
>   * Attempt to do soft-reset or full-reset and reinitialize Asic
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
