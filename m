Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFB6B0BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjCHOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjCHOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:47:26 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F953B06F4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:46:25 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1763e201bb4so18985621fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678286784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlzX8OKaHEAJ+sJq7TL6DCdRPq08Xdgj1/Y7CzN5o08=;
        b=h6CBh3x8qUd/XDjgfRjtHj3iK7HA2sLTCxaO4/FNWk8IE6S8r14Oh4rAMrUFm0WvNC
         KQB01GeJ5xg1s3cmnU000fLp3M1QZ4Ns3aBMBZ3gbFikwYZAVIdLlGhXApEMPU56WR8g
         s0w2NAwQlqlhcN3pgOVu7I5oLEWIBE2gUrgMu0BROfF/3e4RI27qfQaUkiB4LlAHSzif
         tb2AafruRDobLE2VdrknDG+59abhmrFei1KkPeg5alNEgEkVtwcLVBRkYcPWP+oE+Z63
         X4jo07RfSCKqsKdsOV1wKaQ090Wsmvvbf0xHuXRretdPnSn9i7cYRREr96JXtdVgeqrh
         yIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlzX8OKaHEAJ+sJq7TL6DCdRPq08Xdgj1/Y7CzN5o08=;
        b=OPaHKc1ZAmcvIaOOpK8FjJLQLhJk26xsm0xZn8qWbi0fK0fu3p16sYQOUp7GY1tA3+
         VImfvIlUcor3NWexotjciEbAq7iiOg2hM/VuG/fTTveiQJiECgXe0rXcXZuHJwdRuXcd
         WPazcMxOkKWEWeT5s6Ue31pHR93OjgKh2B7y2GJbwdnfBxBKaEP0SqR4JpS+Tviqpz0t
         5Y+8xVWK26+wdDjWCW9zmVSTpOb13Y0ReeG9LQCDlZVF3fwvY5blP8EM/FqLUm4ngH+4
         0+HOl7IDu5tzyercbGlmlA0WfzbSRzoVkOTjVkZ8BMMi4/1VfCjmHyhEOpDSCiou133Z
         IRCQ==
X-Gm-Message-State: AO0yUKXB4o5x9CCJC2iumdfrYr6q2wWpBny2wxKvsYIs+J/c7aGtQdGF
        BTVCWq5Yh+vTxUWfBfo2HaQXJPMJqLkMIiy8++NuL9cYedk=
X-Google-Smtp-Source: AK7set/cVKc3X2GWWCmajeFPqx++VaJ5aY0Qo4YEa1JckdY3lAiZXKdegZqd8ix03KD00vSgfxOF8f8GE2f2DiEBJ/I=
X-Received: by 2002:a05:6870:c7ab:b0:16e:3be:83ac with SMTP id
 dy43-20020a056870c7ab00b0016e03be83acmr6347726oab.3.1678286784591; Wed, 08
 Mar 2023 06:46:24 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsOXH-ORvMP6-aXqVCPcRkNLUp0EARUzdWnoQXjJ5QSHrg@mail.gmail.com>
In-Reply-To: <CABXGCsOXH-ORvMP6-aXqVCPcRkNLUp0EARUzdWnoQXjJ5QSHrg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 09:46:13 -0500
Message-ID: <CADnq5_Mq-hqdxz7JGPBNOUFJNkLQk6yOFKXZQyBzLBFXkHfUxg@mail.gmail.com>
Subject: Re: [6.3][regression] commit a4e771729a51168bc36317effaa9962e336d4f5e
 lead to flood kernel logs with warning messages "at kernel/workqueue.c:3167 __flush_work+0x472/0x500"
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     dmitry.baryshkov@linaro.org, laurentiu.palcu@oss.nxp.com,
        neil.armstrong@linaro.org, tzimmermann@suse.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:02 AM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> I didn't faced to issue drm_bridge_hpd_enable+0x94/0x9c [drm] but
> fixing this issue leads to warning messages on my laptop ASUS ROG
> Strix G15 Advantage Edition G513QY-HQ007 which has two AMD GPU.
> Discrete Radeon 6800M and integrated in CPU Cezanne Vega 8.
>
> I found bad commit by bisecting:
> =E2=9D=AF git bisect bad
> a4e771729a51168bc36317effaa9962e336d4f5e is the first bad commit
> commit a4e771729a51168bc36317effaa9962e336d4f5e
> Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Date:   Tue Jan 24 12:45:48 2023 +0200
>
>     drm/probe_helper: sort out poll_running vs poll_enabled
>
>     There are two flags attemting to guard connector polling:
>     poll_enabled and poll_running. While poll_enabled semantics is clearl=
y
>     defined and fully adhered (mark that drm_kms_helper_poll_init() was
>     called and not finalized by the _fini() call), the poll_running flag
>     doesn't have such clearliness.
>
>     This flag is used only in drm_helper_probe_single_connector_modes() t=
o
>     guard calling of drm_kms_helper_poll_enable, it doesn't guard the
>     drm_kms_helper_poll_fini(), etc. Change it to only be set if the poll=
ing
>     is actually running. Tie HPD enablement to this flag.
>
>     This fixes the following warning reported after merging the HPD serie=
s:
>
>     Hot plug detection already enabled
>     WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_bridge.c:1257
> drm_bridge_hpd_enable+0x94/0x9c [drm]
>     Modules linked in: videobuf2_memops snd_soc_simple_card
> snd_soc_simple_card_utils fsl_imx8_ddr_perf videobuf2_common
> snd_soc_imx_spdif adv7511 etnaviv imx8m_ddrc imx_dcss mc cec nwl_dsi
> gov
>     CPU: 2 PID: 9 Comm: kworker/u8:0 Not tainted
> 6.2.0-rc2-15208-g25b283acd578 #6
>     Hardware name: NXP i.MX8MQ EVK (DT)
>     Workqueue: events_unbound deferred_probe_work_func
>     pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>     pc : drm_bridge_hpd_enable+0x94/0x9c [drm]
>     lr : drm_bridge_hpd_enable+0x94/0x9c [drm]
>     sp : ffff800009ef3740
>     x29: ffff800009ef3740 x28: ffff000009331f00 x27: 0000000000001000
>     x26: 0000000000000020 x25: ffff800001148ed8 x24: ffff00000a8fe000
>     x23: 00000000fffffffd x22: ffff000005086348 x21: ffff800001133ee0
>     x20: ffff00000550d800 x19: ffff000005086288 x18: 0000000000000006
>     x17: 0000000000000000 x16: ffff8000096ef008 x15: 97ffff2891004260
>     x14: 2a1403e194000000 x13: 97ffff2891004260 x12: 2a1403e194000000
>     x11: 7100385f29400801 x10: 0000000000000aa0 x9 : ffff800008112744
>     x8 : ffff000000250b00 x7 : 0000000000000003 x6 : 0000000000000011
>     x5 : 0000000000000000 x4 : ffff0000bd986a48 x3 : 0000000000000001
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000000250000
>     Call trace:
>      drm_bridge_hpd_enable+0x94/0x9c [drm]
>      drm_bridge_connector_enable_hpd+0x2c/0x3c [drm_kms_helper]
>      drm_kms_helper_poll_enable+0x94/0x10c [drm_kms_helper]
>      drm_helper_probe_single_connector_modes+0x1a8/0x510 [drm_kms_helper]
>      drm_client_modeset_probe+0x204/0x1190 [drm]
>      __drm_fb_helper_initial_config_and_unlock+0x5c/0x4a4 [drm_kms_helper=
]
>      drm_fb_helper_initial_config+0x54/0x6c [drm_kms_helper]
>      drm_fbdev_client_hotplug+0xd0/0x140 [drm_kms_helper]
>      drm_fbdev_generic_setup+0x90/0x154 [drm_kms_helper]
>      dcss_kms_attach+0x1c8/0x254 [imx_dcss]
>      dcss_drv_platform_probe+0x90/0xfc [imx_dcss]
>      platform_probe+0x70/0xcc
>      really_probe+0xc4/0x2e0
>      __driver_probe_device+0x80/0xf0
>      driver_probe_device+0xe0/0x164
>      __device_attach_driver+0xc0/0x13c
>      bus_for_each_drv+0x84/0xe0
>      __device_attach+0xa4/0x1a0
>      device_initial_probe+0x1c/0x30
>      bus_probe_device+0xa4/0xb0
>      deferred_probe_work_func+0x90/0xd0
>      process_one_work+0x200/0x474
>      worker_thread+0x74/0x43c
>      kthread+0xfc/0x110
>      ret_from_fork+0x10/0x20
>     ---[ end trace 0000000000000000 ]---
>
>     Reported-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>     Fixes: c8268795c9a9 ("drm/probe-helper: enable and disable HPD on
> connectors")
>     Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>     Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>     Acked-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>     Tested-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>     Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
>     Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20230124104548.32=
34554-2-dmitry.baryshkov@linaro.org
>     (cherry picked from commit d33a54e3991dfce88b4fc6d9c3360951c2c5660d)
>     Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>  drivers/gpu/drm/drm_probe_helper.c | 42 +++++++++++++++++++-------------=
------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> Of course I tried to check the bisect assumption by reverting this
> commit. And I can confirm without commit
> a4e771729a51168bc36317effaa9962e336d4f5e the warning messages do not
> appear within a day.
>
> I attached a full kernel log if someone would be interested to see it.

See:
https://gitlab.freedesktop.org/drm/amd/-/issues/2411

Alex
