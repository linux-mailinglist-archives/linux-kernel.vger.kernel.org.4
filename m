Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70862AF44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiKOXO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiKOXOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:14:31 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7882F01F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:14:30 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so12081691ile.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWr5Fz2oIazLc34oMz/NuYwgSAf7HdgnPlItVksT2Sg=;
        b=cmjuCCsaz6oGr0ohpou+GLmYHPUa6zAspK7PbDQs8rtsdUXVsAuYVjCd5qYUbMOgsa
         oejOftARGJ+U1lAq0EgQUvolSb1MMzW9aTDMLXE6ZCiuXFiiJxNqTsSZGXRFvNHscl+9
         RHqQkn61ZoYvd/Zy6+GnLtPPtXxvAzHAbtx/bv+P3QPr9CBKgSBdAG2qwKfQ/dkYzsqG
         W4esZLbiMBk8MHNhs1er+qfne3wvvXGqdPooQ/3guZefJBYtg5eV+S7pby4huA0eauA3
         jp/EXw88a4hLRikq3nrD0INjqbeB4L0vpgSZP1bHpMxzr1c2fmMXfVzlKCFKhRAk0OL4
         uFiQ==
X-Gm-Message-State: ANoB5pl09RCREB+TopmSfr830a0WV43DGPMTXbOBiymRwVI4icIAgnAV
        xP9CZCLB/VyFMR9EZrRElA2c4Oct17QXruez/ava6lsMav4y
X-Google-Smtp-Source: AA0mqf62bCnBTD4OsFcr2uvEPiAewIzGLm2RhCBq4BCclmC7+Wd9k8Q1Lsp8GY/AEJZGbCPrCU7WO2dz27XLkErTQRC8GEgtl/72
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4415:b0:363:8849:44f7 with SMTP id
 bp21-20020a056638441500b00363884944f7mr9021563jab.24.1668554067973; Tue, 15
 Nov 2022 15:14:27 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:14:27 -0800
In-Reply-To: <20221115123800.2680-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082ae0405ed8a8444@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_commit_transaction
From:   syzbot <syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com

Tested on:

commit:         e01d50cb Merge tag 'vfio-v6.1-rc6' of https://github.c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1191e71e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0b2ecc119b39f
dashboard link: https://syzkaller.appspot.com/bug?extid=52d708a0bca2efc4c9df
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bfd679880000

Note: testing is done by a robot and is best-effort only.
