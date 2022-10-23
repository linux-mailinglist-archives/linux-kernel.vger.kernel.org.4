Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444160945F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJWP0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJWP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:26:27 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545563FE8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:26:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id r12-20020a5e8e4c000000b006bc3030624fso5197656ioo.23
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaxRAuj/+PXkYlhl7uB+dZzAXFnwrxPVUZbjk+r3QWY=;
        b=izBT4RZJRycRnObd6PGRbVInP0TSV1bDoNivR/P0NdGeBGmrpWzk5XmIHntLjQD8Uo
         dQRA58Rtfb/9VtTvAiX3fbh3jVjamr+KGH1lMMS+GIq6zjgALyu2CZrbErvVwNN5+C04
         /OSyPI/c+yPVdx4p736aQ3rDJ+oXIxo5PiAHdXmu1AkCPI0pwmUNg91JqUtDBkrvT+mC
         wqFQQeRv4KlvXGKjlCsCIoZ88tyTsZa2mqEj158lo6D6MtgKukgqz5i8K2R0v4XfZfty
         mVKFwO80+QoDTWTuVLTJ4uJBBKR2IGxrzZUuue1vF4jpBcD/ywmMWgWo89GGixwAjNoS
         oklw==
X-Gm-Message-State: ACrzQf0v0BPhYEHr9aSVEEool5oscJRye8IYX/Byd98IhdodiRLCI3tT
        NbXzJPqMzFt4g5goMDzi6LGKi/8eGMRDgt14HQMDQZt5B2hW
X-Google-Smtp-Source: AMsMyM7dYAUgR1bBqmEzNG+CF8E4C4lf7q1JA+llBbjODOoBlSOCN8wgU3rnB4DS63ZrCY+pYcRiGbjAQlSV+iYDKYC2Z2Tx5iwm
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:300:703:3ca4 with SMTP id
 5-20020a056e0216c500b0030007033ca4mr153911ilx.323.1666538785638; Sun, 23 Oct
 2022 08:26:25 -0700 (PDT)
Date:   Sun, 23 Oct 2022 08:26:25 -0700
In-Reply-To: <20221023071055.2312-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052919405ebb54cf3@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_entry
From:   syzbot <syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com

Tested on:

commit:         4da34b7d Merge tag 'thermal-6.1-rc2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1382cd4a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=0d2014e4da2ccced5b41
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a4632c880000

Note: testing is done by a robot and is best-effort only.
