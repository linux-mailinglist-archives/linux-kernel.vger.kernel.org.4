Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A56458AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLGLNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLGLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:13:03 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2152143
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:12:16 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so7547423iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/t+Me8/030Q5B30P+Xx4k8q643zdaz8TvlfSyAI0rw=;
        b=v8BtQExzJ8mdm+l9+YM3Z9myrUSprXH4Ga3SFCfGCY0ZDa4KO1QrMxD5RuoLiahYTc
         k9e0oKeKqxm0P6GWGgDWg6KuyjiY42K4IDgSKZ7FoAhAMJPQLv+TsHRiwTGZPOaS6Csf
         FLGWqK+3Vb7naF6Dt8xnF/5mQ4AR6YFCDKPn/ma9PMloXybK7nRWlS1oXVUTBR1azWyo
         BRK2GQQ/xTBOTb6vaDgtzPu2gEpKUVVyNLBJxjTSHJGP6GpXw74yORmgTHeKcHShWI9f
         pD0lIZG+6oaKvhY0RVHO87bYATbdcnPmWq2xQTVILfez4XNMCSLs503BMSVsKR++s38G
         CbCA==
X-Gm-Message-State: ANoB5plnpTPpjlQKdJpycxt9ZvqAINVBmn6eol571/lctY4hDDGOreaX
        2BvFHYWfdhUYWmWr4WIw5Yigda7UBYfRRRe+BqoHuVIrjfWW
X-Google-Smtp-Source: AA0mqf5ww7+drHE0GeLT+JNJ6rONEjs5l7ybMhukmhPQH5dMBVpgfGWbj29axv2b0k80Es0gPlPJc5S2jtbKNZHjTvo1GURBSaQJ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1124:b0:38a:171a:dee with SMTP id
 f4-20020a056638112400b0038a171a0deemr11854615jar.292.1670411535836; Wed, 07
 Dec 2022 03:12:15 -0800 (PST)
Date:   Wed, 07 Dec 2022 03:12:15 -0800
In-Reply-To: <20221207081125.7740-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038ea0a05ef3afe8a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in l2tp_tunnel_del_work (2)
From:   syzbot <syzbot+57d48d64daabde805330@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+57d48d64daabde805330@syzkaller.appspotmail.com

Tested on:

commit:         355479c7 Merge tag 'efi-fixes-for-v6.1-4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16391af3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=57d48d64daabde805330
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1311216b880000

Note: testing is done by a robot and is best-effort only.
