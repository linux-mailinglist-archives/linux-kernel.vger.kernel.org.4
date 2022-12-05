Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C068642D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiLEQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiLEQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:41:13 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E601FF83
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:39:20 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b9-20020a056602218900b006dfecfefcfbso6631814iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPWpLiid+Wyro5Ye4DA60dyaWVhxV4ZHkH8qNNA7KLA=;
        b=b2yX1k7SDVpbHc2MzEqQU0GnaOhNL/Vd8MVLeaxv0NWfQ/XS0lJNwiOBNyeIWRS1dc
         0oRtjuMscIb13W93WBaaMLOuWxImpQKX6eP3JyYEHEh/UJSne41+BV5cWwWngLVDIfLU
         NTR7oTSxYUvVe/aPFu5XnjAMmy/bixOv9tSkebuIPvKMlhGxATj7Do13zVXLGGbVT4S2
         SztEBP07MIC5JCRZjadA1ZVjvK0mnFHS9w19D8kr3NF3tt7ZUpXOMKRUuEizOxe9gOmn
         nk+96J2kyJ5Yd1YYUCTJ8NLclgn8julkyn6zfD3bKBT1o427WxZemG95Vps+hDGZil5x
         g8wA==
X-Gm-Message-State: ANoB5pl0bsZcc31f4cLMQ03ANEmLIDqpP8YILI/GhYHqvOI5vrYTUJYL
        ZIVayMvNxcc8xHxbc5byBTFAQ3/50yXa8XH3zIFAT3y3Q0tD
X-Google-Smtp-Source: AA0mqf4+rI8v+xc7vAWZyJK0wow3b2uzCUbjt6iBLrB7FH8dfoYlIS9+StfKDI55Ruzf3PVTKPZB9AkPx3muWB/OD0tbDR0tEJDm
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc5:b0:302:e604:f814 with SMTP id
 l5-20020a056e020dc500b00302e604f814mr25516640ilj.113.1670258360339; Mon, 05
 Dec 2022 08:39:20 -0800 (PST)
Date:   Mon, 05 Dec 2022 08:39:20 -0800
In-Reply-To: <20221205100829.7319-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040556c05ef175474@google.com>
Subject: Re: [syzbot] possible deadlock in attr_data_get_block
From:   syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com

Tested on:

commit:         c2bf05db Merge tag 'i2c-for-6.1-rc8' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ac7d47880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f9c10f880000

Note: testing is done by a robot and is best-effort only.
