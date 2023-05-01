Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019686F3315
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjEAPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjEAPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:43:00 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECF10DC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:42:58 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32a7770f504so40339275ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 08:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682955777; x=1685547777;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPfxIWTGWp9CnObZyzs1d46Jlghk+cgMkQDmg9cUi10=;
        b=UhwCvOyc71J3FgGQ+00QjBpNczoVvTYnXRlxDEOio/otjTHpe1LRjT40OT87nq6agq
         2i8UYKC8rw+xbKuqrD7zM1MbDRDiDWpYNU2L0XaK45gucko1zPoJMM/P8ldbOKTSQ/M6
         q72giBtz114RiST3Oua16ED3STY9+iItTzsxBQ/9Fgg9nofrPSTxzkgwDK3AFtGprGUi
         ynpQ+uAGfyvFsSZzc+limBf2K2XQr0X7Qn6JL0xJF4xGpZmCCtUmOY4vucTiVFabVmjR
         nVh+AofAi7oTsXv3n6nNNo9HLY431wIz0OWgzfYFrackMzmfWDFlSeZ/brKNWelE0aJ0
         KG9A==
X-Gm-Message-State: AC+VfDw5ruJ5AkIbseHO6MdiqqzQ44vQEBP57Bk+n/Z92UobXu3AnKYW
        OWqw8gEys54k9E9cWShCP1vntIaw/yxU7AXmLedlM9/KEJZr
X-Google-Smtp-Source: ACHHUZ4gRLL9co/RarnRBiJRlrXnjbEi963M3YPUDd3N1ggqfCqLESp5xxQQG3e9xAXGtWiHbMDRvDoZpJYKHr2WIvaadCdza8nk
MIME-Version: 1.0
X-Received: by 2002:a02:8629:0:b0:40f:9f49:e4b1 with SMTP id
 e38-20020a028629000000b0040f9f49e4b1mr5784651jai.3.1682955777572; Mon, 01 May
 2023 08:42:57 -0700 (PDT)
Date:   Mon, 01 May 2023 08:42:57 -0700
In-Reply-To: <38c0a2fd-cd9c-43b3-99f0-4f9ed2fdc69f@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b903305faa3ad0c@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbtmc_ioctl/usb_submit_urb (2)
From:   syzbot <syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com

Tested on:

commit:         58390c8c Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=12708e68280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ce77725b89b7bd52425c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ff68e8280000

Note: testing is done by a robot and is best-effort only.
