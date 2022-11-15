Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0366294D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiKOJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiKOJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:50:32 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383D23171
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:50:23 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so10895162ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZKTUy6wg7FC+lXpU1/jLmlOdxTESGKAmRxUJeGg1Vo=;
        b=VJJim9u0RzmEh7WA+X/Xtw/EMeCqvEMjUggBuyHzdI/CJOmTqyYbV4FXUZdmDskp2/
         88A5Np0OZGowhZvwqcIxbpzPqwgbvHXwTZBI0m0dExsrevfp/XUV7/nk7HYl9358HnDr
         sjmsCTg0LVemZBuMe3PRvrh4u0V75YlUw+yPAFwJaW+YFgr425U7Xx1wZWxtobl+A450
         PHffvC1LCrPBrjaBBtZH80rkT2q7U3TvL48y54a3g4HIH1e3YhfS+a40WiAvDJKiXDE6
         jOjjFa9QylcQ+48It7z2w/arUXkGD0B1aPf9GtcLE4B/HeFvLbDSK1MdccHe4E04VUr4
         AUhg==
X-Gm-Message-State: ANoB5plBrqZz/sjyv/nq+L5AoMc0+LS+ekZSxuY/61V9GFo2AzOpqmQI
        Dj9GhQh65xPVFZtTyhi2keVsSbNlqYurOY1hBl6ucfEjt5qP
X-Google-Smtp-Source: AA0mqf5121SRs0RjvmdAL3XV4nnxBekU9XA1BAChljJz3Q0rQwdP9kawDMBbh6VMi6Wz+T+nIBe/rESyrMmia017QNzXLWW3nx/f
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:109:b0:2fa:b6c0:80fc with SMTP id
 t9-20020a056e02010900b002fab6c080fcmr8246169ilm.92.1668505823180; Tue, 15 Nov
 2022 01:50:23 -0800 (PST)
Date:   Tue, 15 Nov 2022 01:50:23 -0800
In-Reply-To: <20221115091825.2381-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e57dc505ed7f4840@google.com>
Subject: Re: [syzbot] possible deadlock in nci_set_local_general_bytes
From:   syzbot <syzbot+8768e9ec924b08e63f82@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+8768e9ec924b08e63f82@syzkaller.appspotmail.com

Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ced5a5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=699b4d125fc2883
dashboard link: https://syzkaller.appspot.com/bug?extid=8768e9ec924b08e63f82
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133ba9c1880000

Note: testing is done by a robot and is best-effort only.
