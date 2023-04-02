Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F896D3518
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 02:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDBAj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 20:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDBAj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 20:39:27 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D14A5E1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 17:39:27 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l8-20020a056e02066800b003247f2ba648so16614335ilt.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 17:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680395966; x=1682987966;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUoVeBKU7vTJ+GrS4X7bbhLsi5eyt8HGqoLwn0y4WQM=;
        b=ICXXTT3ebHecxg4G4//RcntpEvw3733PhalGAL6Z2jBqjvgdZEG3zP4XUpzy76d0oi
         IE8Xj6UcDR4Ww5nUU35a5Sw2Zsq1uS0YMW3936qvXIsmnrUQ/Br/a3UxzAHVWbbyYmnL
         Igp+2++VZQ3qBUKH+BU6NXodYC8rfOGVnvQuqPMszgahXi8yS0VsSQ+AQUyTaHUnwTwN
         5QtXG/7Ik9+vWTns713y2hlI5XIGbxZfizwJgGyyRlrSTXoPlsqKBtEk5fH4RqfcddnD
         hCb++FMEmlDDdP+0NtID0cFi7+19C1hz4I3xeD762DfwP0vGu31vx3JrYIAIS6qkqpnb
         jyWw==
X-Gm-Message-State: AO0yUKX4V+69iy3KX4Fp4LNAy3yxG5ids2UlHgBa8Z7z2DVqH00V7Djb
        Q4/y+QNaXghgI1tWBq7eV0d/oZcbs/G98hc6QkkYUcLb7nkb
X-Google-Smtp-Source: AK7set9msYe5w9kSOIgUp9hqh9gWNWCkvLJ+rjVIR9rBC7kAAcLb/g1o/dNgvLy9b9wpd5pCf6M2/9j3TBqdk9cMwhd2Cla3HNYE
MIME-Version: 1.0
X-Received: by 2002:a5e:9901:0:b0:753:cd5:abde with SMTP id
 t1-20020a5e9901000000b007530cd5abdemr12443355ioj.4.1680395966442; Sat, 01 Apr
 2023 17:39:26 -0700 (PDT)
Date:   Sat, 01 Apr 2023 17:39:26 -0700
In-Reply-To: <20230401230439.284-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a971f905f84facbe@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in class_register
From:   syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com

Tested on:

commit:         a6d9e303 Add linux-next specific files for 20230330
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=129b3ea5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16340cedc80000

Note: testing is done by a robot and is best-effort only.
