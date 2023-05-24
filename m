Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3EC7100FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjEXWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbjEXWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:31:58 -0400
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F4191
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:31:17 -0700 (PDT)
Received: by mail-io1-xd46.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so261073539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684967361; x=1687559361;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEv2m2tkW3LxgGFisYpUk4xaYXyQdf15D8timEsBePw=;
        b=ICfvqXWyAsNOFZSLqtsQgnU0HyKwmxGihfY8DlmKz7p2Hq8jyczOJyx3JrKHHAEx3x
         Ngivga0h5j0CQvYaWBwxjMde/Z6wx+j1canXNOPQz5MrJ6zxswVPnkrcehamzSJsb4Rf
         FT+rQ9JYogYFF7UYI5SeDN7woU3JLJx0aoFrvF2vFsLXJVyfm+0Skr3+Hzbunc+Tsi/T
         O9dfvDBLU1/30dQ47oaryPC7qMJCwzn/oADiOoWl2uEe3W6g3qTGg3Qd/4J3bXyU7WiG
         Wq3m/k2ySznR62Mai8xuF5nctZhtPICgb9E5/uM15TASDwvMKR25+IIgfOVIbCxXESIb
         d5eQ==
X-Gm-Message-State: AC+VfDw7XhYuTgo4HjkjXskkFRi7TmfJkKokwQhMWJSuiAwktEHngW6G
        0YX1NaosMwf8P1H3sqL3KWOs61bo+Mq28T/9zA3SvOB7SAfg
X-Google-Smtp-Source: ACHHUZ72qrCpncxwPE6/T5eypdjBRfnsPFGFFDWfjAutJOp5v9DIOoQX8UKqk1yaqn3vJLjS3kFKoFiv8AWb/wsRgVElDA5SO5rs
MIME-Version: 1.0
X-Received: by 2002:a02:8521:0:b0:41a:c808:b49f with SMTP id
 g30-20020a028521000000b0041ac808b49fmr8538740jai.3.1684967361648; Wed, 24 May
 2023 15:29:21 -0700 (PDT)
Date:   Wed, 24 May 2023 15:29:21 -0700
In-Reply-To: <000000000000eb49a905f061ada5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ca36b05fc780953@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_symlinkat
From:   syzbot <syzbot+e78eab0c1cf4649256ed@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 267a36ba30a7425ad59d20e7e7e33bbdcc9cfb0a
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Jan 16 08:52:10 2023 +0000

    fs/ntfs3: Remove noacsrules

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fdf761280000
start commit:   ec35307e18ba Merge tag 'drm-fixes-2023-02-17' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b8e3df6f76ec
dashboard link: https://syzkaller.appspot.com/bug?extid=e78eab0c1cf4649256ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12570890c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14523acf480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Remove noacsrules

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
