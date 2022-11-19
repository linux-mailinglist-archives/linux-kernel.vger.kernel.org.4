Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E443630DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiKSKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKSKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:00:20 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF56B9FB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:00:19 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id n10-20020a056e02140a00b00302aa23f73fso2779532ilo.20
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yea6PQd3MtMeMEkUBjmVVSVDCQb+qv6n4GJg9fLwd70=;
        b=GvF4v6kwJJRRGEJclI7La83+n+xCjKqahpudbIC93fS3jSVXGj5Vd+yA1iwZ8pdLoi
         3zk606GUMDRuQoVAqb/ob1kPxtwrTMp0KuW7FaZuH9Gv7E86fzHbpT60ZFcoiWQN4QJk
         H68WpcwQ+WaW2H7SVA41qe1ABtCrsaVnoUgW53H4wGUHf4xwaR+jaOBykb+JvOQUr40b
         vGe0gU3fW7tccQEPMzfniMVAeiyOLHBeonWUavdkk8mFCnGy6myq3+96zqI+QWIM/IvJ
         w2sCVR8v/Fz7W05cZm6eBMz8oYMF2Cnhnn+p1inctWq3tt+MX20DWKnNTbxa5cCs9A47
         KOGw==
X-Gm-Message-State: ANoB5plVBVaciNUkT7Emu3RtAK9L3q1Kw51TE+4hvUnXrZ9zzhIDTwPi
        cZ0TAln218vLtGPbq/00+Jx3LSlIwmu5mE4zVYBr2y5siYsS
X-Google-Smtp-Source: AA0mqf6vLcAF94HDs7aDu+RoaAiiVRm9+jy+xrbeveKg/eBhx9udpgbqAUgMstu7UcoBofc2WlFzOu8Rp/ZOsAyrnPqSlI5PohGM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:440f:b0:375:1820:bb85 with SMTP id
 bp15-20020a056638440f00b003751820bb85mr4595683jab.46.1668852018803; Sat, 19
 Nov 2022 02:00:18 -0800 (PST)
Date:   Sat, 19 Nov 2022 02:00:18 -0800
In-Reply-To: <20221119090044.4444-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c37b6905edcfe3e4@google.com>
Subject: Re: [syzbot] WARNING: held lock freed in l2cap_conn_del
From:   syzbot <syzbot+f5f14f5e9e2df9920b98@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+f5f14f5e9e2df9920b98@syzkaller.appspotmail.com

Tested on:

commit:         1707c39a Merge tag 'driver-core-6.0-rc7' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116d366e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=f5f14f5e9e2df9920b98
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10431d31880000

Note: testing is done by a robot and is best-effort only.
