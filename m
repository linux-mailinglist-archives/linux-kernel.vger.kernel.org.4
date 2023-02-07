Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390C068D3FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjBGKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjBGKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:24:19 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A216AF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:24:17 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so10392824ild.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIF+JvkNKJLL8G/0ar4zFz8vDXRrpApsOBLnb50Npss=;
        b=mLboc3ISHm/TXOpKpgLhMQ+62+tN3C54o/vmZJsrmPQr3kP0HrkCu/15dE1CdtMVx6
         +A2UqJsi3jqEIZZxbx7YhcUyYBAD8TlRY9l0y4nJc0jrlGkvepAETlPaRu+f1aq9OiWz
         cRhX31eIsEmQIb0amgDfS5wxmIhrdHpNWKI27LFx26Hn116eFmdPdKpJpVm4F6RsmNTq
         uKMStzzoj8/19TeOQC3DC6pgVBYCUq3cM+pvwyRtevS7Ogbtuu/xDKrckOWFyWGmzDOk
         W+fIn1bFxH3lAM+xODEAMQ9qA+eTgeaIwdIPIrhyT0EHfDZHziK/3AK5h6ZaY2HWOwv1
         kh0g==
X-Gm-Message-State: AO0yUKUqrfGcAsTWuMW+tahFXo2K3RUtKpH8YipIkE4HkijzRgvf3S1F
        kR5ja5fM53IUM4R9LmneETQAcLjANhUnKZcvzCvJDv/ihafQ
X-Google-Smtp-Source: AK7set/1SFBKjlvkbOC4n6i/jBjZr/xpR1TkeVLOFHzekbYFZDYinLM/aAq5Wf0sYzoX0FYXqLRrflXx0iILyX6p3VkDXwgWB3A6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c07:b0:313:d260:41ce with SMTP id
 d7-20020a056e020c0700b00313d26041cemr1932121ile.123.1675765457074; Tue, 07
 Feb 2023 02:24:17 -0800 (PST)
Date:   Tue, 07 Feb 2023 02:24:17 -0800
In-Reply-To: <20230207095807.1448-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc4ae05f4198c67@google.com>
Subject: Re: [syzbot] general protection fault in skb_dequeue (3)
From:   syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com

Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=158599df480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8448640b98955cb4
dashboard link: https://syzkaller.appspot.com/bug?extid=a440341a59e3b7142895
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d9b237480000

Note: testing is done by a robot and is best-effort only.
