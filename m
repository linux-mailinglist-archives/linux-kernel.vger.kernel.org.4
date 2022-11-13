Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7A626EF7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiKMK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiKMK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:29:22 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525811173
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 02:29:21 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso7350148ilh.18
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 02:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kDrJku/WUtVjcDnHaQoA7m28H6P/IU8dYDts5lcCbc=;
        b=NqI+6gMp9224qwM3yJ3JanteCh1P2tuVItDW0ARER5hUcsUuqcC1aYbydljOT25BaZ
         5l3Ohy2z+X5pjRKiuBgnkD+dPIpuapXHJ7dIgm6oUzrunUR7GpxBfk7RdvgRy3JHWiRF
         RjB8IVHEmnPjiHE+Bjmushc2e3c9yR3amvt5BUs0wdU4B4hBom0BB0stlemM7uPEeUEE
         mj+/gnaUEszDjPOTOU8YdnhUQf7G6aHB1Fh5Lho/9Azz+65SrUX1e9IkkwdInMz+yvaz
         IzQZyrH2eUuZTKfCCxVJK3v/Ciu0v8+eBS/wPQ4bapszkTMoF1OgQehJat9ZgnLX69yN
         lizQ==
X-Gm-Message-State: ANoB5pmTxfpj/U6wFy2/pUFLtSTDodjMNxStrWAvpRDyHe4czyiNgdmx
        dZf7ZdaNAbysOH+0KUmOVP+Q2qpa/G7xzA9KLeIlrXl5Txug
X-Google-Smtp-Source: AA0mqf5FBLWx0l6ZBHwrixDtm+d3SANTALLwiyRZp0Kk9vrF4k6eI0rjf8CXngMZObOBWEbGvmx0D5Ml5pyoQiZS0pm+sBPHvMz+
MIME-Version: 1.0
X-Received: by 2002:a6b:6401:0:b0:6bc:a758:9546 with SMTP id
 t1-20020a6b6401000000b006bca7589546mr3879140iog.78.1668335360650; Sun, 13 Nov
 2022 02:29:20 -0800 (PST)
Date:   Sun, 13 Nov 2022 02:29:20 -0800
In-Reply-To: <20221113092552.1769-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089b8aa05ed579869@google.com>
Subject: Re: [syzbot] BUG: soft lockup in ieee80211_tasklet_handler
From:   syzbot <syzbot+27df43cf7ae73de7d8ee@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+27df43cf7ae73de7d8ee@syzkaller.appspotmail.com

Tested on:

commit:         7a7fd0de Merge branch 'kmap-conversion-for-5.12' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=148ea079880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad1d200e85d8538d
dashboard link: https://syzkaller.appspot.com/bug?extid=27df43cf7ae73de7d8ee
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147b763e880000

Note: testing is done by a robot and is best-effort only.
