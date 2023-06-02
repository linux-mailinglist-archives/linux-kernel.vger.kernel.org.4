Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0671FD7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjFBJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjFBJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:18:20 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8051725
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:17:33 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33bc0618941so15526585ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697448; x=1688289448;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuxfesV2mPlW/l31sNPK0qS4J6i6ybe/ktRDhYC5dGY=;
        b=F890hXWZsRF4/ZBzXtg2FNjPvvIwgv4pI5i52qGJpwvaDKWAwOB6phN+OSepbt69iy
         jc/NjJPj75i7rekkdu9N1RBHzKVFyj4Ch4tPr9XuzNsx78k16j8gNoN1VD77BwdfJUIO
         caduprv535EQ4CwALpiUPbnV61zdR9e48hRyrSQ1pYXCYam3ajg90tsq0/r9Om0kWYBn
         uAb1pPIZobfDgjhcpCtT3JxMYuR7XDpQmWU/7S+vZx7HNVeViGYq5vcG17+VZBN7/9mg
         TqnqxK5m+xIDrQRv4Ujj1LU1wwWDsmUdGICoVsVRMZLJZdw2mKpvBbUm6ExbiIvArVtf
         mBDQ==
X-Gm-Message-State: AC+VfDzX+9GZMpXCzT2c3mHWZHMetDrLRJ637VDQSOn8TIfEHER/zafX
        6fEygKggV1MMaf3LL7ap4ljvS7LURPggWMC070oxoKMimJbq
X-Google-Smtp-Source: ACHHUZ6PrrPccCLLqhjvMPqVcJ09RH2oN6qZjU14NNHk0BLRnmjkdIqN3eAT6rsZSocr698Ro1lJbItecytN8+uEC+2QXev7r1LK
MIME-Version: 1.0
X-Received: by 2002:a92:c048:0:b0:338:16ae:c8ca with SMTP id
 o8-20020a92c048000000b0033816aec8camr3790651ilf.2.1685697448454; Fri, 02 Jun
 2023 02:17:28 -0700 (PDT)
Date:   Fri, 02 Jun 2023 02:17:28 -0700
In-Reply-To: <6bb51cd9afb95f2a5bd9bd2a5113f6dcbf4aea07.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d322605fd22054a@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.cz, jeffm@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paul@paul-moore.com, peterz@infradead.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

Reported-and-tested-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com

Tested on:

commit:         4432b507 lsm: fix a number of misspellings
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=166c541d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1095cd79280000

Note: testing is done by a robot and is best-effort only.
