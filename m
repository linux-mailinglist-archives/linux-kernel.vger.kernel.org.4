Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24D6CB85B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC1HlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjC1HlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:41:21 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7504196
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:41:20 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso2167718ile.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989280;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yEsXxlWJL6DWDNWhfmVduwMNH4kQdVlHmBDUPv+WE8=;
        b=OUVDjCk9M2038BdEhqa72wN4rp4+qxLJ6LnRUk7gCD5A3Ra5pJoOU4ExMFgoEFHQ4F
         0/eKbEBdVnWg48wBE2Kmhn3Ujg8vbDNrsQHLcVV6NoHBJ6PWR86t6ZTdgu/hh6FPGLjN
         nov8KjFqQB4sKAD970GL0BE9DyhGHmuop8dglVYJk7mUeYEygTfrK0A4ixZpJU9DfXVv
         3RHuJwkONbTG3aEsw/BuNk6LLfO+evW0PNr9xZE2lUvmIPBPGV75WCvfBJLo/gX4L9r0
         qnqhoCkvYZfo5uTqcDqG6jGPp5WpSy2twX+bFyzCYCCzM1Gt4Jv9o3QmrvhuGUusy0dl
         HBWg==
X-Gm-Message-State: AO0yUKVS7kqq8MM06z0KwYLzscYcGNMsuxAE/3p5alygz5PRkWX9R0vn
        fdqlXV4GrOifD/9lm5R42fCLdlZhEWCwkJ9gKSV7Yt/3wAmE
X-Google-Smtp-Source: AK7set8v02EOh55DsJEnP8B3l2r5w0hOcZK7beIvKcz2vJ6xN3N2+dMFt31/BYg2TQraAKiiYN+wI7GrFeAd6S5Q+b4w2mybMRlL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:315:7a34:224 with SMTP id
 t12-20020a056e02160c00b003157a340224mr11330175ilu.3.1679989280138; Tue, 28
 Mar 2023 00:41:20 -0700 (PDT)
Date:   Tue, 28 Mar 2023 00:41:20 -0700
In-Reply-To: <20230328071915.2501-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044ecc905f7f0fc09@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in rtnetlink_rcv_msg
From:   syzbot <syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com

Tested on:

commit:         3a93e403 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13c10339c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af86302075529ad9
dashboard link: https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
