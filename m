Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8726D9F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbjDFR5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDFR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:57:52 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F158F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:57:48 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so24475068iow.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803868; x=1683395868;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7OAjhxcL9fqt8GNm9m6OaHCzJ6s3UX0YV8ZcboF3hs=;
        b=NHaYPnaOtiH6olc+xziRl2K2PSB2IkmxE8uwYUiNMdETJM6Fm+xKxNuws+/WSwHSmo
         D+lut25QFQX0Hyu6PUPHOy/5xwE2KdVnPpoSm6q+D5kQwFcO1Sonrdo1oEphgj3oactq
         cGH6clRujJ5XEl5cM4mdwVfj4RjmDAYCf9/Xkpk9mEFQ2zFK6DiqKl9Yp6vRCQXgr1Sy
         pctm4yot/2aioAxDs5X8vo06dJHJW/qP9+0GvL7S5eIw9JQ/8MdvbbjGax726iaeuqIH
         GjRA3P7FlqmNwIuVtV/PlFkuahigyLhr80Qye6yCreOL8HREXjd6ir47P+HkJSXIEpws
         9GAA==
X-Gm-Message-State: AAQBX9frPDiLmjD1n/Dn/KbzZXObdsPNV4vQE+4VRb8zHaSLHSIW8Ubg
        M6SCx8VQiFiR3Wq/7G5s5HjURe06hGZLRnglYgoVu6h3AE0/
X-Google-Smtp-Source: AKy350aNB7RclPM1dRcssP7G9ms+u3wSYsdlFAc8Hj5SYtoKgfabzhQy9oUF9F2+6j2GIgQGxB9pwHaQawCIxV7mjMfgbde6Ibk3
MIME-Version: 1.0
X-Received: by 2002:a02:6308:0:b0:3a7:e46f:7d30 with SMTP id
 j8-20020a026308000000b003a7e46f7d30mr5505993jac.3.1680803868218; Thu, 06 Apr
 2023 10:57:48 -0700 (PDT)
Date:   Thu, 06 Apr 2023 10:57:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080a2d405f8aea527@google.com>
Subject: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp
From:   syzbot <syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        rodrigosiqueiramelo@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4b0f4525dc4f Add linux-next specific files for 20230331
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ea0159c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85cc4b935a1f7194
dashboard link: https://syzkaller.appspot.com/bug?extid=75cc0f9f7e6324dd2501
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cb3659c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d06bb015df3/disk-4b0f4525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a1c1ebf3724/vmlinux-4b0f4525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bb2b8d6cd7d/bzImage-4b0f4525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6019 at drivers/gpu/drm/vkms/vkms_crtc.c:103 vkms_get_vblank_timestamp+0x1cf/0x240 drivers/gpu/drm/vkms/vkms_crtc.c:103
Modules linked in:
CPU: 1 PID: 6019 Comm: syz-executor.1 Not tainted 6.3.0-rc4-next-20230331-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:vkms_get_vblank_timestamp+0x1cf/0x240 drivers/gpu/drm/vkms/vkms_crtc.c:103
Code: ce 73 fc e8 53 e9 63 fc 4c 89 e1 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75 65 49 89 04 24 eb c4 e8 b1 ce 73 fc <0f> 0b eb bb e8 d8 80 c6 fc e9 de fe ff ff e8 0e 81 c6 fc e9 78 fe
RSP: 0018:ffffc9000b3873d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000004e19fc6e8a RCX: 0000000000000000
RDX: ffff8880756257c0 RSI: ffffffff850f429f RDI: 0000000000000006
RBP: ffff88801dc84000 R08: 0000000000000006 R09: 0000004e19fc6e8a
R10: 0000004e19fc6e8a R11: 0000000000000000 R12: ffffc9000b387540
R13: 0000004e19fc6e8a R14: 0000000000004e20 R15: ffffffff850f40d0
FS:  00007f5372809700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000202fc000 CR3: 0000000027361000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_crtc_get_last_vbltimestamp+0x102/0x1a0 drivers/gpu/drm/drm_vblank.c:877
 drm_crtc_next_vblank_start+0x13f/0x2b0 drivers/gpu/drm/drm_vblank.c:1006
 set_fence_deadline drivers/gpu/drm/drm_atomic_helper.c:1531 [inline]
 drm_atomic_helper_wait_for_fences+0x1b4/0x780 drivers/gpu/drm/drm_atomic_helper.c:1578
 drm_atomic_helper_commit drivers/gpu/drm/drm_atomic_helper.c:2007 [inline]
 drm_atomic_helper_commit+0x1bd/0x370 drivers/gpu/drm/drm_atomic_helper.c:1979
 drm_atomic_commit+0x20a/0x300 drivers/gpu/drm/drm_atomic.c:1503
 drm_client_modeset_commit_atomic+0x69b/0x7e0 drivers/gpu/drm/drm_client_modeset.c:1045
 drm_client_modeset_commit_locked+0x149/0x580 drivers/gpu/drm/drm_client_modeset.c:1148
 pan_display_atomic drivers/gpu/drm/drm_fb_helper.c:1690 [inline]
 drm_fb_helper_pan_display+0x28f/0x970 drivers/gpu/drm/drm_fb_helper.c:1750
 fb_pan_display+0x2fb/0x6c0 drivers/video/fbdev/core/fbmem.c:924
 bit_update_start+0x49/0x1f0 drivers/video/fbdev/core/bitblit.c:387
 fbcon_switch+0xbcf/0x1380 drivers/video/fbdev/core/fbcon.c:2169
 redraw_screen+0x2bd/0x740 drivers/tty/vt/vt.c:965
 fbcon_modechanged+0x526/0x620 drivers/video/fbdev/core/fbcon.c:2704
 fbcon_update_vcs+0x3e/0x50 drivers/video/fbdev/core/fbcon.c:2749
 do_fb_ioctl+0x6d7/0x740 drivers/video/fbdev/core/fbmem.c:1125
 fb_ioctl+0xeb/0x150 drivers/video/fbdev/core/fbmem.c:1202
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5371a8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5372809168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5371bac050 RCX: 00007f5371a8c0f9
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000005
RBP: 00007f5371ae7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd0e5e571f R14: 00007f5372809300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
