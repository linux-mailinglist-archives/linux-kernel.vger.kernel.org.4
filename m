Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22710641516
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 09:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiLCI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 03:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 03:56:22 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166017A8F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 00:56:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so7736115ilt.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 00:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcyjPB81zGm9SycAzhpq19eSK8XNfTUuWPLCo9jTXOo=;
        b=EozDWFD5kma6hkkb7E/lmBrdc7L1pIR0E6x5h+RxtG2j9ZaPuUYUPfKZgF9Udk/LS0
         PtPFssmoQJeC10EZB4RZ/TAq9wds1JZb6/HcvUOpdaEB+WzYSdkWWPGCcOUBBEd4eVJ1
         XJjFGyq18pCDkIrAZhRz8Z1rEqTAsE6FbGBoPA6JpAsWOWtx6R162Vu138VSvQGmWxl+
         ts6jYz9ltGddpVyCu90+Q5HEeCAjRphbkrMsQwyc5jVxD9L9Zeamgqqf2P3a++bW9HW6
         VgomA8tQ0EJK2j2mfVMSf6BF0FU0Q4aXNqWJQtkTTPnm6AaCFogjFmJlqnk2GbLdWO7/
         U18A==
X-Gm-Message-State: ANoB5pniwbqB3qYFCDDnSF9Aa0fOcYrsDxmMC7Lj/1goGEKjw3BuDgoI
        0c9h+WY+evHdJBPaDWllyvDeiOIrL23LJIxHH5ryMAUZugCG
X-Google-Smtp-Source: AA0mqf6WcDLhHKV2fO6vLjfzSe+rvmOHlyUrxNUQEUjHvuyYVTsn7kGUuc2grvJ/vXUla1/qhQK0JqML/bLr339SYydWfAc6F32N
MIME-Version: 1.0
X-Received: by 2002:a02:cc12:0:b0:386:3792:8569 with SMTP id
 n18-20020a02cc12000000b0038637928569mr25058442jap.76.1670057779612; Sat, 03
 Dec 2022 00:56:19 -0800 (PST)
Date:   Sat, 03 Dec 2022 00:56:19 -0800
In-Reply-To: <20221203074851.7040-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5532b05eee8a043@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+893c55305230e719a203@syzkaller.appspotmail.com

Tested on:

commit:         a4412fdd error-injection: Add prompt for function erro..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152efe6b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105f3bad880000

Note: testing is done by a robot and is best-effort only.
