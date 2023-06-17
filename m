Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB07341A0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjFQOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjFQOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:23:42 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412E1BDB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:23:39 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-77d99de0e9bso164960639f.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687011818; x=1689603818;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTyXiDnvdFP2eKsE2/4PqSdev1oCQmm5tSUh9A/kxgk=;
        b=SgGtypBJA3HbDHI5M8QE7fCmyBk+zU4C5nS5HOOjNctI8SlWfGdnKmfNAYyLL90R8X
         ULBqQeZVXckquaXKibFhXlc9OR4YxGMD5rzFiHFiaKtC9O3FY96L6EYsPoea41T6O7Hc
         MM8pjnpUSmAOM1lTd8sF1zFNctnAhS1PRcObjXn13PIDILszF7EjsY3ZMOtmakqmNhZ/
         0u7LjW1zORCDsVTuTgl/wH2oynn73ird/AyWjAkhSuW+APgXwVnx3T7edNyUT8YWgbn/
         Znwp/XVeYJTYfFGkI5qTh5DODL6bJ3xUsSa6FbfAuN7/GI+nDV3Ulc2LUPBYvU7J8EXr
         076w==
X-Gm-Message-State: AC+VfDwjMdHEVZS9p1KDw/v/nf9Vixs+S+1vRlk7c8xrjtbHI5yqCbrq
        WTb3NmJcfYWjTiXqkISqeCz19HdJEIwcDn5j3JDv0YGb7NmL
X-Google-Smtp-Source: ACHHUZ7p4aUQNHmnkTGykin703Dwt5I/z8nlnBSfJvinUCU9DIvpk95dmGxr+Am+S7RcLx3WPQbx/jTTZYCXwVvSd9Qv/27iWevK
MIME-Version: 1.0
X-Received: by 2002:a6b:7b46:0:b0:777:b438:2926 with SMTP id
 m6-20020a6b7b46000000b00777b4382926mr1318139iop.3.1687011818728; Sat, 17 Jun
 2023 07:23:38 -0700 (PDT)
Date:   Sat, 17 Jun 2023 07:23:38 -0700
In-Reply-To: <20230617133343.1155-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ff45405fe540c3e@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_file_mmap
From:   syzbot <syzbot+c0e3db4f9cd6e05cadd3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c0e3db4f9cd6e05cadd3@syzkaller.appspotmail.com

Tested on:

commit:         b16049b2 Add linux-next specific files for 20230614
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12d596ef280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=c0e3db4f9cd6e05cadd3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118dc77f280000

Note: testing is done by a robot and is best-effort only.
