Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0D6F275B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjD3CYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 22:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD3CYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 22:24:23 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224E19BB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:24:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763646b324aso190103339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682821461; x=1685413461;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBAnq+G06277iYlhw0ATteiSzgOavHY3/Zjp655Iswc=;
        b=XhutpoRXBoLWcc3KkKysssBPiPUJ8ZOtctPpgymr1Tyd5opICMvnSherZe2T4NEZtT
         SdNgBV4iibGPeadjr6hkRDfIGBIIjADI8xonzP9tRnOxyzKiVXWWvhldrRx5hXFIWhRz
         0F6fx+9cB1/JfUSer2/Q/51WZ4CeS6RGIEYKbhvxKxBMlw5ioklcYjs8XROl+97unlWl
         3eqGlkiHhrYrw81EHfAwM6bqiR3CcKiDgy+ZmyQqP0BhgBS6axSjk/NggrUOAk/80hmy
         B9IvflmBbpnO5skHtMZswgLLr9f9M0LWeUtvfXxKo40fJzwFWrVwFRcZtHB+sQIdhuho
         pmZQ==
X-Gm-Message-State: AC+VfDxmio2DiUg/MCRRP0hCTHvHJfM9q0ExbcD/2wY76Lt0tqyophg3
        s+b7bM7ZlRoZmMNoU2H3aXxjw+1JLx4CJMJZYeHY4M/3dNxl
X-Google-Smtp-Source: ACHHUZ6Ky8YOkqiRCIdzfNErbUeAJ+7JDmz+Ptsc55fK4cXKAhiYcfvLor3ZHoJuSOaFiYm9NZwIG1DTmzEp7BMEbkRhYdM9KXMe
MIME-Version: 1.0
X-Received: by 2002:a02:85cd:0:b0:40f:910c:92d6 with SMTP id
 d71-20020a0285cd000000b0040f910c92d6mr4095647jai.6.1682821461741; Sat, 29 Apr
 2023 19:24:21 -0700 (PDT)
Date:   Sat, 29 Apr 2023 19:24:21 -0700
In-Reply-To: <20230430012707.2936-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007297c705fa846734@google.com>
Subject: Re: [syzbot] [ext4?] [fat?] possible deadlock in sys_quotactl_fd
From:   syzbot <syzbot+aacb82fca60873422114@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com

Tested on:

commit:         14f8db1c Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1390f330280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=aacb82fca60873422114
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143f4664280000

Note: testing is done by a robot and is best-effort only.
