Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A866895A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjAMCE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjAMCEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:04:25 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A9621B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:04:24 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so14874762ila.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayK0uCBsQox46J2IE0pM400tXWnCHlDcWCx3CfqtMg4=;
        b=DwldKgGhhQMljrR0HCmlZvLImfUKSNaf9R8Jk0+tkknVEzq67kRoss5qwSb1pfYZiP
         /f84YkM22kGhfbro9nhesHUEm7c8nCIU0wqIoiVlqvQgH4eZ9h8EOSwwoqhsoqyHPkTQ
         3QVxIH7qFeFj9BD9XpmRtRTfFypjiLbmZfuiI0R4lJlnOY99LYE/+p0cDedkmjRf/VnI
         Uh8ld0R5UIsfxZV9xIdoypEnKn95Uzhaa5e8VSmstKGEvIoGlTrGpXZ/fKFm9RafI5IX
         hzWhx4Q3v/v9lqz3orQl81MFYkdpdzh3H/d544xeBd+VSn1tDS+1Mlp+m6HErufjhgQ5
         6mNQ==
X-Gm-Message-State: AFqh2kooIdTwN57uidOkseG7OnCEYfdXtdMs1WpWM/yVl7KImvy2xZ3a
        sqt6MViok9H8gA3b/2oV/lWeOu2vXz4qxp2ul4RGtPsC37Jb
X-Google-Smtp-Source: AMrXdXsKcSRHw8sK4t0XWANe42NYk0I4/oJdtmEBrZdoPzhm0JpvcxnGDQ4Sn8K9sIotqBiDSGtJjPWBqOpkz1le8/IfbiZrzani
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f53:b0:30c:2d97:1a9b with SMTP id
 y19-20020a056e020f5300b0030c2d971a9bmr5456205ilj.143.1673575463465; Thu, 12
 Jan 2023 18:04:23 -0800 (PST)
Date:   Thu, 12 Jan 2023 18:04:23 -0800
In-Reply-To: <d4f4556c-11ac-7533-f047-cdcfda9bddf8@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000013c3e05f21ba793@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_fallback_tw
From:   syzbot <syzbot+ebcc33c1e81093c9224f@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+ebcc33c1e81093c9224f@syzkaller.appspotmail.com

Tested on:

commit:         73f41663 Merge branch 'for-6.3/iter-ubuf' into for-next
git tree:       git://git.kernel.dk/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cc1236480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=ebcc33c1e81093c9224f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
