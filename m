Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70A264E27E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLOUnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLOUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:43:28 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD54B4A588
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:43:27 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so332176ilt.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpHrrv7GqN31QnyWfj9eCU50Ir97F0dGpiHKvKskIs4=;
        b=kkGL+RSkuhX8hC2QTzl/8SIGQmBGNpUO1Ez9fGW7MzfprJkrAvq7A/LnWPFZ6M1ixj
         z1ltTgbD5JM+vVEiJx+8joZ4x68WHvyI1+99XHSONgpu8b8UZhyDTlAKJDzXVjnSS61e
         HgWkhiaDdUykL10YwnUpQxCHeRJAl1ban7CYaWHemZUN7DLEFerTKYwS4/HVBrCfkbH+
         ynudKa8tZcZ7u7lf465ViThZDAt8gOGea8MW6dMyWVMecNYVw1DJndMF24THEuAOW8Jr
         ijy2jcZa1GhmYsp6yYowzbLEdoNBsX1fQXcZpzgvVQisAKD9hwrSvwvasoPTPfu+/j74
         llkw==
X-Gm-Message-State: AFqh2krwhZMF5Mo9dxWMx1G9B0pelWi5SCQfyShXX+RBV/1u0pvbQj0D
        OPH+4eFzmSYMt+BsXLFGsWvRYYBwlHHY+V7HFiGBF0AvMR6B
X-Google-Smtp-Source: AMrXdXuqouBduUFLVIJUdIe+CzC8IL2v0nwGG3HwEHAiOIMJuFddWRCCg5Y2ViXZqxNs8dvSSFcjy+I6pfsV/LY5D8+AWNMrQ41M
MIME-Version: 1.0
X-Received: by 2002:a02:9f88:0:b0:38c:8b67:b322 with SMTP id
 a8-20020a029f88000000b0038c8b67b322mr331069jam.302.1671137007039; Thu, 15 Dec
 2022 12:43:27 -0800 (PST)
Date:   Thu, 15 Dec 2022 12:43:27 -0800
In-Reply-To: <20221215125937.1044-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acfa2305efe3e715@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in path_openat
From:   syzbot <syzbot+59a66cac604a6b49ecce@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+59a66cac604a6b49ecce@syzkaller.appspotmail.com

Tested on:

commit:         8fa590bf Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13a5a6e7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35448eec2d733f7a
dashboard link: https://syzkaller.appspot.com/bug?extid=59a66cac604a6b49ecce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a1acb3880000

Note: testing is done by a robot and is best-effort only.
