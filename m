Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C05727A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjFHIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjFHIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:55:29 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC651270B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:55:27 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-777a9ffdcd7so112635239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214527; x=1688806527;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az3/mC3I6rBptIN6g19U3m8h5kdT0uqVmEGL3ErhZf4=;
        b=ScV23K+IXmv3p7TTHT6EmtJri34LtgG7ilA0e9P3bzLLDsFgzjlMCDK/kM/Qw2xrhY
         9xYZtYRcfAH6UgMSealaCofCXXFJQMbFflojJcQIm13DeJSbNg4GtPm1BbFhYKxnxMln
         4Q1O2bEf00EWgMo288as876oOCWD5eo9S36o7cUF2/FMTq91qXV8kAQZ1cLwc14fIKDY
         tOzLByF4VOEezsc/f9TfeFpjXmVyv5pz1BBe2xYC7t3SmGeCI4x9/vguFSQ6gNStdGHk
         oW7SpRW34YbVh9XWPNh3c5nJrNxWhp7xjU+o7KsDsbGo/BXTZMuJEkAWMXyE3TCRJSdt
         O7/w==
X-Gm-Message-State: AC+VfDz7uRFmOqkLnFKQRK3hWhh4aNXG/eHGkCb/LJamzkbxH8IZSSk5
        aepd0He45v8I/1QgJ5ulwaKZdxYBxq/K1ZZZhvD9yhXoU31C
X-Google-Smtp-Source: ACHHUZ5yyb+RYCCWlyH3EcXKqq8OEbyY76bXgXuq0sD/7Fmaag13b0Dyz/Raq/k815ixLa2X35o4jEcZ1SAyac+IgzCKpC1bbtui
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f06:b0:416:7d71:1261 with SMTP id
 ck6-20020a0566383f0600b004167d711261mr1001216jab.0.1686214527179; Thu, 08 Jun
 2023 01:55:27 -0700 (PDT)
Date:   Thu, 08 Jun 2023 01:55:27 -0700
In-Reply-To: <ZIF9v+qcdhhuYsMr@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8650e05fd9a6902@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_split_ordered_extent
From:   syzbot <syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@infradead.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com

Tested on:

commit:         8176a54b btrfs: fix iomap_begin length for nocow writes
git tree:       git://git.infradead.org/users/hch/misc.git btrfs-dio-nocow-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=11d17a43280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=ee90502d5c8fd1d0dd93
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
