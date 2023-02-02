Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5DF687996
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBBJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBBJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:56:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50787D22
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:56:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n13so925916wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/86veRiNMAotlC8E0v66dTb033ZYUef8g783vJEeso=;
        b=YFCI8EFeCKYROGksvronNRcrP2dUv7lv5d83xpOGukCR2zmdfK9Y5acLGr5BQiJ/yf
         mIb7Ap6/BSnvDzEYjcmwtifoC/UNLk3KnZoWCk9SKvoXOYNJbfcRqky9V6NAXMlicM72
         GYiHow9zyNP0Ts0TQyh4Yc5lE42Szfa74niaAM9zBU686dRPY9FtOoBvJDYR1CzS9YdH
         yow9KWz1NYlsZ5gcm4PdaEs64mX/zJj39IdVooIhTiFxOrExzTqc4S5/KM0Px0LFuxPn
         fzjvf87fYmmAIX3p/6keLN0dSypDEz9Y/ae4dHk5FGhF9FsPy0puR8pmiDSs8Rv/pZnl
         NOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/86veRiNMAotlC8E0v66dTb033ZYUef8g783vJEeso=;
        b=mrZj1Pv7PjteOfDCY4F+Bsg863h2tbCJRnfqWmmEVtqueJVa95cGECbIQ0cRjgp1r9
         RDnvyEoY6/Qq7Lzf/6fB2gDNoWXZO7+kP/3JQdmpbvPHcOQlugzU0NJrNnFAOGvdq6zc
         D5AD6lJccLFTvFbaPt5S3l5Tp+s+6uBmN/L2D592QN5R3PbVVzOZRnvSLVeue8LZvZt5
         Pnh328DGpW02GDSS2mxJhTA6g3KnSH0wzrn1yD5h0tjFaVKGHI4b5S5Gu5NQhdQKv29M
         UfTOwSyUiQVurpFlLIoMKEsaWsQX7AG3tP2BOgjlzP2dx0EPJt/6Y8IFGtBC2hMvetuu
         g+vw==
X-Gm-Message-State: AO0yUKWaFWanezyQn4StS56S3Fv2BAeIHVtZSzGw/aNJVpkQMqIklfGL
        +Qpmxr3VUd7Lp02q0gkEClY=
X-Google-Smtp-Source: AK7set/jUCFaL62fEij5mmBXq0rmi9tGj3yGhlRhFiz5oyT6fMYAFUcO6qIEIwd7Uu9v6LHsmXmdgg==
X-Received: by 2002:a05:600c:4f07:b0:3dc:50c1:5fd4 with SMTP id l7-20020a05600c4f0700b003dc50c15fd4mr5713832wmq.15.1675331800896;
        Thu, 02 Feb 2023 01:56:40 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c17d500b003dc5b59ed7asm3895142wmo.11.2023.02.02.01.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:56:40 -0800 (PST)
Message-ID: <1287614a-754f-a5b9-d940-3f4fdc8f3bce@gmail.com>
Date:   Thu, 2 Feb 2023 10:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] drm/mediatek: dp: Only trigger DRM HPD events if
 bridge is attached
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>
References: <20230202045734.2773503-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230202045734.2773503-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2023 05:57, Chen-Yu Tsai wrote:
> The MediaTek DisplayPort interface bridge driver starts its interrupts
> as soon as its probed. However when the interrupts trigger the bridge
> might not have been attached to a DRM device. As drm_helper_hpd_irq_event()
> does not check whether the passed in drm_device is valid or not, a NULL
> pointer passed in results in a kernel NULL pointer dereference in it.
> 
> Check whether the bridge is attached and only trigger an HPD event if
> it is.
> 
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Changes since v1
> - Dropped prerequisite-patch-ids
> - Added Guillaume's Reviewed-by
> 
> This applies on top of mediatek-drm-next.
> 
>   drivers/gpu/drm/mediatek/mtk_dp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index 1f94fcc144d3..a82f53e1a146 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1823,7 +1823,8 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
>   	spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
>   
>   	if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
> -		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
> +		if (mtk_dp->bridge.dev)
> +			drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
>   
>   		if (!mtk_dp->train_info.cable_plugged_in) {
>   			mtk_dp_disable_sdp_aui(mtk_dp);
