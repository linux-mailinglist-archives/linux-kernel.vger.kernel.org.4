Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781B56BF25A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCQUXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCQUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:23:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC24D2AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:23:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bj30so4685040oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPeNQSs2ItWGIsCHdX7Ugj2NVfLobu8XDfoPlATYzgs=;
        b=mDdjHCSVr++s/eQK+Jq0bYlbFXC5oczx+qcfvDkcnhjaGekCwD9TrkxzwggrQLoIf5
         V9fd8pD++Sd0E6aI13d9qZuPoDv/02BUVRB/gr7ZmVCKwHJkrneQm6BOgRf7czeFErxD
         J2uVJkH+DZGyLMnFgHeoK3zKqthYdcTKGbW/shCNgvG+91lhPDgndyA+xuTtYtWjPDFa
         vRK3NwRKQxMFxuirKTRmtVr/HOF4A1uim1Ilr6XogZdeqV5cDC+MKQcMpZnUWtd5QGbi
         dcHY1enstU3fbox9ZXOPndO4FmoKeUvXl0T/+Qin/jKVHclaeEwNjhjKceXa2rhwL3o5
         2D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPeNQSs2ItWGIsCHdX7Ugj2NVfLobu8XDfoPlATYzgs=;
        b=Zwyah0EBHz6MhZU3f9hC4NqrzyC0D5Fq4KccRXEZQVj40rlXLMfgAN5SyXmFdYOcCU
         7GHVSsg2ykIPa1gkOHLng6wQsLNt/QZk9bCgEIRrTMY5jMKa5diR0Rn7BiNirIyle9LT
         5RboOo62KZGMIgNkM+NLVRDFKrlKSdQUZYflhqtbesJPzHW6XlNgvTA5Hbhu24Hx7cH/
         GOmaSDUnoc+u2u/s/AcoudhbmhbGO5RIVNt0if8C1YjqJmeQpTIZAmutR7xNZmyfbe9+
         a0ptl+CFBxYQ2xsBTJAI2TWtRhXURUNZrH9u2aeyseMo23l+UpUkH5H483/ARak/ILRl
         lxdA==
X-Gm-Message-State: AO0yUKW3hAEe8EhVOIHzLE9dcLpdS/6ut81q87E8Udsu5VKQ1/ZeqOzp
        PhGzLmQ8OaII/alpyywdtIBpTkzK+z20Z1o/Gd4=
X-Google-Smtp-Source: AK7set8KBw4gi6U1rhE0sOeJ7AJ+L7QYd4rhRrr5yEZopo/hyaziXVNE56KhBTazVarqxhghVvBYYH+p9AIHxy65DWU=
X-Received: by 2002:a05:6808:6384:b0:386:9c6c:ebc with SMTP id
 ec4-20020a056808638400b003869c6c0ebcmr3713144oib.3.1679084599294; Fri, 17 Mar
 2023 13:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-17-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-17-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:23:07 -0400
Message-ID: <CADnq5_McaONYTi6XOGi3wO-ObXhTZvMJ7Gor+0MM3NcwR1ES2A@mail.gmail.com>
Subject: Re: [PATCH 16/37] drm/amd/amdgpu/ih_v6_0: Repair misspelling and
 provide descriptions for 'ih'
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c:392: warning: Function parameter or=
 member 'ih' not described in 'ih_v6_0_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c:432: warning: Function parameter or=
 member 'ih' not described in 'ih_v6_0_irq_rearm'
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c:458: warning: Function parameter or=
 member 'ih' not described in 'ih_v6_0_set_rptr'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index 7cd79a3844b24..b02e1cef78a76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -119,7 +119,7 @@ force_update_wptr_for_self_int(struct amdgpu_device *=
adev,
>   * ih_v6_0_toggle_ring_interrupts - toggle the interrupt ring buffer
>   *
>   * @adev: amdgpu_device pointer
> - * @ih: amdgpu_ih_ring pointet
> + * @ih: amdgpu_ih_ring pointer
>   * @enable: true - enable the interrupts, false - disable the interrupts
>   *
>   * Toggle the interrupt ring buffer (IH_V6_0)
> @@ -381,6 +381,7 @@ static void ih_v6_0_irq_disable(struct amdgpu_device =
*adev)
>   * ih_v6_0_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer.  Also check for
> @@ -425,6 +426,7 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *ade=
v,
>   * ih_v6_0_irq_rearm - rearm IRQ if lost
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
>   *
>   */
>  static void ih_v6_0_irq_rearm(struct amdgpu_device *adev,
> @@ -450,6 +452,7 @@ static void ih_v6_0_irq_rearm(struct amdgpu_device *a=
dev,
>   * ih_v6_0_set_rptr - set the IH ring buffer rptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
>   *
>   * Set the IH ring buffer rptr.
>   */
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
