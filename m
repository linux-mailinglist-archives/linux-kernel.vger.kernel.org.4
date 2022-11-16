Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87A662C639
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiKPRUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbiKPRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:20:30 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD405EF8D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:20:15 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso9140665ioo.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb6JgNO9UwvO6T96I5ntpLoGn2uQNzwI00GFZ0JLE1I=;
        b=jChRjMBqMux912tu4B+gj1f9Dr/Am2zu2M8WaOTHHasRo4NLvGF7Zkgz58D1/wSVyn
         8+9dZGHvdA4phCyAOqTDb/30YIuIlnDGTgzm6ddGiGNNu+r63VDiRInVzuZzf4kl6bI7
         cnFC5SVKHA0+SmgAaeXHgGrgkbf58E9ldxZmNlONHIT03w8TUqiHL9R5jUsUjjVeJhIH
         NEOI1ryP1v8mMfktPy9VBAekQmW/YAMoQ73GerxIS0jszXHnR2pUNzT90M66vhjhw43P
         nyvdrwTo6aFBk06gWlhWCJp9zfTdE/XLbk2lXYr/wTBqP/kshCrCB9ij4XG6XShhPkwz
         uirw==
X-Gm-Message-State: ANoB5pl7fADs1ZZc1w/aAaSmpbttkobAWwVfjFTB823fuxWKpZVsdH7D
        pgOZplTiCk07HDZ2rrt7xwv/XEO69gteE0rQdfMXVdAM593H
X-Google-Smtp-Source: AA0mqf4fJJloLYhlr1l6JXtMihWRs5yUfxAyxt4C1Q5VA+M2rvRM9Y7lafTcRqaznlHNzcAFLgOzsy0P8Ou0dVtTPQEWU4BMQ4OP
MIME-Version: 1.0
X-Received: by 2002:a92:d0d:0:b0:302:392a:8cae with SMTP id
 13-20020a920d0d000000b00302392a8caemr10890725iln.48.1668619215056; Wed, 16
 Nov 2022 09:20:15 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:20:15 -0800
In-Reply-To: <20221116123853.3375-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094399905ed99af8b@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in nci_cmd_timer
From:   syzbot <syzbot+10257d01dd285b15170a@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+10257d01dd285b15170a@syzkaller.appspotmail.com

Tested on:

commit:         9500fc6e Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15daabc1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=10257d01dd285b15170a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14919b11880000

Note: testing is done by a robot and is best-effort only.
