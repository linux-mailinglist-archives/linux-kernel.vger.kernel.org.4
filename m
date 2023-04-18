Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98386E5DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjDRJpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjDRJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:44:39 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9307EE2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:44:27 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32b532ee15bso40429605ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811067; x=1684403067;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHfJZwvrmg+gCW9psW/lopSjTm5+PKBoNst03YMYF1k=;
        b=ezliz0unkQYrTF+M6idr/9dQrTi5sm+6JmW2PjXu2twIUBMFxXOwNkVCMMQUCs6gSi
         0RnDLalye8iC1azPFaLHXBEQRiBQxjRX28959Hv9MYg8tQhmOw7a0rprVGjrf/CQQmf0
         2HgCjE+ngrprealWEuxvpLbr139R2nTLUGIRjImhxEgQjikBtFGeHWsGjJNN34HTwFFS
         PwtL81vXbhszJtzPRUhkj9GGK30u0//N0EYEs/A8KvUPiIfOVBM5b8J/fu7qioEwbCBR
         xlS/yRJ2+ECfs8CqmTxBWdC9ST5yBEQcnFaIEJ1BUc4ifVqaEKgM3HtChFJPsKDj+6M1
         1g2A==
X-Gm-Message-State: AAQBX9cm+A9wAeS1Peb4wnpUtC0KsfbK+XKinLMWqExOACcmgLl1pzxC
        2v9hY3l8EQVuwo6T0xn1hKUzRMhmYWkQRjp96hlUKhoExT1x
X-Google-Smtp-Source: AKy350Z37i3+T7LZ5GhdT/rbZ3tH7qJhbKjDZ2cO2TECPZ+LeTXQ7YuHtNRD3I3fQfAuGUv1Umht6tbqpUKzN0udzYu4IcLQGqTd
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2352:b0:760:ea29:2594 with SMTP id
 r18-20020a056602235200b00760ea292594mr1842841iot.0.1681811066896; Tue, 18 Apr
 2023 02:44:26 -0700 (PDT)
Date:   Tue, 18 Apr 2023 02:44:26 -0700
In-Reply-To: <20230418092148.1294-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038ca8205f9992718@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in mini_qdisc_pair_swap
From:   syzbot <syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com

Tested on:

commit:         fff5a5e7 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1658d89fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=b53a9c0d1ea4ad62da8b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d7cd5bc80000

Note: testing is done by a robot and is best-effort only.
