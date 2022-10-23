Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037C560947A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJWPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJWPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:43:20 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED561738
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:43:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x6-20020a056e021bc600b002fc96f780e7so7280975ilv.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTymt5VYbjAjADy06vLnS4ERnFAuQzELOwzGBR8jsnw=;
        b=Ybm/+0242rbkDVS8yTIahV7uR6Wff9lqknmXItYVCNuxVVCNN0cC1cspfe4BLk8Zxv
         Q/KeeKTd44GsYxxmXauB+fr3UFhUaFi7NKdF3utvpUIlXxVo2zVLhFBYjHHta0HByad4
         Y1LLnoDtyzrnkCo1vmdiXaX930Wh+kECgKPIJeMJeucaMBJa8OV4vrlfvKd6byIX9TtK
         jTxVSUZDUjBa+c5W4oc5a7rLiarMmOCtc6DeGubIWkGsvzGCD1GZLUOtrenKPpBtrbjW
         XJIz4W/ZIQE/PYwSkDrgk+/UdXHTxTE0ulRL/0ge9PxAQOHg5r7jGctdMtw/k70r7vEL
         EXHg==
X-Gm-Message-State: ACrzQf2bqjayE7m/wqsD11zzRI6dwVgJMX/H+WeKe3016HszhBRBeEJm
        2vMaPpk0xqRFCfHrZPUTPnJEEoZ9gfF+bOnq1L0l0NaWhZQT
X-Google-Smtp-Source: AMsMyM6fdfRJbZMJnQRdWBaB9SLqI8HPSFMJTo/jUHBmc0KEsMCAUyjDMSnqKJfvqqQSoXSVAA9zJtb0CiZnOF0UiBq7GWbBKQ+h
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4190:b0:372:4b79:5d93 with SMTP id
 az16-20020a056638419000b003724b795d93mr2142763jab.216.1666539799032; Sun, 23
 Oct 2022 08:43:19 -0700 (PDT)
Date:   Sun, 23 Oct 2022 08:43:19 -0700
In-Reply-To: <20221023082948.2403-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9b91705ebb588aa@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in l2cap_conn_del
From:   syzbot <syzbot+03450dacbc626061c3a3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

Reported-and-tested-by: syzbot+03450dacbc626061c3a3@syzkaller.appspotmail.com

Tested on:

commit:         aaa11ce2 Add linux-next specific files for 20220923
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172b6de2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=03450dacbc626061c3a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1069544a880000

Note: testing is done by a robot and is best-effort only.
