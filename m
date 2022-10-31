Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC57612FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJaFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaFS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:18:26 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7F95BF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:18:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso6998541iox.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqHgzxDahGo8WLLuBYy59P40M4NmqDz0QC8mWC+Acpo=;
        b=L1RMjNNFCilprb40LrJE9l5bALtLKiPpq4PEBesOldfXP03HDtfiWi7Tt67Dv3/Dze
         PPwnEoOEdEpthTVmbJTAHFkxKsbUOu/EkGi6LXUHeaU807+SWHltX0bhXVUmQ3aWIs0K
         HfAJ7pL281o6c9nwVpb1FdAZl79GgIHVu7wEXm1VGNEmBi+Y3b9g20zj2DcuIRlQmSeg
         Yf/lnmng1TySoA+FU7nUqfVVO5v326qLC4i0os36pdODkcXDctYcj7H0rDKEY5z9Bg5b
         OPDS1/A+elm3/r17pJN2alGqu60PzmJayQVCyZ8qA3aIKoznTfnt89jRJ0dy/VkXp0Fj
         q9sQ==
X-Gm-Message-State: ACrzQf2fDIlzcmc+b9gKrLzKOkOlH6YBGJAevBv9bnQrnfaD8S9QUJEa
        84c1sUu/OeJnrKN1sgJ6phnW9q5tKnW3Qm/DTWgYuN/1krZs
X-Google-Smtp-Source: AMsMyM5Z+FcFSBgakH6YLy5XAtjRF33Ed5FIP7Y7cGMGJkLgInKlZZou46sPbAtjT/FJ3HaHpKsanl3V/5hWpmqfJlnSgrtqio13
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154f:b0:6bc:f701:cb37 with SMTP id
 h15-20020a056602154f00b006bcf701cb37mr6189453iow.136.1667193504510; Sun, 30
 Oct 2022 22:18:24 -0700 (PDT)
Date:   Sun, 30 Oct 2022 22:18:24 -0700
In-Reply-To: <20221030153622.22720-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bbc8205ec4dbc91@google.com>
Subject: Re: [syzbot] memory leak in regulatory_hint_core
From:   syzbot <syzbot+232ebdbd36706c965ebf@syzkaller.appspotmail.com>
To:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, yin31149@gmail.com
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

Reported-and-tested-by: syzbot+232ebdbd36706c965ebf@syzkaller.appspotmail.com

Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=131ffba1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f454d7d3b63980
dashboard link: https://syzkaller.appspot.com/bug?extid=232ebdbd36706c965ebf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17589461880000

Note: testing is done by a robot and is best-effort only.
