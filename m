Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3173FF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjF0O5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjF0O5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:57:42 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A8341FE2;
        Tue, 27 Jun 2023 07:57:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxycXY+JpkoigDAA--.4912S3;
        Tue, 27 Jun 2023 22:57:28 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF83X+JpkIWoMAA--.47617S3;
        Tue, 27 Jun 2023 22:57:28 +0800 (CST)
Message-ID: <903c71fb-61af-e12a-ca56-a49d4e930f9f@loongson.cn>
Date:   Tue, 27 Jun 2023 22:57:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [32/39] drm: renesas: shmobile: Shutdown the display on remove
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <2c28c0a137854d39b6bc997a21bd6d2db1f7a0a5.1687423204.git.geert+renesas@glider.be>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <2c28c0a137854d39b6bc997a21bd6d2db1f7a0a5.1687423204.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxF83X+JpkIWoMAA--.47617S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWfJry5trW7Cw45ZryUCFX_yoW8GF1DpF
        s7AFWjyFWrtF4Ut3y7C3ZruF15Aa13ta4I9ryqgw45Cw4Yvr9rJ3Z09Fn3XFyUJF4j9a1Y
        vFsIka18Z3WUurXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TCJPUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023/6/22 17:21, Geert Uytterhoeven wrote:
> When the device is unbound from the driver, the display may be active.
> Make sure it gets shut down.

would you mind to give a short description why this is necessary.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index a29c0c1093725b6e..636f1888b815579b 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -16,6 +16,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   
> +#include <drm/drm_crtc_helper.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_fbdev_generic.h>
>   #include <drm/drm_gem_dma_helper.h>
> @@ -145,6 +146,7 @@ static int shmob_drm_remove(struct platform_device *pdev)
>   	struct drm_device *ddev = &sdev->ddev;
>   
>   	drm_dev_unregister(ddev);
> +	drm_helper_force_disable_all(ddev);
Is it that the DRM core recommend us to use 
drm_atomic_helper_disable_all() ?
>   	drm_kms_helper_poll_fini(ddev);
>   	return 0;
>   }

-- 
Jingfeng

