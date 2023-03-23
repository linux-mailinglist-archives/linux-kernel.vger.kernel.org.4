Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47696C5CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCWCnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWCn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:43:29 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B3CC21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:43:28 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z8-20020a92cd08000000b00317b27a795aso11025041iln.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679539408;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW6SjApLYllQMRpcpYJmdWhVK/LigR0wTMNHt18V/gE=;
        b=UqbfLwUyuZ2XCQLibD0mKK+FnPrluA0WiGW4j+VrqLrgkvS63cNI1xRby/bjRhpGb5
         dgG0n6EJYmw4PpJfKQ9iI3oYXuykq/savsRkj2WZKx3WBoGa5G3isW5oo5lzh99SG29C
         DCWs7De+Km8z/67ZC1D3MHPKNg/816ER4uwwLEsuU4A7YRRdR1Jd1ENqm0U6uxE8wA9q
         JVsHoX68xeLu75X2EZWP921cxwYABNltRs7h3XunXDb1pP1meEhslmkzVU/i+1M4oLFL
         4yitGZmIpvVwjKNco25M0XoVRmKGKMMeGKfn8Q+F4kBv+ouv59CbtNCQYzPjUR8MoTxq
         lDQA==
X-Gm-Message-State: AO0yUKUbqO50TL+IYZposuY6yDSHje3yfNs9MT9PcoV3+38bPIZ2aATi
        P6XDjeeR9skbhJ295FJEtuOKxg2c1qQWJFdRDrnYFC9jvAIv
X-Google-Smtp-Source: AK7set/ehLbfMH7yprt+HN1+vR1kcm6eEwmJIq35LhCse5IqAgGAK9l6feNXMkd77UBxyyyarZHt82Ph+OwQ+MXVrMnPvDNMdmmO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cac:b0:315:8de2:2163 with SMTP id
 12-20020a056e020cac00b003158de22163mr3726520ilg.5.1679539408101; Wed, 22 Mar
 2023 19:43:28 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:43:28 -0700
In-Reply-To: <20230323021611.2625-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce69cf05f7883d0f@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] WARNING: refcount bug in
 qrtr_node_lookup (2)
From:   syzbot <syzbot+e8a22d28d4527d9d6148@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e8a22d28d4527d9d6148@syzkaller.appspotmail.com

Tested on:

commit:         fe15c26e Linux 6.3-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14783619c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=e8a22d28d4527d9d6148
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d40289c80000

Note: testing is done by a robot and is best-effort only.
