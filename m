Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575F6297E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiKOL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKOL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:59:28 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8711EAF0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:59:28 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id d2-20020a056e020be200b00300ecc7e0d4so11007141ilu.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckFX2CB6gsIap8LSojIAIL3vivJIeldVypJEOJjg0QM=;
        b=4OAF4abIvN8NfXXtFYr41AgJ8etz2qi2Rncf+qhXH0sspsfqYyhtvQtQ7NLiRfc8nB
         SHuxtF0kb7gDOyxw0hzJFh5K8dhv4rOTn8HMNDXI2DARN8Kos3fZzGjFzQN2fO1mc3ld
         KiuCYP6Yf4yyP/aRwt/yb4HD1LkfXTEqRJmIAn94a0IXOlmflOuwGYUchYD82qzg2y9M
         ++IbuS951o7a/tgrsRNFxYt+kM2MsEgsurdpWHoxy9kDV5LyDeeiPTBG+tjtUhvKjPCx
         NRERTVBCNq1LU9pcZtL+uOdZb9y+Ip8UnpayJ7KgFtzZWDFucgu7xijzi0xNBN9jWDtR
         403A==
X-Gm-Message-State: ANoB5plAYTJMiYkmv0esuFi6mRBfh5KMU5nhJkKm87xHQ7h081n8zNtG
        W5oTppmjfq5jvuEGRV12iJS15LhtJhAjzX9peqnfh74ok2Hh
X-Google-Smtp-Source: AA0mqf6T8Tj+fr3ig4F7leuJyHBzQHC+24Kxxj9eWpmSH75AzuiI5mIhYYfLCui7t9RMBR+UOI2losqAfXo9GQf4gZQPG5AxPqzg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:100c:b0:300:d5a7:4503 with SMTP id
 n12-20020a056e02100c00b00300d5a74503mr8596023ilj.294.1668513567666; Tue, 15
 Nov 2022 03:59:27 -0800 (PST)
Date:   Tue, 15 Nov 2022 03:59:27 -0800
In-Reply-To: <20221115064919.2321-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080f97e05ed811627@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_dirty_inode
From:   syzbot <syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com

Tested on:

commit:         e01d50cb Merge tag 'vfio-v6.1-rc6' of https://github.c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15081dae880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0b2ecc119b39f
dashboard link: https://syzkaller.appspot.com/bug?extid=37edf86c9b60581e523f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110f46be880000

Note: testing is done by a robot and is best-effort only.
