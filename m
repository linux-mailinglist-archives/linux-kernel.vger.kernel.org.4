Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1FE74B33C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjGGOpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:45:29 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C81FE6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:45:28 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b855dc0f0cso30364875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741128; x=1691333128;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faKZ0VTkrZreCkMMkV/w1MPosNwfKMr16O7H/usv77c=;
        b=cKzY3r7w4x64YRzU9/H06cbFhOiuHCyyzVOBQjxx3aJKIg8AFeUWq6fbcXCQ554ltT
         YHmFDSbI5+89CAzn6bpP1xuOeDbb7LN/UVlVEW1OobqoPysqwdqLc1t7OLbxjiSqR0xu
         a5L/4m46b9Zh2G7PVl6fmS2zxoEPAq4jamvaEFsFvItoQfMvSWFP6SMpEPbdIlTUnPIr
         dMXYogqe5ANz9azuTdcHiBvuMVDSSEjkf7ACf+MYQ1pV3qoLKhyIQ6uRpmVrxsAZ6WM4
         2LWCIcYV2igVtwc8qZYIlQCk+W4C3QgjE1DEsI8n39fCiSXPbsze4xQpp+d01upH3nSb
         H2Jw==
X-Gm-Message-State: ABy/qLZm7FjThBmYuOB1AEwIqpRtSUpnKCM79j6EtORobeTBHQKmhPaf
        0h61Zegj/O5ZmFxPoglgYWG6vqxVOHrMvUUiSpkD5snPIvAO
X-Google-Smtp-Source: APBJJlGcoqmtq9dZ2KJii6DburbTcLjXYhE/WlTYXTej235pqTl7vDbZOS50awBLW5giYdO8BGKF+iPVXKutQjDtW/j39Ci5SfBp
MIME-Version: 1.0
X-Received: by 2002:a17:903:2149:b0:1b6:a2e4:c8f8 with SMTP id
 s9-20020a170903214900b001b6a2e4c8f8mr5275199ple.2.1688741128024; Fri, 07 Jul
 2023 07:45:28 -0700 (PDT)
Date:   Fri, 07 Jul 2023 07:45:27 -0700
In-Reply-To: <ZKgfG5yE+VoMiVsZ@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000db85105ffe6af2c@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode
From:   syzbot <syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chao@kernel.org, hughd@google.com,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com

Tested on:

commit:         14245406 f2fs: flush inode if atomic file is aborted
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16961190a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20a954c5f553cc85
dashboard link: https://syzkaller.appspot.com/bug?extid=e1246909d526a9d470fa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
