Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE964C247
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiLNChV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLNChT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:37:19 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34826AD5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:37:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so3112662iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V8K4P+odUhFzrMPlgU7XI9XjkyUPNFDXnhnOg+jYUs=;
        b=d9gP1/s3Fh51qc2R5BUs8ejydNm8GUnZKpeet8NlBRBLL/S03X1MqzbXxonce6Cx3y
         4lWyYFFs0I64tsSOhh0WsZGX3TgAF8PFTsbej6UWLaUVZNZneQCZQmacwcRgzgDiXqTS
         fPeDs8IZwvEtR4/vaoJCNqTN8WKH0Vynhb6E4gzN5eOVVPDWYomEt8FGnUdtSNqmMzmP
         8X+l7klqXg4+KfqKiCgsptVeudpWkb9qPbI5jdX6HPLC8d9gFxsMv2eif5LKys2vJbqb
         ZluwnuBr5gUE72txRr/nKvogEAbul9oOgX6IiYTDGdjpXrcwcEOErEnBxM0eAF3xXdYf
         bJaA==
X-Gm-Message-State: ANoB5pmYME10/bXJTSha0ZLTRx9WH6yQv03jObx/K9CooT9CqbLP3pDs
        jPHhs9YkTEYODr3eAil1ZYABMUCh4oRo9BtKqUpDLJnOVZhf
X-Google-Smtp-Source: AA0mqf7u0eTswsmCa8LdNrGaamA5+mp4gNGUxGfLY2Eb+hqaukHdk7zxDNLOiCVwyu4aK3b6ZvvsyWg+r3SXppaMj/L4Cache0Sm
MIME-Version: 1.0
X-Received: by 2002:a92:cccd:0:b0:302:58d0:2510 with SMTP id
 u13-20020a92cccd000000b0030258d02510mr39789401ilq.27.1670985437082; Tue, 13
 Dec 2022 18:37:17 -0800 (PST)
Date:   Tue, 13 Dec 2022 18:37:17 -0800
In-Reply-To: <Y5kgHgl2dU6fkr3p@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066fb0905efc09dd1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in gadgetfs_kill_sb
From:   syzbot <syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com

Tested on:

commit:         830b3c68 Linux 6.1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=10f5988b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ad66d65044b93f16
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12208bc0480000

Note: testing is done by a robot and is best-effort only.
