Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C449363E9EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLAGaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLAGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:30:24 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CE77417
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:30:23 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so1090948ilv.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoNt7ZDVt8IdbGC1e8WCGEnJltyy9da12ChPpKWKRng=;
        b=2ZoMhjJmfn8uTF3P0neap6gkJCcIP+fWwMEViOYYpHcn3wXLBZAPiC3OjFoxiG7OtC
         9wRha9FrsENrp+6NV5yWu7BPeY9byfIh6g4tqxSAv7NqKenN2lnxVlu1QBDOIs2yYwwV
         BaXHVuLC7l130mQjuBoosx/ZFUqHeUemaxCJh6vRMmj5K5PT8jj+Tgbf9zXjDiurWGnC
         KzCTPjR+Q6wNK7odw3sll3cvmXeSriw6knxowFq+fMaqVyxalu4z7CyE2Vui2yf1mG9i
         ix+435cdtYX1A/0iLkQ0TI7O7edmMvs6GQsm1ulU5LZOeJ0VgE1smfU5pj16+atgUPJ+
         UZ+A==
X-Gm-Message-State: ANoB5plTJROsAFi3b5YGuKK/f6DTpWVpn9TMxy3540UGup/h140Yhmhh
        W60qsAnffAVznaHe5fAGNsxlieH98m8k8DLTFH5QNZsLuaSe
X-Google-Smtp-Source: AA0mqf6s8DLA7Z4eHoHy+S4I2QeGdfPgw1un3v0K2sDRa9BVwafDaJkr4YFKPCNPNuM3k8QA7GcQsgTLx26O5vjWMsg7MX1WPq+M
MIME-Version: 1.0
X-Received: by 2002:a92:d243:0:b0:303:e36:3b8f with SMTP id
 v3-20020a92d243000000b003030e363b8fmr9549571ilg.51.1669876222606; Wed, 30 Nov
 2022 22:30:22 -0800 (PST)
Date:   Wed, 30 Nov 2022 22:30:22 -0800
In-Reply-To: <771e309e-d7c6-d4db-ab11-0df05db6b9a0@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001143c205eebe5b63@google.com>
Subject: Re: [syzbot] INFO: task hung in gfs2_gl_hash_clear (3)
From:   syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>
To:     bobo.shaobowang@huawei.com, brauner@kernel.org, broonie@kernel.org,
        catalin.marinas@arm.com, liaoyu15@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com, madvenka@linux.microsoft.com,
        scott@os.amperecomputing.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/gfs2/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b7b275e6 Linux 6.1-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17185a87880000

