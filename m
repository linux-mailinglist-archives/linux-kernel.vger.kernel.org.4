Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB796E07BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDMHaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDMHaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:30:16 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0A10D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:30:14 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e10so5354805ybp.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681371014; x=1683963014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGv1JkQ2XdUnq+6HP1fTrxYEFDSooshQ2NWaFXUJVlg=;
        b=RJ80LANdPZ3eEVYRjk8PRVsAF0ASP5oa2p1HahEZE8ObfM3jdIXDIlNcFIHCk2kyxO
         cqn1TCs3NWloHNTMNHAR3vQW1d1nchnc2cQNvtxlarNSR/IBsNPk0QzXONDWyDA3ibly
         r2GWNSig+EKE5+582c5Z2BWQM0M4Qg8eI8ianzgmrfyVfz0qi7B3JniJdoGFUuY3qVp3
         QDNQrGmwFyOTsZNlJyoBj94inmDVqYJS/9CkkWUcd32QyM1aPVz7PyOEQTKdRjW6GudI
         mDIj08L4mh9Hfg9weL532sO+qj8NstEMmr1xFAqSnbAKeMnmcgksKepTKtXo/xiDw4j0
         cebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371014; x=1683963014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGv1JkQ2XdUnq+6HP1fTrxYEFDSooshQ2NWaFXUJVlg=;
        b=awMujJT28d2ir3EKUso0CxW1XXHqq9v1wsRtt+OkU6u1POUgK2DZ9Bo15ciyZaXaNx
         8TcBlozomIhkk2uB6Ww/I4ACn100j7HeH4SyarJtbihtcY3m0l0Egkk+aRr/qi4FxTQO
         mq8BDogn8ZmdCZBCTuJw4Vp8YdPsfr826fiLKNMqfKKcInePYAE4AJM6f3FVLCyufyjc
         RRZ0XjNK+qXQmtmzuq8pbed4JkbmQZnItJLXI+InS2+a/WNu+XeVAQv/NcPUYLytXUgq
         VgV6AlQUUKI0+m995TQAkZsa7uY8xBPFOuccC4Sg/jEjKg0OwC9NXcvQ1qkzeQSWfAwF
         u4PQ==
X-Gm-Message-State: AAQBX9fdTZBR7XQtDd3GDfpVt/acs2m5jWcbpEBM+bwH3OGsz9f7KMQb
        iHUeboNTTev8geZsXOWk+AKkRZFDDow34ZE36+YQzIRVZVf6
X-Google-Smtp-Source: AKy350bbGvktxNXee/YBihEt5Sn6d7Hx3KYLd7vDuhpI131igW4XOGqtEgM4cL0ejgvc/mU96qOHjMCJFTJZI2CUVpg=
X-Received: by 2002:a25:ca56:0:b0:b8f:610b:e6b8 with SMTP id
 a83-20020a25ca56000000b00b8f610be6b8mr35800ybg.9.1681371013815; Thu, 13 Apr
 2023 00:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvZ=Y1psyd0nmfzm6GhqMKvq5V_NQCWb_X02nasp1CpfcQ@mail.gmail.com>
 <87r0spcuvi.fsf@intel.com> <CALjTZvao=N7wxyj_DpqzWUhdJwEsWSKUo3ddi-3ubgMp8BXi_Q@mail.gmail.com>
In-Reply-To: <CALjTZvao=N7wxyj_DpqzWUhdJwEsWSKUo3ddi-3ubgMp8BXi_Q@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 13 Apr 2023 08:30:02 +0100
Message-ID: <CALjTZvaf1cwcZc9O8g24SnZXsoQaWB97UVQW=g6M0coaudLr6w@mail.gmail.com>
Subject: Re: [BUG?] INFO: rcu_sched detected expedited stalls on CPUs/tasks: {
 0-.... } 3 jiffies s: 309 root: 0x1/.
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        paulmck@kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi again, everyone.

So, while preparing to file the bug report with the requested
information, I got a trace completely unrelated to DRM (on a swapon
call, it seems).

[    4.868340] rcu: INFO: rcu_sched detected expedited stalls on
CPUs/tasks: { 4-.... } 3 jiffies s: 265 root: 0x10/.
[    4.868349] rcu: blocking rcu_node structures (internal RCU debug):
[    4.868351] Sending NMI from CPU 3 to CPUs 4:
[    4.868355] NMI backtrace for cpu 4
[    4.868357] CPU: 4 PID: 462 Comm: swapon Not tainted 6.3.0-rc6-debug+ #57
[    4.868359] Hardware name: Apple Inc.
Macmini6,2/Mac-F65AE981FFA204ED, BIOS 429.0.0.0.0 03/18/2022
[    4.868360] RIP: 0010:zram_submit_bio+0x57c/0x940
[    4.868365] Code: 04 4c 01 f0 48 8d 48 08 f0 48 0f ba 68 08 0d 0f
82 80 00 00 00 4c 89 ef e8 01 eb ff ff 49 8b 45 00 4a 8d 44 30 09 f0
80 20 df <f0> 48 ff 45 00 48 81 eb 00 10 00 00 41 83 c4 01 48 81 fb ff
0f 00
[    4.868366] RSP: 0018:ffff8881057dbcd8 EFLAGS: 00000246
[    4.868368] RAX: ffffc90001c186d9 RBX: 000000003e893000 RCX: ffffc90001c186d8
[    4.868369] RDX: ffffc90001c186d0 RSI: 0000000000000000 RDI: ffff88810083b400
[    4.868369] RBP: ffff88810083b470 R08: 0000000000027e40 R09: 0000000000025850
[    4.868370] R10: 000000000014b212 R11: ffff88810ba03180 R12: 00000000000c176d
[    4.868371] R13: ffff88810083b400 R14: 0000000000c176d0 R15: 0000000000000000
[    4.868372] FS:  00007fbd8f8ce800(0000) GS:ffff888266100000(0000)
knlGS:0000000000000000
[    4.868373] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.868374] CR2: 0000563005371000 CR3: 000000010355c003 CR4: 00000000001706e0
[    4.868375] Call Trace:
[    4.868377]  <TASK>
[    4.868378]  ? block_read_full_folio+0x23e/0x2e0
[    4.868383]  ? kmem_cache_alloc+0x1b/0x110
[    4.868385]  ? mempool_alloc+0x37/0x140
[    4.868388]  ? pcpu_block_update_hint_alloc+0xce/0x2f0
[    4.868390]  __submit_bio+0x41/0xd0
[    4.868394]  submit_bio_noacct_nocheck+0xc4/0x2b0
[    4.868396]  blk_next_bio+0x55/0x70
[    4.868398]  __blkdev_issue_discard+0xc8/0x180
[    4.868401]  blkdev_issue_discard+0x3c/0x80
[    4.868403]  __x64_sys_swapon+0xb71/0x1120
[    4.868407]  do_syscall_64+0x2b/0x50
[    4.868410]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[    4.868414] RIP: 0033:0x7fbd8f712d5b
[    4.868416] Code: 73 01 c3 48 8b 0d bd 30 0e 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 a7 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 30 0e 00 f7 d8 64 89
01 48
[    4.868417] RSP: 002b:00007ffcaf9a3448 EFLAGS: 00000246 ORIG_RAX:
00000000000000a7
[    4.868418] RAX: ffffffffffffffda RBX: 0000000000018064 RCX: 00007fbd8f712d5b
[    4.868419] RDX: 0000000000018064 RSI: 0000000000018064 RDI: 000056300535fb10
[    4.868420] RBP: 00007ffcaf9a3530 R08: 000000014b213000 R09: 00007fbd8f7f70f0
[    4.868420] R10: 0000000000001000 R11: 0000000000000246 R12: 000056300535fb10
[    4.868421] R13: 0000000000000064 R14: 00007ffcaf9a3530 R15: 0000000000000000
[    4.868423]  </TASK>

Could it be that RCU is reporting expedited stalls too eagerly? And,
if so, why only on this machine?
