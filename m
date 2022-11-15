Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866962964A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiKOKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbiKOKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:50:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79322656F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:24 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so11064122ilt.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZnV+6NbxuXULt+sWB2/L/gIqBRC0Y69Y3IvhVemV88=;
        b=tB06cX/0gcz+ddL+aQvdmAYk/HrOdNaUXXs9aCIzNAiffNEEyhpUM98IVZv1uqqL3h
         TJZQyx0lcZ1ble+xnaFus4D2mchcH88W6LqrAD8/Wxhh4cjrmjqS4Ymq7tFfgF6Naeil
         h7sRULjef6WLh/SzDOTRN3kk43MhCny4RKw4eY4Vv3W5ga8CwvRoj3Ma/olB9v/pkvaZ
         Y8j4u1KSRKFBFEMvGteP/VzQ1DnHuxO2RWEtu8lsvMIpj0JvxSa+Ck3HzfwCuludLkNW
         3LDXiiVJw0+8ybiDGsgamZXYNgTE47gida623Jryd5JJJkLJAYjZXwu6wz8gofxy22mB
         IuuQ==
X-Gm-Message-State: ANoB5pmyxewmlSVmmo6pU/Cb0T76EN8l6ok5B48XXLBK+ruXpEwC1At/
        M3IGI2RsPdHAi85yMCDcuoJ3XpXLGsXmlVv5TJkq/kCOvWyS
X-Google-Smtp-Source: AA0mqf7Uk0nm6MGg3DxTPRsqQB2Vgk1MkB8TGN0bFjC8ukRgDTUX41BoEb0No4lkbp960fc/0KZ7z8WOgpInvTqKZZW7+4rfkAkV
MIME-Version: 1.0
X-Received: by 2002:a92:8711:0:b0:2f8:f87a:d23d with SMTP id
 m17-20020a928711000000b002f8f87ad23dmr8224989ild.130.1668509424317; Tue, 15
 Nov 2022 02:50:24 -0800 (PST)
Date:   Tue, 15 Nov 2022 02:50:24 -0800
In-Reply-To: <20221115102048.2433-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a7b4c05ed801fc3@google.com>
Subject: Re: [syzbot] possible deadlock in virtual_nci_close
From:   syzbot <syzbot+8040d16d30c215f821de@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+8040d16d30c215f821de@syzkaller.appspotmail.com

Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=120ddf69880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9aff35d9bd592994
dashboard link: https://syzkaller.appspot.com/bug?extid=8040d16d30c215f821de
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11685d35880000

Note: testing is done by a robot and is best-effort only.
