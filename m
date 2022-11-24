Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D6637D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKXQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKXQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:20:17 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB15169039
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:20:16 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so1403883ile.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLu57xj1JC82H0XXz+GNssdmQJiC9qe/YgctFzNmVG4=;
        b=2gAE+eVtBKMRTX4vctPAklCM1NOJUkf2l5CpZquW1DGPkTX/4VHhfSkwdm8NrmidPJ
         cVvfttv8W16GgCk0Ubfe/a3D18F8AakCXOhG/+jkCzIaxkBFSxOUFVYgOpBDGAzNzM7S
         sgoT9NrrPeNkmSjQ7UV2SRKIfEWHRukcC4l7FcBckOJI1P8kssg9lv74T8twjmZ0wKxg
         Lphltg1tln3n/zHpoEInXMgftoazoKAE3LjmgTTKqVMspeK8UJvzqfqXwd7LGhUj8JM5
         1raSWplVpvFB5deuZxtrgSgr+jfsz9jAasfeNwJobpDFbtqyJ5Yo6aWuFRc5fCjOPCdZ
         Fllg==
X-Gm-Message-State: ANoB5pkgWKxTAhJklMBhf1j+MiZZh1vHLYTRK8fS3b0zQEQZUvmn9yar
        Nze2PgkNjp+hTGrdm58nWpp5W7Gt1v/fhxnpoMjF8tFuT6IW
X-Google-Smtp-Source: AA0mqf4SJAQZVT4Jwk7/+fz5PzSbbTOB+9yCW80SQJofgTk2Q1JpUZ6ITjSAqpEq12edrM6PcQ2CYn2mBv5fHDzsVoZBesMnImOs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1c0a:b0:386:8261:ab08 with SMTP id
 ca10-20020a0566381c0a00b003868261ab08mr4116458jab.21.1669306816155; Thu, 24
 Nov 2022 08:20:16 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:20:16 -0800
In-Reply-To: <CAJfpeguD4Ai8_PiRnDO8dRFauHPdwLimWrB6xsxsyn8yFLgL6w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc587705ee39c75c@google.com>
Subject: Re: [syzbot] general protection fault in ovl_dentry_upper
From:   syzbot <syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com

Tested on:

commit:         c3eb11fb Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a0ec05880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=a4055c78774bbf3498bb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b17403880000

Note: testing is done by a robot and is best-effort only.
