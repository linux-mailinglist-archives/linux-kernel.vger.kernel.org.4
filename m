Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC868750B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBBFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBBFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:24:20 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070987961E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:24:19 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so580123iln.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 21:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IdhLN7blaiFlYYXdiDw2TjTWyguHQAL6uESu612dl4=;
        b=6Kzogz1T1C9l/ThMfQq7ouLltvCZXym3WMX3K6O+OoVVEvInlfagqFttFAgY4Z+0y8
         yUgnWn93oXDHAliiUl+CMdsOyt0GFmWLhHV1lPzw5sgQ5wTGwkaq9sSunwDdklRoQ7Hy
         Lk7VLAVEHl5Q7KNWDbQmEikpnXEaYMM7nfMaUNeFtl6NY+xZIrS5Pw4CB8UJ4+FrhLW7
         kif7tLq2te2ccgWxKhp8ekR8/4PmFI+nQzD8Dzc2melZIx+zijFzgm5999AGunU55bLt
         pfu9AzXwGb8KUzNMIbZ7LPA6DUEBxtjAJ6W8Rl6bw6jmt8XaUuVnJs+V5LjIUmLqaEHp
         PqbQ==
X-Gm-Message-State: AO0yUKVA57Nfl+VS4iX9md5cUj+P26wBw6DLUXtm26xjz05gELGUD1ZP
        T567L+QWWG7T5DvsagfhowaKIWyNTbY2+ktgct/Dqra/sf4Y
X-Google-Smtp-Source: AK7set8Le06QLMqtTXGi4uyCFFPiku2FDoa91+mnIte4BEHLNE793EABS5jx0ZYH3yGOl1lxN0NsMpxSFhpaOZ13H+X8mE8sPHi1
MIME-Version: 1.0
X-Received: by 2002:a92:1a0b:0:b0:312:6793:13a3 with SMTP id
 a11-20020a921a0b000000b00312679313a3mr898772ila.38.1675315458354; Wed, 01 Feb
 2023 21:24:18 -0800 (PST)
Date:   Wed, 01 Feb 2023 21:24:18 -0800
In-Reply-To: <20230201233318.593-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8393b05f3b0c6fb@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com

Tested on:

commit:         9f266cca Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1288afb3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f93727847d4d81
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
