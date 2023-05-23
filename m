Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2C70E139
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbjEWP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbjEWP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:58:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6FE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:58:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af6f309613so1896697a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684857485; x=1687449485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFvK2YI/SbwYaKr7Laqhu7qjWnMsgbqf1UfbCGjE36A=;
        b=hA7H5Y4Uy0DlU+6tVXmlOjXIaAE+kzcbckW+uLeM5cTkq4lkSIyH5kSJwgnQ5VpErz
         /iouIKIQJEn4Kgcdn4V56BJbegiUFnlI3zE3XyzBZ7MpqX59ModviJ8I+pFxG89n8E9r
         aSZri1UHfi3gAUHoNpC3Ty2Ricv5rvtOrBNxipJf24Ycw+CGwHZDl2cPwvmxhAahjaNd
         pg0ptOe8RYOiBxUZiwxuCnlZccrNJ2oL80DR52X13d5Hlb1ym1kHr9BWNnIeXJ7VwCsF
         /rjXzj7IPSQtqx/feRTbUXy+wjl6mhFjKYmrX63IPqXngcATyLAvjX94UurAQnmcd56k
         8V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857485; x=1687449485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFvK2YI/SbwYaKr7Laqhu7qjWnMsgbqf1UfbCGjE36A=;
        b=KzJwD2Xstw7ZOEjfCbNrENOKs3iKmo+nh6pamf/ZNh/Son0tEnaJk/NgATx4Jcyi0f
         WyNE5mAuoo1oyuF4sL3RtiDRHSjrUF/zTFRXBiH+TDgkGiMkbLVt6bVaDLIbuj1x4Ldl
         giQx87XbNOzN0XyDdUgQtn3Sl4ZErAcV4F/4m/YVmk9SnLP50h2J2djTdC/74b/cKQt5
         90+2WlX3697DxrOd8Ti8Wz4UbxiTe34DmVrQCvGVskAuMvSYH9iFJTPqgIalrGFDXtyV
         uLaalxz0yfFJsaSJnsoMWGTylZhBM+rUVbnxZvsUJyiogVMjrBaTVW0/p+26S8zIkK4f
         +Vww==
X-Gm-Message-State: AC+VfDx6prO9LcjTMmgZZTn3wMVIhj3Sp5SyTDBRVYzw/bebnzDcnEHg
        POJHa9zCWhe4awJCb8GbQ9ZNUTkMgecCHYDlhBEOiE4s
X-Google-Smtp-Source: ACHHUZ4AHxuecDwpGGY0Y5cC98Kt8hS8/f6vC/Te2pco6rpqdVK3DQDOmabHqkqRyIjIUm3H5nOyovYmTshHVUQjwpg=
X-Received: by 2002:aca:3356:0:b0:395:e376:7ca1 with SMTP id
 z83-20020aca3356000000b00395e3767ca1mr8819792oiz.7.1684857484855; Tue, 23 May
 2023 08:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230523033202.109828-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230523033202.109828-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 May 2023 11:57:53 -0400
Message-ID: <CADnq5_Ojwdsy9k=R_o1bDsDt4LZyU0QJkW9qaky-3SKd0bXKvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: Modify mismatched function name
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
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

Alex

On Mon, May 22, 2023 at 11:32=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:374: warning: expecting prototype=
 for vcn_v4_0_mc_resume_dpg_mode(). Prototype was for vcn_v4_0_3_mc_resume_=
dpg_mode() instead.
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:631: warning: expecting prototype=
 for vcn_v4_0_enable_clock_gating(). Prototype was for vcn_v4_0_3_enable_cl=
ock_gating() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5284
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 339842382a1e..5d67b8b8a3d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -362,7 +362,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device=
 *adev, int inst_idx)
>  }
>
>  /**
> - * vcn_v4_0_mc_resume_dpg_mode - memory controller programming for dpg m=
ode
> + * vcn_v4_0_3_mc_resume_dpg_mode - memory controller programming for dpg=
 mode
>   *
>   * @adev: amdgpu_device pointer
>   * @inst_idx: instance number index
> @@ -620,7 +620,7 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(=
struct amdgpu_device *adev,
>  }
>
>  /**
> - * vcn_v4_0_enable_clock_gating - enable VCN clock gating
> + * vcn_v4_0_3_enable_clock_gating - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
>   * @inst_idx: instance number
> --
> 2.20.1.7.g153144c
>
