Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6773063396F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiKVKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiKVKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:11:28 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F754B3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:11:21 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id h21-20020a05660224d500b006debd7dedccso3119578ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+PjVHTh1krt4Sf8cWM+AKO9LG/6NPuUny+28uZGvz0=;
        b=7jKPIh22AbmgG0iiIrw0JGK+cxaKtpzbhmzO3eqmBOZtdgM9eOmI6PArnf9Vqbs7i+
         odL3mDODEiVQEt4ZqqRWmuM6XnuOOCy0ACFkAFN5kaQcJL2piDCGj2ZzytorvCdPBNSH
         ZBIv3wfjfqBQGpUZXqX3ItjTssrzNOZSJx1NLwI1FYigj8g/1qK1VoFVpK+SO4CgfHHc
         hQIxwyTnw+s7iBUxCaWhW8W/FmGeQgkUFnIG5g19NWMx+ISy8eXAWC/tPQ+JM+H7sYSs
         hqGJJylDuoQBoXkeRO8uZ7H5hQJ3QNowaQ2OPMk1xVRZj7BR/gsz3NVOEHlYsJZQouzy
         /Lww==
X-Gm-Message-State: ANoB5pmmlDbCKgyVosvRpXHWxGAshH5Ir27szqjEN4H3t9JW0Lv/+o4M
        4mW/MvbQGosnYnKW6LTfiFfvfRwC/je1tOELpEq9gpXlffa8
X-Google-Smtp-Source: AA0mqf6tz6DazWUy2GRuQA9AwpmCJb4FZk/kmuMMYIW9wvuNSUfDuyejQaj8Fcjn4t5bJPKZEJPaEbx/6kZvUx/EcKyZ0mzEOHx7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d83:b0:375:8feb:71ae with SMTP id
 ci3-20020a0566383d8300b003758feb71aemr10737515jab.79.1669111880723; Tue, 22
 Nov 2022 02:11:20 -0800 (PST)
Date:   Tue, 22 Nov 2022 02:11:20 -0800
In-Reply-To: <20221122091648.5301-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdb2d605ee0c64d9@google.com>
Subject: Re: [syzbot] WARNING in notify_change (2)
From:   syzbot <syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com

Tested on:

commit:         eb708140 Linux 6.1-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13043963880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8232c7627e3f923
dashboard link: https://syzkaller.appspot.com/bug?extid=462da39f0667b357c4b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147a9d63880000

Note: testing is done by a robot and is best-effort only.
