Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C83609AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJXHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJXHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:04:42 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CDE11147
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:04:38 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 23-20020a5d9c57000000b006bbd963e8adso5880206iof.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2qMk01p1y2UcDubJpHKziTQteyQaf5CHj4pTV0csVY=;
        b=him1/N9TqjvlD/6nOCKWjfRcHW0+b5amS9pBWjT7iB8+PHGmgTQ4uhe10YBO7f+Sed
         ZiWckT8ZZLuNvIZv+udYicEvxwG332px90SAqlHJCVoiPz8eEmblnftoLZNGlbHz6ADE
         Tv0xg42yywiBro6D3luBGyA2aX/a+jFkjjFWUOvFZOp5joIa4zuaOMPmbWUm6KtZ04jQ
         fydL6o9erp/5Zm1nXQKiW3Gd/hlQ76aY2+vdZqKMbicX2lHA46SKSh1JYzsqqizVlUUk
         NJMEPqRi69n8I4rFYUBzHtSkRpiHi2Hnlg4bNdlQwn4hdRAfMuZTVigoUx32lIuswDjU
         KC6A==
X-Gm-Message-State: ACrzQf0jG9RIPFuNudqKMi7bWfbR4GZljZ/bbKYr+js8J7DRt/UCLtzi
        Cje9kbj+wqwv5bD0SeXbjTN9gyyLSvUeLJ/ccg8BNxIAhuG+
X-Google-Smtp-Source: AMsMyM41NRDqCjS47+i/He0adKT75JTvu8kTDBwm59xQZ0LbZ1XVMHN346ISStj5rhlj37V26YhsM/271J3LXV7aEN97h323ZOWr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d03:b0:363:efb2:41de with SMTP id
 q3-20020a0566380d0300b00363efb241demr22604423jaj.36.1666595076343; Mon, 24
 Oct 2022 00:04:36 -0700 (PDT)
Date:   Mon, 24 Oct 2022 00:04:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008291c505ebc267d1@google.com>
Subject: [syzbot] linux-next boot error: kernel panic: kasan_populate_shadow:
 Failed to allocate page, nid=NUM from=ADDR
From:   syzbot <syzbot+31ac477942b208466c5f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    76cf65d1377f Add linux-next specific files for 20221024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1238856a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=31ac477942b208466c5f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f02c41d197ff/disk-76cf65d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e829e2883ef/vmlinux-76cf65d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31ac477942b208466c5f@syzkaller.appspotmail.com

x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xbfffd max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000f2750-0x000f275f]
Using GB pages for direct mapping
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F24D0 000014 (v00 Google)
ACPI: RSDT 0x00000000BFFFFFA0 000038 (v01 Google GOOGRSDT 00000001 GOOG 00000001)
ACPI: FACP 0x00000000BFFFF330 0000F4 (v02 Google GOOGFACP 00000001 GOOG 00000001)
ACPI: DSDT 0x00000000BFFFD8C0 001A64 (v01 Google GOOGDSDT 00000001 GOOG 00000001)
ACPI: FACS 0x00000000BFFFD880 000040
ACPI: FACS 0x00000000BFFFD880 000040
ACPI: SRAT 0x00000000BFFFFE60 0000C8 (v03 Google GOOGSRAT 00000001 GOOG 00000001)
ACPI: APIC 0x00000000BFFFFDB0 000076 (v05 Google GOOGAPIC 00000001 GOOG 00000001)
ACPI: SSDT 0x00000000BFFFF430 000980 (v01 Google GOOGSSDT 00000001 GOOG 00000001)
ACPI: WAET 0x00000000BFFFFE30 000028 (v01 Google GOOGWAET 00000001 GOOG 00000001)
ACPI: Reserving FACP table memory at [mem 0xbffff330-0xbffff423]
ACPI: Reserving DSDT table memory at [mem 0xbfffd8c0-0xbffff323]
ACPI: Reserving FACS table memory at [mem 0xbfffd880-0xbfffd8bf]
ACPI: Reserving FACS table memory at [mem 0xbfffd880-0xbfffd8bf]
ACPI: Reserving SRAT table memory at [mem 0xbffffe60-0xbfffff27]
ACPI: Reserving APIC table memory at [mem 0xbffffdb0-0xbffffe25]
ACPI: Reserving SSDT table memory at [mem 0xbffff430-0xbffffdaf]
ACPI: Reserving WAET table memory at [mem 0xbffffe30-0xbffffe57]
SRAT: PXM 0 -> APIC 0x00 -> Node 0
SRAT: PXM 0 -> APIC 0x01 -> Node 0
ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x23fffffff]
NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x23fffffff] -> [mem 0x00000000-0x23fffffff]
Faking node 0 at [mem 0x0000000000000000-0x000000013fffffff] (5120MB)
Faking node 1 at [mem 0x0000000140000000-0x000000023fffffff] (4096MB)
NODE_DATA(0) allocated [mem 0x13fffa000-0x13fffffff]
NODE_DATA(1) allocated [mem 0x23fff7000-0x23fffcfff]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000023fffffff]
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x00000000bfffcfff]
  node   0: [mem 0x0000000100000000-0x000000013fffffff]
  node   1: [mem 0x0000000140000000-0x000000023fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone Normal: 3 pages in unavailable ranges
Kernel panic - not syncing: kasan_populate_pmd arch/x86/mm/kasan_init_64.c:67 [inline]: Failed to allocate page, nid=0 from=1000000
Kernel panic - not syncing: kasan_populate_pud arch/x86/mm/kasan_init_64.c:99 [inline]: Failed to allocate page, nid=0 from=1000000
Kernel panic - not syncing: kasan_populate_p4d arch/x86/mm/kasan_init_64.c:119 [inline]: Failed to allocate page, nid=0 from=1000000
Kernel panic - not syncing: kasan_populate_pgd arch/x86/mm/kasan_init_64.c:138 [inline]: Failed to allocate page, nid=0 from=1000000
Kernel panic - not syncing: kasan_populate_shadow+0x57f/0x71f arch/x86/mm/kasan_init_64.c:153: Failed to allocate page, nid=0 from=1000000
CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-next-20221024-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 </TASK>
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
