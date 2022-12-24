Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D1655880
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiLXFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLXFtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:49:08 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D1E0CC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:49:06 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id i188so6161406vsi.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXTJ9rR1GM3DcV8n/vDF0G5xPTpCfYvL0WYKQlALcoI=;
        b=i5LuFwYXiMiCxQS4+5jOkimDrAjHEcr12d15QWjVGHlEytHiLo03aSvlwSlMpfrt+9
         DJX8EuS1gFwRU8TJ1LH45R6EkRRtpbRj9dKQ2uFigL283Dx01M440wYtLRywZZEWnR1O
         Yb1U2+CmvULYgRGr2bbS3auXtzxeFQoaSSLd88/jwgy8DK0yrUFNhySCaqtpuMJpHYDW
         jWqKqc4nkWU8uWWe5yFw4XnU7CjAX3jyMDZq/pfiacCCrsIlEpQbNe/bp43bTZHvKTH5
         UolUfiic68iiCTkhrikzdoe6RJSJrDkXYN2DCHxIdPIAmYVTb1ITpEYL/rAwGcelyfai
         zXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXTJ9rR1GM3DcV8n/vDF0G5xPTpCfYvL0WYKQlALcoI=;
        b=ccelgXiuOM8s2Sk5wEQtB4nvlLbGGlJA+WFZo88TTldNgqRbiuFMpwwpRBUlWqUUKf
         BfpX0sqDhHlqYzjZPPUdIUocRwNRNNIcK5UNforetdmFyhWOJuOyH/ZkdCCyZJFal/iT
         ZT2giB5t83iQejMGQgNWvaDB/ejIMU54s7vlZZ0lIPqYsJwbGhDEdCP1an2SRTfj7gWE
         oPWsviuC2s+uonPjRHMqnecC9pTKPxv5xTw9MdRtqg+KenwKvXnmHQbVNhV4hY5EiBJe
         JlCIJfXfsG6fqVCJSUmfVgqCvw63zpJDMkda5tEQZ4D7zgjApJJUDKDDo2pTu0OvxV2R
         ESRg==
X-Gm-Message-State: AFqh2kpjxOxmVTCnb9aKw3mzcNuahwtATEhrIYLW3T4sqdyV3b+0JVZn
        pIQ24gh/GqP49keHarK8Lh66k8ms7LGdqP8Hfui+Y6rK
X-Google-Smtp-Source: AMrXdXugAHZXwuD0veKj9WOrhYrvUMc6zOAlX09PTRwFhD5ZJttwqZJU/IYuVuuMvEEA2aCL9TPUUYmoUYCs73NYQk8=
X-Received: by 2002:a67:ee93:0:b0:3b2:a92d:a1f0 with SMTP id
 n19-20020a67ee93000000b003b2a92da1f0mr1395419vsp.46.1671860945885; Fri, 23
 Dec 2022 21:49:05 -0800 (PST)
MIME-Version: 1.0
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
In-Reply-To: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sat, 24 Dec 2022 13:48:55 +0800
Message-ID: <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
Subject: f2fs write error Linux v6.2
To:     lkml <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
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

Got the following error in latest linux-6.2-git with just vim (:w
file1). No problem with linux-6.1.1

2022-12-22T14:09:51.419409+08:00 [localhost] kernel: BUG: kernel NULL
pointer dereference, address: 0000000000000024
2022-12-22T14:09:51.419422+08:00 [localhost] kernel: #PF: supervisor
write access in kernel mode
2022-12-22T14:09:51.419423+08:00 [localhost] kernel: #PF:
error_code(0x0002) - not-present page
2022-12-22T14:09:51.419424+08:00 [localhost] kernel: PGD 147b63067 P4D
147b63067 PUD 177d5c067 PMD 0
2022-12-22T14:09:51.419424+08:00 [localhost] kernel: Oops: 0002 [#7] PREEMPT SMP
2022-12-22T14:09:51.419428+08:00 [localhost] kernel: CPU: 6 PID: 22891
Comm: vi Tainted: G     UD            6.1.0 #11
2022-12-22T14:09:51.419428+08:00 [localhost] kernel: Hardware name:
LENOVO 21CCS1GL00/21CCS1GL00, BIOS N3AET69W (1.34 ) 12/05/2022
2022-12-22T14:09:51.419428+08:00 [localhost] kernel: RIP:
0010:f2fs_issue_flush+0x10e/0x180
2022-12-22T14:09:51.419429+08:00 [localhost] kernel: Code: ba 01 00 00
00 be 03 00 00 00 e8 ad e8 d5 ff 48 83 3b 00 74 1e 48 89 e7 e8 7f c1
84 00 f0 ff 4b 24 8b 44 24 2c e9 66 ff ff ff <f0> ff 43 24 e9 4a ff ff
ff 45 31 ff 4c 87 7b 28 4d 85 ff 74 d6 44
2022-12-22T14:09:51.419429+08:00 [localhost] kernel: RSP:
0018:ffffc90000b13df0 EFLAGS: 00010246
2022-12-22T14:09:51.419430+08:00 [localhost] kernel: RAX:
ffff888101caccc0 RBX: 0000000000000000 RCX: 0000000000000000
2022-12-22T14:09:51.419430+08:00 [localhost] kernel: RDX:
0000000010000088 RSI: 000000000005a844 RDI: ffff8881027bf000
2022-12-22T14:09:51.419431+08:00 [localhost] kernel: RBP:
ffff8881027bf000 R08: 0000000000000000 R09: ffff8881027bf2a8
2022-12-22T14:09:51.419431+08:00 [localhost] kernel: R10:
0000000000000000 R11: 0000000000000000 R12: 0000000000000024
2022-12-22T14:09:51.419432+08:00 [localhost] kernel: R13:
000000000005a844 R14: 000000000005a844 R15: 0000000000000000
2022-12-22T14:09:51.419432+08:00 [localhost] kernel: FS:
00007ff03fdf0b80(0000) GS:ffff88883f380000(0000)
knlGS:0000000000000000
2022-12-22T14:09:51.419432+08:00 [localhost] kernel: CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
2022-12-22T14:09:51.419433+08:00 [localhost] kernel: CR2:
0000000000000024 CR3: 000000013d64e006 CR4: 0000000000770ee0
2022-12-22T14:09:51.419433+08:00 [localhost] kernel: PKRU: 55555554
2022-12-22T14:09:51.419434+08:00 [localhost] kernel: Call Trace:
2022-12-22T14:09:51.419434+08:00 [localhost] kernel: <TASK>
2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
preempt_count_add+0x63/0x90
2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
preempt_count_add+0x63/0x90
2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
preempt_count_add+0x63/0x90
2022-12-22T14:09:51.419436+08:00 [localhost] kernel:
f2fs_do_sync_file+0x489/0x650
2022-12-22T14:09:51.419436+08:00 [localhost] kernel: __x64_sys_fsync+0x2f/0x60
2022-12-22T14:09:51.419437+08:00 [localhost] kernel: do_syscall_64+0x35/0x80
2022-12-22T14:09:51.419437+08:00 [localhost] kernel:
entry_SYSCALL_64_after_hwframe+0x46/0xb0
2022-12-22T14:09:51.419438+08:00 [localhost] kernel: RIP: 0033:0x7ff03feef20b
2022-12-22T14:09:51.419438+08:00 [localhost] kernel: Code: 3d 00 f0 ff
ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 a3 a2 f8
ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35
44 89 c7 89 44 24 0c e8 01 a3 f8 ff 8b 44
2022-12-22T14:09:51.419438+08:00 [localhost] kernel: RSP:
002b:00007ffe6ecca530 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
2022-12-22T14:09:51.419439+08:00 [localhost] kernel: RAX:
ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff03feef20b
2022-12-22T14:09:51.419439+08:00 [localhost] kernel: RDX:
0000000000000002 RSI: 0000000000000002 RDI: 0000000000000003
2022-12-22T14:09:51.419440+08:00 [localhost] kernel: RBP:
0000000000002000 R08: 0000000000000000 R09: 00000000024bcfb0
2022-12-22T14:09:51.419440+08:00 [localhost] kernel: R10:
fffffffffffff4bf R11: 0000000000000293 R12: 00000000000006b7
2022-12-22T14:09:51.419440+08:00 [localhost] kernel: R13:
000000000000003d R14: 0000000000000000 R15: 00000000024a1680
2022-12-22T14:09:51.419441+08:00 [localhost] kernel: </TASK>
2022-12-22T14:09:51.419441+08:00 [localhost] kernel: Modules linked
in: [last unloaded: ecc]
2022-12-22T14:09:51.419442+08:00 [localhost] kernel: CR2: 0000000000000024
2022-12-22T14:09:51.419442+08:00 [localhost] kernel: ---[ end trace
0000000000000000 ]---
2022-12-22T14:09:51.419443+08:00 [localhost] kernel: RIP:
0010:f2fs_issue_flush+0x10e/0x180
2022-12-22T14:09:51.419443+08:00 [localhost] kernel: Code: ba 01 00 00
00 be 03 00 00 00 e8 ad e8 d5 ff 48 83 3b 00 74 1e 48 89 e7 e8 7f c1
84 00 f0 ff 4b 24 8b 44 24 2c e9 66 ff ff ff <f0> ff 43 24 e9 4a ff ff
ff 45 31 ff 4c 87 7b 28 4d 85 ff 74 d6 44
2022-12-22T14:09:51.419443+08:00 [localhost] kernel: RSP:
0018:ffffc90003903df0 EFLAGS: 00010246
2022-12-22T14:09:51.419444+08:00 [localhost] kernel: RAX:
ffff888100106d80 RBX: 0000000000000000 RCX: 0000000000000000
2022-12-22T14:09:51.419444+08:00 [localhost] kernel: RDX:
0000000010000088 RSI: 0000000000b0e2ba RDI: ffff888116227000
2022-12-22T14:09:51.419445+08:00 [localhost] kernel: RBP:
ffff888116227000 R08: 0000000000000000 R09: ffff8881162272a8
2022-12-22T14:09:51.419445+08:00 [localhost] kernel: R10:
0000000000000000 R11: 0000000000000000 R12: 0000000000000024
2022-12-22T14:09:51.419445+08:00 [localhost] kernel: R13:
0000000000b0e2ba R14: 0000000000b0e2ba R15: 0000000000000000
2022-12-22T14:09:51.419446+08:00 [localhost] kernel: FS:
00007ff03fdf0b80(0000) GS:ffff88883f380000(0000)
knlGS:0000000000000000
2022-12-22T14:09:51.419446+08:00 [localhost] kernel: CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
2022-12-22T14:09:51.419446+08:00 [localhost] kernel: CR2:
0000000000000024 CR3: 000000013d64e006 CR4: 0000000000770ee0
2022-12-22T14:09:51.419447+08:00 [localhost] kernel: PKRU: 55555554

Jeff
