Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9C63725A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXG3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKXG3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:29:21 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B170942DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:29:17 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 13-20020a056e0216cd00b003023e8b7d03so692178ilx.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3hGbkP5C8W3VIRPGiXKUeFAJRekFAZNpzrs08gFsso=;
        b=WRz+MBBXjxkD1q7F3AA5OxYVIEjVyiu+BSQSs6yu02YlphGe6t0T1NFRS9inqfdanx
         f5vUlwTwDczqPgd193Gpo6TKrEF0wz+rm93z4SBfS6pxSQjDwGnLOd1Vz9PFWQb9lUP+
         Ue+1msaaB6zITsesJLIoW9SZoXFNmoEfy3TKNJz4VOLv8+I9fK7+QXgZCiffxpSa9C5c
         Rp9tnlFNvmVnZEYXF97U+uOGJK90mDgSfJHZpVT5lcAKSoItBnR9e+2rLPax+PJIVgHm
         2MQhjQOqVUMwx5P73U8GNHiaswL7pRf34WzWzyYy1qQ+bdczAs/J8eyUKcFX9R79sfTX
         NgdA==
X-Gm-Message-State: ANoB5plpcFmUe1JEfWMFDifaB7utKcRz4PIW4rKm737lK4VhQLeiGZmO
        gcxn1mZC0ll4SeLvWtXoNz1zbBX/GpodEjPPAY/4fukkdXu+
X-Google-Smtp-Source: AA0mqf4K6uapWj6gCPQOuieKv/pKTXT+XmG+U0nhkQJpwfvKVj6g81x+g4jfol4I+HYorihHsLe9d0gcCp6Rll3Sahf1KZ8yJbyd
MIME-Version: 1.0
X-Received: by 2002:a92:3609:0:b0:2f9:609c:5b3e with SMTP id
 d9-20020a923609000000b002f9609c5b3emr5304078ila.289.1669271358476; Wed, 23
 Nov 2022 22:29:18 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:29:18 -0800
In-Reply-To: <20221123235645.5656-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b193405ee3186b1@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_search_slot
From:   syzbot <syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com

Tested on:

commit:         eb708140 Linux 6.1-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c25fe5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11dec839880000

Note: testing is done by a robot and is best-effort only.
