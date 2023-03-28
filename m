Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935A6CBFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjC1MuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjC1MuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:50:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590E10C9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:49:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h25so15665269lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680007774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VidQzNASsjux63fhI4uuQ2DTo+OMQ7IeAyjim1gV9U=;
        b=Yfxn63WyrzAfO1tKDAfFXoAxKnk6BCSIbXkw8TEZ3p7jxTrOECdb5AHNR+w+7SYsnw
         xBKd+uFhn7qCc/r3TcsIsaVF975bOzOrmJSx2HRjK7xPOZiCypLmgOgkREtZNZSYRg1Z
         6osNuvxfJkMdo+4Xyf/UwTfYKoaTSMeszkoI+Rc/ut1buFEspBG3mV9hBRisJj6MwHmM
         0V+RUhtMX3UEoXJM6VNjsDuN7NHFgZlEKIiOkH4z9r/Ier2+HTS1ec3MnOCxf587tl/S
         VHbaO+a/QOoEUrt8rN6OYAC0qno3U3ULfO01L4+18XOKp38dkyQxXqxbC6JO/HP3DXLP
         JpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VidQzNASsjux63fhI4uuQ2DTo+OMQ7IeAyjim1gV9U=;
        b=tAjEgT0sWKzxhzkrLbx3cI/+hY3pT4hHAyp79GS7PGW3V+2JuQnMN2S3ayjJVB7Nis
         83axrCD6A9uNAvESgF52AtF48KFUvOKDiTx2sxJFfECD90TzqbXGMgcLS5vohq8xOB83
         Ao0y+S3+PI43ST00ULdM3NFa/6BjFgDZa6l6bMRcQW3mqObweRK8oKNXJ484he4EQp+D
         epAU6w0EX26IQKU2lzuWVH2X2c8JD4R3wvXhuA3y+KRHh4Z3eKWkh4gwZ4Byqy9RhY8U
         ZJsnPucmWZKbJISeLnqjPpV2FHrTqp+EjQRm4DStQp0rCyQ75mW6EerXdgXQH379kYm6
         IbAw==
X-Gm-Message-State: AAQBX9dXAhwzcWnCCTE/Mfu/8UDFbm84/8fwauiZpEN4n0U6NJ6g9zOc
        GflTmJHzs01WYujdEhFXRfu6Cg==
X-Google-Smtp-Source: AKy350b+rejnzP2zxrXGmRaUOdHxM2i1U5qKBX8wGs8qd7uzaDxdvUIU3FUVEmqrn6C7LJ1eUJGuvA==
X-Received: by 2002:ac2:5598:0:b0:4ac:b7bf:697a with SMTP id v24-20020ac25598000000b004acb7bf697amr4967288lfg.4.1680007773949;
        Tue, 28 Mar 2023 05:49:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b004a2c447598fsm5028496lfc.159.2023.03.28.05.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 05:49:33 -0700 (PDT)
Message-ID: <74e44866-1de6-e74c-7d06-7189fe328aa5@linaro.org>
Date:   Tue, 28 Mar 2023 15:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/10] Revert "drm/msm: Fix failure paths in
 msm_drm_init()"
To:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <20230306100722.28485-3-johan+linaro@kernel.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230306100722.28485-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 12:07, Johan Hovold wrote:
> This reverts commit 8636500300a01740d92b345c680b036b94555b1b.
> 
> A recent commit tried to address a drm device leak in the early
> msm_drm_uninit() error paths but ended up making things worse.
> 
> Specifically, it moved the drm device reference put in msm_drm_uninit()
> to msm_drm_init() which means that the drm would now be leaked on normal
> unbind.
> 
> For reasons that were never spelled out, it also added kms NULL pointer
> checks to a couple of helper functions that had nothing to do with the
> paths modified by the patch.
> 
> Instead of trying to salvage this incrementally, let's revert the bad
> commit so that clean and backportable fixes can be added in its place.
> 
> Fixes: 8636500300a0 ("drm/msm: Fix failure paths in msm_drm_init()")
> Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Ok, let's do it this way

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot.c |  3 ---
>   drivers/gpu/drm/msm/msm_drv.c                | 11 ++++-------
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> index b73031cd48e4..e75b97127c0d 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> @@ -129,9 +129,6 @@ void msm_disp_snapshot_destroy(struct drm_device *drm_dev)
>   	}
>   
>   	priv = drm_dev->dev_private;
> -	if (!priv->kms)
> -		return;
> -
>   	kms = priv->kms;
>   
>   	if (kms->dump_worker)
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index b7f5a78eadd4..9ded384acba4 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -150,9 +150,6 @@ static void msm_irq_uninstall(struct drm_device *dev)
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct msm_kms *kms = priv->kms;
>   
> -	if (!priv->kms)
> -		return;
> -
>   	kms->funcs->irq_uninstall(kms);
>   	if (kms->irq_requested)
>   		free_irq(kms->irq, dev);
> @@ -270,6 +267,8 @@ static int msm_drm_uninit(struct device *dev)
>   	component_unbind_all(dev, ddev);
>   
>   	ddev->dev_private = NULL;
> +	drm_dev_put(ddev);
> +
>   	destroy_workqueue(priv->wq);
>   
>   	return 0;
> @@ -442,12 +441,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   
>   	ret = msm_init_vram(ddev);
>   	if (ret)
> -		goto err_drm_dev_put;
> +		return ret;
>   
>   	/* Bind all our sub-components: */
>   	ret = component_bind_all(dev, ddev);
>   	if (ret)
> -		goto err_drm_dev_put;
> +		return ret;
>   
>   	dma_set_max_seg_size(dev, UINT_MAX);
>   
> @@ -542,8 +541,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   
>   err_msm_uninit:
>   	msm_drm_uninit(dev);
> -err_drm_dev_put:
> -	drm_dev_put(ddev);
>   	return ret;
>   }
>   

-- 
With best wishes
Dmitry

