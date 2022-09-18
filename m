Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784535BBD9A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiIRLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIRLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:33:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98642314C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:33:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d7-20020a056e02214700b002f3cbbcc8cbso13745968ilv.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tOAcwprBKvdlnMP02YBeJwpkhPA2fnxvRa3dgTcqouk=;
        b=sLdvk9qX16E8KXWPQl+WhLQb5T/4JGTQ+fzvv+s16ScfNyMyQlaeIlnhtTB3sNw4jM
         IlP3O50/8eyz2uxxcCTHdU2UvzwrfbS3+dcLKCiOGWFRYZOvcYWeh3hIcKIi2wmwmUOJ
         HF44czYJHjKw6efBax0KNN8QORumfpCi+JJynu3S1sP87esNsEwqJo6Mlf4I4/qF8Tn6
         w8HF7MK5y5lAvLKM50CWGDZwCXOKkv94NYPdSYCRuKEAh+rZO87NzxNInrbZlP+MQKdQ
         /MoOc6dM73YH5hATCMVnfRjJQ2m3n45SZETzyHjCrlZ7x6SNuBor4xRr8Lp1LAW0wLRc
         VgcQ==
X-Gm-Message-State: ACrzQf19EWyhr7itpXr3k3CuL6umCtEaMVTX7G3VKsuOCLZG8/UPg1fe
        FJpnHOO8SAj9ZEcoln/TSLG5PouuCpclK1WD0h2HOR3wMC2e
X-Google-Smtp-Source: AMsMyM6qgLPj+BjGRT2qRNlZp0LSSEOqy3B5DTDkckbYFcxXvsQuyEjHqQ93lyvFZMrADSpI7fHQXCjGNfDGIERsOj3lvJapMSkL
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d54:b0:35a:995f:502b with SMTP id
 d20-20020a0566380d5400b0035a995f502bmr4584673jak.278.1663500800774; Sun, 18
 Sep 2022 04:33:20 -0700 (PDT)
Date:   Sun, 18 Sep 2022 04:33:20 -0700
In-Reply-To: <20220918110253.947-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000505e9c05e8f1f62b@google.com>
Subject: Re: [syzbot] BUG: soft lockup in tx
From:   syzbot <syzbot+5e87db90e68fbc4707c6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+5e87db90e68fbc4707c6@syzkaller.appspotmail.com

Tested on:

commit:         a6b44374 Merge branch 'for-next/core', remote-tracking..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146dded8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13804ed5080000

Note: testing is done by a robot and is best-effort only.
