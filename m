Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A974265FD42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAFJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjAFJDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:03:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCC062C0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:03:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so3560480wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BzESQrUDM05zlTEwrX4Mj8dG0qJRTLEWdAlMpGzRIU=;
        b=ipTeb+kU+Y9knB9QUZ7sUKNDljfl2Jel9SUsuWtjkKXaoI5rUdeCqry2nktxA255PR
         JzrInWHtqpSM9HJNbN+vnvPDLJwc4esfi5OVDYxIzvq95Aq1JEjpVlrBCiz/jMR0gSVJ
         PtBiZxSi3+HB3HMv1+1yL/f3cbo6wzZ0w8Qw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BzESQrUDM05zlTEwrX4Mj8dG0qJRTLEWdAlMpGzRIU=;
        b=1Y3cLI3zI9TztiTUUNVXYNo/LSRT7GfzFWn/TfE+NxvENxy53Mvez5ojPvPhwe9Kvh
         LRgp1v22AYM8z+Crh8SV0n/6yCZWtua3FlJZE8WAcdEEh5GyGMh/ovGT31jzzvcoh22C
         g1xv7pAM5CNX3GMe6AUxEkcUEIMTg82aNi58r4roi4jd62eKdYRcm79O6As668L/BmKz
         6BROcnvDw/rbIy2TspDrJf4G/nA3ABf2KSKoA6nvbWx0KgtS/FZie8m18wG8b7JYqf2o
         AHRCUJvvbR12LKCG4VbEoanCl1KAD6kjFefpRPE4VruYnQUhgoAu3CogvcemfzMPuHKs
         BZcw==
X-Gm-Message-State: AFqh2krOZ6islUYnyVwK5+17P+DQuYNUWTd5sR60x4sm2zpzPQWHM6QH
        shXcaxrj+/pvtk35ebZjscm6gQ==
X-Google-Smtp-Source: AMrXdXt0arOZc3l0kts8OHBZ/+UO0oRr7Cuyh3i4z4GyM+Yn5GuirvZkRTu52vYbVVMlytkF25SSdg==
X-Received: by 2002:a05:600c:3d86:b0:3cf:9ac8:c537 with SMTP id bi6-20020a05600c3d8600b003cf9ac8c537mr39944191wmb.14.1672995799979;
        Fri, 06 Jan 2023 01:03:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm5847712wmo.39.2023.01.06.01.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 01:03:18 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:03:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Steev Klimaszewski <steev@kali.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/msm: Set preferred depth.
Message-ID: <Y7fj1N4blo2MYZDt@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Steev Klimaszewski <steev@kali.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
References: <20230106071609.3948-1-steev@kali.org>
 <98a30f00-c98f-cecb-d681-30b55caf2f8a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98a30f00-c98f-cecb-d681-30b55caf2f8a@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 09:31:31AM +0100, Thomas Zimmermann wrote:
> Am 06.01.23 um 08:16 schrieb Steev Klimaszewski:
> > As of commit 37c90d589dc0 ("drm/fb-helper: Fix single-probe color-format
> > selection"), if no supported color formats are found, it tries to use the
> > driver provided default, which msm didn't have set and leads to the
> > following output:
> > 
> > msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> > msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> > msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> > msm_dpu ae01000.display-controller: [drm] No compatible format found
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 73 at drivers/gpu/drm/drm_atomic.c:1604 __drm_atomic_helper_set_config+0x240/0x33c
> > Modules linked in: ext4 mbcache jbd2 msm mdt_loader ocmem gpu_sched llcc_qcom gpio_keys qrtr
> > CPU: 0 PID: 73 Comm: kworker/u16:2 Not tainted 6.2.0-rc2-next-20230106 #53
> > Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET74W (1.46 ) 10/12/2022
> > Workqueue: events_unbound deferred_probe_work_func
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : __drm_atomic_helper_set_config+0x240/0x33c
> > lr : __drm_atomic_helper_set_config+0x68/0x33c
> > sp : ffff800008a7b790
> > x29: ffff800008a7b790 x28: ffff73ee3e130a00 x27: 0000000000000000
> > x26: ffff73ee3d256e00 x25: 0000000000000038 x24: ffff73e6c0d65e00
> > x23: ffff73e6c17a7800 x22: ffff73e6c0d64e00 x21: ffff73e79c025e00
> > x20: 00000000c0d64e00 x19: ffff73ee3e130a00 x18: ffffffffffffffff
> > x17: 662074616d726f66 x16: 20656c6269746170 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa829144ff8bc
> > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : ffff73e6c0d65f50 x4 : ffff73ee3d254950 x3 : ffff73e6c0d65ec0
> > x2 : ffff73ee3c953a00 x1 : ffff73e79c025580 x0 : 0000000000000000
> > Call trace:
> > __drm_atomic_helper_set_config+0x240/0x33c
> > drm_client_modeset_commit_atomic+0x160/0x280
> > drm_client_modeset_commit_locked+0x64/0x194
> > drm_client_modeset_commit+0x38/0x60
> > __drm_fb_helper_initial_config_and_unlock+0x528/0x63c
> > drm_fb_helper_initial_config+0x54/0x64
> > msm_fbdev_init+0x94/0xfc [msm]
> > msm_drm_bind+0x548/0x614 [msm]
> > try_to_bring_up_aggregate_device+0x1e4/0x2d0
> > __component_add+0xc4/0x1c0
> > component_add+0x1c/0x2c
> > dp_display_probe+0x2a4/0x460 [msm]
> > platform_probe+0x70/0xcc
> > really_probe+0xc8/0x3e0
> > __driver_probe_device+0x84/0x190
> > driver_probe_device+0x44/0x120
> > __device_attach_driver+0xc4/0x160
> > bus_for_each_drv+0x84/0xe0
> > __device_attach+0xa4/0x1cc
> > device_initial_probe+0x1c/0x2c
> > bus_probe_device+0xa4/0xb0
> > deferred_probe_work_func+0xc0/0x114
> > process_one_work+0x1ec/0x470
> > worker_thread+0x74/0x410
> > kthread+0xfc/0x110
> > ret_from_fork+0x10/0x20
> > ---[ end trace 0000000000000000 ]---
> > 
> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > ---
> >   drivers/gpu/drm/msm/msm_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 8b0b0ac74a6f..65c4c93c311e 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -479,6 +479,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
> >   	drm_helper_move_panel_connectors_to_head(ddev);
> > +	ddev->mode_config.preferred_depth = 24;
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

preferred_depth is not a mandatory thing, we need to fix the fbdev patch,
not work around that in all the drivers. xrgb8888 is the assumed default.
-Daniel

> 
> Best regards
> Thomas
> 
> >   	ddev->mode_config.funcs = &mode_config_funcs;
> >   	ddev->mode_config.helper_private = &mode_config_helper_funcs;
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
