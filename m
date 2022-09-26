Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8D5EA81D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiIZOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiIZONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:13:34 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592041822D9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:24:20 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id h9-20020a056e021b8900b002f19c2a1836so5034755ili.23
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u25rEeokQPPBefAKi6INDDiXFGPGGD4GJZGsMNXA1Sk=;
        b=AC/b7cwEfmrkmC/B0LYRMGEitvpmGu/SqzRp5V3fK+n4nlkfTYooHcV2nwg9MCygLU
         osdHaKT+LQlfWBF2aR8nnNA3ZK6KXHf9VG/mpxwYwRP/PxDZhnCn9QCy+rJh9d+ii48A
         HHHx/52ZafD7/S3sKM+19loAOPUrt2vZhHtkBSmpDHgFSQzPLbMKqRzCq8FvuizqfWn/
         jlB+Q8emZH8ebJ4ceZ8XSHAGsUQsafmlDSkEpew/fCCX4/jHihGzH4lXmDNoqSxeIv0L
         JdajarPPidsEO0r+iCk5y9fxRdsRROJUdVqxOWzD88WzsLyftnHGREfJdKkmxMZDARfj
         OV3Q==
X-Gm-Message-State: ACrzQf1tbS4g5CczUsE8C1deBOSlOYtFn4tSg3/TnkqILhSCdUqx0r+Q
        xSa3HbpvUSW2Xvgi/gYwUpHzof1xEhE++i9BtFe3LjsBHFSt
X-Google-Smtp-Source: AMsMyM4V5W+/9GChVpBuWF5zPe6CNtlotcDxQpXmpyDrz/jXC7xVU0bsnOKzdU3v/Q6iho/N3rhSAA4eNlS1QHDXqjnuh7T3R6Eg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:2f2:f8c:5b54 with SMTP id
 j12-20020a056e02154c00b002f20f8c5b54mr9835914ilu.134.1664195059375; Mon, 26
 Sep 2022 05:24:19 -0700 (PDT)
Date:   Mon, 26 Sep 2022 05:24:19 -0700
In-Reply-To: <20220926115901.4941-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059e49c05e9939b85@google.com>
Subject: Re: [syzbot] WARNING in wireless_send_event
From:   syzbot <syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com>
To:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
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

Reported-and-tested-by: syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com

Tested on:

commit:         aaa11ce2 Add linux-next specific files for 20220923
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1490566c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=473754e5af963cf014cf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162cc9e4880000

Note: testing is done by a robot and is best-effort only.
