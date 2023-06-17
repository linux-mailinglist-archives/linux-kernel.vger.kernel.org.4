Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA61F734128
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjFQNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:17:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4486E10FE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:17:26 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-777a93b3277so166125939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687007845; x=1689599845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcJ/KnjQReOH/j4o3Nadt6pVWnlcUFy9dTdwyMMha2w=;
        b=ad1hPonrxDV9z2oqbc/1JxcGfKYHUp/cUT4Rm1is0k54S6W83+4Eh0GQv5TWz34GkQ
         kPKRA9zsts8l87wWha27Z9YHwNE6zaAWcFgEyh+qjfj/U5LdO+6wFGstyoQJCLZH1J0l
         nkzIjXTjLFweeJRDkSO99BA9oDkZcQUscpN5D7k+6oaccDMs8sq2db0NDlIc9f4GoOUv
         By0FOTenW1jhHfEgnjHIaQHMmXzJuJ464YqH5nkHZ+SCfBjq3NagJPAXiVOUMkC30wfZ
         CSdmnYncMroov3vOdGMOROSDGXXdCBjjTsXt7c1qTd/mwxGwenl7VtNihZB9Dn7fK819
         mUBw==
X-Gm-Message-State: AC+VfDwKjCHguOVel71/1TLVM82fXanhNZj4BlDyTpYA87nJ+2fgynV4
        mz3gO8Ih3u5WACuP+hB1moY01U9a2nflWV7Aiq3x0D7qEpak
X-Google-Smtp-Source: ACHHUZ611xh0AvJBL61OKySA2+A/z6tkmeTnYEC238favVE4IZ8piYbNV6MoNk11wThDdcKDI4jgnJ7yLekXny6xaNUiF6TpTjyn
MIME-Version: 1.0
X-Received: by 2002:a92:ab07:0:b0:342:372e:7901 with SMTP id
 v7-20020a92ab07000000b00342372e7901mr262268ilh.6.1687007845656; Sat, 17 Jun
 2023 06:17:25 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:17:25 -0700
In-Reply-To: <20230617125728.1034-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fb31a05fe531f05@google.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (3)
From:   syzbot <syzbot+04625c80899f4555de39@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+04625c80899f4555de39@syzkaller.appspotmail.com

Tested on:

commit:         f7efed9f Add linux-next specific files for 20230616
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10494c37280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=04625c80899f4555de39
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1067f2cf280000

Note: testing is done by a robot and is best-effort only.
