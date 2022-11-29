Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17963C0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiK2NR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiK2NR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:17:27 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8946204A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:17:22 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so11997124ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idplWkIx0VVSllsI4MlCtfwzzribvzY97/kVlTqx25U=;
        b=UVoFByX2Zdk/E01NUoj2wRfGtBzPuVJOXd07PqWCV8+pAHETNR4R8gA0+XKzv3sYWO
         zHu6ITAslEj9nxjwMKIN2ivEJ15xOuOurzwqvOojyoec3G/5FpwCYd9D+iVNXceh4tEZ
         rCYmJ7NFHmuHyNLMl6h5zXRN7gHOdyINAsKwtEbg048Mu8rz1dqyVgpCqoK1dSBD61n5
         P+yMKro5btd5En3vlhnkBqhAAkvu8h7N/TySQcDJZbwwz6vLCnohHzVk7OOf+jvCgzAO
         VojpHU04TmnjHQxt+bK9ETZpERJqH0ljNuC8+doXF3Q3I1+mc+10teSV72JRLo14VWgz
         ZkcA==
X-Gm-Message-State: ANoB5pnt7chk7L/k0+FB4b1/hbaFVa9wUFAuoxoBdD22hYba9Ybul+JH
        jBAbWtfcDHsv+hfM8w0LPl02ZKvNNKk8IM0Gxl9akO0nBv2A
X-Google-Smtp-Source: AA0mqf6Y7aH38ZalHxNfPDePL5Q3bbB1ysjAFhZX1zo2cZmijy5rr3U3OnUoHejPfs8qEbC2mby6lXLJaEM4SNqqbNIlaJwe86z5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:801:b0:303:d8b:3cbc with SMTP id
 u1-20020a056e02080100b003030d8b3cbcmr5915468ilm.117.1669727841511; Tue, 29
 Nov 2022 05:17:21 -0800 (PST)
Date:   Tue, 29 Nov 2022 05:17:21 -0800
In-Reply-To: <20221129123436.6417-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd751605ee9bcebf@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_join_transaction
From:   syzbot <syzbot+6eb64eace626d6222d2a@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+6eb64eace626d6222d2a@syzkaller.appspotmail.com

Tested on:

commit:         6d464646 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1082bce3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb64eace626d6222d2a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ac3d03880000

Note: testing is done by a robot and is best-effort only.
