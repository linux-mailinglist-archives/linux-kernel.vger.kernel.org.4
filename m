Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C3701F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjENUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjENUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:40:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0B1707
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:40:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcd46bf47so2703908a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684096836; x=1686688836;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80c+WxEAYuIAh+HPhTgq5eRkWUytvoeoSVXWMi0jnrU=;
        b=HY48kBB8QTaGjLVJgVpRU3VlV4y0I0Q1PMTAxqh8EK3lcQN00xidj1Ci1uGKIuQFn/
         4hIVsFf8X1s7oTID8StcLOPlpOs1DgDpH4DkpUrICQlTxqPBquOW1u7EbUKEddQeaukG
         EcZJjCl4vl9ehL2EwmTQ8UV9ifW9GZgpmO4+EquCkD8vOV1xN/gRlzWtoE/ZMFZ6PzWV
         V7BMNd7SD4H41kYM3rdmYFcsBVLPGIlo+HseLhNHnUnhH2IFMhjgdKgQ2Q+158SsPLFk
         tf4YQEDW66smoTcq+G3ZFlHCK6m/6pbXoqMh9CYGnHtBD83KI2V7/qHBVO3yvSH9sq0A
         Mw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684096836; x=1686688836;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80c+WxEAYuIAh+HPhTgq5eRkWUytvoeoSVXWMi0jnrU=;
        b=dTGwGT3DumnqcYKUHD12DYq2DU83xIL5BNJ8/vzHwCv2lmb1GN6JNRY2mCL0Nf+SMM
         /gqw7wJlV3wwNIpuQQacDabFYnhBkYoMNMOIL0izatC7L7NUp2rbnynHKFmxmyiqkaHC
         klyOJFcjTo9DLhLLmfLYqXjrSdrRA0zohOjyBDXmNsxSRxCy6kNVKlv12z1UQV/po3rk
         1NoTAldEat27phLYqLKGLTAUdOAJrRVB5xKzYbkuZXEp9/UY6me2h+D4mwezZworI3B3
         aMoIlNnaqoMj3gSHCUVoTU83+Tn7AAGresIUQInsMeOb5G0aHnNwVdlRy+uxpbKgb9Sv
         Ye4w==
X-Gm-Message-State: AC+VfDxFGPFWgQqHmwGU+S6CWaQMjc+RkCtDoZdjjuA20u4W9tslQJKR
        siZTTV3NEsnWHpOsOPAx4LN8d2qOqG4=
X-Google-Smtp-Source: ACHHUZ7FYqQeZWOodA+zmnR/BIpa8+6frs7OvzRmmTk6njJU7OTNqAMmo0dtvoajUXITgRgnnVR0BA==
X-Received: by 2002:a05:6402:510c:b0:50d:a9bb:356c with SMTP id m12-20020a056402510c00b0050da9bb356cmr21231735edd.0.1684096835496;
        Sun, 14 May 2023 13:40:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7d418000000b0050bfa1905f6sm6590516edq.30.2023.05.14.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 13:40:35 -0700 (PDT)
Date:   Sun, 14 May 2023 22:40:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Exclude scan_mutex in
 rtllib_softmac_stop_scan
Message-ID: <20230514204033.GA20187@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exclude scan_mutex from cancel_delayed_work_sync(&ieee->softmac_scan_wq) as
ieee->softmac_scan_wq takes scan_mutex as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e

[ 1766.998408] ======================================================
[ 1766.998410] WARNING: possible circular locking dependency detected
[ 1766.998411] 6.3.0+ #8 Tainted: G         C OE
[ 1766.998413] ------------------------------------------------------
[ 1766.998414] wpa_supplicant/1184 is trying to acquire lock:
[ 1766.998416] ffff91e404469ec8 ((work_completion)(&(&ieee->softmac_scan_wq)->work)){+.+.}-{0:0}, at: __flush_work+0x4d/0x490
[ 1766.998425]
               but task is already holding lock:
[ 1766.998426] ffff91e404469150 (&ieee->scan_mutex){+.+.}-{4:4}, at: rtllib_softmac_stop_scan+0x20/0x80 [rtllib]
[ 1766.998439]
               which lock already depends on the new lock.

[ 1766.998440]
               the existing dependency chain (in reverse order) is:
[ 1766.998442]
               -> #1 (&ieee->scan_mutex){+.+.}-{4:4}:
[ 1766.998445]        __mutex_lock+0x99/0xce0
[ 1766.998450]        mutex_lock_nested+0x1b/0x30
[ 1766.998453]        rtllib_softmac_scan_wq+0x62/0x1e0 [rtllib]
[ 1766.998461]        process_one_work+0x2ba/0x5a0
[ 1766.998463]        worker_thread+0x4d/0x3d0
[ 1766.998465]        kthread+0x116/0x150
[ 1766.998469]        ret_from_fork+0x2c/0x50
[ 1766.998473]
               -> #0 ((work_completion)(&(&ieee->softmac_scan_wq)->work)){+.+.}-{0:0}:
[ 1766.998476]        __lock_acquire+0x1494/0x1fc0
[ 1766.998479]        lock_acquire+0xdc/0x2c0
[ 1766.998480]        __flush_work+0x6d/0x490
[ 1766.998482]        __cancel_work_timer+0x137/0x1c0
[ 1766.998485]        cancel_delayed_work_sync+0x13/0x20
[ 1766.998487]        rtllib_softmac_stop_scan+0x60/0x80 [rtllib]
[ 1766.998494]        rtllib_stop_protocol.part.0+0x113/0x130 [rtllib]
[ 1766.998503]        rtllib_stop_protocol+0x1c/0x30 [rtllib]
[ 1766.998510]        rtllib_wx_set_essid+0x12a/0x150 [rtllib]
[ 1766.998519]        _rtl92e_wx_set_essid+0x4e/0xa0 [r8192e_pci]
[ 1766.998527]        ioctl_standard_iw_point+0x2de/0x3b0
[ 1766.998531]        ioctl_standard_call+0xaa/0xe0
[ 1766.998533]        wireless_process_ioctl+0x194/0x1e0
[ 1766.998535]        wext_handle_ioctl+0x9e/0x100
[ 1766.998537]        sock_ioctl+0x200/0x340
[ 1766.998540]        __x64_sys_ioctl+0x95/0xd0
[ 1766.998543]        do_syscall_64+0x3b/0x90
[ 1766.998546]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1766.998550]
               other info that might help us debug this:

[ 1766.998551]  Possible unsafe locking scenario:

[ 1766.998552]        CPU0                    CPU1
[ 1766.998553]        ----                    ----
[ 1766.998554]   lock(&ieee->scan_mutex);
[ 1766.998556]                                lock((work_completion)(&(&ieee->softmac_scan_wq)->work));
[ 1766.998558]                                lock(&ieee->scan_mutex);
[ 1766.998560]   lock((work_completion)(&(&ieee->softmac_scan_wq)->work));
[ 1766.998562]
                *** DEADLOCK ***

[ 1766.998563] 4 locks held by wpa_supplicant/1184:
[ 1766.998565]  #0: ffffffff8a14f610 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x17/0x20
[ 1766.998570]  #1: ffff91e40446b078 (&priv->wx_mutex){+.+.}-{4:4}, at: _rtl92e_wx_set_essid+0x38/0xa0 [r8192e_pci]
[ 1766.998580]  #2: ffff91e4044690b0 (&ieee->wx_mutex){+.+.}-{4:4}, at: rtllib_wx_set_essid+0x36/0x150 [rtllib]
[ 1766.998590]  #3: ffff91e404469150 (&ieee->scan_mutex){+.+.}-{4:4}, at: rtllib_softmac_stop_scan+0x20/0x80 [rtllib]
[ 1766.998601]
               stack backtrace:
[ 1766.998602] CPU: 3 PID: 1184 Comm: wpa_supplicant Tainted: G         C OE      6.3.0+ #8
[ 1766.998605] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[ 1766.998607] Call Trace:
[ 1766.998608]  <TASK>
[ 1766.998610]  dump_stack_lvl+0x5c/0xa0
[ 1766.998614]  dump_stack+0x10/0x20
[ 1766.998617]  print_circular_bug.isra.0+0x2e5/0x420
[ 1766.998620]  check_noncircular+0x103/0x120
[ 1766.998622]  ? register_lock_class+0x4c/0x450
[ 1766.998624]  ? check_path.constprop.0+0x28/0x50
[ 1766.998628]  ? check_noncircular+0x80/0x120
[ 1766.998631]  __lock_acquire+0x1494/0x1fc0
[ 1766.998633]  ? __this_cpu_preempt_check+0x13/0x20
[ 1766.998638]  lock_acquire+0xdc/0x2c0
[ 1766.998640]  ? __flush_work+0x4d/0x490
[ 1766.998643]  ? find_held_lock+0x38/0x90
[ 1766.998646]  ? lock_timer_base+0x72/0xa0
[ 1766.998648]  ? __this_cpu_preempt_check+0x13/0x20
[ 1766.998651]  __flush_work+0x6d/0x490
[ 1766.998653]  ? __flush_work+0x4d/0x490
[ 1766.998655]  ? __this_cpu_preempt_check+0x13/0x20
[ 1766.998658]  ? lock_release+0x14f/0x380
[ 1766.998662]  ? __cancel_work_timer+0x10d/0x1c0
[ 1766.998664]  ? __this_cpu_preempt_check+0x13/0x20
[ 1766.998667]  __cancel_work_timer+0x137/0x1c0
[ 1766.998671]  cancel_delayed_work_sync+0x13/0x20
[ 1766.998674]  rtllib_softmac_stop_scan+0x60/0x80 [rtllib]
[ 1766.998682]  rtllib_stop_protocol.part.0+0x113/0x130 [rtllib]
[ 1766.998690]  rtllib_stop_protocol+0x1c/0x30 [rtllib]
[ 1766.998698]  rtllib_wx_set_essid+0x12a/0x150 [rtllib]
[ 1766.998707]  _rtl92e_wx_set_essid+0x4e/0xa0 [r8192e_pci]
[ 1766.998715]  ioctl_standard_iw_point+0x2de/0x3b0
[ 1766.998718]  ? __pfx__rtl92e_wx_set_essid+0x10/0x10 [r8192e_pci]
[ 1766.998726]  ioctl_standard_call+0xaa/0xe0
[ 1766.998729]  ? netdev_name_node_lookup+0x65/0x90
[ 1766.998732]  ? __pfx_ioctl_private_call+0x10/0x10
[ 1766.998734]  ? __pfx_ioctl_standard_call+0x10/0x10
[ 1766.998737]  wireless_process_ioctl+0x194/0x1e0
[ 1766.998740]  wext_handle_ioctl+0x9e/0x100
[ 1766.998744]  sock_ioctl+0x200/0x340
[ 1766.998748]  ? syscall_enter_from_user_mode+0x21/0x60
[ 1766.998751]  __x64_sys_ioctl+0x95/0xd0
[ 1766.998753]  do_syscall_64+0x3b/0x90
[ 1766.998757]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1766.998760] RIP: 0033:0x7f4ed5f223ab
[ 1766.998763] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 00 f7 d8 64 89 01 48
[ 1766.998765] RSP: 002b:00007ffe820546c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1766.998768] RAX: ffffffffffffffda RBX: 0000000000000020 RCX: 00007f4ed5f223ab
[ 1766.998769] RDX: 00007ffe820546d0 RSI: 0000000000008b1a RDI: 0000000000000009
[ 1766.998771] RBP: 000055d229516ff0 R08: 0000000000000000 R09: 00007f4ed5ffa240
[ 1766.998772] R10: 0000000000004000 R11: 0000000000000246 R12: 00007ffe82054780
[ 1766.998774] R13: 00007ffe820546d0 R14: 0000000000000000 R15: 00007ffe820547e0
[ 1766.998778]  </TASK>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 18885cda60f6..cb2dd18fa14b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -682,11 +682,11 @@ static void rtllib_softmac_stop_scan(struct rtllib_device *ieee)
 	if (ieee->scanning_continue == 1) {
 		ieee->scanning_continue = 0;
 		ieee->actscanning = false;
-
+		mutex_unlock(&ieee->scan_mutex);
 		cancel_delayed_work_sync(&ieee->softmac_scan_wq);
+	} else {
+		mutex_unlock(&ieee->scan_mutex);
 	}
-
-	mutex_unlock(&ieee->scan_mutex);
 }
 
 void rtllib_stop_scan(struct rtllib_device *ieee)
-- 
2.40.1

