Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5478694377
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBMKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:50:39 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435B26B7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:50:38 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id d73-20020a6bb44c000000b0072805fbd06aso8163059iof.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imWoWn1wOb/vHQ2rwIhB6EiQHzFH9YLuSzF5fLaP5a8=;
        b=QNNFwj6xHKyrtPzK2ktm5eAwsFK4g30XIo8YlDp6g+XmWG4HffGH+VQXLsr5KTTCAf
         khi1D4RPvybNUm3JAAFHwuRNxKrAIqRWb4DREdvKLqQjN7/0vcbackpdeji0hhoFpzis
         1wlP9NPWGF8c1Bb7oTY984Dqu6Ovucey1xO4FIjVxuLVsTSuB82rb4W5LfxVD37joFQP
         Xk5R3TOguF6Q/opc1ZDf+FTjeCV+7KP75yVXaX76LdB4SM1P9dLLBrqX/uIwjLF5mbME
         2cPGvf8ZNXgkD48wC3ybbg128/QxRptlREK3l1PlP434cddbUFcnLE6dE+oT/uN2hHXU
         vKJg==
X-Gm-Message-State: AO0yUKWYUKH7UTvUBISm0rIkhH6ZtMIA9KXZclmdGdEBvWFfg6zAGRmI
        MZJAQIVJ04F4b9+LxpqCjE3kOuoJD0KYMo9+pOqviXj+DTmi
X-Google-Smtp-Source: AK7set/WN+UOLOs4DAALUK/amyT8Wo5FY+PLHjMTrHUAcbxEpBKP6hQ4Cs3EKhHICCncrcOqnn41I/NywnTL42T1vEEuHy46ZJn5
MIME-Version: 1.0
X-Received: by 2002:a02:c8da:0:b0:3c4:aa6f:6de3 with SMTP id
 q26-20020a02c8da000000b003c4aa6f6de3mr3784746jao.136.1676285437668; Mon, 13
 Feb 2023 02:50:37 -0800 (PST)
Date:   Mon, 13 Feb 2023 02:50:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000df2c105f4929eb5@google.com>
Subject: [syzbot] KMSAN: kernel-infoleak in iommufd_vfio_ioctl
From:   syzbot <syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com>
To:     glider@google.com, iommu@lists.linux.dev, jgg@ziepe.ca,
        joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8c89ecf5c13b kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1592ac0b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91d3152219aa6b45
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1e0978f6bf46b83a58
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9d1327adc33/disk-8c89ecf5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a07e8c41800/vmlinux-8c89ecf5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe36dc6c869b/bzImage-8c89ecf5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c5/0x270 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1c5/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:169 [inline]
 iommufd_vfio_iommu_get_info drivers/iommu/iommufd/vfio_compat.c:437 [inline]
 iommufd_vfio_ioctl+0x1e57/0x2330 drivers/iommu/iommufd/vfio_compat.c:462
 iommufd_fops_ioctl+0x254/0xb10 drivers/iommu/iommufd/main.c:315
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x2dd/0x4b0 fs/ioctl.c:856
 __x64_sys_ioctl+0xdc/0x120 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable info.i created at:
 iommufd_vfio_iommu_get_info drivers/iommu/iommufd/vfio_compat.c:384 [inline]
 iommufd_vfio_ioctl+0x423/0x2330 drivers/iommu/iommufd/vfio_compat.c:462
 iommufd_fops_ioctl+0x254/0xb10 drivers/iommu/iommufd/main.c:315

Bytes 20-23 of 24 are uninitialized
Memory access of size 24 starts at ffff8880ab237cb0
Data copied to user address 0000000020000000

CPU: 0 PID: 7156 Comm: syz-executor.5 Not tainted 6.2.0-rc7-syzkaller-80760-g8c89ecf5c13b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
