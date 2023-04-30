Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14116F2760
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 04:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjD3Cn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 22:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD3CnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 22:43:25 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25C19BF
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:43:24 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760eead6a4aso70510439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682822604; x=1685414604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHyqiYshGATJqd+nvOc8o3zWkjOstzf+D/pKrldpisU=;
        b=cXj68oV0l6yDzPEfP9HRRnrYG4ktmMwko9ElV7WZoBL42t5a7dG0kq1a4eL/mc2FKH
         0TX3A82uLsBK2YV7OLwfLiNXnPSPmUTMdWvG1pIXSrCWHTEMzW/m05lOZgLI5FagZXTp
         8bD/xs9QncYREPnuWdut7dwkwqJwakLSZx2MBvX5VlSYVsCoNt5dT1lqIpoEoGT53Xig
         Whl6A9ov3pn6grR+8LNKQRJPSIT6PP+omHvV0nW8ZQrflEJ2mJJ7R7tLnTKtyCIC4NNV
         PFwKUUkH3w1B9++fGNsRubnCNXnIdZsfwPDhEztQr1LVYwYt7neSuzKAfE/C2D/K7h4m
         lgvA==
X-Gm-Message-State: AC+VfDys/LqddGq8gmaLtQdpEz/QThDIYlGem/bRJB4csAAGMBaqDcpR
        lFhJCYhKviVb38AZG8xM5I5OiDBfSeuDiikeqHu3M62BEGyx
X-Google-Smtp-Source: ACHHUZ6evyzRwmJE2gtwEIVQij+x3tGT2m7zymCxJOcc7onqVpht+dBqd0zOtyaE1pSrxQUBIsq1yuIgdnKLsEfkdzVpdhru4tyI
MIME-Version: 1.0
X-Received: by 2002:a6b:7601:0:b0:762:f8d4:6f2 with SMTP id
 g1-20020a6b7601000000b00762f8d406f2mr4445063iom.2.1682822603919; Sat, 29 Apr
 2023 19:43:23 -0700 (PDT)
Date:   Sat, 29 Apr 2023 19:43:23 -0700
In-Reply-To: <20230430014527.3017-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086d97a05fa84ab33@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in xpad_probe
From:   syzbot <syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com

Tested on:

commit:         92e815cf Add linux-next specific files for 20230428
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17eb28f8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8c8ae4d47d23592
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f758b8d8cb7e49afec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1578fdf0280000

Note: testing is done by a robot and is best-effort only.
