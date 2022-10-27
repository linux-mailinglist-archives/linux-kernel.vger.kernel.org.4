Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A160F637
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiJ0Lap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiJ0Lam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:30:42 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8C8A6DE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:30:41 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e15-20020a056e020b2f00b002ff99582d01so1282788ilu.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MopiNGIxKtyALzcNk5GQJ19MYOT4wIVN4KQKOPZ7ing=;
        b=7juPivlvGLt0PJv/lXTBn9Fi8G233SlaoJ54n94m5InUFFRdPVrc/gE58nbLVVFb5H
         2npzT2outGN0HshGvSRUgOusdD3NZTxVRy1xRMzmQuj8jvB6AG45lVUM0vfPhSyJb8sw
         JX4LgnnVR4ZhJlFSEB23mS1O/BmLx0hvKSQVm58DO410gk6nHhq7rmWgxg7W4ywdHOM8
         gNFP67P1Wvg/yAnph5f5zLbIVedJ9dVMFXnu6J52+AKAnbKZWJmQ1PNNOo8AaqC88N7g
         G6oDcAfiYNzwPNxnsHkAEOYH6/lbG4bOPOk+XuNJWUsLrtbGKZCgRbEYYAP/uaQqivrM
         WyBg==
X-Gm-Message-State: ACrzQf1wtSOPF5pzkRJYegb/LmTxR728CgAIwX54jWdLDEHlKjhZX0Di
        iWIm296f9NIsH4kpGeMtviHU5fW7x52OVD7wY2wbfNHCqFsP
X-Google-Smtp-Source: AMsMyM5w5FYkS+2AwtZr70DGl3pg9y1LIfrFfN2H+JGzM7R4ZN8SgdCmld8+5SIVVaa8txpKaJe36W691IpkNF2DAmzbOpJnHla1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2195:b0:365:d82c:8c4e with SMTP id
 s21-20020a056638219500b00365d82c8c4emr26374061jaj.85.1666870241019; Thu, 27
 Oct 2022 04:30:41 -0700 (PDT)
Date:   Thu, 27 Oct 2022 04:30:41 -0700
In-Reply-To: <20221027030304.3017-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a532d05ec0278e0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
From:   syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com

Tested on:

commit:         88619e77 net: stmmac: rk3588: Allow multiple gmac cont..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c37cfc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=9228d6098455bb209ec8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162614ca880000

Note: testing is done by a robot and is best-effort only.
