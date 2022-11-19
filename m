Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18F1630DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiKSJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSJZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:25:24 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D7E776D3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:25:23 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so4914755ilt.22
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGvXBVP8jpxjglxtUj5dMXG1j/vd5yYN2OA8Q+kjvjs=;
        b=e1/jwWXD74iktvjhVvMRp6iUq7/L0eV2qi7OJdJJs1KJMtiKImknF/VZBXgP2MiU+Z
         QZ9n8qTKLKMUwaadMWQq+Zh0p5SYlI27c/YQ2eECcj+dWa/pVJIghe6uROb7/JRbBVNh
         P7DDpc3pKJxOeHxRmgvTrOQ1p20nLX9kEGNHgkPjxREkrR/Vzzm77/up1SHK/778iXeu
         ofqRGA6c9tz8BaIEOQHojA4dzkD+Na/FSaYfHzDgeBogif7UeF0GSR44dBv3zp/X+lAz
         OO70ZR4Mnpr1E/Zw4Ml4n3ptsJbc8Qq6QVHLYZl900amP/cpct4M6QZPHVl9ZjgEGcfu
         XMkQ==
X-Gm-Message-State: ANoB5pngwppVb2/a6btr9aOWUkIrsM1EH/8y9QOgZP0iXqcq3v6K7cjt
        6KuwTUfU9gYTjJuOWj1RGZ9RX5Rcx5nIsfnICorFigVr3vrB
X-Google-Smtp-Source: AA0mqf7tHDYjlRYj7H+3cwKZzGe6HHyQ0ChDNGXTMwgjfaxSDJUwQcxgybQoe/wJ4SF2lVBTkFicVqo8gtl/8APQ68qHChKSx0zV
MIME-Version: 1.0
X-Received: by 2002:a02:cca3:0:b0:372:104d:8049 with SMTP id
 t3-20020a02cca3000000b00372104d8049mr4579800jap.241.1668849922783; Sat, 19
 Nov 2022 01:25:22 -0800 (PST)
Date:   Sat, 19 Nov 2022 01:25:22 -0800
In-Reply-To: <20221119030519.4257-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4c0ae05edcf6602@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in static_key_slow_inc
From:   syzbot <syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com

Tested on:

commit:         064bc731 netdevsim: Fix memory leak of nsim_dev->fa_co..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12a7010d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a33ac7bbc22a8c35
dashboard link: https://syzkaller.appspot.com/bug?extid=703d9e154b3b58277261
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11425701880000

Note: testing is done by a robot and is best-effort only.
