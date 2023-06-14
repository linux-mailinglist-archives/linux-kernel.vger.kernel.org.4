Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F41730BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjFNXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFNXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:41:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF361BE8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:41:28 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76998d984b0so875837539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686786088; x=1689378088;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFtV4cQuNDH9Gt0RVe/wpR64rx6fAfMaazIbTuOUSMc=;
        b=c1UgsFoHxlj5xhT6fmSLlr2DVUz1i7XVFNoVRWQ7xKHxbfQBR7DgZvIGLOCNeKYB8K
         fFGmi4Iw4lGcjia8smgFSxM51qYebyPYXWfbMrnIetyNhzAsZuaqyv1ou8AknCRPIy4N
         P8VCm4r4SZLfJgGnrsMnNUfvxZUQuGvztXaXh3kfn5+/4Ry8Wof3vUf+Rq9mOCLihc2c
         rAPZ8QxsQ+LBjAxLgNBHyfSTe25XXXrAhGWEgfboOutV3iBxW3rUht8Ycx4wduKr8zJD
         KcyBlDu8jcqQh6+6zzARbv2g9HzPJnIWl+J7e0RDJUh8WWl3dx2gmH2BvQm+kkSNXYh4
         aFfQ==
X-Gm-Message-State: AC+VfDwI2ffxcFHQ/6IlbkBB6XDao2vO/tmyjI7clFCN1UFB4Hz5Uucg
        AHlcjfs6ZvVtH778Rlo35n9ar+q9YU5ixAsQ7tP0ykFkLqE8
X-Google-Smtp-Source: ACHHUZ5R8Upobb3nECqWppkB7qfYRqhRYjMPYVdGioYN5rCnpienfmVURjPO7S3pJ0WrfkIgeIKNr8qml+QDD04Ke4DPOfsWY7V1
MIME-Version: 1.0
X-Received: by 2002:a02:2305:0:b0:423:1273:ae33 with SMTP id
 u5-20020a022305000000b004231273ae33mr286508jau.1.1686786088089; Wed, 14 Jun
 2023 16:41:28 -0700 (PDT)
Date:   Wed, 14 Jun 2023 16:41:28 -0700
In-Reply-To: <1665043.1686763322@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c36305fe1f7dc9@google.com>
Subject: Re: [syzbot] [net?] WARNING in unreserve_psock
From:   syzbot <syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=17677753280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=dd1339599f1840e4cc65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1299c5e7280000

Note: testing is done by a robot and is best-effort only.
