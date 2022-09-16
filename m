Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED25BB1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIPRdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:33:52 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1DB5A76;
        Fri, 16 Sep 2022 10:33:51 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t15-20020a4a96cf000000b0044e0142ec24so3631822ooi.8;
        Fri, 16 Sep 2022 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fBLKyH7CgKzdu0sdL+2+ttEv7QAignRvxC5/meELxsc=;
        b=PwGUHnprOKMd9ZV8gp1ze2jZNz9YdSVYMqWrvunEtodfENazUhrdo9tAjof2a2Vxgb
         iHTSSQ1yXzRw/pDCLSW4o31+PxpkknLNAjddJ/aHxtW3UH4Q9aRRT327eJA7jpCJkT3M
         35DnMdN0V/3DWivocuFfcxitD1Kua1e75Y4JnV+YaaGVEGzkaqsJksfOeLjgFX/Tej1i
         FlQEPK2POpGDawkmuTDvcUWm+gbr+n8WLsJ0dSF5cv43u2inQVCL1eSfPtBAAOXKNqTh
         Yw/W5unoQMnwTJVzSf2mx5ekedEyUMweHKM6MeYgRN/drZhGUOn4YuZ7/1NZmhcI3TDW
         VgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fBLKyH7CgKzdu0sdL+2+ttEv7QAignRvxC5/meELxsc=;
        b=frMyCc1sOZ2OjUJvHuTmG4wWQ9L4UOObJGVsac3g9nhu4ej6dATnySrqy56EIY7VrT
         9wi3Ruxd/smF9k9UKS4Spjx/YTIQoh9WVisZJ9ImB1+8P5n5WH80kviOVgzdOW9eQPGl
         FLN2jwXCS5JErHrfev7qmgp7gHwtVwIMLrazB3htM96GCB77wkQeDCZVHgEHN7sv+RZ5
         saxUcF6OYmYXMcgR5cpXFKtT9FPzpWaVCYnyHrgMYxcV4Ex0UG0Gl9WYN9UvNeRUNs6C
         F7iR4s6yq7yQ6is4wBzMLgnPtYibOWj89MNrNN5bjKSGXpDV4+x/gnKG/SU/mo66NxsQ
         ETyA==
X-Gm-Message-State: ACrzQf3i4+kWUu/Dwf9BPGr0NuzoXgasrmgrpLgywEAWIYX0/2QrGcwi
        ivRul2HJwect/cvg9v8YZweCGtNx9v8igvtcG7Y=
X-Google-Smtp-Source: AMsMyM5dcaDQ2ebBoOCvWrT/ibg7sU42N2YPxtR4RrgQPXjfLAc8fxWJNwdyIu4G+gxuUl1pRP7DJRT4tdGdNBWvEY4=
X-Received: by 2002:a4a:a78a:0:b0:472:a078:98d6 with SMTP id
 l10-20020a4aa78a000000b00472a07898d6mr2554260oom.97.1663349630965; Fri, 16
 Sep 2022 10:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220914171505.54154-1-colin.i.king@gmail.com>
In-Reply-To: <20220914171505.54154-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Sep 2022 13:33:39 -0400
Message-ID: <CADnq5_NY+XfdjLhEf0mppF+paUVQjPP8xm_N=6=-1aG08-f54Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdkfd: Fix spelling mistake "detroyed" -> "destroyed"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 14, 2022 at 1:15 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a pr_debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 7522bf2d2f57..c70c026c9a93 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -898,7 +898,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>                 return VM_FAULT_SIGBUS;
>         }
>         if (!mmget_not_zero(svm_bo->eviction_fence->mm)) {
> -               pr_debug("addr 0x%lx of process mm is detroyed\n", addr);
> +               pr_debug("addr 0x%lx of process mm is destroyed\n", addr);
>                 return VM_FAULT_SIGBUS;
>         }
>
> --
> 2.37.1
>
