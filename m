Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718E69DA47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjBUFJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjBUFJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:09:46 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17B325B8E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:09:45 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id m6-20020a056e020de600b0030f1b0dfa9dso1180260ilj.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ht4YMZ9xHmCpd10L1Q7UoHoJ8sa6svP1SEn5xjqGq0c=;
        b=hFEBNxXmAlKPs/FW9Z2PjXnm2EnbTesQfvoA2z/bNHaKHjwH2BvBKeleioZAbX7gkL
         10OYxZjYpCJa/MeFVSKogbRFuARJ52YltlAdtydTlsakKepZCtqHPco8AbNtwVA81tPy
         xWB3HkZ0YlO/Sk7D2IoPWPMEcfi8ux5Iar/cBwrfF/x8nYPBY6Tpt//mlfFVdXLZgLog
         uIB6DkE8iEXDsdQp0EmgEInnbZ/cTADXL/SY419k8Dc34diZT2NniIZEeN2SSehAvarO
         n/MbPr44Q5N9a0UZTTk80H1BXtQb9Fhva3QpGvQs6MB6OHpINl2VKfWa4e3TRzOR0/sB
         ts7A==
X-Gm-Message-State: AO0yUKWnTQaY5tYf2SSE705rxzybHdRmB3zqAVvLg3ntzkwQlqvMIBXO
        rlzJ8ztXMFkOcW84c7kwtcdNdJOz7ScE/LtrFzeaBoTmkjX6
X-Google-Smtp-Source: AK7set+nYB6MBJH2q9vy2jy1HaXut9lcchTCIZemyEmf468mV8xEhQUy37UkV8BT4h/E3z7e0+6QA+rW4tEAuSG85+ixcK/WjxGU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1122:b0:3c5:1302:c88c with SMTP id
 f2-20020a056638112200b003c51302c88cmr1562618jar.0.1676956185156; Mon, 20 Feb
 2023 21:09:45 -0800 (PST)
Date:   Mon, 20 Feb 2023 21:09:45 -0800
In-Reply-To: <000000000000ff304105f4d1cd36@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8643205f52ec9bf@google.com>
Subject: Re: [syzbot] WARNING: can't access registers at entry_SYSCALL_64_after_hwframe
From:   syzbot <syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jpoimboe@kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d2af0fa4bfa4 Add linux-next specific files for 20230220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109146a0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=594e1a56901fd35d
dashboard link: https://syzkaller.appspot.com/bug?extid=dac365e3ce07c3d0e496
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b9f4d8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138179e8c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83b78c113e8e/disk-d2af0fa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d59f9b2c9091/vmlinux-d2af0fa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2726c16c1d3b/bzImage-d2af0fa4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com

WARNING: can't access registers at entry_SYSCALL_64_after_hwframe+0x63/0xcd

