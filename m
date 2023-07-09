Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08D74C1A5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGIJNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 05:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 05:13:44 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F34B8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 02:13:41 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b8af49a5d2so55973705ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 02:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688894020; x=1691486020;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL6vpHSrLw96URdBMqmcjtEoTRKeIBuISOPwTfuerXA=;
        b=izdqgSaFBG4vdL9a5PWPLa26dZ6crjDcTbNlb5VhtAZVpCZhV7e6BHczfQ8uy/klKQ
         56TMudB54CBA5As4sSApdZgCGec4yvbmGQ/hmcRWrckcJn+IMAH5GzNMf8R62dIT0Pi/
         7tAQ75GLewN1EbD6kqeQeFTHYuRdfykgJMu3EX/eJtQy6Hg6N9zwtVzU8l3x3IQvNFWu
         I5Pl5FVCLz0zb7AwQuawRg7kd2cRIvm1GvBbHEHKYt8DMJt9ApEaz+cmI22YhgbVrGmL
         tkEJFZXk6dE2klCXDJN3+M4Hky3KeRgHhOeziZvnILG7uJOLd5THOCA1+ieQNqc/BtKI
         4m5w==
X-Gm-Message-State: ABy/qLYLx72kGdvahnMCsqPCo9bD1XsZbc7fsT6OO/N0yZOvNPqi2Vt6
        Yux3oUFOxCVPon1Xhsin7afixuFwEAyKvjYKNomUhAIdgSZI
X-Google-Smtp-Source: APBJJlFF+r6HKL4TEL5EbK0VCkDe+FawzjzUMesSeuqfrqjPTlmGGdAiEjgoTQrAw4ZQ3lUZP0KDvFSGKeIt/PSgiu3axLMOqq/z
MIME-Version: 1.0
X-Received: by 2002:a17:902:ab4f:b0:1b8:902f:222 with SMTP id
 ij15-20020a170902ab4f00b001b8902f0222mr9788535plb.3.1688894020563; Sun, 09
 Jul 2023 02:13:40 -0700 (PDT)
Date:   Sun, 09 Jul 2023 02:13:40 -0700
In-Reply-To: <20230709083511.1624-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028b8de06000a4887@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From:   syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com

Tested on:

commit:         8fc3b8f0 Merge tag 'hardening-v6.5-rc1-fixes' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12fc9faca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9831e2c2660aae77
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1127939ca80000

Note: testing is done by a robot and is best-effort only.
