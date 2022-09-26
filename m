Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2985EABAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiIZPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiIZPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:52:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D690181
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:40:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h10-20020a92c26a000000b002f57c5ac7dbso5285418ild.15
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ng/WLGY7e/twhA8GiPNA9Temvif9bAJ4lIqtpvMFShs=;
        b=2zHtVUhxYJoDoeYhYT0scr8r7n4qinwGxHfUsmnGbqdkKb4/+gofunVAfJnzT0oXRS
         Bttr3/rQu9bgBknLXVlEIf02ctdRrl7uByz2JRajtUXyHZBROxufQpRzgV/6Vhxr9Mle
         SCzeVjJfnCtdPeDZOOOrgnXGJfK9fOwXtoy4Wr7ZGSb0nX6wr22ZIModus2tYoDRNHTJ
         SWjtO+Klvo+c9BOXONsvv6lkbI8TQdU2LxlQwtddf8srHhF+a6vnLxSKQ3Ey4deGrpTz
         JswpI7+3BkRW4n6KvELkKLo4lrfPjV31Vx0TMbBu4J3iu4sa9J2hhYiAOy/Q9l+fsxEm
         p1kw==
X-Gm-Message-State: ACrzQf36idm3JzfMnl/E10cftSfaPifv04bOSXT+MEQ+58aonxO8GQ6h
        fr3HdJpwNsJHQw10Tg+VUKej4bilnxB9yIyCnrJsAvL2B8xQ
X-Google-Smtp-Source: AMsMyM62K5wgeVkJhA1nQ1HJUjj8Yz+G+91GaXIoM1LGdh7k20zDaYb/G/y8rK3pCmogwop2Xyn0KJ+OcIUH0OrgLZ8A4JCkz+z3
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:2f8:16a6:e0e2 with SMTP id
 k10-20020a92c24a000000b002f816a6e0e2mr5257616ilo.291.1664203218789; Mon, 26
 Sep 2022 07:40:18 -0700 (PDT)
Date:   Mon, 26 Sep 2022 07:40:18 -0700
In-Reply-To: <ee12470f-4fca-a036-1195-d68a3ca1f3f9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ab5505e995814a@google.com>
Subject: Re: [syzbot] KASAN: invalid-free in io_clean_op
From:   syzbot <syzbot+edfd15cd4246a3fc615a@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+edfd15cd4246a3fc615a@syzkaller.appspotmail.com

Tested on:

commit:         f159b763 io_uring/net: fix cleanup double free free_io..
git tree:       https://github.com/isilence/linux.git io_uring/net-free-iov-bug
console output: https://syzkaller.appspot.com/x/log.txt?x=15697b18880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3521db70c6a595c4
dashboard link: https://syzkaller.appspot.com/bug?extid=edfd15cd4246a3fc615a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
