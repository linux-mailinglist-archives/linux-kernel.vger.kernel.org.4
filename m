Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBA74BBD1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGHElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:41:38 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193571FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:41:38 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-682ce1a507bso2735866b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 21:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688791297; x=1691383297;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0VhvwbxZGAWKOUoBFRLQTEqpuP8bm9XMrOO7d52aZI=;
        b=aAAFd+kqyY1+n+h1ui6O89HWd095vOtbdOXDX6Zu3vqUEUCWSaOnNFcP5gNCOC+z7n
         qdzXlJtbOFS484SWCDyl27lu1mH6stdI1iTXSPo3MXH404ACMTf+JFeS+9QH7wPY9lvP
         hqz8yZM+tjYNJw87bLHzro3v9RHZcfwgSlnlmz4wbVUKnqrnzy1elNZrQXkKNYviXTLr
         XtM50P+sMUAeVJahi1RlXArXhMTVe3CumKByW5VktBZKB9pebvneiSyXk4obxEOqPbPm
         EOTbId4/FbUp6mk5k4zaFEpRCEsNKIYIoMYLXaugOUdsshBrnmbpe23FU7K8bL6MQmE3
         lJLg==
X-Gm-Message-State: ABy/qLY/SISXhMAJod0i9EWCcByqo4RqS6k8VDPQ6KiXdQt5xN0/qw/X
        JwkWsSR0HaJt/a12NMAC3AR8VOlC8+vvoxou8Xi1tTlb5rB0
X-Google-Smtp-Source: APBJJlEMXRYYKZGiXeBkman76ubozY/u7l0NdVApYYVuUGWypdtb9Z5EVFtEzpZKnAzUdk5GiUSiQsInetR6tISmWxxpSUt3xtLo
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:194d:b0:682:5c5e:5450 with SMTP id
 s13-20020a056a00194d00b006825c5e5450mr9871192pfk.3.1688791297584; Fri, 07 Jul
 2023 21:41:37 -0700 (PDT)
Date:   Fri, 07 Jul 2023 21:41:37 -0700
In-Reply-To: <20230708040455.1491-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006473ee05fff25d9c@google.com>
Subject: Re: [syzbot] [media?] [usb?] WARNING in smsusb_start_streaming
From:   syzbot <syzbot+a7c205f9c1168e2f1dcc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a7c205f9c1168e2f1dcc@syzkaller.appspotmail.com

Tested on:

commit:         d5280145 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14150e3ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=a7c205f9c1168e2f1dcc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127c479ca80000

Note: testing is done by a robot and is best-effort only.
