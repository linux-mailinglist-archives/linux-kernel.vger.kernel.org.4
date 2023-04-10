Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378946DC54E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDJJoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjDJJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:44:08 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37667199E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:43:47 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id q17-20020a056e020c3100b003245df8be9fso3714300ilg.14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681119806; x=1683711806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJKZF44pl91wg5axLuITmc4eT5aKQGmjCOeCJWpfmqE=;
        b=AB+XzxTMiH0b5um5BAlctuhnA5VepWLphusbeY7toQWqSzADPTiqd5zX3nztYAsNhL
         EhU4cXZ9DAvOvpRNtECj/EoHKyADooXZ9nmW+GFeq9yu9HAkzN5tvluq6IJzyklHRAsl
         hSOn1XZotNMd9zUQ6eflYDBXI7CcG66TazSlI9Lf7lqiWj6StHn/zaoSJN2OET+EI1j9
         C5kEDYUhhj4mbL9/jICh927Iq8XW+p6BgdTC7VtmtUGMip+rnSl1BtunySkfe+W/N5Gv
         H9wRa0xwGJDVDNpr8+OoQaXgZ2trL4qy5kf1pH/kS2qnXR0ZOZLDVFhvyQ/38ineRuEe
         2lVA==
X-Gm-Message-State: AAQBX9ezMfTXT1AWBQDfnf2SM30kRp1HkSjMiGxvKyiYZMHHOyRH4X9t
        xobcKS63RTukGPkwPsqYMpp43Da6fbv2gAgXHIbXHFICNx1q
X-Google-Smtp-Source: AKy350bDOn1JZxKnq3INKUBPDnuN8dYHrrcXp5jswLb971AVEcfcZpuR7GZ4eQgHEEiPCrKAEPONVF4a+4Gy0+dZMoj2RLDWHnT9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ee5:b0:310:a298:1c95 with SMTP id
 j5-20020a056e020ee500b00310a2981c95mr5458286ilk.6.1681119806130; Mon, 10 Apr
 2023 02:43:26 -0700 (PDT)
Date:   Mon, 10 Apr 2023 02:43:26 -0700
In-Reply-To: <723ddab6-9298-6021-27a9-872aa389ef16@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de8f6a05f8f834e5@google.com>
Subject: Re: [syzbot] [erofs?] BUG: spinlock bad magic in erofs_pcpubuf_growsize
From:   syzbot <syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com

Tested on:

commit:         09a9639e Linux 6.3-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc39abc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c47e989e3f0f1947
dashboard link: https://syzkaller.appspot.com/bug?extid=d6a0e4b80bd39f54c2f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
