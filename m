Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F906DF017
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDLJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:15:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1D100
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:15:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v7so9479857ybi.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681290940; x=1683882940;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4QoMYbCHBULDwPZmE/i1/T9z4EvtEBKckR0ihDTwwPw=;
        b=Wy4ONxeColGe8sjIhX/boO16Grw2Z5WQSvTUKWpRocb6x38Yuc7oFP4lMyhhB4/Upl
         VHEIFsApw2xFfSbhHhVKLUuQAgaY/mBicjUBICAgXyt8DMGhsu3nBOmAPa/G468VngeO
         UuMN8L4IAa8jIVEKuwmDwMXZvwBTeQYuvVObxQk2SzydGOeBgTsaq2Q7nWTBAWbtLvpf
         Dix4+BP6UMe3K95vEXlrnWdIWyCZD2QTJ0ceTTjCebHUtnw2jiy8rYpn2KFw0dThPzMm
         Y0lj/jeh6T/FsTmpCTh+EuxrA8S9f8Z/tWTUN0wntLpRNjccPUpextGUmSSgIdgGui/X
         /foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681290940; x=1683882940;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QoMYbCHBULDwPZmE/i1/T9z4EvtEBKckR0ihDTwwPw=;
        b=xBIn+J1olhUkuVTcBb7LG7i38Sc2tFWMTGfI9sMZv48PKEp3dK0qi4bLFHn+qfoAnV
         GDyGcIxA70wEWQ4uxwon2yukVY94lrComP1TTR15fbfMO7HevrFoNVlxoedaLNEYf36V
         DkghKcFdNFQjpyodVedE8RISmAbE1oIrWL4mDzmfP36du+MOI3Pbf/vGO2uzGbNrUhek
         NQqMIwnJCCvfwyfdYDrTfVff5w7vfljIRrTZFrmd4/40m19NF6Ub5VO2EDEqFtUjmAB1
         ssuVs9/A49RQ2HrscC+bdgS/YdNgOsbQ6ihl9xJcEF8KmqfDRbaG3eNr03Dx6uW2l+l3
         WAyg==
X-Gm-Message-State: AAQBX9cSrzkm01IfvIhP1tcGLGhlI5USgOd4zr8icF9z33hU1r6gDwBA
        EUQG8YGvY3HDTce0vqjDGlYRQTYZgfC8YT3keA==
X-Google-Smtp-Source: AKy350YCzOezy3P7htngYrTrNP5gL9p+d9ZO3rpBGc2a3PnnTBleii6m2bIuFT71My6fcLqNgHznx9iULV4u4SZ4+gQ=
X-Received: by 2002:a25:d884:0:b0:b8e:f1ef:a144 with SMTP id
 p126-20020a25d884000000b00b8ef1efa144mr1571606ybg.0.1681290940273; Wed, 12
 Apr 2023 02:15:40 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 12 Apr 2023 10:15:29 +0100
Message-ID: <CALjTZvZ=Y1psyd0nmfzm6GhqMKvq5V_NQCWb_X02nasp1CpfcQ@mail.gmail.com>
Subject: [BUG?] INFO: rcu_sched detected expedited stalls on CPUs/tasks: {
 0-.... } 3 jiffies s: 309 root: 0x1/.
To:     jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, paulmck@kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone,

I apologise in advance if I've sent this to {too many, the wrong}
people. For some time now, I've been getting sporadic (in about one
out of five boots) DRM-related RCU complaints on an Ivy Bridge-based
(Core i7-3720QM) Mac Mini. Call trace (on Linux 6.3-rc6) follows:

[    5.794026] rcu: INFO: rcu_sched detected expedited stalls on
CPUs/tasks: { 0-.... } 3 jiffies s: 309 root: 0x1/.
[    5.794044] rcu: blocking rcu_node structures (internal RCU debug):
[    5.794045] Sending NMI from CPU 1 to CPUs 0:
[    5.794049] NMI backtrace for cpu 0
[    5.794051] CPU: 0 PID: 537 Comm: Xorg Not tainted 6.3.0-rc6-debug+ #57
[    5.794053] Hardware name: Apple Inc.
Macmini6,2/Mac-F65AE981FFA204ED, BIOS 429.0.0.0.0 03/18/2022
[    5.794054] RIP: 0010:fwtable_read32+0x45/0x100
[    5.794060] Code: 5e 00 49 89 c5 48 8b 45 08 8b b0 2c 1d 00 00 85
f6 0f 85 94 00 00 00 8d 83 00 00 fc ff 3d ff 5f 0d 00 77 28 48 03 5d
00 8b 1b <48> 8b 45 08 8b 88 2c 1d 00 00 85 c9 75 48 4c 89 ee 4c 89 e7
e8 82
[    5.794061] RSP: 0018:ffff88810d17f968 EFLAGS: 00000082
[    5.794063] RAX: 0000000000085010 RBX: 0000000000000200 RCX: ffff888101d80000
[    5.794064] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888101d81f28
[    5.794064] RBP: ffff888101d81f08 R08: 0000000000000000 R09: 00000000000032ab
[    5.794065] R10: 0000000000000001 R11: 00000000000061b2 R12: ffff888101d81f28
[    5.794066] R13: 0000000000000246 R14: ffff888102f693d0 R15: ffff88810d17faef
[    5.794067] FS:  00007f579a20da80(0000) GS:ffff888267200000(0000)
knlGS:0000000000000000
[    5.794068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.794069] CR2: 000055fe9b660028 CR3: 0000000111e97004 CR4: 00000000001706f0
[    5.794069] Call Trace:
[    5.794071]  <TASK>
[    5.794073]  get_reserved.isra.0+0x23/0x30
[    5.794076]  get_clock+0x25/0x70
[    5.794078]  sclhi+0x43/0x70
[    5.794081]  i2c_stop+0x2b/0x40
[    5.794083]  bit_xfer+0x22a/0x5d0
[    5.794085]  ? __pm_runtime_resume+0x40/0x50
[    5.794088]  ? __intel_display_power_get_domain.part.0+0x4d/0x60
[    5.794092]  gmbus_xfer+0x3c/0x90
[    5.794094]  __i2c_transfer+0x15b/0x4d0
[    5.794096]  i2c_transfer+0x3c/0xa0
[    5.794098]  drm_do_probe_ddc_edid+0xad/0x120
[    5.794101]  drm_get_edid+0x71/0x90
[    5.794104]  intel_crt_get_edid+0xf/0x80
[    5.794106]  intel_crt_detect_ddc+0x28/0xc0
[    5.794107]  intel_crt_detect+0x1f5/0xc40
[    5.794108]  ? pollwake+0x61/0x70
[    5.794111]  drm_helper_probe_detect+0x43/0xa0
[    5.794115]  drm_helper_probe_single_connector_modes+0x403/0x490
[    5.794117]  drm_mode_getconnector+0x32d/0x430
[    5.794119]  ? drm_connector_list_iter_next+0x7c/0xa0
[    5.794120]  ? drm_connector_property_set_ioctl+0x30/0x30
[    5.794122]  drm_ioctl_kernel+0x91/0x130
[    5.794124]  drm_ioctl+0x1d8/0x410
[    5.794125]  ? drm_connector_property_set_ioctl+0x30/0x30
[    5.794127]  __x64_sys_ioctl+0x3b9/0x8f0
[    5.794129]  ? handle_mm_fault+0xc1/0x170
[    5.794131]  ? exc_page_fault+0x18b/0x470
[    5.794134]  do_syscall_64+0x2b/0x50
[    5.794136]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[    5.794139] RIP: 0033:0x7f579a1119ef
[    5.794141] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
00 00
[    5.794142] RSP: 002b:00007ffc1dee7620 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[    5.794143] RAX: ffffffffffffffda RBX: 000055fe9b660060 RCX: 00007f579a1119ef
[    5.794144] RDX: 00007ffc1dee76c0 RSI: 00000000c05064a7 RDI: 000000000000000f
[    5.794144] RBP: 00007ffc1dee76c0 R08: 0000000000000000 R09: 0000000000000000
[    5.794145] R10: 00007f579a6bc1d8 R11: 0000000000000246 R12: 00000000c05064a7
[    5.794146] R13: 000000000000000f R14: 00000000c05064a7 R15: 00007ffc1dee76c0
[    5.794147]  </TASK>

Please let me know if you need any additional information (kconfig,
etc.) in order to fix this. I will, of course, be happy to test any
patch thrown my way.

Kind regards,
Rui
