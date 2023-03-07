Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D96AD477
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCGCN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCGCN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:13:26 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492537F05
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:13:26 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id n42-20020a056602342a00b0074cde755b99so6469752ioz.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 18:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678155205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cVsYx/OrAmI0jd28DDkFuFm5fdW/PDwxzkcSRRP6iM=;
        b=LvS9o5uGDiBSdKquHA8exWpfFEI0JtZtknWbznAim6sg4GQHM1uOR6m14sGcqAVT0M
         kdeJEk0kwv3QOhjzSfP5Kl+4eYlBmUMKbjAUuhbO5qCyKi+K0WEuOfVbSwqy2WDB8rLn
         xL2jxcIAkuP/FSue/viYvN1iKj3+q+9hLCvcE1bbRLC3eGH/YMIbz38fAPNfew48hQ6S
         XIbhDHjTE6O8fSna9hGLz5lvLIr2JFM6GpSRfI1HotQUHdGXzpHYxQCOUcmZvsyjmPgn
         iiZQj18RMbSOqsW/LrQU/oGI3kLzcHJ35Dm1aXmJwC/bL0XSZjr+rrIluYVKnHS4EpuC
         C4Sg==
X-Gm-Message-State: AO0yUKVKXGfvFfxNYtLTEfr2PpTlcrNyKp4kY4nIriU7ZdL8g2+aMsAh
        w20O1fLX3IHmkU4gKrdyAJTSpob7VtPGleSKj0f98zvY1Uk8
X-Google-Smtp-Source: AK7set8X/JX2ziwEZw/0ZRbNOr5QEv3gOivvnA6bS4D4fu6up9U7t+TXq9KKSFfHpTj6VUpcSROUfr0Jed52qgdjUavbhLKV08qO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13f4:b0:313:fa72:d9aa with SMTP id
 w20-20020a056e0213f400b00313fa72d9aamr6498598ilj.0.1678155205548; Mon, 06 Mar
 2023 18:13:25 -0800 (PST)
Date:   Mon, 06 Mar 2023 18:13:25 -0800
In-Reply-To: <20230307014933.1882-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7a56505f645f4e7@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in __block_write_full_page
From:   syzbot <syzbot+3aa7a6b7eb0d5536abaf@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3aa7a6b7eb0d5536abaf@syzkaller.appspotmail.com

Tested on:

commit:         b01fe98d Merge tag 'i2c-for-6.3-rc1-part2' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fa2884c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc0f7cfe5b32efe2
dashboard link: https://syzkaller.appspot.com/bug?extid=3aa7a6b7eb0d5536abaf
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147eadbcc80000

Note: testing is done by a robot and is best-effort only.
