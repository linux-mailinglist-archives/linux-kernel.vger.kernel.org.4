Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C847260912A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 06:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJWEd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 00:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJWEdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 00:33:18 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB2785AF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 21:33:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e02214600b002fa23a188ebso6524724ilv.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 21:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3++xCNbtwyE0ImzYHfirIEVfDj412WSC2LsDLBoEUI=;
        b=eERWQl5cR50yUIO3kr1Aq2CDe73+9S6wo1Ni+ldiw22NTw3imBJrZk0EIFvyzu+OP9
         +m5+2C/1LSmZyaGFLsxUMaxJDn3x+YnBtRpVnm1Kiot1ixBN2GdrXlN+dy7cY4WGrWPm
         43Wj32f1Hll2j1K+zHKNUNyGTT+m2fL+KBGcHLd/5ensG09NFjyWM2Qe42I88VmVBZnF
         Podl2Ze8LCbxUK7HOxqQq306g97THE6nCOK4uwIa0zf2o80R/D1eKNo0U3yPQqFKjdU8
         ukUOh2WKWNtdWVnMDqh/7JQT7IY0SPtxUM87eu5fYYWHJ4ibVJCKAPr3V4KcLIbnILcg
         T//Q==
X-Gm-Message-State: ACrzQf29E4V5foC6+mSVq+T4uX0b49g4k1iRH1+cHBJEQ9N7OT7w5W/o
        Wiqy2HtxS5ZKQyFAWC2hOrawxPdKJA5c2Ug4SLyuqPlDDBfD
X-Google-Smtp-Source: AMsMyM4Mc76rW/65SJF918n4ANtyC3c5DAqcIzPgK7E6HfOSp3TpvtNNE4Fhre+g/8U0+W5Zs2tZfh2V5JGUkPafLTrlTakEzB0e
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b45:b0:2ff:9c07:fbb8 with SMTP id
 f5-20020a056e020b4500b002ff9c07fbb8mr4924838ilu.200.1666499596563; Sat, 22
 Oct 2022 21:33:16 -0700 (PDT)
Date:   Sat, 22 Oct 2022 21:33:16 -0700
In-Reply-To: <20221023040136.2199-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078bbca05ebac2c70@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_add_one
From:   syzbot <syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com

Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12f6abd2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aa6e5678f6a04d5
dashboard link: https://syzkaller.appspot.com/bug?extid=ef17b5b364116518fd65
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17dbacba880000

Note: testing is done by a robot and is best-effort only.
