Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105762C5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiKPRFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiKPREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:04:38 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8978559876
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:04:16 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so13583485ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms3o1oCtSPlMnp0EJmXL0dtGWZHfF5+ovUGbqazHZgw=;
        b=OVxwuOCR5SM46nsqHnuACaI4tdVQNblFq3FKc9XIKBXuUt4ueNJ+66D8N6AOaceEdr
         u+4hhRods0v+l7fAmHfTobhx/Q9mEmbptjgekK5B383FuIzxXhYciAY4WeyLjiFdvi2R
         gSuOA30jyCD4YUKolr89Em+dJ4KtGLU266uLqv4QvVlK/YcBdLM4exeOOz+0J2AhEsCo
         JoTfoYeqzQnUgXvYG3ZfXg9sz/kJf7I4Uo5jQEJlnjqtQcOwC/F+768lE1AlB88yTlKT
         jgOOFD8RfeO7/m2awiqqUe5ZipssJ6Ei0wAHUnd7KC3EMOTKLk//t++/RRD0nMJmmLUq
         jr8A==
X-Gm-Message-State: ANoB5pmYyIWm1tvhV9Dy0iKNio5bET1UJ2EmtuyIDh9pz6jMS7LF4fFe
        wveuEKNUtZwjBAQdKKNS8iOhffq2SCOSxukj3GKooQTA9DQ5
X-Google-Smtp-Source: AA0mqf7GT+KtUFy910VUeWnjWwuF8TcGtrTRMRxnNAswY8BP7udS/Mr1eDME0VTRm5c2qE7dPluZbcUgC9niNnHXwDwyAtx0ZEp/
MIME-Version: 1.0
X-Received: by 2002:a02:2286:0:b0:363:a1bb:343e with SMTP id
 o128-20020a022286000000b00363a1bb343emr10983038jao.175.1668618254922; Wed, 16
 Nov 2022 09:04:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:04:14 -0800
In-Reply-To: <20221116120954.3294-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059c74905ed997607@google.com>
Subject: Re: [syzbot] WARNING in nci_send_cmd
From:   syzbot <syzbot+43475bf3cfbd6e41f5b7@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+43475bf3cfbd6e41f5b7@syzkaller.appspotmail.com

Tested on:

commit:         9500fc6e Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=171cb89e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=43475bf3cfbd6e41f5b7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16aed579880000

Note: testing is done by a robot and is best-effort only.
