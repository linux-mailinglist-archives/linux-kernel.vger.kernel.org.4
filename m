Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCD73BC5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjFWQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjFWQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:07:31 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED42708
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:07:31 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-341ca1a51e5so5032705ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536450; x=1690128450;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rj1HcKKNnldMdeD2XNSySckZRvgWRLe0ofFpk2T+xdg=;
        b=XdAC3EDLEONchEulBn1FlkUTutEACQg22WiWmafgZz80Z69Rf2gBSCmGoxomAIkI6f
         QjgQEmKW/Yt6/WsF8AmkBsf/bVJdqrk1/uwnadXJqiqbLux1sWxuXsohBly29UvzzxIu
         5lVB5re4k3KJS/vPKknTzfAfneJmKL86eyk1It+snjAYU8fEdmunq5u8lf9bAjBRMGm9
         F2TsjnowNTAAsyhf4N7Wl8nd79W8OcY3vbM41ubbRHGPZQRqOMQUi4UF/E9caykUhleU
         ET6JJIDi8npNgqN6SWpFy8xbTvNzgMZsyu1E6DHarQRKv5UttPVCribJQfIH9fVYodJo
         SanA==
X-Gm-Message-State: AC+VfDwsFWQIV/asxPCt/jiabuIoEp06echjI9C80Vem/FjH7//L7htN
        k4/Jaqa3EuaKPekCHliWhzmIDYiqK4XxEyYe3m0ug9geDlMP
X-Google-Smtp-Source: ACHHUZ4+tDqI4FxVxVx9esMJCzQ872Ye0OjJJfbBVuvc0Mj1O61IdyXl+Stk7c+KRlN0TpqpR4ZQBAw5Cl29h3MS6l18DgdS1ZxM
MIME-Version: 1.0
X-Received: by 2002:a92:d44b:0:b0:340:ba08:3c45 with SMTP id
 r11-20020a92d44b000000b00340ba083c45mr8076102ilm.4.1687536450338; Fri, 23 Jun
 2023 09:07:30 -0700 (PDT)
Date:   Fri, 23 Jun 2023 09:07:30 -0700
In-Reply-To: <0f685f2f-06df-4cf2-9387-34f5e3c8b7b7@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab076105fece32e3@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb
From:   syzbot <syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lkp@intel.com, netdev@vger.kernel.org, nogikh@google.com,
        oneukum@suse.com, pabeni@redhat.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, troels@connectedcars.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com

Tested on:

commit:         45a3e24f Linux 6.4-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.4-rc7
console output: https://syzkaller.appspot.com/x/log.txt?x=1210e557280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=63ee658b9a100ffadbe2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e0e557280000

Note: testing is done by a robot and is best-effort only.
