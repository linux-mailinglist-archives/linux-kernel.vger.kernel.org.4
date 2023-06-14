Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1872F0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjFNAUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFNAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:20:27 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679A10EC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:20:25 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3406661e649so13661355ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702024; x=1689294024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPZJuew65UVR5FFQsxCbQqGDSX7P8C2GTOs6C/LbA5k=;
        b=YCcel+acfrTYic9py/4+GQxBeYHex8HYS6aJRETtkGDciO17WiLb3IvVVERevIS5Qj
         ZosO2LrZqZzwUqms6q8JuoEXOzXqIKm9+8MeIAKYHXjlrIgioZM85Rh8WtgvKTblQqLQ
         yBrNbIoZlF/iwo4RwqpB7aJAA5Tu8I0C984OWGrpAbjgZcS1mU+68r9uv2o3cuW5L9tx
         eBV04KTKSBC36HFH9g9J06qalFuijpjox0kM/kQ7CdVCFQMqAoUPRdq+Pg2Yvmysc8ed
         yb89hRIlte7eL036xOckp68bkVaTtXhB4xUNT1cWBMrY+gvfkW9X5L08mpd39D1zuR1P
         XHog==
X-Gm-Message-State: AC+VfDwJuJuXcw5AnxTbKg5g3Dx7XvuSdFbIDpXiYisf4In38rCbWWf6
        498bStHqxCUIIUucxL1pwhbSC18QLstAqiWqqrPweQu/pJyP
X-Google-Smtp-Source: ACHHUZ5vfao69TzkXMKSqLdZVZkQjhmYJLPV9X2girde6yyBqzjp7nQ2/UjzqGlW9LrxZhB3uLFSTTG2d/SigJlwdS0tZP7hRA/U
MIME-Version: 1.0
X-Received: by 2002:a92:c98f:0:b0:33b:1445:e9cc with SMTP id
 y15-20020a92c98f000000b0033b1445e9ccmr6377594iln.1.1686702024743; Tue, 13 Jun
 2023 17:20:24 -0700 (PDT)
Date:   Tue, 13 Jun 2023 17:20:24 -0700
In-Reply-To: <1394611.1686700788@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006e58b05fe0beb6c@google.com>
Subject: Re: [syzbot] [net?] KASAN: stack-out-of-bounds Read in skb_splice_from_iter
From:   syzbot <syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com

Tested on:

commit:         a9c47697 Merge branch 'tools-ynl-gen-improvements-for-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=145cfc8b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=d8486855ef44506fd675
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ed8d2d280000

Note: testing is done by a robot and is best-effort only.
