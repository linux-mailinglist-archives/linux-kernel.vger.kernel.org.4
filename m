Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246F76CF9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC3EI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC3EI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:08:26 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1D524F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:08:24 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso11451241ilq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680149304; x=1682741304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=749REmaSqohCPYHd1tbPSYQ7gMIpSBf/jrLiSuc9foY=;
        b=Ds/l4/PDk32EOct8OSju3e3mx9NpEkhaEBZ0Dbxw8c3KlAmYNljM3XdZaHifpOuLpx
         KJUVZyX0F4DESVO4QsFNaMPuX/kz7B1f1UKDGR5wPRVp5pd1b+fKb4+5BghwaPFPG/7n
         9gUlv2rJcJ6ryO/88qD2JJC1puYEr3BKd3Wms4MOOIqsl4Bm3CoscjFzzAYMcWO2ZSFx
         rNoh0N6pvllQXDed357Aaa3MSqCwaMPcRmuW8ZgvBw0X7wJFTe6Yj8ooMNuYjPFrdSsg
         qKc5ODi81SKp+0gPuV6MBab7CecHoGbwmtdGOKaskttMh2Wg4aMT82iH9JP4TdTIH2Lu
         WVjw==
X-Gm-Message-State: AO0yUKVPOtS5zVKxoDbXCggcN2/lZeacQRzIIgpBNHDZjTuHkwHIId5Z
        CABMx8vbvHSpYcLeh9hSKKe6QZiMDL9RY8eN9WN7Uu+QUIVS
X-Google-Smtp-Source: AK7set/YeOPuN+1mY9XvPCAcmDb9TEsXQUVrOFEcvmNzMmSc/t14IERRU3XwlxCB77xOBq2hzDRGzp+W5BKcrE6/ioVfRaZqXkIA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10ce:b0:3a9:5ec2:ef41 with SMTP id
 q14-20020a05663810ce00b003a95ec2ef41mr8357058jad.3.1680149304162; Wed, 29 Mar
 2023 21:08:24 -0700 (PDT)
Date:   Wed, 29 Mar 2023 21:08:24 -0700
In-Reply-To: <20230330033925.2831-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071bdae05f8163e5a@google.com>
Subject: Re: [syzbot] [fs?] KASAN: null-ptr-deref Read in ida_free (3)
From:   syzbot <syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com

Tested on:

commit:         da8e7da1 Merge tag 'nfsd-6.3-4' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=139a22b9c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac3859139c685c4f597
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1765c20dc80000

Note: testing is done by a robot and is best-effort only.
