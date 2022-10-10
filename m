Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551685F9EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiJJMcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJJMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:32:21 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DFCBCBE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:32:20 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a9-20020a056e0208a900b002f6b21181f5so8616030ilt.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NY4FKPwKQuedItLVi3ddA8KHRf2/cnLfGSPTAj8X78=;
        b=cDyctFtBvcPrZiVjnJJkR09d+ug1IUcNJp8OUrd/A38Lu8qPc95DoykeSskNYtZMfa
         ifPAsQACDiU4L/mBFXtfN/5YaIL+n94fh10reOxbEQtZ7MQzrt/mENU6yR6luK/FgsXT
         /+OcAhQ5vaWekgIGwPQl0Li+V38d9TgweveZJa0X89JGVlRZ6nLrwHijy4BJWNJp961/
         9roreuQl2afKfvysZ83c1RZvAvDaZCZGNfv61zTZt4BdKtRnQyyrf3MdiWVPpMNxN98K
         iYKF7dj5iyHeZ0Fw7RD+gnGdxduyXmocyM6xrGjejEFV08WjKhjMUGiluuDSWzveEGkF
         jlWw==
X-Gm-Message-State: ACrzQf17gRtkeFjwGSmMnKahMKOHd8Tyip999ki9/hfCPUCUa9Y4iMfV
        sP0kY1ttfevf4QgcD+ZCKeLaRaO6cZA9WAgnSHpRhrVedFD6
X-Google-Smtp-Source: AMsMyM5jh03YIS7EmROb7RsFjdg2nj8nmlQKfFmyPjc5sJRkvCc6DgygSncNwKc9jf1QRZdAWY2G5QyVcnaPFD6l8B+I99JJbIZ9
MIME-Version: 1.0
X-Received: by 2002:a92:b00d:0:b0:2f8:ed7d:88e7 with SMTP id
 x13-20020a92b00d000000b002f8ed7d88e7mr8563405ilh.61.1665405139626; Mon, 10
 Oct 2022 05:32:19 -0700 (PDT)
Date:   Mon, 10 Oct 2022 05:32:19 -0700
In-Reply-To: <a88a1cbd-2800-78a2-1651-ebac0736549b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1324205eaad5903@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in io_uring_show_fdinfo
From:   syzbot <syzbot+e5198737e8a2d23d958c@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e5198737e8a2d23d958c@syzkaller.appspotmail.com

Tested on:

commit:         4f408867 io_uring: fix sq shifts in fdinfo
git tree:       https://github.com/isilence/linux.git io_uring/fdinfo_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=1529d51a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b87022a508b2913f
dashboard link: https://syzkaller.appspot.com/bug?extid=e5198737e8a2d23d958c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
