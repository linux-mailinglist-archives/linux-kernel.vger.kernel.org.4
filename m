Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA46D2F62
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDAJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:29:25 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8082CA2E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 02:29:22 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id n9-20020a056e02148900b003263d81730aso4652802ilk.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 02:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680341362; x=1682933362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuPBq9HQjfBShwo9tM0oMFOU2W+X2nOnvexjKlnXFSI=;
        b=BatwfPZ6b6REY6Li1mv1vHkEWVfQXNWdy4ZBsgaTIpAcO36u/CwejZAotH4MlCd82E
         1leI/DeaSgHYb+YW0n3oqsYu352EOg/7GYGWIyTEGF7a0KnCexxTq0kNb7FhkP828CGi
         ZVHArDgJvIZTwkJTJhdwVmvU4aqVFP1XUXAEBuZ1+9EIhIGoeYgUx4fxtfMW0x/Nr8oX
         dJkQbz0isLEnq9/cwmP7g7Cms4BcghbBwXkPfsR2A9Yx1KlC9yCxZ8hHIj2PY8mMOf6I
         5jJrFzJUDlbPYHqsH7kBMnoDaRtY78qyFsuT9P3RHgJ7I9OMUAlJz37W4m1qyd4fXhK0
         q1rA==
X-Gm-Message-State: AAQBX9fbUu+z9sjNhw/Jj7K9tvdRwuo3g1zK9QzQYFr7GgF30+9ArVm5
        a3tku9oa5yo1C6JYHowyv+BiRWDggqcpxo/9eSfXPrGJ333C
X-Google-Smtp-Source: AKy350bjvQM6etnyUIDAKa3yOdfrmdafA/Hy01HtCFTmm/dMc0ZFt1pdtoO2aeDEx8K+tXq8kNMwwH5Ruqdkw05aCSh33hjoyRMN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:326:5ee1:ecc3 with SMTP id
 s12-20020a056e021a0c00b003265ee1ecc3mr375558ild.5.1680341362156; Sat, 01 Apr
 2023 02:29:22 -0700 (PDT)
Date:   Sat, 01 Apr 2023 02:29:22 -0700
In-Reply-To: <2023040150-mooned-gizzard-962a@gregkh>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe2c9005f842f5aa@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in class_register
From:   syzbot <syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com

Tested on:

commit:         980c0561 driver core: make sysfs_dev_char_kobj static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/ driver-core-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1188bdd1c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=495034798c39316a
dashboard link: https://syzkaller.appspot.com/bug?extid=41d665317c811d4d88aa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115da421c80000

Note: testing is done by a robot and is best-effort only.
