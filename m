Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853266C2B68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCUHdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCUHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:33:36 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A33B0DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:33:24 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so7329299ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmnBnuSz/VzYWMjicA89xeJjfAn5SOsuHag4y11RgyE=;
        b=Ri5eKlO/qDQQEa3XHImcKurqFOULvTJaYk0I16DzTM3DHjnnTtYlYO3ebXhdD9vUhz
         BHAgkkKSTWUG5C8/oh01WmX9JIVxganvl50yBj2qCeuq2IaNrDZTorU7ofFWcQzVwc5O
         9P+coJDopHFKcQRN8FwxlqQilVObDDl72V8VadpTo0Urbs601qVDyJf2om0tlyJVpbWb
         597GqqWPuK907U6Xg7Mi2FxDTmTkiT2YS89gaWDI74sG9SlyGI/EJS+Ve5rxlyB2hNEC
         HoNArX8liC7zK4zh+ybN8aPkmp75SNJ4/03I73jZglFqHMLyfCvPTRlk22656UDlJ1Sg
         OAKA==
X-Gm-Message-State: AO0yUKXo8Fu0MGgxj2A/KklWQYZTzV80QOvCQ08kRukYv4/fkm1IEK+b
        3IAjW1qNfn2PPTofmAvIvtDaSCXC80d3b4iqTroi18e/HG5p
X-Google-Smtp-Source: AK7set9CXbxO+yuO7xJsqVQ+koOzzJACnM1rqFQIlrXrvzaBgCVfcWhPZtDzOhEcbRkTzomth7zqZ3Lr61SLDaC+OP9FgSnT9wmF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1244:b0:316:f93f:6f83 with SMTP id
 j4-20020a056e02124400b00316f93f6f83mr519034ilq.6.1679384003548; Tue, 21 Mar
 2023 00:33:23 -0700 (PDT)
Date:   Tue, 21 Mar 2023 00:33:23 -0700
In-Reply-To: <20230321070141.2434-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f91f1405f7640e06@google.com>
Subject: Re: [syzbot] [fat?] possible deadlock in exc_page_fault
From:   syzbot <syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com

Tested on:

commit:         e8d018dd Linux 6.3-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0f66ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=6d274a5dc4fa0974d4ad
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162abfaac80000

Note: testing is done by a robot and is best-effort only.
