Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A745ED733
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiI1ILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiI1ILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:11:20 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA7672B7D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:11:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x3-20020a056e021ca300b002f855cd264cso6511789ill.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DvNn2FLy2WIHs2DS1R9N1912pokoVazfC3fl6rMzZGk=;
        b=4qc6WTJIdihgOJKMdCLS5GOqoUjKydB2WqHDTjshBPLy9zx0jRc0ohuQGcxH/LrJTJ
         k5Z2Z+JngLo9DN/HvkUB5kSsVVor6Tt7SUUZvJ9ifJe/bnIjoot3mfFTeAapX2M0pW1d
         vhXfAcALtgjfZYQ1NCfuqvgiho/qzO+5hzR6AxIDllSh4WMN2ubI4aSqBsIHDxNjvLYF
         iqw4EoT4qbS0j9k9jFu8gr/b3863zUlCuJuog2OPlQoD3r7WQmLYxhuPgm3XmxinWF7r
         yUNZprw6Bxu0nEpC4YRGvCL6qFZPJW7UQT5l3BWovVyMdlJqEMp4wv6BN+89N03eQkGt
         lFYw==
X-Gm-Message-State: ACrzQf0vkvhIpiz2ZIHbh7PzcBco7wGRu2S2Io5lk6m2bjfqogXWbUhn
        I1C6r+NsFUSBEtoxB0rRt5EuNBfqflrB+SNSHeBUxBEpG4Oq
X-Google-Smtp-Source: AMsMyM7tAv563ZeC3QZ11hR0ENce0UcCkM5t0gslKHTz7bK273P1Va/q8VYOftgCGUAYxqjmH/YxyCNGzknU2WO6D0ZyEe67H3hB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:2f6:a9d2:9a24 with SMTP id
 x5-20020a056e021ca500b002f6a9d29a24mr14844022ill.300.1664352677804; Wed, 28
 Sep 2022 01:11:17 -0700 (PDT)
Date:   Wed, 28 Sep 2022 01:11:17 -0700
In-Reply-To: <20220928075253.2331824-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000243f9205e9b84e58@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_get_ea
From:   syzbot <syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com>
To:     eadaivs@sina.com, eadavis@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com

Tested on:

commit:         e47eb90a Add linux-next specific files for 20220901
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172b636c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7933882276523081
dashboard link: https://syzkaller.appspot.com/bug?extid=c4d950787fd5553287b7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167e7ddf080000

Note: testing is done by a robot and is best-effort only.
