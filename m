Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139BA60854A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJVGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJVGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:55:27 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F8144092
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:55:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y26-20020a5d9b1a000000b006bc71505e97so4041111ion.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NF3UcaKznpcPj6/vW39qsVkC0SlgsHxyw6fjLXpAN/w=;
        b=kqhqOhNWJ2xgsBtqmCycVeBSFc4WPHPLbTBh5C+8EY4zi9FwLw+ODzOU8n/pnJvSBk
         aTc1RhSjap5D5KgnNQm9AGkzHtwb0rxYiJZtIe9TmHHAMqFiqArDm9/vY1LE4rW8hRpl
         7Roc5yReItThsKG/HnclcxICZzqVtVaTGGprp3Ji6zo8bdSoMtxr2ekHqigbe4W4ypPf
         TXCYuDwpt/PswwO1dsnRjrM04YASgLciMypWxnFH7SqHdk2eMuhJyty2sApO0aiXYUcm
         EV9fa/XAtWKPaJzw1DWumeWzvXE/c2uFZTzUpQtPZMQEBSuPtlQkQVl1sahrKBQ9Rjpf
         QZYw==
X-Gm-Message-State: ACrzQf2onPWr1JOvoOr4Wr4C2duibmGNhYg1dqh8Rkx1Ba/WUVQMRyFV
        /fiD+2e4J4hsOTOIlM2msB9Ih/vZlI/zoFQnXt8zUNlm0q/r
X-Google-Smtp-Source: AMsMyM5DuoEkApoT0/mBIlzGWl45SzTLINv4/itS/1izilRmbw68HZq8i+iK9ddfML6OUc0jg+o+v021ckaD0CHV3lqOrAouPErh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:2fa:3064:2a7a with SMTP id
 b10-20020a056e02184a00b002fa30642a7amr16710114ilv.97.1666421725593; Fri, 21
 Oct 2022 23:55:25 -0700 (PDT)
Date:   Fri, 21 Oct 2022 23:55:25 -0700
In-Reply-To: <20221021225228.1750-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000000a1405eb9a0bee@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

Reported-and-tested-by: syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com

Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17242776880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1223c16a880000

Note: testing is done by a robot and is best-effort only.
