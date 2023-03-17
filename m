Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AD6BF256
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCQUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCQUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:22:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0468A24BC5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:22:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id be16so4723593oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu9FEPDbzyGLlECMc2aGYaFPIGLvzNJrO43JlAS13RQ=;
        b=ekA+YU0yAqC1U1gReZKCODIm18NQaGslCP4mC+ru3AHqIYEiCYlKMKFja6SsLFZxT3
         fh3lb+8+qdx4ik8gUCYlt+SOkuvVOHYBUCjGWbMW4jYmsYNCPc3CbQPdhyCGMX0m0/3h
         P2nxpgZYnCSlc5ymMZWIB6EX3ZbryqlkOaSoE+p3DRddHNJ8FNKunJ5vTn5fska/Z05M
         oa9J6P6GtJ1HQ/+8iWt62GY/re25iUnIYPHbj4u02cWqxowc6RC3r05lA5/6b6Ked8bs
         HgbQTua517CS8hDI14H75nUk0BuShCbeySFOpbKcyU+NhMlQSH3TRHitWCIuJerbxmqk
         ca/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu9FEPDbzyGLlECMc2aGYaFPIGLvzNJrO43JlAS13RQ=;
        b=paCB5/iHSG6ZvJyOzxqQ7SNGSkPvU9L53TmPHScyaR0cA8bxK36EtkwC4k/IrG/xdo
         n9xAbflhE9657O4wJLJUStmjsgas10e3tZTyEea8l2HFQwCwroqEPS0+ahXERvmgS/3I
         i3l8lUEIUVImuZBuhFgPFQZ6aaRrt0pQ/thruF7quqngeK9+CXkbs6RDdB9m83WgP5Yh
         WUDfB/l4x/+fH4D367zyOHwfFAK27h5Tl/cNy4GkutKXoVN+oAFegjG2evwfuiJuXnR8
         mC2WqstSUU8ZoAP45kRzRThufzspxOTPvQgYmXU/lIol3YrP246g/gPC0J+JXfEAhqO0
         UG3A==
X-Gm-Message-State: AO0yUKWx85ZRKM5/0uQxasG27ljZcycOoeOaymQZdoqLdE4tFT9RRPjd
        hwitXi8AvSUc1ZVTa02JgZDK0vw3H/9+4dSZkUs=
X-Google-Smtp-Source: AK7set+8FK0AR04WJhBPP7BsOsQys7+Jy2T4vWiqBjFA/tCxMnTIC2HZ6Z88h6kfzBcIZkHHy5KnhP4BFHmodIHRdu0=
X-Received: by 2002:a05:6808:2b0a:b0:384:893:a924 with SMTP id
 fe10-20020a0568082b0a00b003840893a924mr3612499oib.3.1679084547380; Fri, 17
 Mar 2023 13:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-16-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-16-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:22:15 -0400
Message-ID: <CADnq5_OF=Nkx6h2F-qqBajWcqn2AupHUu2GgJnx_NzuE3t0swg@mail.gmail.com>
Subject: Re: [PATCH 15/37] drm/amd/amdgpu/gmc_v11_0: Provide a few missing
 param descriptions relating to hubs and flushes
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Alex

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c:282: warning: Function parameter =
or member 'vmhub' not described in 'gmc_v11_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c:282: warning: Function parameter =
or member 'flush_type' not described in 'gmc_v11_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c:322: warning: Function parameter =
or member 'flush_type' not described in 'gmc_v11_0_flush_gpu_tlb_pasid'
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c:322: warning: Function parameter =
or member 'all_hub' not described in 'gmc_v11_0_flush_gpu_tlb_pasid'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index fad199ed15f38..9f4f28192c601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -274,6 +274,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>   *
>   * @adev: amdgpu_device pointer
>   * @vmid: vm instance to flush
> + * @vmhub: which hub to flush
> + * @flush_type: the flush type
>   *
>   * Flush the TLB for the requested page table.
>   */
> @@ -313,6 +315,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>   *
>   * @adev: amdgpu_device pointer
>   * @pasid: pasid to be flush
> + * @flush_type: the flush type
> + * @all_hub: flush all hubs
>   *
>   * Flush the TLB for the requested pasid.
>   */
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
