Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC975660C52
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 04:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjAGDwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 22:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGDwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:52:30 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E34D730
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 19:52:30 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso2241497ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 19:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBcSVnaxc/NIeEvWPgHZmLKKJrzqh0xUvpKv4gtAeQc=;
        b=qbWTu5WiCHRnUXj9wHXLif65r5ekP1+vTjp38m1r42YAWN5IvOWG09Ps7y3RDK7xWH
         rdnlbiHy90OiSCaGyFXSjLr60DwvJFO5wr/+AzfNvqkJWyY6vK3G6nnIZ6/mmPOM59+d
         0Dv1L9zUerU/tQ8HXze9rXrQlUfkVT7GVsOd5nmkaSdeFAeJF4wdA3sivm8OSVrCwcyE
         hxTGX769fN9RQOJ5xiIyU3YFaAa1bxzKEb1kzi4wxZajoO0/o805y33Krsl6XNC1RanV
         /g2HXBFtyhlJSd1xYWS+k/MDK3MScmphNwe0WGkxPAXbSU5ymXLT5nQVgVxRw/ebE/8n
         sziw==
X-Gm-Message-State: AFqh2kr0SIinj56nZLKD091iZvMhkfwk2ktIgmYl05I6gfbZJEPxX7xz
        PUuaZ5pOOJUUoroDOSS8U0HFyhawSw0PriROLho/qGQssv6s
X-Google-Smtp-Source: AMrXdXs19/6uyxVam2n1YH4dt3uMqt9Zx8yMmD+vZE/1UzT9rp9eGUJ3oQijkph6dD4YYfE8mbjg0CibAA05HRVw4pcbd+4Faz5C
MIME-Version: 1.0
X-Received: by 2002:a02:cbc8:0:b0:38a:90d6:bf60 with SMTP id
 u8-20020a02cbc8000000b0038a90d6bf60mr5954401jaq.290.1673063549633; Fri, 06
 Jan 2023 19:52:29 -0800 (PST)
Date:   Fri, 06 Jan 2023 19:52:29 -0800
In-Reply-To: <20230107011144.4677-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000900fe405f1a476f5@google.com>
Subject: Re: [syzbot] possible deadlock in rds_message_purge
From:   syzbot <syzbot+2286d16a0b79933453e5@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2286d16a0b79933453e5@syzkaller.appspotmail.com

Tested on:

commit:         a5541c08 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10b79dfc480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=2286d16a0b79933453e5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147f346a480000

Note: testing is done by a robot and is best-effort only.
