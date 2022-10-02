Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0A5F21A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJBHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJBHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:07:27 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585A3F31C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 00:07:26 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b002f612391d5bso6383153ild.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 00:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Qi6nBTR+UnFwIOgi+5za5E54nvZ3NxHLQWk2qFGen7o=;
        b=ui3EtIe1IjhH8WVy+KCS3SSutiD4WOdnutkhCqhpmrZz+LERKnRLe5uWxhwsIOjie8
         hzS1b/054Sqs+vzGKMnKxidlrOCgkWhudvS4/OdXXVd1MJ6azFjADAC1x4L7OfyEA2zf
         iQUSPHRRwmXc99/ki+ucNVKytyanw91RNXDw/RGWjT+E94c5xMNDGc+QSRJwX4f/v5co
         N3kWBml6FbKjnEyIqMRno0z23X/FIwXQgZieD6SJVch9cCWZtZsnyI7MZTeCoh4boefM
         840sy4u2dSLCGmNUcIiGx4lfRj8Z0YbKFYz+QA6KqyXMGfzhbolvbfhizjV2BJi2ps/I
         tyCQ==
X-Gm-Message-State: ACrzQf3jvLor1XXHEb1a3goS/A8vEOISgiOkQougJ44D2FxltbkQa/V+
        p/HonxjiXwOTs04KMdwzLXdyjn2tspJu0fwaXBSG77bhL1kI
X-Google-Smtp-Source: AMsMyM6cwMuncRrmt79Mj/WXcS4r8FkcadYGjogneb5rOnAxTbtsoztfCGT+QgEWfG27XV9v4TrPFfCnEMjjdH+b+i0t+wg4+sQ6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:2f9:c089:eb27 with SMTP id
 g12-20020a056e021e0c00b002f9c089eb27mr447588ila.172.1664694446144; Sun, 02
 Oct 2022 00:07:26 -0700 (PDT)
Date:   Sun, 02 Oct 2022 00:07:26 -0700
In-Reply-To: <000000000000c2333105e9cc7b1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f464d05ea07e1ec@google.com>
Subject: Re: [syzbot] WARNING in wnd_init
From:   syzbot <syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        kari.argillander@gmail.com, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, pjwatson999@gmail.com,
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

syzbot has bisected this issue to:

commit fa3cacf544636b2dc48cfb2f277a2071f14d66a2
Author: Kari Argillander <kari.argillander@gmail.com>
Date:   Thu Aug 26 08:56:29 2021 +0000

    fs/ntfs3: Use kernel ALIGN macros over driver specific

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e776f4880000
start commit:   49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13e776f4880000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e776f4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cad4e0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1303781f080000

Reported-by: syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
Fixes: fa3cacf54463 ("fs/ntfs3: Use kernel ALIGN macros over driver specific")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
