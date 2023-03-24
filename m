Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C36C7CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjCXLH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:07:24 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2123653
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:07:24 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d5-20020a923605000000b003232594207dso986874ila.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679656043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ZhVIxPFtXCaALNrb4+ySwYO8dQSio+fYGgbOrXswk=;
        b=VCrmi1aoBkf+hRH7m5wzf2gbrgAViSQChcgG70mKlwnoTQyBySmTnIakYJQ4NZ6Xs4
         Pxajv5VrzqEUbsDvFLtCh04HPssbnq0OuutYHnEFat8Yn8f8emG5SqtuslbxutnJ5VYy
         t9pJAR1KUT+xu6JJEP5qCfJMyou8yMEWqwV+JRIYcXWyaOknlVQyRUwdds/srQEB009+
         GfvAAx54NOUHaG61Rw+mGF1Xu13lNXPFrWjGV5x3LU4OBZv4j4/OovHmNBb/Vi6PnYWn
         tvqlaW88qmbqceEOjR2/ZTYDCXzexRFiZbc0eARz4ptahaytmgc9yMQa8SAKB5d4ngm8
         zH3A==
X-Gm-Message-State: AAQBX9fFwt7P0mWx2huww6ogcrFQnn5/IY+40pNhJreF6CK1ofVb/AXg
        jx9GkKpmujJqolwbytlUz5oDgPdwOf3QaXbWhtFq4tyObOrk
X-Google-Smtp-Source: AKy350YCaqe2kHPz+8zu4gx3PjOc9aGzJ2Ul6S76biylj9zWEg0h4C7lqLBFKFoPyqrNIGdTY1lkjUofKlTRCRm1k+HlsMDdThd1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:313:cc98:7eee with SMTP id
 p11-20020a056e02144b00b00313cc987eeemr1605730ilo.1.1679656043503; Fri, 24 Mar
 2023 04:07:23 -0700 (PDT)
Date:   Fri, 24 Mar 2023 04:07:23 -0700
In-Reply-To: <20230324104205.1646-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1686905f7a3655a@google.com>
Subject: Re: [syzbot] [net?] [virt?] [io-uring?] [kvm?] BUG: soft lockup in vsock_connect
From:   syzbot <syzbot+0bc015ebddc291a97116@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+0bc015ebddc291a97116@syzkaller.appspotmail.com

Tested on:

commit:         fff5a5e7 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=133635eec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12e37aa0abf8dee
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc015ebddc291a97116
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1478e85ac80000

Note: testing is done by a robot and is best-effort only.
