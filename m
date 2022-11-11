Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA741626366
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiKKVJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiKKVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:09:02 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD70E018
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:09:00 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.83]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXXZf-1oU2ZK1IHX-00Z1to; Fri, 11 Nov 2022 22:08:41 +0100
Message-ID: <737e7e23-1bc5-eaf3-2d15-5498fc5b0415@i2se.com>
Date:   Fri, 11 Nov 2022 22:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/vc4: hdmi: Enforce the minimum rate at
 runtime_resume
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech>
 <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:p1P9ebm+F+zvfBkVXdlQhDM4wdPDfMtQZFdKRBA4EtF/oQ2vqFl
 67GVvwHEHSTyJVq9hAnxdu1TbIgpEFbARDD1Xr6giCmH3SeC1WphljI/YrgImgT50QSGlVy
 xI4b1fdJaqEHwbweyC837c58JBHpqo4CaRlRo90//fLEGmi5QX7N4cA86jJs6j1yqKbJg51
 +ie/aUV76gGV/yb5mfdxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WDb+IGX8DmU=:HFU8yHplq3TceO8E3Fv7KA
 sz+k8Qh4XEVEv3f9h2OEFgstLgGPcXHTlsrui0MpijsuuXRgEIbMy7YTIf68JHG7Tf8jmEqfW
 BW7gdN9kBXzMh+UnlR2yhdXAbmIzTpv7o03Ae80pFLNwUk2h8Eaqot3L8D5rFBuQ1mlfQ0IOD
 I/NX5zYjVi1f76HsheLxWKW5RaeeAahAa5Pcvpf+whdfVxvJsjfjzA7DYO7eiqnUrH5iaLNHr
 vpoCnZQoV3aKT1AAV/1nSMav8Wd7ml7pzHVk2atRNL7/JgP+Uv4JK6T5C9b9yN81cs8UGcJG+
 vijcIqn1UdMrySKuzRSndJAsSZ8WoSjri05KcwMIbkpdYgH8iyfX14tymLDcTV/bbgkZ/hl/A
 635AiMHm97wy8ScuJAFd7nCvFz/Gz1pyjoZo2OlZqRHaa7BMrfdfize+F+pRNID57YGvb7QPq
 dBd910zBgakdfDGjAXaxVNCnucJtos9yRlHFW4tMSgpn6NjlfMIK/QFjLXuoUcKaQc/cD4M7m
 zcSER4ma3qV2kwseKfQKd+vQmpD3rZuxD71tMcThGDmElcHD6zJTDDcXu73FnySozTIA/OLmd
 fivcc71S9XMWVqfquElK3ktaouk1uP/XyxDIs9JXiivHijcOONDWSOKjVBX5lGKs7TPjq4e0a
 PJwR+iUacrTLz6ne0EPn9hD6BL+ogF5iEvfwKR1863Uy0CZ1Vinw0ZcgPRDCjoRGBphPpfQrv
 URXnMAzw0uXdHw3062UjHYbZmzRYLJsa4GcGsdKEy8pREyz8qlRDgSHTpANWOmXifXZCpKbSJ
 0VOd4ycNjnzGMs8rDVvRpI97hsi0h2/hjr5VIwzmAqyRg2BzRkRiwmmBMmucnR6nXhgkv8YlN
 ziLPDAZOcczL0QYh8lgOsyecyjyetZTT22If3V3TZ/1XqiHshoawBg9SMMZ0Mf2+zQhZRRXGE
 CPdLCIqM8xAzrxvFTuPlaI0DyJLASrVYqh6f5G2Ov5aVb0f5fxcVddt1DxkBaVjwETeRaDZBp
 eRB5qs6Pd/x5a4IggihoFUQa9F0e0u8GsR9aCT0KMOZw2yMATbsCZQcICL0W7p/Qyvg/rdeE7
 +Ss0QgmWSnbTlh3z5kgXor5k2jxJNK+jQ5YZbaT07L7UE1qaPFDEzAxl9x3daBwiy3rnoy1g2
 NoPvuN1RF0p622WRlk0lZsCSPrhJ+VOX+DZluoF+X3HHYW7lK+RH3hXgw4V12aqtsQ1TpfTIN
 rHIHavmU5BPmGfbUQ9aZ2A8V7C9AfhF8dpjbMRsbbkcZkPeOOQRkvgDL9i7rl092JN3jrLQft
 KwojJu/8TzP9CZPjhWDCn5MZscSKiQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Am 29.09.22 um 11:21 schrieb Maxime Ripard:
> This is a revert of commit fd5894fa2413 ("drm/vc4: hdmi: Remove clock
> rate initialization"), with the code slightly moved around.
>
> It turns out that we can't downright remove that code from the driver,
> since the Pi0-3 and Pi4 are in different cases, and it only works for
> the Pi4.
>
> Indeed, the commit mentioned above was relying on the RaspberryPi
> firmware clocks driver to initialize the rate if it wasn't done by the
> firmware. However, the Pi0-3 are using the clk-bcm2835 clock driver that
> wasn't doing this initialization. We therefore end up with the clock not
> being assigned a rate, and the CPU stalling when trying to access a
> register.
>
> We can't move that initialization in the clk-bcm2835 driver, since the
> HSM clock we depend on is actually part of the HDMI power domain, so any
> rate setup is only valid when the power domain is enabled. Thus, we
> reinstated the minimum rate setup at runtime_suspend, which should
> address both issues.
>
> Link: https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
> Fixes: fd5894fa2413 ("drm/vc4: hdmi: Remove clock rate initialization")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 199bc398817f..2e28fe16ed5e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2891,6 +2891,15 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
>   	u32 __maybe_unused value;
>   	int ret;
>   
> +	/*
> +	 * The HSM clock is in the HDMI power domain, so we need to set
> +	 * its frequency while the power domain is active so that it
> +	 * keeps its rate.
> +	 */
> +	ret = clk_set_min_rate(vc4_hdmi->hsm_clock, HSM_MIN_CLOCK_FREQ);
> +	if (ret)
> +		return ret;
> +

unfortunately this breaks X on Raspberry Pi 4 in Linux 6.0.5 
(multi_v7_defconfig + LPAE). Today i saw this report [1] and bisected 
the issue down to this patch. Shame on me that i only tested this patch 
with Rpi 3B+ :-(

Best regards

[1] - https://bugzilla.suse.com/show_bug.cgi?id=1205259

>   	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
>   	if (ret)
>   		return ret;
>
