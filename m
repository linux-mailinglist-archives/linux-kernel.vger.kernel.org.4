Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45267C501
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAZHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:43:28 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DA1E1C8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:43:27 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b26-20020a056602331a00b00704cb50e151so504675ioz.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TQjimL8KUZMscO4m3fC34iqwHwmpZuK4STzqhRFKQI=;
        b=jmwhRC04oLz8K4LclOFS6wc2QEyxwVcNB43dSdPx1KR+XusaI83dayO8BQg1LeiAVW
         IVCCCKadT6GA8Z88AOnIGM8YovXAxTZMA6PAk2ryiRFAlrdIhTwP/289nkI7FujEbo6e
         c53dXIhYC/BjwbB7UHYn3FaItWkrPNGUVZ18xwtrPfjhIz9lywuL3abZMo+WP72cyam6
         u/st/mnfv8MQP5nb2J6gsd1ZQmKdyKDJk5OnZERRsI6HjAs1M6VpnNQaJPwn2SYa68Pr
         z8YT+z8ybhptjVcNn5K92H3tAEC2Yo7XcDCMEdLu/p3ZqYBJNr0zqWypFbTQoZAuRRRG
         u2sA==
X-Gm-Message-State: AO0yUKUShAj4ul25Rs3SWTp5Fzwu4sNFJowWlqjjlEbyNEi8j7NKdPou
        x0PY0UnZu0N1rQg0cSn3iiMfNQ4GSzKJOMVmu6X0W7zN8bdr
X-Google-Smtp-Source: AK7set/Vv6ZjO9ahlx0QhgfopXjJRbCub29Q4TxRW0teLnducMO6s47KRgREX7WE/K6uWQ9HZE4kOIcDUx6WGFFyypmZsXUQ6v8e
MIME-Version: 1.0
X-Received: by 2002:a92:8e05:0:b0:310:b8e9:dfd4 with SMTP id
 c5-20020a928e05000000b00310b8e9dfd4mr103349ild.69.1674719006911; Wed, 25 Jan
 2023 23:43:26 -0800 (PST)
Date:   Wed, 25 Jan 2023 23:43:26 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081766205f325e781@google.com>
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
