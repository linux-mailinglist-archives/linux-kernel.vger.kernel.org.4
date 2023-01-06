Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB365FBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjAFHTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjAFHSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:18:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A478154
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:18:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g13so886490lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 23:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwNOkK/619F6kwc/0Tj1pDo4Y9cxK12cXZ8QRlsLr6c=;
        b=JYJ70ritw2cx4/IvR9IiIbsgwqw4HWs/g4hPHX5vB+Fsokz0YvbAkV+WT8PMDX3Yrv
         o1pI0tIcLqzWLHzSWTosiOtxcIE2Q79xD3r2kBD1KlCfS8P3OreyFq39ARAthzF7dUaW
         0k44EHlzwnAMW1ZhKTHumoJz/TemXhH3+CVxBLTUW4Vsv9U5tGm8VrmLXp/aVXFRRJwu
         chqKdo7ZT5FExXxJSE3ck4oltx83rsKafIBfjQ2enm2ymVH5Idk6bRj1o/DeWE0jVxo5
         yJlgrF3e1cGCBjesc0AZACf9j7oRegCzyHa+PjrvlX01fjVSHEw0eKJu5MuCuuXRctO0
         /y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwNOkK/619F6kwc/0Tj1pDo4Y9cxK12cXZ8QRlsLr6c=;
        b=EL8uuXqWmbT9CJkKRswqGaoKQi14oOmCzsv4K4evNjsuclnvVcw0FO/SNW7+vAQarq
         54/P23cjfSUnbOQO/lCJg9ioo+ooMaXeK+BIw8GsmMO/nhCt+IyvVoRWMOp0f9i7tB5U
         4Ts0vOZwGH6sAGpiqNUfWK0yS1v/hO4zDoANivzf3E/VDzO2ZJQ13zha+6K7L+tYsII9
         mwZ4XGBl8XD+lfSfTMj6Vj7Xx8x1fpvTyQ9U1i9l5ovG09mpODgd6ThV7YBgEOhmpJ+y
         aiA/HByEecz8UanXvzZVjTmfrvAVGyizbxWlGRJB454kJ3U80Agt3ZAuKxmS7YhpSl4h
         Mogw==
X-Gm-Message-State: AFqh2kr+aWPK1EHXk7qhk5WqOkWqdVOj4M3Pf1H0kLDCssmH20MEN/t4
        ictqHnbyBiL5dfo/hcVZhXpXXg==
X-Google-Smtp-Source: AMrXdXtkBlNpkecak93UASBcKEuMXUx4GuG2RT59y+bG+p5w0zFuJUEV6ziyHNppyL41uyZ+n65U3g==
X-Received: by 2002:a05:6512:3c9e:b0:4b6:a6e4:ab7a with SMTP id h30-20020a0565123c9e00b004b6a6e4ab7amr17977799lfv.8.1672989503149;
        Thu, 05 Jan 2023 23:18:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y8-20020ac255a8000000b004a9b9ccfbe6sm57707lfg.51.2023.01.05.23.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 23:18:22 -0800 (PST)
Message-ID: <f52cca60-ab6a-460a-65f9-367c083b51fa@linaro.org>
Date:   Fri, 6 Jan 2023 09:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm: Set preferred depth.
Content-Language: en-GB
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230106071609.3948-1-steev@kali.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230106071609.3948-1-steev@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 09:16, Steev Klimaszewski wrote:
> As of commit 37c90d589dc0 ("drm/fb-helper: Fix single-probe color-format
> selection"), if no supported color formats are found, it tries to use the
> driver provided default, which msm didn't have set and leads to the
> following output:
> 
> msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> msm_dpu ae01000.display-controller: [drm] No compatible format found
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 73 at drivers/gpu/drm/drm_atomic.c:1604 __drm_atomic_helper_set_config+0x240/0x33c
> Modules linked in: ext4 mbcache jbd2 msm mdt_loader ocmem gpu_sched llcc_qcom gpio_keys qrtr
> CPU: 0 PID: 73 Comm: kworker/u16:2 Not tainted 6.2.0-rc2-next-20230106 #53
> Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET74W (1.46 ) 10/12/2022
> Workqueue: events_unbound deferred_probe_work_func
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __drm_atomic_helper_set_config+0x240/0x33c
> lr : __drm_atomic_helper_set_config+0x68/0x33c
> sp : ffff800008a7b790
> x29: ffff800008a7b790 x28: ffff73ee3e130a00 x27: 0000000000000000
> x26: ffff73ee3d256e00 x25: 0000000000000038 x24: ffff73e6c0d65e00
> x23: ffff73e6c17a7800 x22: ffff73e6c0d64e00 x21: ffff73e79c025e00
> x20: 00000000c0d64e00 x19: ffff73ee3e130a00 x18: ffffffffffffffff
> x17: 662074616d726f66 x16: 20656c6269746170 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa829144ff8bc
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff73e6c0d65f50 x4 : ffff73ee3d254950 x3 : ffff73e6c0d65ec0
> x2 : ffff73ee3c953a00 x1 : ffff73e79c025580 x0 : 0000000000000000
> Call trace:
> __drm_atomic_helper_set_config+0x240/0x33c
> drm_client_modeset_commit_atomic+0x160/0x280
> drm_client_modeset_commit_locked+0x64/0x194
> drm_client_modeset_commit+0x38/0x60
> __drm_fb_helper_initial_config_and_unlock+0x528/0x63c
> drm_fb_helper_initial_config+0x54/0x64
> msm_fbdev_init+0x94/0xfc [msm]
> msm_drm_bind+0x548/0x614 [msm]
> try_to_bring_up_aggregate_device+0x1e4/0x2d0
> __component_add+0xc4/0x1c0
> component_add+0x1c/0x2c
> dp_display_probe+0x2a4/0x460 [msm]
> platform_probe+0x70/0xcc
> really_probe+0xc8/0x3e0
> __driver_probe_device+0x84/0x190
> driver_probe_device+0x44/0x120
> __device_attach_driver+0xc4/0x160
> bus_for_each_drv+0x84/0xe0
> __device_attach+0xa4/0x1cc
> device_initial_probe+0x1c/0x2c
> bus_probe_device+0xa4/0xb0
> deferred_probe_work_func+0xc0/0x114
> process_one_work+0x1ec/0x470
> worker_thread+0x74/0x410
> kthread+0xfc/0x110
> ret_from_fork+0x10/0x20
> ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 1 +
>   1 file changed, 1 insertion(+)

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

