Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6EF6B881D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCNCLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCNCL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:11:29 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A2D85B32
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:11:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s1-20020a6bd301000000b0073e7646594aso7240677iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678759881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+gommvcmQInkAWZvmI953iPYt6DUKvljAaKIYhxxxw=;
        b=5kwsVmmSYjiad9DsJGFNULeTPrW2+CUkw26f/+vii25wv7XnW0jU4S6kmsnlTuNSmm
         lCU1jOh1N7bcZU71Gnkb9fTaSHJINK3DuG0vtdhDnyKdsfP98xDDbe5j8IjT4o6lXsNM
         2kSHe3FCCuNjgXakotRY2GTG8PBFyii/Yntbl/vkxDhk6qQRRPn24aQokwnbjNKm/qZw
         c2L+YwkeGdVeqrtNVm8T3YeJ9pRSfD44mYToBbXmoAIBBIjx4NvfG9OxLfLQVZn7KrgQ
         a/vYJnUqflcLsNGMRlsUqNcAwmc8iP2DApLS//L05MiRUPB1Az2zQqyVi5knZS4B816N
         wlrA==
X-Gm-Message-State: AO0yUKWYFhNzmmsMS0UeLHq00icKeUNeDYkR7k9QdQC4ujgHuFDPUaef
        dF5A6DWhexu1XZBiXAq/fWGlbC3oiZijtX3McyKD/5hN+CZY
X-Google-Smtp-Source: AK7set+GrKCT8l8cwWsvNMiTfNPoyQwYd9VfsJSV3mE1Dgs29Wu6WexwgUQPzwDEFYHoIv3NBp+k97oAtRL0rFNGyArYl0EXsmlS
MIME-Version: 1.0
X-Received: by 2002:a6b:ef18:0:b0:745:dfde:ecec with SMTP id
 k24-20020a6bef18000000b00745dfdeececmr16586583ioh.1.1678759881671; Mon, 13
 Mar 2023 19:11:21 -0700 (PDT)
Date:   Mon, 13 Mar 2023 19:11:21 -0700
In-Reply-To: <20230314014732.1971-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690ab405f6d2beb8@google.com>
Subject: Re: [syzbot] [fscrypt?] WARNING in fscrypt_destroy_keyring
From:   syzbot <syzbot+93e495f6a4f748827c88@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+93e495f6a4f748827c88@syzkaller.appspotmail.com

Tested on:

commit:         fe15c26e Linux 6.3-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116c0c3ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=93e495f6a4f748827c88
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12aad472c80000

Note: testing is done by a robot and is best-effort only.
