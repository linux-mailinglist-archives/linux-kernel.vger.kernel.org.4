Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBB62984C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiKOMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKOMO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:14:26 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AA8140FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:14:25 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so7194144ioj.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maXQ8T1aPqLhNBHg/3veTewVJvurHxhydomNgPgvxbc=;
        b=Axy54PCgqxCEhy+CYHf6UlcsYyblKq1C5NAEZnk0AcO7Q3ejIlc+AMnK3ynuRG+iUD
         13+ewttKqg7WGE1w9Sp5iwfPTKymG+vDfV1G85ItZZBymTbJHCF15fgNUa46+VcRK6yp
         1R0GK6ndqbkXBLSxQMGOoO9yS0tDC6KQCxOsnfVAE8fBC+S6bxRfheiFj1uLQrxdkicH
         J5sBFDLtXaP6fR9X1ApEbH1b17+jM919aJB3flu95cxo/JbdxJKb5kp8WIZuHC0OGRMU
         m25grucIz2dY5VDwXiiexbcSwWPW5AC4OAvQ6Z5GacbOGY/LEGy+wMjMimCK+pTrmeeO
         b7Zw==
X-Gm-Message-State: ANoB5pkZLZPFQr2MA5FJLBqnAcleEcm+l8S+31Wgn9JX6EStmL5inRXu
        cyswLTavc8qeCoenFtBQ9fBIdnmmTNR0Z/IXq+i+9FOe5lx/
X-Google-Smtp-Source: AA0mqf6cXUBPB7jUMCW9AjO0C03+ZzxNK7T8fwYR/nQdjLw6nNNPJVf0bUNmJOFBhBqtfsLplhswx3fLTc+H3/7qGgmNhZv4cewb
MIME-Version: 1.0
X-Received: by 2002:a92:b707:0:b0:301:23ad:68a0 with SMTP id
 k7-20020a92b707000000b0030123ad68a0mr8597293ili.190.1668514464961; Tue, 15
 Nov 2022 04:14:24 -0800 (PST)
Date:   Tue, 15 Nov 2022 04:14:24 -0800
In-Reply-To: <20221115114118.2604-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc9db005ed814ba9@google.com>
Subject: Re: [syzbot] possible deadlock in exfat_get_block
From:   syzbot <syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com

Tested on:

commit:         9e4ce762 Merge branches 'for-next/acpi', 'for-next/asm..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1732cf15880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ffacc1ce1c99b5
dashboard link: https://syzkaller.appspot.com/bug?extid=247e66a2c3ea756332c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12df7d35880000

Note: testing is done by a robot and is best-effort only.
