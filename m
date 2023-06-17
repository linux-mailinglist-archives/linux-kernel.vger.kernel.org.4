Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D0734179
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjFQNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFQNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:48:34 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D7699
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:48:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3420c84e530so11847825ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687009712; x=1689601712;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ad5CvYu120Tnp8p6CoLp65bBEG4gIpvPDCK1drkPXU=;
        b=ko/qrOe2qIvrqpKTdWYsFGrIbpHIUMafg3sh+JvAGwtyOMBz0RDuspH1CFghheHuf0
         IRn37VH1wV4slMzjx4kESNafB4/jRwyIE6fSlO1rcWIsSYqkXLCyiDb1kmB1jyHaCzgd
         5IajW1YXTFUpzeXS6IY7RHwwYcyqtyEkPtFJK43pPNTGbj+xr8CFhTZ0WwdiU4x1+F7B
         VYwRt59VCgKDAmBT2vXgo2Sn8iM805BZlMD8bhprXWl/UYK27E0hfdwgdCc1Qm5nxhY0
         0DonzpuWNbJfiEvcSYjE2JZtzdfiA4+Qr0L8vJ8Hc0d8SAbQjnxhzyerMxKs+ow2ya1d
         DpJA==
X-Gm-Message-State: AC+VfDyacT+WcR0w6bAnaq8S3UCAm32s2waif3LmG9nveVpKm/fPrhvs
        GSTwznnNwRVPL6n/tf7/81h50A36YjLUQ9DPTtu0XWpR3uRU
X-Google-Smtp-Source: ACHHUZ5foKX5PPdxdDJ+kmslsPGGGXODYHvWZhwRSOoC+lojtF21Llk+nkSG32HQpWqs9ce/idTN5i15IvPjSSOLl7pDBtxRaGRG
MIME-Version: 1.0
X-Received: by 2002:a92:603:0:b0:340:c135:a371 with SMTP id
 x3-20020a920603000000b00340c135a371mr1245231ilg.1.1687009711999; Sat, 17 Jun
 2023 06:48:31 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:48:31 -0700
In-Reply-To: <20230617130908.1093-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dd46005fe538e4e@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in __hci_cmd_sync_sk
From:   syzbot <syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com

Tested on:

commit:         1f6ce839 Add linux-next specific files for 20230613
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc9373280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=c715e1bd8dfbcb1ab176
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e6e45b280000

Note: testing is done by a robot and is best-effort only.
