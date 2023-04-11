Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7668C6DD4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDKINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDKINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:13:24 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7083C2A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:13:23 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id bk27-20020a056602401b00b0074c9dc19e16so5018420iob.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681200803; x=1683792803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djjgIgk1VBqK4RbpYBgfm+h8QwgOT9VRNFK+aNQOl2Y=;
        b=JAYfU9q7Ru6S+8nhbxRllYGnk6NMEvX0ir51Xx/G53k7imxrRDH/1l7BcgvZlkmN9o
         PyJJ+UE2DsMHV38bm/L0Kchu4YcirflPxFkJf9M1hltL70rJkVcfQxPjfP8OVqkpXO6g
         MFQG457nPKYAAbkshDRylhT8rOqCSw3XxgMeHBcNj4phPlPFrChGeKXoZd/X3R8RjMHA
         /DXpu2VVlMtQnNJH1NsBJ0V/WW+GvmE6DL9lZ2Oc7kF7fmuKADMUXApYXPYCKgXqLJy/
         CtuovwbLJkO6SkLxy6eQxCJVPJUpNQFnTDzZ8PXx2vSJcomyAmjypkXQBKvQB1myBSox
         zLgw==
X-Gm-Message-State: AAQBX9e1HfAh7WB6qRmHurXw4laG1P5FgP9l9r3UxQaNBQiKbAlpT1Y3
        eDbwBLh1v5SLJLORckwwhoDXUJiVDV+fpF400UQxoiRcbZvf
X-Google-Smtp-Source: AKy350Z7gtlhP31HcuwhBvlRatMCqL3+8ybejEWbkaZEGdhua9vgHG48v6hnsbZbEqnnqS4G024NkH7T7BA/QMsE1YZqkoCBLMFI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:326:21b:6e66 with SMTP id
 i15-20020a056e02152f00b00326021b6e66mr1357815ilu.1.1681200803193; Tue, 11 Apr
 2023 01:13:23 -0700 (PDT)
Date:   Tue, 11 Apr 2023 01:13:23 -0700
In-Reply-To: <9be0b507-4c02-86cb-20d8-052e9c7b97be@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abaf4f05f90b1083@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in rmqueue
From:   syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
To:     hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
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

Reported-and-tested-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com

Tested on:

commit:         349ea8a3 erofs: enable long extended attribute name pr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/ dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=113f800fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7094f4ecb462be3
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
