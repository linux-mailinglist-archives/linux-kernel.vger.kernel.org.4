Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D56658A09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiL2Hlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2Hle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:41:34 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D952EF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:41:33 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so11356787ili.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TQjimL8KUZMscO4m3fC34iqwHwmpZuK4STzqhRFKQI=;
        b=0jAYEJ0wTZHuWLr8nDBmXS9bzE1yzirpee7nZV2E9mzQrzMkG9PJ3RXs+ZDEukhopS
         +v6UFZNAecfNbWVQb92Q8Afp0fDUqOlvxMLwJLSti3QXWmDZfxe2hYWIIMiAHXsPJ0Yi
         Txm9pBtTaFyYOm4u8m5L1ciD2PS2vIWtlgKv+kONjwpLeMSLF17/owt34I4NWRP+uVLT
         P/QeHn+lEYOLLRDmHquhwfApyPsyaMNF/lhIFMqypIEc79QmEYNrBuzZSsEt4ydgxmpX
         nLyzGK/zjIbo+xvLt8cPo5pH2XNMXrYOiMysH6Q1Iklj777VkS4mBm2nETN1j6Bt0GhW
         OfbQ==
X-Gm-Message-State: AFqh2kqp2kX9GDaA2JFRgNaVwnNglFaMTUmI7VfA9PVT0WgeS5e098oE
        YPOiggNjv6Wsdpkaxc5PKJtflhJsJbpJgcDy0LDxPXsDZ9Cs
X-Google-Smtp-Source: AMrXdXuYLY6fqexLmgudj5C+fa2G61v4XrTcbiSl1xvdnHFrzt5G6uuSPBCL5pfEUBrWBTeNyMSoN5rgpur89PA6kEU6VrHQRqSJ
MIME-Version: 1.0
X-Received: by 2002:a92:dd8e:0:b0:30c:217:ddfa with SMTP id
 g14-20020a92dd8e000000b0030c0217ddfamr945881iln.148.1672299693017; Wed, 28
 Dec 2022 23:41:33 -0800 (PST)
Date:   Wed, 28 Dec 2022 23:41:32 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029119905f0f29dd3@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, dvyukov@google.com,
        linux-cachefs-bounces@redhat.com, linux-cachefs-owner@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=5b129e8586277719bab3

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
