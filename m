Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57F6484EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLIPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiLIPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:21:31 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288218B383
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:21:28 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so85297ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pSyhnAA/+sF+8/dS4NvF8BdyEwfdVTfddEx2JWC8Ts=;
        b=z31XRU5OifrFkqp9uPKhSM2FlSeWtxig6NYckVRo6jw+agMmYS85QPoJJk4K1KWuJo
         DTInCul8S9rYW+Eoz+rSf6g4T7Pd9oMTPR5X9FPxR+OM+t4K1HKzYteAr01Jaka71F74
         OTBadkqeNb850Y6bqIugccDK0bfzZ+4mzF14ORsmooV5j23zmOlQDipk2HmlUDjUdMGk
         j/AJagtlrkZOPlMjaOLWzj00FnyUk2H+nmirq/89kqVWquqCjkRKsb7Xiua8MMThCziy
         53hcwraGltsTS3fLU9mHEwU3Wifh2IDUVDHq4+vpPiXCM0xMS6tb9d/5aeg1u8Fh0ONk
         yBig==
X-Gm-Message-State: ANoB5pm2p8cPiXYW9h8JUn/MUIcF23fD6Y0IFAsUOX2egZOIWhLbWQL+
        9CG8/lE/Cp8Tr3CV+OqrbWs+kSKQK0gEi9zdY6VyWzu/x4Jf
X-Google-Smtp-Source: AA0mqf5Hy0RDGd/9jAqVuH4xFL9kwpdHK9cN19m0z8Gr/snizWkn2LrDDhNJFWHZdUAnIpsFWP8ZUqAOLXewhBy0mQhPOgkihnNM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:38a0:b0:38a:518e:d230 with SMTP id
 b32-20020a05663838a000b0038a518ed230mr7617894jav.255.1670599287495; Fri, 09
 Dec 2022 07:21:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 07:21:27 -0800
In-Reply-To: <20221209073632.1861-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017e09605ef66b518@google.com>
Subject: Re: [syzbot] possible deadlock in ntfs_fiemap
From:   syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com

Tested on:

commit:         0d1409e4 Merge tag 'drm-fixes-2022-12-09' of git://ano..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12726a43880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dba623880000

Note: testing is done by a robot and is best-effort only.
