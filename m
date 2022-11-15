Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE08629789
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiKOLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiKOLdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:33:20 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EB2A26A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:32:21 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id c14-20020a5ea80e000000b006d6e9b05e58so7177370ioa.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gv7raZK4J+vZQK4qaREuUccb/QEI3hJCmjFXTPZ9tSs=;
        b=UD1pe1udUpj6YxJEmFeEN8qGlnt6LTjiu11lS+xzOKTAjiv9IOziNDb4ss3S8O5SoT
         tKJQNyfCMQl3qqD46JE216GQ+7mTI7Z1YOpBRm1PzzGNdmTNFwlJnptAtCsKRBBZXJWq
         J01URt53nWtsdGP8s88ryRaaMi63VWWbivki5y4KjlmcgjqObFI7Bj9I4NQKSnO/lBI2
         BuKQIFpvrYvVM1AxRHqA/rNkdLPpJQrzC1FtArZrFSnAHwN+EduG7iALve8M303pi2e9
         dDu7od12n7HBHPCTulgS0za/wV340Lfm5uwmB9Mvsv2bxRX0+OAtwCqeAIJq0cfRXH0K
         pMHg==
X-Gm-Message-State: ANoB5pmGxH70aauOlYK1TNCLL+yoeMFcd2ikADl422O/SqXo3utGFhW2
        JTHwhiYIB6YD8YZtgDWr+4FIXsvH1yc8JhuwyqxloegAn0Rp
X-Google-Smtp-Source: AA0mqf5T+EYwixuXdTuy8dbJWzbOEAeD3bKP3QR1Ny+Sokm9xR0REq2tF+neOV7rZ/dsne2CTbJ+h4FHUaHWhx3RT2uQkEKquAU/
MIME-Version: 1.0
X-Received: by 2002:a5e:d80f:0:b0:6dc:8db7:ee4 with SMTP id
 l15-20020a5ed80f000000b006dc8db70ee4mr7659720iok.150.1668511940509; Tue, 15
 Nov 2022 03:32:20 -0800 (PST)
Date:   Tue, 15 Nov 2022 03:32:20 -0800
In-Reply-To: <20221115110542.2538-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084890d05ed80b57e@google.com>
Subject: Re: [syzbot] possible deadlock in nci_start_poll
From:   syzbot <syzbot+f1f36887d202cea1446d@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+f1f36887d202cea1446d@syzkaller.appspotmail.com

Tested on:

commit:         094226ad Linux 6.1-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=102b6095880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31242cbb858881d2
dashboard link: https://syzkaller.appspot.com/bug?extid=f1f36887d202cea1446d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160ddf69880000

Note: testing is done by a robot and is best-effort only.
