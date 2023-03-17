Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269106BF268
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCQU1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCQU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:27:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B17AA0284;
        Fri, 17 Mar 2023 13:27:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bg11so4699963oib.5;
        Fri, 17 Mar 2023 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba1T52G1S948o7T3Sv1JQdxUM0FGCuF6VR8R5Mn80os=;
        b=e5hycfXZJoahdd+EK2xsTNQpEheR1OaVRQ2wD6fTlb/tYwRqaK5PjxVNd2daMEJkIO
         BoXetfGiJLB6y6/krTD6mAKCvtObcv7WfzAO2r5K9a6JMbXjD0sT/vIhM0Y7a++WzQMo
         93o0pzgjrW+ffCHTUUclRJNrW9dkwSfOYuDEzAhTTwREnGRMLKuizTANO/1k7CGf4WBm
         kMbD/KtlI9cj7a7TQeD9D9Bh5nz/X4sso6fprKCGWUMeQlG3YG3hP29q4vjl3pR90q/7
         9NM4S0cDnoJFrTmloDK6+hj7tDvQ/UC9LmKLZRmK1n8LLEMy+Sop3ue/W+7Tln+2u1JT
         TPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba1T52G1S948o7T3Sv1JQdxUM0FGCuF6VR8R5Mn80os=;
        b=S9qpxH7J8b8Z6/KuFsrQufew8UD5o0zoUeVZeXWN58UKzU0SdVg0K+2Sgb7gU6s9q9
         c0KxFSYyFddAuwgMFXknhNVHa8yBGpfZLy3rSfZTVxxqk3nU7kFWGGQiMrRXAzY9OiNl
         zuGN7TblDEOUlattdMQD4m3kkp8W6s7ZBvdGf69xTGmGkw8KwUpPlgWAJQnBRB/yPNE4
         KUGAt5ovVfDchzwOzuG2D5Yey/3tuId93G2XlooxrUqeISpZuMtrp1BS2YUJXRirGAwI
         QwgrcJsP9zKegf1T1ObJKVEqjMsDzHTCfTI0JjswP+y3RuNfU2w86yiX7TgBv9Eg4+mt
         wVkA==
X-Gm-Message-State: AO0yUKWM7ZfsEMjnnzr3awXDn22VrAQmnCTHOE4KIars5vXrRnB/n6mp
        UyzATXk2DCAxcd7sHAW/g0NIMgCO9cAue1yYEnI=
X-Google-Smtp-Source: AK7set8/mMOeRQfI0SzS7VmayrF+lkziaBf2mSmKHYCfX8qAH2GPW32TprON+LtUX5ehQJAw/2SL7eWbeq0Hx8m8+Z0=
X-Received: by 2002:a05:6808:9a7:b0:386:d34c:16fe with SMTP id
 e7-20020a05680809a700b00386d34c16femr969451oig.3.1679084869443; Fri, 17 Mar
 2023 13:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-19-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-19-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:27:36 -0400
Message-ID: <CADnq5_Piyr=XPu3OvPAE6YUhT1gcuUFJYkxgf=0YZbVr1fKDHA@mail.gmail.com>
Subject: Re: [PATCH 18/37] drm/amd/amdgpu/amdgpu_vce: Provide description for
 amdgpu_vce_validate_bo()'s 'p' param
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

Applied with minor modification.  Thanks!

Alex

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:599: warning: Function parameter=
 or member 'p' not described in 'amdgpu_vce_validate_bo'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 2fb61410b1c02..c4d65ade5c00a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -585,6 +585,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_r=
ing *ring, uint32_t handle,
>  /**
>   * amdgpu_vce_validate_bo - make sure not to cross 4GB boundary
>   *
> + * @p: parser context
>   * @ib: indirect buffer to use
>   * @lo: address of lower dword
>   * @hi: address of higher dword
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
