Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84791637233
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKXGDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKXGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:02:48 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B229C9D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:02:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so671382ilv.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1H7DHPWQxy6B6fw3dGfq08QiogfT8XWAqR68mTWOJs=;
        b=H34ydFNUpCU/a66Q2V7nkn/NFwLlnW5/YgPH/rS0IDK2arWM3/InNw3TQJipj1XHpI
         Ia5LvlzT32qOak1XmDwNdF3FXggxywc0Q0i/U4OMcpsCY/PWpM4vMCghT6dpWr3Lr4a5
         72ZcwjRs9I203U+B+ID88X4fJnnyc6cbq6exWFHDiVmqP/N7UE0P/IMrKUexbT7bCBUD
         6cejTMhELx791Lfft+YbWtTtI49xZFQwkVpGHyOU9yYpCA7dGUVS5huklvBRx3/tPRVH
         4pX76kyAfGFcGZrr0L6f/5hm00iHiF2VMCRpjpardETkUzM+EhiZXK6eSjiVPnyJMo7/
         bxWA==
X-Gm-Message-State: ANoB5pnbI+BKCOEXf1P2+iZc43oMFRUPlgwTewCjmqtJQ8DYhmYEoR8r
        BFwfGNReerPD4/9DHdB3Vbjc5XayPavNsdskQJwhMVCDaL0r
X-Google-Smtp-Source: AA0mqf4eW3j5FQ3aj3RKTywSTTkuftft0gQGJcMeRlQxLfq9MlvNI96yxlKsjhr+UI7+f656n8y5V993j+YGkaAeLW/6xQ/rBUht
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a0b:b0:371:874a:26b5 with SMTP id
 cd11-20020a0566381a0b00b00371874a26b5mr14162804jab.113.1669269755117; Wed, 23
 Nov 2022 22:02:35 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:02:35 -0800
In-Reply-To: <20221123231231.5594-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9cda305ee3126e5@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write_file
From:   syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com

Tested on:

commit:         eb708140 Linux 6.1-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12589ac3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17711155880000

Note: testing is done by a robot and is best-effort only.
