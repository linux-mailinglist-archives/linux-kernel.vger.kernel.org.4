Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6F6E0B80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDMKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:37:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DD1BD3;
        Thu, 13 Apr 2023 03:37:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id os24so6571070ejb.12;
        Thu, 13 Apr 2023 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681382253; x=1683974253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLSB6ZQIDEf0LPXWHBV0UtyjKrgEU/7Ar0gUwuv/GcM=;
        b=SiWsJ+jDPZXiNlIMoYyecYSNTipW2sX6cIqTSM2Lcix/JVd8ubWwBbHNbY4CfeThR0
         mj4Lj/CoNoZDuwp8PymZXQ4DjV99rYoITBdoJXZkv1GhZZeh5fsG+OgaxrD2S6bB4lsu
         Dsn8dAvvdCrURnFrGpn9Gc5F9v4Mr+Xt8hY690es9jJv+AYLvS0sVwbuNI4sdAFqYOym
         87P7ytplM6XoHICxbSw/0vOhlRX9xsFL0ndazmjNEvAnx+k80ONAzpaf/Vlwuf+h/sWc
         i0BmaGriyC6zXmShbCVz52S3uJ7bZC3MzeCaKf0ekDcZZLzraNTvqpfMeBFf6KIjm5HG
         S0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382253; x=1683974253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLSB6ZQIDEf0LPXWHBV0UtyjKrgEU/7Ar0gUwuv/GcM=;
        b=cLhAFuhHklvrTGR3Hdt2gx8zJ4fHljxYv3Qa2oITlm8MQp/Eofia/TtGXsdUR/ATFw
         6+gsISqlrhnYCv4g62HB7qW3RDYg3QPJOq8aR0Zapnfo9L9SfziTTYw0M82Oa0QkY3qn
         QWHKG6hDPCr/yxpI7siSdl3bxNRbWLrYqECSBcbtLLr90/PkUsE8ftExUIZOwP9YDugI
         7YY4o1DNJDTp0AwD4RbwWTrnKruL5nwhWSTtv8qSSJ/vJCznojD7LVDp84M3h8bLrpMl
         ujqHFm7SlYHE3hOwL3OlTLr0vTQPconwY++ABH0At/a3Bf8TeJzzyt4fN1Eq1YwA9a/s
         y4Ew==
X-Gm-Message-State: AAQBX9d/ZaMEh82lBDqGp+6TY6EKT76hoz++mwHviykUrL+yM2SD0t7d
        3pDauFbq3vB/Rrnv83I1APoWFU/Cz1E=
X-Google-Smtp-Source: AKy350aOsqhu9DZk1TU6rm3Yh3wLheQacY1+JUZNQleHEHvuC7zn5Fr43eRufMw4nfXPtcsCPm8etg==
X-Received: by 2002:a17:906:6d86:b0:944:308f:b976 with SMTP id h6-20020a1709066d8600b00944308fb976mr1928887ejt.36.1681382252494;
        Thu, 13 Apr 2023 03:37:32 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
        by smtp.gmail.com with ESMTPSA id xb9-20020a170907070900b0094e6a9c1d24sm810802ejb.12.2023.04.13.03.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 03:37:31 -0700 (PDT)
Message-ID: <6af1d173-166a-7015-355b-95ad23606f9d@gmail.com>
Date:   Thu, 13 Apr 2023 12:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/6] drm/amdgpu: Switch to fdinfo helper
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Airlie <airlied@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Guchun Chen <guchun.chen@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        linux-arm-msm@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Christopher Healy <healych@amazon.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
References: <20230412224311.23511-1-robdclark@gmail.com>
 <20230412224311.23511-4-robdclark@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230412224311.23511-4-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.04.23 um 00:42 schrieb Rob Clark:
> From: Rob Clark <robdclark@chromium.org>
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 16 ++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  2 +-
>   3 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index f5ffca24def4..6c0e0c614b94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2752,7 +2752,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>   	.compat_ioctl = amdgpu_kms_compat_ioctl,
>   #endif
>   #ifdef CONFIG_PROC_FS
> -	.show_fdinfo = amdgpu_show_fdinfo
> +	.show_fdinfo = drm_show_fdinfo,
>   #endif
>   };
>   
> @@ -2807,6 +2807,7 @@ static const struct drm_driver amdgpu_kms_driver = {
>   	.dumb_map_offset = amdgpu_mode_dumb_mmap,
>   	.fops = &amdgpu_driver_kms_fops,
>   	.release = &amdgpu_driver_release_kms,
> +	.show_fdinfo = amdgpu_show_fdinfo,
>   
>   	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>   	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 99a7855ab1bc..c2fdd5e448d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -53,9 +53,8 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>   	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
>   };
>   
> -void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
> +void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   {
> -	struct drm_file *file = f->private_data;
>   	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
>   	struct amdgpu_fpriv *fpriv = file->driver_priv;
>   	struct amdgpu_vm *vm = &fpriv->vm;
> @@ -86,18 +85,15 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	 * ******************************************************************
>   	 */
>   
> -	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
> -	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
> -	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
> -	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
> -	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
> -	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
> -	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
> +	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> +	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
> +	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
> +	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
>   	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>   		if (!usage[hw_ip])
>   			continue;
>   
> -		seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
> +		drm_printf(p, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
>   			   ktime_to_ns(usage[hw_ip]));
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> index e86834bfea1d..0398f5a159ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> @@ -37,6 +37,6 @@
>   #include "amdgpu_ids.h"
>   
>   uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
> -void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
> +void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file);
>   
>   #endif

