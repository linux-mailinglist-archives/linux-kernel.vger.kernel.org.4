Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D55B986F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIOKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIOKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:03:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD175BFB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:03:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d1so132738eje.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=/Qjns2dzKwXVZXVl3GhSLCuKlWy3lxC1uL56WyORvEw=;
        b=IGwCCzT8moNWTMnenQU0zJgN9i0Dm6pXPBDDiUley2co6Mt/bCBo444V3TEgSR5klD
         2J3hueFcrmf8IQ6hk2vTVPT136lsw0cjTpy9hdF4SKGkBCUEGw/EJRdXzj+dA/Wty6BS
         FY6fR6AV75IJtpAykDkqd8RW2qCw3TKNdC1bzbGDw2Cd1tRCgy9UPqT5g4BEvEWiIs9n
         rArB5fn/YKtpC0HIVPNepLThMIjR2Z21vSRjgkxq2qfr98PMZJLpapAPJbtYDAdhei8A
         EE08b247Bj4Fo0Cb4gfBco0TRs50cLVM7Uk6B2CERRKBxS5gpQuzYQyZhWCwyRaQ5QZB
         aA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/Qjns2dzKwXVZXVl3GhSLCuKlWy3lxC1uL56WyORvEw=;
        b=rGyMVsOfUbvmLh7mu9smiNguZ2xlXGHcbjphzgnXjugLZhv6S1upmZr1qqNh1Y71/z
         gGcYE+D23+nEJBd9+xuEYh4haJamOGCAt5a5qwdyRvcYQLU+OKUE0eb+a8mlBQFSRb7f
         IQqLtySD2KbREC/fsPWuoL4quq45XsSrNf/qZUKFGDk9OEx3lTcTSeiWGvapowS4zbMM
         n4ur5Jl0X2RvWZljAumn41OuC6RRIzi0IESaBYI5+YLJLFgkbOawsWEO0GOQxe/QgF5X
         IxCYH6W+k0taX18csatrByhoFhzUljvTpCRIJZNdA0BCQwJs+jQpZrCWUjEmOoURtg4S
         udeA==
X-Gm-Message-State: ACgBeo17ziHDLknZJiwNvIaDEbp2V6oFCdp2osMICq9uEOjNT33i+fhW
        5+yOgZhGTB2UkYEV9LWriWmmGOmKXaa2cuUv0YtPceMW8bXmJQ==
X-Google-Smtp-Source: AA6agR5O37e9BO1OiO7vo4wy2KRm+B2q/VSBc+rRJp8mnHigIpjvVuNEwLTk24TmX311pmQacCt5tk1Gh+Pfx3Hyw4U=
X-Received: by 2002:a17:907:7f8e:b0:770:7c67:f522 with SMTP id
 qk14-20020a1709077f8e00b007707c67f522mr28665684ejc.366.1663236230175; Thu, 15
 Sep 2022 03:03:50 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Sep 2022 15:33:38 +0530
Message-ID: <CA+G9fYuRouC_n1keb1fJXU9hap2MjEkUaOFGegVHebaiw=wjig@mail.gmail.com>
Subject: dragonboard 410c: Internal error: Oops: 96000006 on 6.0.0-rc5.
To:     open list <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
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

Following kernel crash log reported on arm64 Qcomm dragonboard-410c device
while booting Linux mainline kernel 6.0.0-rc5.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This reported crash is not always reproducible.

[    9.122741] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000134
[    9.122978] Mem abort info:
[    9.130984]   ESR = 0x0000000096000006
[    9.131001]   EC = 0x25: DABT (current EL), IL = 32 bits
[    9.131012]   SET = 0, FnV = 0
[    9.131020]   EA = 0, S1PTW = 0
[    9.131027]   FSC = 0x06: level 2 translation fault
[    9.131036] Data abort info:
[    9.131043]   ISV = 0, ISS = 0x00000006
[    9.131050]   CM = 0, WnR = 0
[    9.131059] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008d8a2000
[    9.131069] [0000000000000134] pgd=080000008d8aa003,
p4d=080000008d8aa003, pud=080000008d8ab003, pmd=0000000000000000
[    9.131112] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[    9.131121] Modules linked in: qcom_wcnss_pil adv7511 cec
snd_soc_lpass_apq8016 snd_soc_msm8916_digital snd_soc_apq8016_sbc
snd_soc_lpass_cpu snd_soc_qcom_common snd_soc_lpass_platform
snd_soc_msm8916_analog qrtr qcom_spmi_temp_alarm qcom_q6v5_mss
qcom_pon qcom_spmi_vadc qcom_pil_info qcom_q6v5 qcom_sysmon rtc_pm8xxx
qcom_vadc_common qcom_common qcom_glink_smem qcom_camss
videobuf2_dma_sg venus_core qmi_helpers qnoc_msm8916 qcom_rng msm
v4l2_mem2mem qcom_stats v4l2_fwnode mdt_loader v4l2_async
videobuf2_memops i2c_qcom_cci videobuf2_v4l2 videobuf2_common
gpu_sched drm_dp_aux_bus drm_display_helper icc_smd_rpm crct10dif_ce
display_connector drm_kms_helper rmtfs_mem socinfo fuse drm
[    9.131287] CPU: 0 PID: 328 Comm: v4l_id Not tainted 6.0.0-rc5 #1
[    9.131296] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    9.131301] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.131310] pc : __mutex_lock.constprop.0+0x80/0x570
[    9.131329] lr : __mutex_lock.constprop.0+0x48/0x570
[    9.131338] sp : ffff80000c4e39a0
         Starting Rebuild Journal Catalog[    9.131342] x29:
ffff80000c4e39a0 x28: ffff80000c4e3c70 x27: 0000000000000000
[    9.131368] x23: ffff0000058bd108 x22: ffff0000022be278 x21: 0000000000000002
[    9.131382] x20: 0000000000000001 x19: ffff0000022be278 x18: 0000000000000000
[  [    9.131408] x14: ffffffffffffffff x13: ffff000003637025 x12:
ffff80000c4e3cb4
[    9.131421] x11: 00000006955fc5f6 x10: 0000000000000002 x9 : ffff8000093fb84c
[    9.131434] x8 : ffff00000cfc9900 x7 : 0000000000000000 x6 : 0000000000000001
[    9.131447] x5 : ffff80000aa5f2e8 x4 : ffff0000022ae300 x3 : 0000000000000100
[    9.131460] x2 : ffff0000022ae300 x1 : 0000000000000100 x0 : 0000000000000100
[    9.131474] Call trace:
[    9.131478]  __mutex_lock.constprop.0+0x80/0x570
[    9.131489]  __mutex_lock_slowpath+0x1c/0x2c
[    9.131499]  mutex_lock+0x4c/0x60
[    9.131507]  v4l2_pipeline_pm_use+0x3c/0xa0
[    9.131516]  v4l2_pipeline_pm_get+0x1c/0x30
[    9.131524]  video_open+0x7c/0xe0 [qcom_camss]
[    9.131579]  v4l2_open+0xb0/0x130
[    9.131592]  chrdev_open+0xc8/0x230
[    9.131601]  do_dentry_open+0x134/0x3f0
[    9.131612]  vfs_open+0x34/0x40
[    9.131620]  path_openat+0x8c0/0xe64
[    9.131630]  do_filp_open+0x88/0x134
[    9.131640]  do_sys_openat2+0xbc/0x174
[    9.131648]  __arm64_sys_openat+0x68/0xb0
[    9.131657]  invoke_syscall+0x50/0x120
[    9.131669]  el0_svc_common.constprop.0+0x104/0x124
[    9.131679]  do_el0_svc+0x38/0xd0
[    9.131688]  el0_svc+0x30/0x94
[    9.131697]  el0t_64_sync_handler+0xbc/0x140
[    9.131705]  el0t_64_sync+0x18c/0x190
[    9.131718] Code: 540000c1 f9400260 f27df000 54001a60 (b9403401)
[    9.131726] ---[ end trace 0000000000000000 ]---
[    9.131732] note: v4l_id[328] exited with preempt_count 1
[    9.148208] remoteproc remoteproc1: remote processor
a204000.remoteproc is now up
[    9.162458] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000134
[    9.195610] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000134
[    9.223604] Mem abort info:
[    9.223616]   ESR = 0x0000000096000006
[    9.223626]   EC = 0x25: DABT (current EL), IL = 32 bits
[    9.223637]   SET = 0, FnV = 0
[    9.223645]   EA = 0, S1PTW = 0
[    9.223653]   FSC = 0x06: level 2 translation fault
[    9.223662] Data abort info:
[    9.223669]   ISV = 0, ISS = 0x00000006
[    9.223676]   CM = 0, WnR = 0
[    9.223685] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008ce7a000
[    9.245821] Mem abort info:
[    9.245835]   ESR = 0x0000000096000006
[    9.251896] [0000000000000134] pgd=080000008ce82003, p4d=080000008ce82003
[    9.255295] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000134
[    9.255315] Mem abort info:
[    9.255322]   ESR = 0x0000000096000006
[    9.255330]   EC = 0x25: DABT (current EL), IL = 32 bits
[    9.255340]   SET = 0, FnV = 0
[    9.255348]   EA = 0, S1PTW = 0
[    9.255355]   FSC = 0x06: level 2 translation fault
[    9.255363] Data abort info:
[    9.255370]   ISV = 0, ISS = 0x00000006
[    9.255377]   CM = 0, WnR = 0
[    9.255385] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008ce6c000
[    9.255395] [0000000000000134] pgd=080000008d8ea003,
p4d=080000008d8ea003, pud=080000008d8eb003, pmd=0000000000000000
[    9.255436] Internal error: Oops: 96000006 [#2] PREEMPT SMP
[    9.255444] Modules linked in: qcom_wcnss_pil adv7511 cec
snd_soc_lpass_apq8016 snd_soc_msm8916_digital snd_soc_apq8016_sbc
snd_soc_lpass_cpu snd_soc_qcom_common snd_soc_lpass_platform
snd_soc_msm8916_analog qrtr qcom_spmi_temp_alarm qcom_q6v5_mss
qcom_pon qcom_spmi_vadc qcom_pil_info qcom_q6v5 qcom_sysmon rtc_pm8xxx
qcom_vadc_common qcom_common qcom_glink_smem qcom_camss
videobuf2_dma_sg venus_core qmi_helpers qnoc_msm8916 qcom_rng msm
v4l2_mem2mem qcom_stats v4l2_fwnode mdt_loader v4l2_async
videobuf2_memops i2c_qcom_cci videobuf2_v4l2 videobuf2_common
gpu_sched drm_dp_aux_bus drm_display_helper icc_smd_rpm crct10dif_ce
display_connector drm_kms_helper rmtfs_mem socinfo fuse drm
[    9.255606] CPU: 3 PID: 327 Comm: v4l_id Tainted: G      D
  6.0.0-rc5 #1
[    9.255615] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    9.255621] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.255630] pc : __mutex_lock.constprop.0+0x80/0x570
[    9.255646] lr : __mutex_lock.constprop.0+0x48/0x570
[    9.255655] sp : ffff80000bca39a0
[    9.255659] x29: ffff80000bca39a0 x28: ffff80000bca3c70 x27: 0000000000000000
[    9.255673] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    9.255686] x23: ffff0000058bc3c8 x22: ffff0000022be278 x21: 0000000000000002
[    9.255699] x20: 0000000000000001 x19: ffff0000022be278 x18: 0000000000000000
[    9.255712] x17: 0000000000000000 x16: ffff800008f910e0 x15: 0000000000000000
[    9.255725] x14: ffffffffffffffff x13: ffff000003fc8025 x12: ffff80000bca3cb4
[    9.255739] x11: 00000006a55e0cf6 x10: 0000000000000002 x9 : ffff8000093fb84c
[    9.255752] x8 : ffff00000a351700 x7 : 0000000000000000 x6 : 0000000000000001
[    9.255764] x5 : ffff80000aa5f2e8 x4 : ffff000003e19080 x3 : 0000000000000100
[    9.255777] x2 : ffff000003e19080 x1 : 0000000000000100 x0 : 0000000000000100
[    9.255791] Call trace:
[    9.255794]  __mutex_lock.constprop.0+0x80/0x570
[    9.255804]  __mutex_lock_slowpath+0x1c/0x2c
[    9.255813]  mutex_lock+0x4c/0x60
[    9.255822]  v4l2_pipeline_pm_use+0x3c/0xa0
[    9.255831]  v4l2_pipeline_pm_get+0x1c/0x30
[    9.255839]  video_open+0x7c/0xe0 [qcom_camss]
[    9.255889]  v4l2_open+0xb0/0x130
[    9.255902]  chrdev_open+0xc8/0x230
[    9.255911]  do_dentry_open+0x134/0x3f0
[    9.255920]  vfs_open+0x34/0x40
[    9.255928]  path_openat+0x8c0/0xe64
[    9.255938]  do_filp_open+0x88/0x134
[    9.255948]  do_sys_openat2+0xbc/0x174
[    9.255956]  __arm64_sys_openat+0x68/0xb0
[    9.255965]  invoke_syscall+0x50/0x120
[    9.255976]  el0_svc_common.constprop.0+0x104/0x124
[    9.255986]  do_el0_svc+0x38/0xd0
[    9.255995]  el0_svc+0x30/0x94
[    9.256004]  el0t_64_sync_handler+0xbc/0x140
[    9.256012]  el0t_64_sync+0x18c/0x190
[    9.256024] Code: 540000c1 f9400260 f27df000 54001a60 (b9403401)
[    9.256031] ---[ end trace 0000000000000000 ]---
[    9.256059] note: v4l_id[327] exited with preempt_count 1
[    9.258661]   EC = 0x25: DABT (current EL), IL = 32 bits
[    9.265353] , pud=080000008ce83003
[    9.270551]   SET = 0, FnV = 0
[    9.275499] , pmd=0000000000000000
[    9.283425]   EA = 0, S1PTW = 0
[    9.291911]
[    9.291934]   FSC = 0x06: level 2 translation fault
[    9.298032] Internal error: Oops: 96000006 [#3] PREEMPT SMP
[    9.305146] Data abort info:
[    9.305307] Modules linked in:
[    9.312531]   ISV = 0, ISS = 0x00000006
[    9.319629]  qcom_wcnss_pil adv7511 cec snd_soc_lpass_apq8016
snd_soc_msm8916_digital snd_soc_apq8016_sbc
[    9.326762]   CM = 0, WnR = 0
[    9.333863]  snd_soc_lpass_cpu snd_soc_qcom_common
snd_soc_lpass_platform snd_soc_msm8916_analog qrtr
qcom_spmi_temp_alarm
[    9.340993] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008d581000
[    9.343236]  qcom_q6v5_mss qcom_pon qcom_spmi_vadc qcom_pil_info
qcom_q6v5 qcom_sysmon rtc_pm8xxx
[    9.348113] [0000000000000134] pgd=080000008d578003
[    9.352348]  qcom_vadc_common qcom_common qcom_glink_smem
qcom_camss videobuf2_dma_sg venus_core qmi_helpers
[    9.355580] , p4d=080000008d578003
[    9.359554]  qnoc_msm8916 qcom_rng msm v4l2_mem2mem qcom_stats v4l2_fwnode
[    9.363738] , pud=080000008d577003
[    9.368233]  mdt_loader v4l2_async videobuf2_memops i2c_qcom_cci
videobuf2_v4l2 videobuf2_common gpu_sched drm_dp_aux_bus
[    9.371638] , pmd=0000000000000000
[    9.374918]  drm_display_helper icc_smd_rpm crct10dif_ce
display_connector drm_kms_helper rmtfs_mem socinfo
[    9.378754]
[    9.381862]  fuse drm
[    9.381876] CPU: 2 PID: 329 Comm: v4l_id Tainted: G      D
  6.0.0-rc5 #1
[    9.381887] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   10.175885] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.175900] pc : __mutex_lock.constprop.0+0x80/0x570
         Starting Network Time Synchronization.
[   10.190145] lr : __mutex_lock.constprop.0+0x48/0x570
[   10.190164] x29: ffff80000c4db9a0 x28: ffff80000c4dbc70 x27: 0000000000000000
[   10.207157] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   10.207175] x23: ffff0000058bde48 x22: ffff0000022be278 x21: 0000000000000002
[   10.207190] x20: 0000000000000001 x19: ffff0000022be278 x18: 0000000000000000
[   10.207203] x17: 0000000000000000 x16: ffff800008f910e0 x15: 0000000000000000
[   10.207216] x14: ffffffffffffffff x13: ffff000002204025 x12: ffff80000c4dbcb4
[   10.207229] x11: 0000000685617ef6 x10: 0000000000000002 x9 : ffff8000093fb84c
[   10.207242] x8 : ffff00000ce67000 x7 : 0000000000000000 x6 : 0000000000000001
[   10.207255] x5 : ffff80000aa5f2e8 x4 : ffff000004eb4200 x3 : 0000000000000100
[   10.207268] x2 : ffff000004eb4200 x1 : 0000000000000100 x0 : 0000000000000100
[   10.207282] Call trace:
[   10.207286]  __mutex_lock.constprop.0+0x80/0x570
[   10.207306]  __mutex_lock_slowpath+0x1c/0x2c
[   10.294349]  mutex_lock+0x4c/0x60
[   10.294367]  v4l2_pipeline_pm_use+0x3c/0xa0
         Starting Record System Boot/Shutdown in UTMP[   10.294377]
v4l2_pipeline_pm_get+0x1c/0x30
.
[   10.314976]  video_open+0x7c/0xe0 [qcom_camss]
[   10.315030]  v4l2_open+0xb0/0x130
[   10.326795]  chrdev_open+0xc8/0x230
[   10.326808]  do_dentry_open+0x134/0x3f0
[   10.326818]  vfs_open+0x34/0x40
[   10.341739]  path_openat+0x8c0/0xe64
[   10.341752]  do_filp_open+0x88/0x134
[   10.341762]  do_sys_openat2+0xbc/0x174
[   10.341771]  __arm64_sys_openat+0x68/0xb0
[   10.361322]  invoke_syscall+0x50/0x120
[   10.361341]  el0_svc_common.constprop.0+0x104/0x124
[   10.361353]  do_el0_svc+0x38/0xd0
[   10.361362]  el0_svc+0x30/0x94
[   10.361371]  el0t_64_sync_handler+0xbc/0x140
[   10.385704]  el0t_64_sync+0x18c/0x190
[   10.385724] Code: 540000c1 f9400260 f27df000 54001a60 (b9403401)
[   10.385732] ---[ end trace 0000000000000000 ]---
[   10.403024] Internal error: Oops: 96000006 [#4] PREEMPT SMP
[   10.403059] note: v4l_id[329] exited with preempt_count 1
[   10.407359] Modules linked in: qcom_wcnss_pil adv7511 cec
snd_soc_lpass_apq8016 snd_soc_msm8916_digital snd_soc_apq8016_sbc
snd_soc_lpass_cpu snd_soc_qcom_common snd_soc_lpass_platform
snd_soc_msm8916_analog qrtr qcom_spmi_temp_alarm qcom_q6v5_mss
qcom_pon qcom_spmi_vadc qcom_pil_info qcom_q6v5 qcom_sysmon rtc_pm8xxx
qcom_vadc_common qcom_common qcom_glink_smem qcom_camss
videobuf2_dma_sg venus_core qmi_helpers qnoc_msm8916 qcom_rng msm
v4l2_mem2mem qcom_stats v4l2_fwnode mdt_loader v4l2_async
videobuf2_memops i2c_qcom_cci videobuf2_v4l2 videobuf2_common
gpu_sched drm_dp_aux_bus drm_display_helper icc_smd_rpm crct10dif_ce
display_connector drm_kms_helper rmtfs_mem socinfo fuse drm
[   10.465667] CPU: 1 PID: 330 Comm: v4l_id Tainted: G      D
  6.0.0-rc5 #1
[   10.478341] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   10.485848] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.492737] pc : __mutex_lock.constprop.0+0x80/0x570
[   10.499407] lr : __mutex_lock.constprop.0+0x48/0x570
[   10.504587] sp : ffff80000b75b9a0
[   10.509764] x29: ffff80000b75b9a0 x28: ffff80000b75bc70 x27: 0000000000000000
[   10.515035] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   10.521043] x23: ffff0000058beb88 x22: ffff0000022be278 x21: 0000000000000002
[   10.528097] x20: 0000000000000001 x19: ffff0000022be278 x18: 0000000000000000
[   10.535121] x17: 0000000000000000 x16: ffff800008f910e0 x15: 0000000000000000
[   10.542139] x14: ffffffffffffffff x13: ffff000003cb7025 x12: ffff80000b75bcb4
[   10.549215] x11: 00000006756337f6 x10: 0000000000000002 x9 : ffff8000093fb84c
[   10.556296] x8 : ffff00000a2c2900 x7 : 0000000000000000 x6 : 0000000000000001
[   10.563344] x5 : ffff80000aa5f2e8 x4 : ffff000003e18000 x3 : 0000000000000100
[   10.570394] x2 : ffff000003e18000 x1 : 0000000000000100 x0 : 0000000000000100
[   10.577473] Call trace:
[   10.584521]  __mutex_lock.constprop.0+0x80/0x570
[   10.589079]  __mutex_lock_slowpath+0x1c/0x2c
[   10.593533]  mutex_lock+0x4c/0x60
[   10.597904]  v4l2_pipeline_pm_use+0x3c/0xa0
[   10.602216]  v4l2_pipeline_pm_get+0x1c/0x30
[   10.606527]  video_open+0x7c/0xe0 [qcom_camss]
[   10.610865]  v4l2_open+0xb0/0x130
[   10.615108]  chrdev_open+0xc8/0x230
[   10.619301]  do_dentry_open+0x134/0x3f0
[   10.623460]  vfs_open+0x34/0x40
[   10.627632]  path_openat+0x8c0/0xe64
[   10.631798]  do_filp_open+0x88/0x134
[   10.635937]  do_sys_openat2+0xbc/0x174
[   10.640067]  __arm64_sys_openat+0x68/0xb0
[   10.644195]  invoke_syscall+0x50/0x120
[   10.648331]  el0_svc_common.constprop.0+0x104/0x124
[   10.652505]  do_el0_svc+0x38/0xd0
[   10.656650]  el0_svc+0x30/0x94
[   10.660766]  el0t_64_sync_handler+0xbc/0x140
[   10.664891]  el0t_64_sync+0x18c/0x190
[   10.669005] Code: 540000c1 f9400260 f27df000 54001a60 (b9403401)
[   10.673182] ---[ end trace 0000000000000000 ]---
[   10.678377] note: v4l_id[330] exited with preempt_count 1

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/5528977#L2630

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 3245cb65fd91cd514801bf91f5a3066d562f0ac4
  git_describe: v6.0-rc5-25-g3245cb65fd91
  kernel_version: 6.0.0-rc5
  kernel-config: https://builds.tuxbuild.com/2Ekrm9xSlRYzXBPItNu5631aN7K/config
  vmlinux.xz: https://builds.tuxbuild.com/2Ekrm9xSlRYzXBPItNu5631aN7K/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2Ekrm9xSlRYzXBPItNu5631aN7K/System.map
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/639865874
  artifact-location: https://builds.tuxbuild.com/2Ekrm9xSlRYzXBPItNu5631aN7K
  toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org
