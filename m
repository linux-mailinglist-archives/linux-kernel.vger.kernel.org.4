Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E6667F74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbjALToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjALTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:43:47 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F258F10073
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:33:49 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id h185so16113678oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aypgsOMzmGEhnMGY/eHKs1+jahN6svk47TXr3cbBLDY=;
        b=XJIfIuVyF+2IeoN8v3sm8ShKWmRSQhjtD/VSFe40yy9oq/Bd/3BrFL/EiH/ND/xLtv
         AoSNUskM/kLb/ByQl4tqDJ1BZT0ulle6DoHja4hqpFL9LBn0efdGnj9Zcpq56jHrl0E1
         Kz5tZ64Lcx2JRTrsUNQjkVSo6sYM95eqe0b1cpt/8qvFTUkN3GHYe63eOAVQWY/0b7rz
         3nOpFcdKPJpHdAnTunPdlNZs4yMBAO+6uROA2EF/4GEbWv37fh3qA4L8h+GzuGMUG1gO
         O+d+3F+8CBODT/B6OMZH+5ZDWX0UMV4/W83OcrbQUG0DQVpZwPzqPKHjAjbyWyZxj/VS
         gayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aypgsOMzmGEhnMGY/eHKs1+jahN6svk47TXr3cbBLDY=;
        b=EPZxdCYUluO+blnmah8FQ2RCFOLUVN283SSkEegOgYDKLWNvmRM/ZLE7AzsVe27SV/
         AKD3wH4Ev8Hz+QHv3cdTYj1bTn1FzYO+vSCj2LtlIsZJwvgBN/e/MSN2LeRWa6e49lpn
         CpvWxAdJ8Ffb1lzgGzz33Li+JjVMAwEnHcyaOBvs4kLoqWoG+cdnLdVInKF+CUMJFD8R
         YPoitM01bJ0MwyWBszhVrnbQJ6vfiO3XiE/vtRg+4ca/uLnOA8SGqij2gnCI2zbg95Bb
         AssXwbX1c8f2cL7B5ytlz3Vq28nKd9097+Cqo4V9FV32CL1B6uDqOasc+f0r5O+ZxMtZ
         DJOg==
X-Gm-Message-State: AFqh2kr9KON/yw49ogNlnwm+/5XgxvJwqW2rj43bcX5okA9EKtfx8IqA
        fm4knzgI62VJQ8Bb8Edx80AX69O3cTviKPPqR+k=
X-Google-Smtp-Source: AMrXdXtyJjc6vkU/EGsBHOqdS2kLFiSshjKvc0JLtfUFk6F0VTt7UUKvuL5X6VXwN3sLCNU5UUTi3xMRk9SAdlEVp+s=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr5306345oib.46.1673552029252; Thu, 12
 Jan 2023 11:33:49 -0800 (PST)
MIME-Version: 1.0
References: <Y8AQYhVkJjV86VXV@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y8AQYhVkJjV86VXV@ubun2204.myguest.virtualbox.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Jan 2023 14:33:37 -0500
Message-ID: <CADnq5_OttrDQ=nDQSg3OWj_aqwKSs1s3YpWRqnM1wmzJQ-F2RA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Conversion to bool not necessary
To:     Deepak R Varma <drv@mailo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jan 12, 2023 at 8:51 AM Deepak R Varma <drv@mailo.com> wrote:
>
> A logical evaluation already results in bool. There is no need for using
> a ternary operator based evaluation and bool conversion of the outcome.
> Issue identified using boolconv.cocci Coccinelle semantic patch.
> This was also reported by the Kernel Test Robot. Hence
>
> Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 22125daf9dcf..1e39d0939700 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -105,8 +105,7 @@ static void vblank_control_worker(struct work_struct *work)
>         else if (dm->active_vblank_irq_count)
>                 dm->active_vblank_irq_count--;
>
> -       dc_allow_idle_optimizations(
> -               dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
> +       dc_allow_idle_optimizations(dm->dc, dm->active_vblank_irq_count == 0);
>
>         DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
>
> --
> 2.34.1
>
>
>
