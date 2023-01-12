Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F99666BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjALHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbjALHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:42:28 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA43F45B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:42:26 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so12772378ilu.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TQjimL8KUZMscO4m3fC34iqwHwmpZuK4STzqhRFKQI=;
        b=KnUr6+TBIjKLZ5LbC76Q2UI9h5JP1vbbfy3YtjF+nj0iyfpTIE3F1ulFRNtGLmoZHW
         IgN4czMn5WP0oMbBcH0ND+86/puuUsKrcu2tkuxCM6E8dQRRWPhyOkPjPkZTFbcbYJMl
         OTq7Gv7aCF8U7H+/ics0KWhrmrdRDhDPjEziz1Z568quH7x0FIurWuuhV3nIqEUb2i9Q
         o9NS1X29yd4pQdENZri9E1f8NTz2IU3JIeu3PQ1HuSmWbAo5U4Kfdq6SfsxybJFjiE9N
         nYclwJDQie1Ns3vqQjBfQ71nqHy/EFr76WVPWbtrJ7ouIntjkZ2RdJ1VLSCQ+iTEeAEC
         z4Uw==
X-Gm-Message-State: AFqh2krR/KNalCW1WNb1pm7cGsMI07bt4Sik+LiQTok3e+jSDdPegLaH
        vftoiKmAacCg/EfjVVQvY+V2blCaP4zJ2jf0qhzklaJ9gQGv
X-Google-Smtp-Source: AMrXdXsKCZePNVlRHn4wtr1s76eeempx4mtvAQfxz/sKaVwwejEpSYE+q3rdDiIZupgUnQIkmsWPf8BVsPx8vxngPT+fX5VHKlvE
MIME-Version: 1.0
X-Received: by 2002:a92:4402:0:b0:30d:90de:eb8e with SMTP id
 r2-20020a924402000000b0030d90deeb8emr2414568ila.204.1673509345955; Wed, 11
 Jan 2023 23:42:25 -0800 (PST)
Date:   Wed, 11 Jan 2023 23:42:25 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018186f05f20c420c@google.com>
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
