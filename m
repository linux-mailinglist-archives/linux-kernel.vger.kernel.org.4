Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3673CA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjFXJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFXJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:33:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299071A3;
        Sat, 24 Jun 2023 02:33:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxFsVwuJZkgyoBAA--.1921S3;
        Sat, 24 Jun 2023 17:33:36 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM5vuJZkHQEFAA--.25269S3;
        Sat, 24 Jun 2023 17:33:35 +0800 (CST)
Message-ID: <97bc4380-1a2a-aec7-168e-04536fc74e37@loongson.cn>
Date:   Sat, 24 Jun 2023 17:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [28/39] drm: renesas: shmobile: Use drm_crtc_handle_vblank()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <7b6ffa43307522833103fe29ec6a084b7d621a16.1687423204.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <7b6ffa43307522833103fe29ec6a084b7d621a16.1687423204.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM5vuJZkHQEFAA--.25269S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyfGw4kZFWfuw1fWr4Dtrc_yoW5XF4Up3
        y7JryayFyjqFWFqwnrGFn7ur13u345Ga4fCrW8t345Aw4vqw1fJF1rAw13Kr45JF97ua1j
        qr43K3yrZF1UuFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I'm fine with this patch but I I don't see the benefit.

This reply is more about my personal question.


On 2023/6/22 17:21, Geert Uytterhoeven wrote:
> Replace the call to the legacy drm_handle_vblank() function with a call
> to the new drm_crtc_handle_vblank() helper.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index c98e2bdd888c3274..6eaf2c5a104f451a 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -86,7 +86,7 @@ static irqreturn_t shmob_drm_irq(int irq, void *arg)
>   	spin_unlock_irqrestore(&sdev->irq_lock, flags);
>   
>   	if (status & LDINTR_VES) {
> -		drm_handle_vblank(dev, 0);
> +		drm_crtc_handle_vblank(&sdev->crtc.base);


After switching to drm_crtc_handle_vblank(),

your driver need another deference to the pointer of 'struct drm_crtc' 
to get the pointer of 'struct drm_device';

Plus another call to get the index(display pipe) of the CRTC by calling 
drm_crtc_index(crtc).


Consider that shmob-drm support only one display pipe,

is it that the switching is less straight forward than the original 
implement ?


```

/**
  * drm_crtc_handle_vblank - handle a vblank event
  * @crtc: where this event occurred
  *
  * Drivers should call this routine in their vblank interrupt handlers to
  * update the vblank counter and send any signals that may be pending.
  *
  * This is the native KMS version of drm_handle_vblank().
  *
  * Note that for a given vblank counter value drm_crtc_handle_vblank()
  * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
  * provide a barrier: Any writes done before calling
  * drm_crtc_handle_vblank() will be visible to callers of the later
  * functions, if the vblank count is the same or a later one.
  *
  * See also &drm_vblank_crtc.count.
  *
  * Returns:
  * True if the event was successfully handled, false on failure.
  */
bool drm_crtc_handle_vblank(struct drm_crtc *crtc)
{
     return drm_handle_vblank(crtc->dev, drm_crtc_index(crtc));
}

```

Is it that drm_crtc_handle_vblank() function is preferred over 
drm_handle_vblank() in the future?

I'm fine with this question answered.


>   		shmob_drm_crtc_finish_page_flip(&sdev->crtc);
>   	}
>   

-- 
Jingfeng

