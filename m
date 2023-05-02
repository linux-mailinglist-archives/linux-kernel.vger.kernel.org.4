Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE37D6F3E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjEBHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBHWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:22:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0271FD8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:22:18 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-32f240747cdso197404255ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683012137; x=1685604137;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=widNiSwX2TDPwhdqo7VA82B8JqRaJrDDhtHCns4kZ1I=;
        b=YjZZmQvXdMlVm7QWE4XQ30iwqDSN5UWVShzPZM42PWEeCoVQxY2mBT6OLt1MkqwQlm
         21NXHkQ021onfwl3pOYtKvM9R+7FBZEx9SUj/kEaAj0ReZVUzdCjeuWmpDPMHTTrPme9
         iSuozKDHaKVzk2+HCGkDkeM60VBWKu0ujEFomsQ19xsTq30ixk6I43qL1//ELSOrLuMY
         /0QgVnvXQTdm1+KWm7ZKnjGb+wFQxydyMRisPFfrtoCE6CnraRMSBf6K35TV4tognEuG
         W55HqShIvqz+X1flT57IJQgmDDPRRWA7sB+CguzuAAChhQpsZnCFkora1uMwkZlMyhtB
         4pnQ==
X-Gm-Message-State: AC+VfDwT5/VzUS/w9SAR9H1MgNyjE/V/WajCpJE/9Kzq0UULrw1LDXYb
        ot7gR/tIw7nR/Z/NERmjg3G+cZDmAwjP3ECiUyY7VKf1wMxO
X-Google-Smtp-Source: ACHHUZ5YidlTQmB4YIxVgllTU0f60IUBEUNRNf7aeIadgHWndAuRzmDIo8shyLn0gSotPxhK512L+iw3IOXb3+2ewYBMOFKmATdZ
MIME-Version: 1.0
X-Received: by 2002:a02:85e5:0:b0:40f:9ab9:c43e with SMTP id
 d92-20020a0285e5000000b0040f9ab9c43emr7630628jai.3.1683012137584; Tue, 02 May
 2023 00:22:17 -0700 (PDT)
Date:   Tue, 02 May 2023 00:22:17 -0700
In-Reply-To: <20230502070029.3525-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d819805fab0cc7f@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in usb_anchor_suspend_wakeups
From:   syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com

Tested on:

commit:         89d77f71 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1547bf94280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d963e7536cbe545e
dashboard link: https://syzkaller.appspot.com/bug?extid=d6b0b0ea0781c14b2ecf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f4eaf7c80000

Note: testing is done by a robot and is best-effort only.
