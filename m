Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F666D6A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjDDRWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjDDRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A8019BC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g17so43279401lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUqufO4ckbA7YUQ7khTnLIBsU5Ng8gcS7UT9jN47mOw=;
        b=Dn1QKSiziw+xYbWhowDlXDLCpMhlaP1KiIc6ghEGYnHrF8J/UyEQfkSyYcQCj65KDV
         fSQYXnS/RkXLrAzY7gtIzcZnQoGBtWDxGmoHrzzi5KVmhrS/NJ/JYJF/pi6trmtut9TE
         9NqPTAWbbIJhP9NS7jh2x7qCLoXeljuPivmopm5wnN3KYx+f4m0lMIQmDBnqxkN7c8XB
         bCn75O4l96enwn3nq0qum18+srtz1zq9vhGphNsu4YkFtwedB1GDsvu1nFGzR4ZhIsFE
         PemsWj7yVHQF+oM9ffnaortDUTv1xGgH9my55Th0H/rJk45Zx6jR4oYQ4LkKk8E+/KlM
         3UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUqufO4ckbA7YUQ7khTnLIBsU5Ng8gcS7UT9jN47mOw=;
        b=SxdFRD27ddy3R6NHu51KPTH/0SNR5NmZCjUi1ErRuygOex0m/3+n1tgY37ox2PIC+b
         mngZy8qKle4ogvQDfK2dg/seWE/xUIM5ZhrFob/ZvkSx967NWT+vFCeid8rntqS8r+ga
         kFUn6QBt+Y/rm0RQLVMyUy7oRvxLG2/H7bA/pSD2lWhVBlf4W1bZbna7wawl6s4IC7s9
         vPxgdYMlewnF8Ag5DjGv3QAK8SJpd0tk4HYlLJCBIzhavBmVX0zh/RZxqueK9ljhEQ3N
         j630Kz8tetLuUe3jrpHFJtfxzq9Pe7zWLMVivfFWOkI8/H1jfBmqfIqJJXkiHAJ3DrDo
         h4iA==
X-Gm-Message-State: AAQBX9fOXdCGuR121HFVxgkak5z6VHN+a39pfrigZpUjZHdHbEYrjMPm
        WHpuEwMfSIBt9ulnaE8dyOeHrw==
X-Google-Smtp-Source: AKy350aFgyLEvgw50iXsaUnWapEj11fiy/sBlLTQCgrgC+UcwhVJWMw4sXgMPmfYkgLstHg3q5MbbQ==
X-Received: by 2002:ac2:5ed9:0:b0:4dc:6ad4:5fe4 with SMTP id d25-20020ac25ed9000000b004dc6ad45fe4mr870102lfq.32.1680628926728;
        Tue, 04 Apr 2023 10:22:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::227? (dzccz6yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::227])
        by smtp.gmail.com with ESMTPSA id z24-20020a2e3518000000b00294649d3dcasm2440956ljz.44.2023.04.04.10.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 10:22:05 -0700 (PDT)
Message-ID: <dfc21f18-7e1e-48f0-c05a-d659b9c90b91@linaro.org>
Date:   Tue, 4 Apr 2023 20:22:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v10 11/15] drm/atomic-helper: Set fence deadline for
 vblank
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        freedreno@lists.freedesktop.org
References: <20230308155322.344664-1-robdclark@gmail.com>
 <20230308155322.344664-12-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230308155322.344664-12-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 17:53, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> For an atomic commit updating a single CRTC (ie. a pageflip) calculate
> the next vblank time, and inform the fence(s) of that deadline.
> 
> v2: Comment typo fix (danvet)
> v3: If there are multiple CRTCs, consider the time of the soonest vblank
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/drm_atomic_helper.c | 37 +++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

As I started playing with hotplug on RB5 (sm8250, DSI-HDMI bridge), I 
found that this patch introduces the following backtrace on HDMI 
hotplug. Is there anything that I can do to debug/fix the issue? The 
warning seems harmless, but it would be probably be good to still fix 
it. With addresses decoded:

[   31.151348] ------------[ cut here ]------------
[   31.157043] msm_dpu ae01000.display-controller: 
drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
[   31.157177] WARNING: CPU: 0 PID: 13 at 
drivers/gpu/drm/drm_vblank.c:728 
drm_crtc_vblank_helper_get_vblank_timestamp_internal 
(drivers/gpu/drm/drm_vblank.c:728)
[   31.180629] Modules linked in:
[   31.184106] CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 
6.3.0-rc2-00008-gd39e48ca80c0 #542
[   31.193358] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[   31.200796] Workqueue: events lt9611uxc_hpd_work
[   31.205990] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   31.213722] pc : drm_crtc_vblank_helper_get_vblank_timestamp_internal 
(drivers/gpu/drm/drm_vblank.c:728)
[   31.222032] lr : drm_crtc_vblank_helper_get_vblank_timestamp_internal 
(drivers/gpu/drm/drm_vblank.c:728)
[   31.230341] sp : ffff8000080bb8d0
[   31.234061] x29: ffff8000080bb900 x28: 0000000000000038 x27: 
ffff61a7956b8d60
[   31.242051] x26: 0000000000000000 x25: 0000000000000000 x24: 
ffff8000080bb9c4
[   31.250038] x23: 0000000000000001 x22: ffffbf0033b94ef0 x21: 
ffff61a7957901d0
[   31.258029] x20: ffff61a795710000 x19: ffff61a78128b000 x18: 
fffffffffffec278
[   31.266014] x17: 0040000000000465 x16: 0000000000000020 x15: 
0000000000000060
[   31.274001] x14: 0000000000000001 x13: ffffbf00354550e0 x12: 
0000000000000825
[   31.281989] x11: 00000000000002b7 x10: ffffbf00354b1208 x9 : 
ffffbf00354550e0
[   31.289976] x8 : 00000000ffffefff x7 : ffffbf00354ad0e0 x6 : 
00000000000002b7
[   31.297963] x5 : ffff61a8feebbe48 x4 : 40000000fffff2b7 x3 : 
ffffa2a8c9f64000
[   31.305947] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff61a780283100
[   31.313934] Call trace:
[   31.316719] drm_crtc_vblank_helper_get_vblank_timestamp_internal 
(drivers/gpu/drm/drm_vblank.c:728)
[   31.324646] drm_crtc_vblank_helper_get_vblank_timestamp 
(drivers/gpu/drm/drm_vblank.c:843)
[   31.331528] drm_crtc_get_last_vbltimestamp 
(drivers/gpu/drm/drm_vblank.c:884)
[   31.337170] drm_crtc_next_vblank_start 
(drivers/gpu/drm/drm_vblank.c:1006)
[   31.342430] drm_atomic_helper_wait_for_fences 
(drivers/gpu/drm/drm_atomic_helper.c:1531 
drivers/gpu/drm/drm_atomic_helper.c:1578)
[   31.348561] drm_atomic_helper_commit 
(drivers/gpu/drm/drm_atomic_helper.c:2007)
[   31.353724] drm_atomic_commit (drivers/gpu/drm/drm_atomic.c:1444)
[   31.358127] drm_client_modeset_commit_atomic 
(drivers/gpu/drm/drm_client_modeset.c:1045)
[   31.364146] drm_client_modeset_commit_locked 
(drivers/gpu/drm/drm_client_modeset.c:1148)
[   31.370071] drm_client_modeset_commit 
(drivers/gpu/drm/drm_client_modeset.c:1174)
[   31.375233] drm_fb_helper_set_par 
(drivers/gpu/drm/drm_fb_helper.c:254 drivers/gpu/drm/drm_fb_helper.c:229 
drivers/gpu/drm/drm_fb_helper.c:1644)
[   31.380108] drm_fb_helper_hotplug_event 
(drivers/gpu/drm/drm_fb_helper.c:2302 (discriminator 4))
[   31.385456] drm_fb_helper_output_poll_changed 
(drivers/gpu/drm/drm_fb_helper.c:2331)
[   31.391376] drm_kms_helper_hotplug_event 
(drivers/gpu/drm/drm_probe_helper.c:697)
[   31.396825] drm_bridge_connector_hpd_cb 
(drivers/gpu/drm/drm_bridge_connector.c:129)
[   31.402175] drm_bridge_hpd_notify (drivers/gpu/drm/drm_bridge.c:1315)
[   31.406954] lt9611uxc_hpd_work 
(drivers/gpu/drm/bridge/lontium-lt9611uxc.c:185)
[   31.411450] process_one_work (kernel/workqueue.c:2395)
[   31.415949] worker_thread (include/linux/list.h:292 
kernel/workqueue.c:2538)
[   31.426843] kthread (kernel/kthread.c:376)
[   31.437182] ret_from_fork (arch/arm64/kernel/entry.S:871)
[   31.447828] irq event stamp: 44642
[   31.458284] hardirqs last enabled at (44641): __up_console_sem 
(arch/arm64/include/asm/irqflags.h:182 (discriminator 1) 
arch/arm64/include/asm/irqflags.h:202 (discriminator 1) 
kernel/printk/printk.c:345 (discriminator 1))
[   31.474540] hardirqs last disabled at (44642): el1_dbg 
(arch/arm64/kernel/entry-common.c:335 arch/arm64/kernel/entry-common.c:406)
[   31.489882] softirqs last enabled at (42912): _stext 
(arch/arm64/include/asm/current.h:19 arch/arm64/include/asm/preempt.h:13 
kernel/softirq.c:415 kernel/softirq.c:600)
[   31.505256] softirqs last disabled at (42907): ____do_softirq 
(arch/arm64/kernel/irq.c:81)
[   31.521139] ---[ end trace 0000000000000000 ]---



-- 
With best wishes
Dmitry

