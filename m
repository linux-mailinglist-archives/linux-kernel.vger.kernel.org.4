Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90765B39F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjABO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:56:25 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188AB0B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:56:24 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id u1-20020a5d8181000000b006ee29a8c421so7712422ion.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbLOW9xzFnV6xde18RxTRBV2jx9u4A4nHG/+gWbGcDA=;
        b=UUcB/Pgff6I4UsCVZMsKspxtse438L0gEooUI3lPsNXgAmrxAovLgxQCE8z7DCi639
         UgNcAOUcBX+acjpQlJTjNCCgx3mwXEaqquWD73l0vuqmueObkFpA1vCz2/gVoGEr14I/
         fyt/8nj/YNNCXPlQyq8ZWvJ63VVLlbChrLx0onNH990X96tPZZJOARVZa6hwfX0CH7ej
         qqgrS3W7JXrtESWh4udH8O8EP4262UAADaOss0TVO2EBm43yj5i0xviBZRp4raO/7HqW
         pXcFMSG+sjTtCEC3OJ5NMtANOmwaLtXFgS8MxPWHBvk6TK9Mkq2VLwtqEKd1jhzWLSkf
         Z/Mw==
X-Gm-Message-State: AFqh2koGtab2f5Zqd0+4seBP3tz+mI9lHpw6enQNfc9+hKwaaw4IIUou
        40AwVv5LMML+Ds+ZC4aDL9OmkRiGpDmyJceB6UXUmVqVqbKW
X-Google-Smtp-Source: AMrXdXv1TGibfk+8X1HKQZP4CF2YpNSpPFHawYMixbTiRWBC4tjfCtnN7lOkwISlfBnI9zFze6JYKIn5EoqYAAPDKrNgiXiyijFw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10da:b0:38a:b159:7b9c with SMTP id
 q26-20020a05663810da00b0038ab1597b9cmr3315807jad.77.1672671384204; Mon, 02
 Jan 2023 06:56:24 -0800 (PST)
Date:   Mon, 02 Jan 2023 06:56:24 -0800
In-Reply-To: <20230102094125.3552-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae803005f149272b@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in do_user_addr_fault (3)
From:   syzbot <syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longman@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        willy@infradead.org
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

Reported-and-tested-by: syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com

Tested on:

commit:         88603b6d Linux 6.2-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1508687c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdb1e7bec4b955a
dashboard link: https://syzkaller.appspot.com/bug?extid=bed15dbf10294aa4f2ae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162634e0480000

Note: testing is done by a robot and is best-effort only.
