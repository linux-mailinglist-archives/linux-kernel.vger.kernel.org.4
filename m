Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7995FC120
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJLHOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJLHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:14:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE62EACA18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:14:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ot12so36129499ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YrM9AXlV+Yjz/9a/UJEjVSeS2W/2GJxeJBViYwkeKi4=;
        b=xx9DmA2R9fhxOFt5zZzL388ykcEA0OZ41CtirZW6S8buUf7v7owkLzNIxcXAHOi6Tz
         l4pAVGmOtmds4fDSL5epMx/nRkLHo+aLiprPK+Jiv/0ur6h4IzZihW9xgX60NaE+hXJw
         RexcrilSlSgOybR3f8r6U7Dd+HmvnhQOhwC1YPuLx4SBj1BEiln0fzV1R/x58XZ+7pK9
         D8xhuyW0dAQquwB0Je+cUS4fOeScDefHBgc5viN1yxGWAj3bkdyOmv0vARimtoiEpUCY
         XBAvUH8WjfpQC+4y7EHze82FIr2cXqCu0fX4drAdsfjMl1Bxq4sgUPE1iMwZLw8L8i4E
         MWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrM9AXlV+Yjz/9a/UJEjVSeS2W/2GJxeJBViYwkeKi4=;
        b=qJRcoDnjvxtlM8BIXqX9lQqtBJkR2BiM5y708MDP01mrRWc/DMRu47PSKTjrnuiGzV
         4Q+FYopRYzWsAVwDYfD3381DKn4IuUCGZ2D2OT7PbmCF8pFusNalZGbgUyx/Pq31Velp
         6+hRuyeaUHohrVHzar6/XH/94AWV0YO3plWXpVU8BZfk1t1wGQeNjLN+/RJtG7vb16fg
         WKxYw2SeZ57/lgsr1BVIYkE81IpSqGo2v5TCGBbD1lmlc4ZGp/+Z1gOlDbv9hsot3qK3
         A5O3XA9+CUPg3b/FEi5ZJzv5oQMysG39VrsuIjbMKJaehbfnAOalg9hxoriahywN7aWd
         FOiQ==
X-Gm-Message-State: ACrzQf2sU+gplMhjk6gMjd2+le96glkgNVsKqV8gyIoHFIy4RgiWc7aw
        2uWG55l4lp/O+lZPVYXFyzaqUtn7/bAJ0ZoPIZMyUBJzzX6aVQ==
X-Google-Smtp-Source: AMsMyM6E4SM+zZlolmoE6H3BmvWqVXRVc5lrG4wh55M0bG/S+1eFG2HnwNgr10MxMz/k8FipbNygY2Kx2InJ1lRV+zI=
X-Received: by 2002:a17:906:fe46:b0:73d:939a:ec99 with SMTP id
 wz6-20020a170906fe4600b0073d939aec99mr22106337ejb.169.1665558852523; Wed, 12
 Oct 2022 00:14:12 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Oct 2022 12:44:01 +0530
Message-ID: <CA+G9fYuB1-qmObe3L0A0oUDXXaWa=-UxOEGtEWWJ-=_wc791Uw@mail.gmail.com>
Subject: db410c: WARNING: CPU: 1 PID: 272 at lib/list_debug.c:30 __list_add_valid
To:     open list <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel warnings noticed on arm64 Qcom db410c device
While booting Linux next 20221012 tag kernel Image and kselftest configs.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[   29.295284] ------------[ cut here ]------------
[   29.295685] list_add corruption. prev->next should be next
(ffff000004735300), but was 0000000000000000. (prev=ffff000010693750).
[   29.299665] WARNING: CPU: 1 PID: 272 at lib/list_debug.c:30
__list_add_valid+0xdc/0x110
[   29.310921] Modules linked in: snd_soc_msm8916_digital(+)
qcom_pil_info(+) msm(+) qcom_q6v5 qcom_sysmon qcom_common
venus_core(+) qcom_glink_smem qmi_helpers v4l2_mem2mem llcc_qcom
qcom_camss qcom_stats qcom_rng qnoc_msm8916 mdt_loader
videobuf2_dma_sg v4l2_fwnode ocmem v4l2_async gpu_sched
videobuf2_memops drm_dp_aux_bus videobuf2_v4l2 i2c_qcom_cci
videobuf2_common drm_display_helper icc_smd_rpm rpmsg_ctrl rpmsg_char
display_connector drm_kms_helper rmtfs_mem sch_fq_codel socinfo fuse
drm
[   29.340698] CPU: 1 PID: 272 Comm: systemd-udevd Not tainted
6.0.0-next-20221012 #1
[   29.362124] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   29.369650] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   29.376514] pc : __list_add_valid+0xdc/0x110
[   29.383136] lr : __list_add_valid+0xdc/0x110
[   29.387648] sp : ffff80000c70b3d0
[   29.391879] x29: ffff80000c70b3d0 x28: ffff80000c70bb10 x27: ffff800037c6cdc8
[   29.395178] x26: 0000000000000000 x25: ffff000005472010 x24: 0000000000000001
[   29.402296] x23: ffff000010580818 x22: ffff000010693750 x21: ffff000010580818
[   29.409418] x20: ffff000010693750 x19: ffff000004735300 x18: 0000000000000000
[   29.416533] x17: 3030333533373430 x16: 3030303066666666 x15: 0720072007200720
[   29.423652] x14: 072e072907300735 x13: 0720072007200720 x12: 072e072907300735
[   29.430769] x11: ffff80000b510340 x10: 0720072007200720 x9 : ffff8000081d3c28
[   29.437889] x8 : ffff80000c70b0a8 x7 : ffff80000aff78b8 x6 : 0000000000057fa8
[   29.445007] x5 : 0000000000000fff x4 : ffff00003fc4cc50 x3 : ffff8000356cc000
[   29.452125] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000a2e1b00
[   29.459243] Call trace:
[   29.466253]  __list_add_valid+0xdc/0x110
[   29.468541]  kobject_add_internal+0x78/0x2c0
[   29.472718]  kobject_add+0xa0/0x110
[   29.476952]  device_add+0x108/0x930
[   29.480165]  of_device_add+0x4c/0x70
[   29.483640]  of_platform_device_create_pdata+0x9c/0x130
[   29.487496]  of_platform_bus_create+0x1c4/0x4f0
[   29.492428]  of_platform_populate+0x70/0x160
[   29.496937]  venus_probe+0x314/0x4b4 [venus_core]
[   29.501464]  platform_probe+0x70/0x100
[   29.506041]  really_probe+0xd4/0x3f4
[   29.509680]  __driver_probe_device+0x8c/0x1a0
[   29.513430]  driver_probe_device+0x4c/0x13c
[   29.517680]  __driver_attach+0xc8/0x250
[   29.521666]  bus_for_each_dev+0x80/0xdc
[   29.525485]  driver_attach+0x34/0x4c
[   29.529300]  bus_add_driver+0x1a4/0x260
[   29.533124]  driver_register+0x7c/0x13c
[   29.536681]  __platform_driver_register+0x38/0x4c
[   29.540522]  qcom_venus_driver_init+0x28/0x1000 [venus_core]
[   29.545409]  do_one_initcall+0x80/0x43c
[   29.551093]  do_init_module+0x50/0x210
[   29.554648]  load_module+0x1de0/0x22b4
[   29.558467]  __do_sys_finit_module+0xb0/0x130
[   29.562214]  __arm64_sys_finit_module+0x2c/0x40
[   29.566646]  invoke_syscall+0x8c/0x120
[   29.570969]  el0_svc_common.constprop.0+0x104/0x124
[   29.574814]  do_el0_svc+0x44/0xcc
[   29.579554]  el0_svc+0x48/0xc0
[   29.583020]  el0t_64_sync_handler+0xbc/0x13c
[   29.585997]  el0t_64_sync+0x18c/0x190
[   29.590413] irq event stamp: 149728
[   29.593964] hardirqs last  enabled at (149727):
[<ffff8000081d392c>] __up_console_sem+0x78/0x7c
[   29.597389] hardirqs last disabled at (149728):
[<ffff80000976df44>] el1_dbg+0x24/0x90
[   29.606054] softirqs last  enabled at (148374):
[<ffff800008090be4>] __do_softirq+0x514/0x62c
[   29.614055] softirqs last disabled at (148365):
[<ffff800008097558>] ____do_softirq+0x18/0x24
[   29.622648] ---[ end trace 0000000000000000 ]---
[   29.634248] ------------[ cut here ]------------
[   29.635814] list_add corruption. prev->next should be next
(ffff80000b348928), but was 0000000000000000. (prev=ffff0000106938e0).
[   29.640666] WARNING: CPU: 1 PID: 272 at lib/list_debug.c:30
__list_add_valid+0xdc/0x110

Full boot log link,
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221012/testrun/12360228/suite/log-parser-boot/test/check-kernel-exception/log
 - https://lkft.validation.linaro.org/scheduler/job/5660724#L2717

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: f843795727e4f5612c612cd178db1557978da742
  git_describe: next-20221012
  kernel_version: 6.0.0
  kernel-config: https://builds.tuxbuild.com/2G10hEBW0Cdgh2jzrxvNzlRXdec/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/664367901
  artifact-location: https://builds.tuxbuild.com/2G10hEBW0Cdgh2jzrxvNzlRXdec
  toolchain: gcc-11
  System.map: https://builds.tuxbuild.com/2G10hEBW0Cdgh2jzrxvNzlRXdec/System.map
  vmlinux.xz: https://builds.tuxbuild.com/2G10hEBW0Cdgh2jzrxvNzlRXdec/vmlinux.xz


--
Linaro LKFT
https://lkft.linaro.org
