Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510F6F3C37
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 04:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjEBCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 22:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEBCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 22:50:22 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ABB3AB8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:50:21 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7639ebbef32so470866539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 19:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682995821; x=1685587821;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtgYAOm4mEvO4wck6c4SokUyB0mN/mF2sqtpCYuKcws=;
        b=CU+92NAy4ZSyTs5djgos5cJT+MdW3AC79KxqgrkKVjtf6/5UvNMcT50iyqFP8KV6dv
         dwksCxPTGI6+wxc2qEuYwZt0k5chKY/MQVVSZ8KtRky0muiHrBpJL2u2JDpuNXejJnTp
         spJOtVCTSrnH4Eu3g//vy8hfyum0S1WUPzfVe6qDlfdLntoqkIf7netzhYWBizK9MCxI
         gTMw6wPwgSZLSmYXNcWP4k8A17VES68zpotBSDsFcNqRE6CpKqgTLcRrMHx9OeEFA7Yw
         lVW4M6jI4kcsct5ZKz66PIGqfsKcnLUVFoKR+hi9R8JXAQ4MHfmHMe0eZ3L84kzFonh8
         lERQ==
X-Gm-Message-State: AC+VfDzBjcKGPHLqP7HRxpGOUvvdF7wMlnPWamEKBhvyMnv6xZZHZoEG
        HxZYE8pTLfczC0dPBD+WZWlzi7pcI5au6peg/hyLz74347x0
X-Google-Smtp-Source: ACHHUZ7mFH7s2jke2+ezG8hvV58qOIeiBILQTJlhtJPbw9L9a666QwHasIhNO+b6WSR1/rI9Sh4oWMI4VYnrtlBtOXJLe/xcf/hS
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2152:b0:40f:9c3a:8ce2 with SMTP id
 z18-20020a056638215200b0040f9c3a8ce2mr7027825jaj.5.1682995820941; Mon, 01 May
 2023 19:50:20 -0700 (PDT)
Date:   Mon, 01 May 2023 19:50:20 -0700
In-Reply-To: <20230502022438.3394-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010daaf05faad0056@google.com>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in tty_write_room
From:   syzbot <syzbot+4e24c3e417773c914ee4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4e24c3e417773c914ee4@syzkaller.appspotmail.com

Tested on:

commit:         58390c8c Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136a4928280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=4e24c3e417773c914ee4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14758e2c280000

Note: testing is done by a robot and is best-effort only.
