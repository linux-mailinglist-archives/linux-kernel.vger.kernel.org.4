Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83068646E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLHLJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLHLJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:09:27 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D536A94939
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:06:17 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so837087ilh.22
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 03:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFNEjikdDKIGbIXcuAlk/+ki2ZmSz9fWBbGY16JNQhU=;
        b=qfu99g1Gn4+OxsCid6bZTgDDnP0moeO1ROKHF9Mg7agSR9OrDsB+SZqG94oOi6qN1Q
         IW5jSGEfDwF+z0HVTN4lP38Toe1VLTA2RfD9NQK8Dh4smWou9yvrLUdNBWMrMqOLddWk
         i7j2Rnz4dZHsO6Y+zvjNC+Ojm9A3tViwq1EXhfIbo7IXCnW2oe33zys2ykW6VQpDqYlC
         s57aoWu/84UsfuUQ6JOfbb0z+wqXiB4f4gVsTTIrnfnO+g4K6mRmOGnErOFNr2PFTY4o
         WdydDbLBgWYgsxvTJqZdVU1U8g030fH2mMR9DXPkH5ozUPj9W9+du5vAZGf5TsDJTR+p
         ODeg==
X-Gm-Message-State: ANoB5pmd3r5PDCREmOqOBHpDacjyG996SH6HkgbXYcgyqB6lVnJou1x5
        /LG8/RwAfQ7mh9LfM5Bwe0kGn71RMR7nyycKPI2t4uA3i0LL
X-Google-Smtp-Source: AA0mqf6ZFw+5uYrfGquMZC8eelXMMwS1iAYVUo6vrzG+2km6Vk/VPAS7q7w8GQZUQzcZID2VZkquqKsEGkaClJQJC7YhB5cRVXGC
MIME-Version: 1.0
X-Received: by 2002:a92:870f:0:b0:302:501a:a25d with SMTP id
 m15-20020a92870f000000b00302501aa25dmr34269679ild.311.1670497577197; Thu, 08
 Dec 2022 03:06:17 -0800 (PST)
Date:   Thu, 08 Dec 2022 03:06:17 -0800
In-Reply-To: <20221208032216.63513-1-chenzhongjin@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afe93f05ef4f063a@google.com>
Subject: Re: [syzbot] memory leak in tcindex_set_parms (3)
From:   syzbot <syzbot+2f9183cb6f89b0e16586@syzkaller.appspotmail.com>
To:     chenzhongjin@huawei.com, davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
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

Reported-and-tested-by: syzbot+2f9183cb6f89b0e16586@syzkaller.appspotmail.com

Tested on:

commit:         355479c7 Merge tag 'efi-fixes-for-v6.1-4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=175b5b23880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=979161df0e247659
dashboard link: https://syzkaller.appspot.com/bug?extid=2f9183cb6f89b0e16586
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142313f3880000

Note: testing is done by a robot and is best-effort only.
