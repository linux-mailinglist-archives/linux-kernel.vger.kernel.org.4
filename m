Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDD6C7A13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjCXInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCXIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:42:59 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3627D62
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:42:37 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id t16-20020a92c0d0000000b00319bb6f4282so797263ilf.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679647349;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wehTAMPFYUXjNm4f3wqSJ3jEOL3BL9kxZ/157OWhvDc=;
        b=rSXtOINW5SpS3R8MXsRcwknIhFzXVZ0F2xD8ZmR00KKfee8CCmsIlb00XYWIcRcW0s
         VH2VAuEIs5RXEVkZjSzK+3m1tR1C65/8s8yq8XkYd6lwfLUNrWbYCDQx64Y2OzL6F8MJ
         8jxIyTNeEZyHzGDfqWoFHYryKpjh6yhLo5FuZnH/d1Si7PbDSAlngzP9tEniSlC1TinS
         FYkN5gKoMUnOWr9GNgFMGq216XcASb94VsLQzhD753H0ThBc/ZL8R7JJpz5KFkaVEcE1
         Bu4P7PExvp6X6VHPleKOq8NIjTG/Y8y7J0tWjpaphh9rRLZ6LJ6nBsO5c1pLxgNetWvi
         GQ5w==
X-Gm-Message-State: AO0yUKXhHxopH/c/E+1m6QYWd5aQSI01shGtCdkmUU95V9wqZSp+O3d5
        AhVv1sqYbvl75Gwwd4CgtIHNbbTEaQ43vfYJsRxW3AXk4NIq
X-Google-Smtp-Source: AK7set/ecgrOoH6Wjo9F7Pr3qehTGWbKYHmT2v/vNq/qSHUE4SCRgLzJ/SmHxfEAKvu5zTfOZOjhzuZcXU0q6BnRX/HlnWNrg7ls
MIME-Version: 1.0
X-Received: by 2002:a02:aa09:0:b0:3eb:fd40:78be with SMTP id
 r9-20020a02aa09000000b003ebfd4078bemr699382jam.3.1679647349222; Fri, 24 Mar
 2023 01:42:29 -0700 (PDT)
Date:   Fri, 24 Mar 2023 01:42:29 -0700
In-Reply-To: <20230324081551.1593-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099354605f7a15f3b@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in virtio_transport_purge_skbs
From:   syzbot <syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com

Tested on:

commit:         fff5a5e7 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10b96eeec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=befff0a9536049e7902e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ad956ec80000

Note: testing is done by a robot and is best-effort only.
