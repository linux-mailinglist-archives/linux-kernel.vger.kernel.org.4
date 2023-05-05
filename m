Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41A6F8460
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjEENvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjEENvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:51:41 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA706AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:51:38 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-331514f5626so11679175ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 06:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683294698; x=1685886698;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5yJe0ucTNR5LQU+mWFKPT+Eu3Uj6CjrEWiPxsQOsWg=;
        b=XA8CvmZ9I8bUQYK/lg+zcEjmO0Jdbp/D7LA3vzMwLSgem+7lzC8JQYs23EaMo795cs
         nOJbcP+ihTdc6Z1W5fElpH4pQN/yYf5v99Y9zyMrFHJNFRd4kDW01conlZv8VUD4DKWA
         iATd7DfvmPTlkM8gBhqYicjXye2LgLBQVVYnRW8tw06JbYWji0JOvtJcJYlhiUYk84z6
         gvTjHCK8adoZ9RnoX3OipOaRUZH1e2meGDmnQ9ZxiSftREgSdSCrTKqBCLKSM+pYG49+
         F9ZQOk8a31BVoJbY440GJ5MxM9mPodnDhWzHAHz9vP7jRWMSNmrDIwdjRcJshhUcFnWs
         RGTw==
X-Gm-Message-State: AC+VfDy6qR/o8rqXOQHAPP4HYmPFKr+7vW21drri0TDnEAzKdBNERG11
        wbclp5VdYFI9KVMSozUZOwgeQXyWlzX8bR0h7HR3NlnDZj7o
X-Google-Smtp-Source: ACHHUZ5a3/LH4iKSxtjJ8ieObZ5ct2paMcCyy7nFhY+eLkUCP2q5glbTiVIOXkIQrdY5V8786M98Z8UZN46i0BdsTpG6pnuLVH/7
MIME-Version: 1.0
X-Received: by 2002:a02:a1d3:0:b0:414:39cf:e6b6 with SMTP id
 o19-20020a02a1d3000000b0041439cfe6b6mr693410jah.0.1683294698259; Fri, 05 May
 2023 06:51:38 -0700 (PDT)
Date:   Fri, 05 May 2023 06:51:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008acbdb05faf2961c@google.com>
Subject: [syzbot] Monthly xfs report (May 2023)
From:   syzbot <syzbot+list457a2ec8617806111bfa@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 3 new issues were detected and 2 were fixed.
In total, 22 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 560     Yes   INFO: task hung in xlog_grant_head_check
                  https://syzkaller.appspot.com/bug?extid=568245b88fbaedcb1959
<2> 501     No    KMSAN: uninit-value in __crc32c_le_base (3)
                  https://syzkaller.appspot.com/bug?extid=a6d6b8fffa294705dbd8
<3> 128     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<4> 110     Yes   INFO: task hung in xfs_buf_item_unpin
                  https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
<5> 89      Yes   WARNING in xfs_bmapi_convert_delalloc
                  https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
<6> 12      Yes   KASAN: null-ptr-deref Write in xfs_filestream_select_ag
                  https://syzkaller.appspot.com/bug?extid=87466712bb342796810a
<7> 11      No    KASAN: use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=f0da51f81ea0b040c803
<8> 7       Yes   KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submit_buffers
                  https://syzkaller.appspot.com/bug?extid=d2cdeba65d32ed1d2c4d
<9> 2       No    WARNING in xfs_bmap_extents_to_btree
                  https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
