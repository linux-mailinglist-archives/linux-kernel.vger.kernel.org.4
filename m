Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8864D60790F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJUOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiJUN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:59:44 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2582A412
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:59:26 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l10-20020a056e021aaa00b002ff950bc0deso1525926ilv.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUVxkOrQ0ve+76/9pJtO6CtnkmWrKX6j90T6Mm/+oY0=;
        b=CDEdVAQc7YfAR1XzT5gxW2Pv+dvejBpPfwtvJaAGsFF+gTC5WoDAdtBV3U4fYygBlR
         di80HO/iyM30dQJqW1PLuqQ4ifgIJvEux+UFqAG2HhlPILdnPnnBFojzLbKxaol9/IBl
         eS+cPTLFLK6P+4ooKOWUhXoWKK364vfP6Kt2CrLBjxY+cALZeYsnvL1FMLEkTd/DJgG4
         vQT8YfkM5XFC+nc2oiaq4t4J8iu6qAA8P8ghZMRxK95yRTj/AkyqBhE8VxAusR3kH9D3
         dJkHSe36LXopl+BllqE8Ev5BPXeCM8qoz71a8MCMUkmNRQubfcL+VWncOg25L5c2UQ2n
         ZIeQ==
X-Gm-Message-State: ACrzQf0M+AxytVfAUffbpqVVzQ1Fo666O8ya9g6SolQLcQK/Pm/JySqG
        bam+54ArGFNvlyU/qBtRS+4f12tnY9jHS3o9QTpo4Ftc/hN6
X-Google-Smtp-Source: AMsMyM77pEUVbk4C33OqaQqZSWv7cNteCorjSy/aj/ePscnqTq+1TKCGcdsfZcxZ0BN+V6JOkhqmYcmbJhbQjG/uJ04iVWiJw4WA
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e0b:b0:6bc:d134:4791 with SMTP id
 o11-20020a0566022e0b00b006bcd1344791mr14618026iow.45.1666360765409; Fri, 21
 Oct 2022 06:59:25 -0700 (PDT)
Date:   Fri, 21 Oct 2022 06:59:25 -0700
In-Reply-To: <20221021133530.1693-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d6fff05eb8bd978@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

Reported-and-tested-by: syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com

Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16261486880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1103ce4a880000

Note: testing is done by a robot and is best-effort only.
