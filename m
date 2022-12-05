Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20906424DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiLEIkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiLEIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:40:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F2165A8;
        Mon,  5 Dec 2022 00:40:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so17395824wrv.10;
        Mon, 05 Dec 2022 00:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sDErz481UBaoPgkLvcD3eW5dfuo2lmP7dTKUT9LSxo=;
        b=CDIaq58SaoHZjMxz72d7q7O2qPXm3X5yQhKvffSTBy6HbLLR9WZsqWeU6LtseQtI68
         o6IV03Moh3V4oiwZMBB/yQeeqcYi1/x+Uh3XAOsGS1gJAva+Uba46W61i0BYIsVCC1QS
         iHsyy2W5+3qokLKTdR+TQ+Xz1hdyL+V2Z7rXFtWy6A9p2Z0u/Qle5ctT3/TYrtquf0ps
         V+BMqOoBT8DUVuc2Qe7LzZQ2p2uyP7f5QkeH8HmGFY37xvxI4WhNHsW+rGB7KSvOQbOW
         jO8krwIhzAX+dHjzKkFkj7Y3VT236pu97vDXS3Mi6HnIgdsqYNOGyVtb8/jJ1ALzZZSv
         BTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sDErz481UBaoPgkLvcD3eW5dfuo2lmP7dTKUT9LSxo=;
        b=MYZlERKNZe4a1GAqhT4UIx+dBtSS7qtbnmuvfWMOnlC18WzlRkMOI/3GSrLBCKag0T
         +uyCUGSuIFgSkjk1uNPi0wGFETB2GcPxZM2te9IjJlksXJLTdXunjOwU+apSS7rVuBhz
         6bfZ6k8e7YNdErlmPzQhNKzByUf+0oQNdlqmLngxDwHhwhy9EkbiklQRFiT1Z28EgJD8
         /R+a4rf1Wl7yEFhuHTKveJoHgiO054TP8MIGxPI8tl5OzIlD5xlxNjknq42S0BwWLM6R
         xaPqOBGOOB4QkODj/buJUBvjsI5TueBXroGGzFfw+pJqEzvptKcM9PbIbUH1VSezDLti
         O2Ig==
X-Gm-Message-State: ANoB5pnOfVdqjFOZmylJhzBzhO9/KutWo9pXo7cdDudPhXaAZltcz9w2
        sGMKZ6TtDy8uITuEY2Ef/w4=
X-Google-Smtp-Source: AA0mqf5MP9EIAj7+h6OgOC3ocdnmonuHI3yeFv7QjjRItw/MJU/pvg58z8YhycF7wThpojAmspf4fg==
X-Received: by 2002:a5d:6d4b:0:b0:242:4e26:51be with SMTP id k11-20020a5d6d4b000000b002424e2651bemr5621729wri.253.1670229621269;
        Mon, 05 Dec 2022 00:40:21 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003cf878c4468sm23288030wms.5.2022.12.05.00.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:40:20 -0800 (PST)
Date:   Mon, 5 Dec 2022 11:40:17 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/msm/adreno: Fix null ptr access in
 adreno_gpu_cleanup()
Message-ID: <Y42ucX8GwYEFVUcr@kadam>
References: <20221204040946.1.Ib978de92c4bd000b515486aad72e96c2481f84d0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204040946.1.Ib978de92c4bd000b515486aad72e96c2481f84d0@changeid>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 04:11:41AM +0530, Akhil P Oommen wrote:
> Fix the below kernel panic due to null pointer access:
> [   18.504431] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
> [   18.513464] Mem abort info:
> [   18.516346]   ESR = 0x0000000096000005
> [   18.520204]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   18.525706]   SET = 0, FnV = 0
> [   18.528878]   EA = 0, S1PTW = 0
> [   18.532117]   FSC = 0x05: level 1 translation fault
> [   18.537138] Data abort info:
> [   18.540110]   ISV = 0, ISS = 0x00000005
> [   18.544060]   CM = 0, WnR = 0
> [   18.547109] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000112826000
> [   18.553738] [0000000000000048] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [   18.562690] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> **Snip**
> [   18.696758] Call trace:
> [   18.699278]  adreno_gpu_cleanup+0x30/0x88
> [   18.703396]  a6xx_destroy+0xc0/0x130
> [   18.707066]  a6xx_gpu_init+0x308/0x424

Fixes: 17e822f7591f ("drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}")

Let's add Jonathan to the CC list so he can Ack your patch.

Although the real issue is that a6xx_gpu_init has bad error handling.

The a6xx_destroy() function supposed to free *everything* so then the
question becomes how do we avoid freeing something which was not
allocated?  With normal kernel style we just free things one by one
in the reverse order from how they were allocated.  See my blog for more
details:
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

However this code is written in One Function Frees Everything Style
which is difficult to review and prone to bugs.  The common mistakes are
the kind of NULL dereference that you've seen, double frees, and missing
frees.

The only way to read this code is to open a new text editor window and
line up the allocations with the frees.

  1725  static void a6xx_destroy(struct msm_gpu *gpu)
  1726  {
  1727          struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
  1728          struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
  1729  
  1730          if (a6xx_gpu->sqe_bo) {
  1731                  msm_gem_unpin_iova(a6xx_gpu->sqe_bo, gpu->aspace);
  1732                  drm_gem_object_put(a6xx_gpu->sqe_bo);

These unpin/put must be done together and should be in their own
function.  The ->sqe_bo pointer is allocated in a6xx_ucode_init().  It's
assigned to an error pointer, but then set to NULL on error or after a
free.  So this is okay.

  1733          }
  1734  
  1735          if (a6xx_gpu->shadow_bo) {

->shadow_bo is allocated in hw_init().  Should there be a call to
msm_gem_put_vaddr(a6xx_gpu->shadow)?  It's unclear.  [QUESTION #1]

  1736                  msm_gem_unpin_iova(a6xx_gpu->shadow_bo, gpu->aspace);
  1737                  drm_gem_object_put(a6xx_gpu->shadow_bo);
  1738          }
  1739  
  1740          a6xx_llc_slices_destroy(a6xx_gpu);

This has IS_ERR_OR_NULL() checks so it's okay.

  1741  
  1742          a6xx_gmu_remove(a6xx_gpu);

This uses a gmu->initialized flag which allows it to safely clean up
everything.  Fine.

  1743  
  1744          adreno_gpu_cleanup(adreno_gpu);

This function has the bug that you identified.  Let's dig into it.
(With normal kernel error handling you can read the error handling by
looking at the label name but with this style we need to jump around and
compare code from different files).

  1745  
  1746          kfree(a6xx_gpu);
  1747  }

drivers/gpu/drm/msm/adreno/adreno_gpu.c
  1079  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
  1080  {
  1081          struct msm_gpu *gpu = &adreno_gpu->base;
  1082          struct msm_drm_private *priv = gpu->dev->dev_private;
  1083          unsigned int i;
  1084  
  1085          for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
  1086                  release_firmware(adreno_gpu->fw[i]);

This is okay.  ->fw[i] is either valid or NULL and releasing a NULL is
fine.

  1087  
  1088          if (pm_runtime_enabled(&priv->gpu_pdev->dev))

This is the bug you found.

  1089                  pm_runtime_disable(&priv->gpu_pdev->dev);
  1090  
  1091          msm_gpu_cleanup(&adreno_gpu->base);

Let's dig into msm_gpu_cleanup().

  1092  }

drivers/gpu/drm/msm/msm_gpu.c
  1006  void msm_gpu_cleanup(struct msm_gpu *gpu)
  1007  {
  1008          int i;
  1009  
  1010          DBG("%s", gpu->name);
  1011  
  1012          for (i = 0; i < ARRAY_SIZE(gpu->rb); i++) {
  1013                  msm_ringbuffer_destroy(gpu->rb[i]);

Destroying an error pointer is fine so this is okay.

  1014                  gpu->rb[i] = NULL;
  1015          }
  1016  
  1017          msm_gem_kernel_put(gpu->memptrs_bo, gpu->aspace);
                                                    ^^^^^^^^^^^
[QUESTION #2] Passing an error pointer here will trigger a stack trace
so this is bug.  The drivers->aspace pointer is allocted in
msm_gpu_create_private_address_space()

drivers/gpu/drm/msm/msm_gpu.c
   824  struct msm_gem_address_space *
   825  msm_gpu_create_private_address_space(struct msm_gpu *gpu, struct task_struct *task)
   826  {
   827          struct msm_gem_address_space *aspace = NULL;
   828          if (!gpu)
   829                  return NULL;
   830  
   831          /*
   832           * If the target doesn't support private address spaces then return
   833           * the global one
   834           */
   835          if (gpu->funcs->create_private_address_space) {
   836                  aspace = gpu->funcs->create_private_address_space(gpu);
   837                  if (!IS_ERR(aspace))
   838                          aspace->pid = get_pid(task_pid(task));
   839          }
   840  
   841          if (IS_ERR_OR_NULL(aspace))
                    ^^^^^^^^^^^^^^^^^^^^^^
[QUESTION #3] This check seems reversed.  It should be if *NOT* is error
or null.

   842                  aspace = msm_gem_address_space_get(gpu->aspace);
   843  
   844          return aspace;
   845  }

regards,
dan carpenter


