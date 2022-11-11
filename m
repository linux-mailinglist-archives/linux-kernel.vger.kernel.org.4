Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A1625258
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKKEV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKKEVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:21:24 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B212EF16
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:21:22 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso2465640iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPMeuzfbfCaaUp7pCVTYrjnJrrSQ/9h1MB2n4tQtfVQ=;
        b=1UJTPoOstSGzzVmijPE3I+UtjbtfxLYHzaLj+u5j5Nd/GkR+GVqEIU5C1F4UEfZwdW
         is5MnA+UDVQTfWm6ay4jOCTCWSXW/yyIZuqOk61/e+NqVVwiY96nRZjhKUO5N2SGt+Bo
         r8O4tfu2hnu7VQvpwj9I6+ixUi4FuJGnohs1gaNFiLd0YDoRkKIzNm7RnSzh9IZm3vX6
         pp4YZLkX408FlRftPfx+6xkjRE+1HMojfqKMw6UMAPeeNjrDHQOv12qiZJjBwI5zfKNX
         759aaU8TyrZcaD2VeiHEm8jDBwrq42cofVUa3kMHOoC6Gkx44sZysZvZQS1YyCfA/jS0
         MoRA==
X-Gm-Message-State: ANoB5pkc2AokcnChwdb8Kyk61QC+kKAftv/w+lKyYYYEVqptLV2pdkBt
        tA3GnE4Pb+yrOw3/IIPhVJOFVcQX+jeiuM+zXDB9pTyDdvRS
X-Google-Smtp-Source: AA0mqf4XYDM7zX6JrLC5wPCxgLPrXaXIEwxYZDZLnYwTJ36ULmaPFETJrSFRZ+9gYIi0hGm+gw6lSHP/iah6dMQiyqxO2fvONVkM
MIME-Version: 1.0
X-Received: by 2002:a92:c14e:0:b0:2ff:f996:8695 with SMTP id
 b14-20020a92c14e000000b002fff9968695mr249910ilh.172.1668140482123; Thu, 10
 Nov 2022 20:21:22 -0800 (PST)
Date:   Thu, 10 Nov 2022 20:21:22 -0800
In-Reply-To: <20221111034642.1272-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df5e3705ed2a3869@google.com>
Subject: Re: [syzbot] INFO: task hung in lookup_slow (3)
From:   syzbot <syzbot+7cfc6a4f6b025f710423@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+7cfc6a4f6b025f710423@syzkaller.appspotmail.com

Tested on:

commit:         bbed346d Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=179df3b9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170257e1880000

Note: testing is done by a robot and is best-effort only.
