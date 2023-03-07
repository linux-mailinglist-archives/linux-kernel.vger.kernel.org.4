Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFABB6AD439
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCGBpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCGBpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:45:33 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FE6C696
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:45:21 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id p3-20020a92d283000000b0031fe39f6bfdso2756140ilp.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 17:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678153521;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSqPK4mzWCaaqH1ZHdz4jwe8Y0oDlyn8ZCi6aUqdM7U=;
        b=jiyEP8gOJkvVzZ9dZpeFmFYSkZc/vHp1lwx/dKRbWN8oRMhGqrEiyCIqXW3pzXF8hs
         7M4Kz26TiiVVUvki02ICCSEhM8xsAOjHNk0+4T3J9pVjSmfLFlvp9jkqXWzgzYfS2nT6
         l1dh/8cGX7lXsdbKcJ/llI2QOBVdYNExYGD8Dw1t+iGBQTQBtsTuQggtD9kONd8HtiOO
         +1yVAf/quGRbXvf7CbdwNxMbc3JRO9p1cESQIjCZjZqvLS4s0n0+E/P2Hy6v5cz3KgBc
         rMtEkdr0kWWNsjABZtclL5KBBr4P/xif/zdOIgbMJplUKd6Q0BGy8fLsDij6n4vP08+E
         N6ww==
X-Gm-Message-State: AO0yUKVzuJcCZb8wEOtnkVicn3AzrRFPaO8xMv+iPu1FvvCwUI1JFzEM
        UMriWyTsUtjl1r5zCRge9jGrqJlZ9GVrlP85hSp+T57FjB6U
X-Google-Smtp-Source: AK7set8DQa9CZLECzIt8/89MQq7YmUqeTyTWg/qGtsi6IjitNlpxHIv4y8cJgmJA6IbxuNlpI15ScRY1sGMuPXLeMm+Wm5143uC8
MIME-Version: 1.0
X-Received: by 2002:a92:c20e:0:b0:313:f870:58fb with SMTP id
 j14-20020a92c20e000000b00313f87058fbmr6080227ilo.2.1678153520934; Mon, 06 Mar
 2023 17:45:20 -0800 (PST)
Date:   Mon, 06 Mar 2023 17:45:20 -0800
In-Reply-To: <20230307012101.1825-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e7f3b05f6459094@google.com>
Subject: Re: [syzbot] [fs?] WARNING in schedstat_start
From:   syzbot <syzbot+184ec1dbe951014904b3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+184ec1dbe951014904b3@syzkaller.appspotmail.com

Tested on:

commit:         fe15c26e Linux 6.3-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157e8722c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=184ec1dbe951014904b3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1276b7acc80000

Note: testing is done by a robot and is best-effort only.
