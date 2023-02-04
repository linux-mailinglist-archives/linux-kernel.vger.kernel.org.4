Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711A368AA70
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjBDN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjBDN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:56:55 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9737B4C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 05:56:17 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z25-20020a6be019000000b00716eaf80c1dso4596379iog.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 05:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Emb63XsdDhrPAmiTP8mjO1WrwEK7/rhCpoRqKx1srC4=;
        b=h5fZytvSwQ/yvut3kwKSdAzgazwt6WzVXDevht7L2nnYoY3zZglJ8/VQvH/mxatvzx
         xgqFWvbqGMQw+UuTXv31+DqijQIFejr+fDlpfgBGzC83c44Tji6cPLf1YR/8L85Qa/lV
         oIDRdCsw1IIV5ZSh9Ztj62p2bBhQxDDEZwcqxM7/6Vfry7mbrQ3/fJx5YbKXWp14FBW8
         wCeMcxmyXwZZPc+QBkvtvDZ/62ZteNaC/VWCOzrz60pj27G38cWz6dyEYBHg3lbJ0miY
         dhvbCSKVZuufU+yExWOekU+uDjlii3bVbkCZgwF478gt1oFgm7HxdtkjFDHBwPRt0wDs
         v74A==
X-Gm-Message-State: AO0yUKXu6mB++2KkMW3q87N6yxLkdWxHwoV+sYNFLF8zxhfeQiUSqB/M
        +AxsMBL/dbSEN5BjloQpkpFFodzQxtEmrH5wNNWO5BYsIWoX
X-Google-Smtp-Source: AK7set+CSbVY2liHAelhyVioAOv8bFi9fhdU7Wj4/2qemmhDU6DvfkHo5EsSrGGF9wo02b7P4lJDB/FVRbwnABoPd9k+dQlzbIbo
MIME-Version: 1.0
X-Received: by 2002:a92:ac14:0:b0:310:c4b0:3629 with SMTP id
 r20-20020a92ac14000000b00310c4b03629mr2574328ilh.97.1675518976440; Sat, 04
 Feb 2023 05:56:16 -0800 (PST)
Date:   Sat, 04 Feb 2023 05:56:16 -0800
In-Reply-To: <000000000000f61bdf05e79a7c5c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067d34605f3e029f7@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in mi_enum_attr
From:   syzbot <syzbot+28207acc70bbf3d85b74@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

syzbot suspects this issue was fixed by commit:

commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 10 10:15:33 2022 +0000

    fs/ntfs3: Check fields while reading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c11ba5480000
start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=28207acc70bbf3d85b74
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1275aed7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124f533b880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Check fields while reading

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
