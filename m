Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983D6B6DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCMCxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMCx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:53:29 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA21D911
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:53:28 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id t2-20020a922c02000000b003230219cf1eso1379903ile.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678676008;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61d+K3V56EzCLVe5PdifDbhKFzOtUuVmQU2j+nhYREc=;
        b=EM5mgSAzeAaVbBWemUCiFDzji4CE7C5+2yPxYMaYEwNHu5+sToAUJ/Lc22puk0nUvw
         co0O9VwZaBOOsGAJBwJW4mo2Dtls08o9ItbvjCW6cT14s9NGoFvvUy9H6bMBHXgX5I5O
         jI3f2MrutymXwmAHnOOEkazlDaWSVE6LhjlcbRO7oBMgX+pg1272/tSAZivL6qfuVE9F
         sOhV0Nkj5bljaebpEJMemVn4Unmt6W15yLurNQ9fZjgSlx3p4xSHfrZA2KJkyvsVUFMq
         ghBypagtMXfI+Hbn54K1xMLbe8dPKBzklGYTp2MIwNSpwFHbj98yAiPzb0Oo/+8AjDpi
         OR1w==
X-Gm-Message-State: AO0yUKUjDDlX6j6eR1LMnKkA5NOliTL/wMT32DqM6kwpR+SFeUGlWUTw
        IwdC8eDErS60npWyPK3IJaxBlmr/kI2xH+Cm6dfpWYP4ldrL
X-Google-Smtp-Source: AK7set8rEn736rmryIRgzdSLWkmbfZuNRTz4nSv5IQsf9frSpH1vkNzCy3LcjV3NnGaGvfgws8Or0rRUQz/7P7O/HBHE1ocM0J4b
MIME-Version: 1.0
X-Received: by 2002:a92:c20e:0:b0:317:b01:245 with SMTP id j14-20020a92c20e000000b003170b010245mr14563388ilo.0.1678676008052;
 Sun, 12 Mar 2023 19:53:28 -0700 (PDT)
Date:   Sun, 12 Mar 2023 19:53:28 -0700
In-Reply-To: <20230313023247.1600-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027321d05f6bf37e0@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in del_device_store
From:   syzbot <syzbot+6d10ecc8a97cc10639f9@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+6d10ecc8a97cc10639f9@syzkaller.appspotmail.com

Tested on:

commit:         13423166 Merge tag 'staging-6.3-rc2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1038328ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aef547e348b1ab8
dashboard link: https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16700724c80000

Note: testing is done by a robot and is best-effort only.
