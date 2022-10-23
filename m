Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF3609109
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 05:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJWDLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 23:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJWDKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 23:10:48 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F664F676
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 20:10:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z5-20020a5e9245000000b006bd430ff7c0so1447036iop.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 20:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzH2cHcO+f+WCmHUnIIJYAxrhsafeAZbtM+Kt6D6xoU=;
        b=ETMnmp7+vhgMJOjT0raUfu/zyn1x2PmwFhKlA1dV0Z41KuXIR3dIwQHycpytVhpkpU
         qiyVJqNmJ2xdPLiWNFcgE279V9fkSpSs7Q+Dx09PE8oOgWpPA6QdxtDtYmSr3HKVRKV8
         l1mkehu6DMM6WGIVnivSMCqIxEx0lNaW9K83D4ERSH3X8vE+9+cdPbeF9WynTozkC5/H
         ltmK3vhXj6FMtYbnK6UhtMnkvoyC05ser+ZpdqLXoSGcKsAQT/+gRDYKLKc80N4wmxBG
         5w3JN5TYNxK3pL+NsmfHOAnVNcLBfQdEhz5PRUAQ53bCOMaI1f6LKcLG44Dj7jSPN6Gb
         Q5eA==
X-Gm-Message-State: ACrzQf3yfunuBqXgtVVlq1YB46g3fBcDytYAU8Wv08GARcDaSoxicSad
        ChB15gxOHP83wE2WymgGi92IgONTY5DlJ2Efj4ENpEySrJOz
X-Google-Smtp-Source: AMsMyM4Wvgq6S71oo6KQVzdnTs8KFKVpft55VGzhAQ23myLoK+PIJvD57JRzTu6CNTq3Eq3dwbY6gx/qREWe++TgeoKaOFaiGTGo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:338a:b0:363:bcaf:1017 with SMTP id
 h10-20020a056638338a00b00363bcaf1017mr18765741jav.176.1666494619795; Sat, 22
 Oct 2022 20:10:19 -0700 (PDT)
Date:   Sat, 22 Oct 2022 20:10:19 -0700
In-Reply-To: <20221023013350.2139-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5452e05ebab0313@google.com>
Subject: Re: [syzbot] general protection fault in skb_queue_tail (3)
From:   syzbot <syzbot+160a7250e255d25725eb@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+160a7250e255d25725eb@syzkaller.appspotmail.com

Tested on:

commit:         aaa11ce2 Add linux-next specific files for 20220923
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1040fe26880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=160a7250e255d25725eb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14aae96a880000

Note: testing is done by a robot and is best-effort only.
