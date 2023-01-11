Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574B46660F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjAKQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjAKQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:50:23 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C97F6B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:50:22 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id u1-20020a5d8181000000b006ee29a8c421so9459167ion.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVlkwIcu/ERIdMF9zXl1iw0QgUBv4pumheJU/b/0NDs=;
        b=a0WAveAnh2cNBOuxqm1SpN4ttnDDaXGUgydLcf2yZN1iP+UBLgq3PVYaTYToLwiGP+
         u50/te/bp5ZTsgCzM5UutEP3LnMX40CP9zBvJIk9NesF7+XuVa9I7wPuXyqN/rVOilOz
         chb6QVq2qUFjmn7yO7OcNlcZTPUXtdyJpH3moKIcijoqLDSoFtX1+xcVuCwGf8z8XLW/
         ZpmSdrtnQ3bata6vtT7b0wiH9b1n4Yq8yqjth0RU5V9K29K1ee1gbz+rGOU7s33H2Yw5
         +dmCJNBaU0rz8Q4vEOXnujysgk/YEMK3EflLzH8IRtScigkznNs3t5jzW+NUaYyaD6HV
         o2Cg==
X-Gm-Message-State: AFqh2krETW5WKro5Njw3C5466sTVJUWRZV9VbLUIvciXMu1BqulKFtIQ
        cumeNTMZ3tafkigS/yu6SVfwzXKPxebw0WitgWLOjgk4u9Hk
X-Google-Smtp-Source: AMrXdXujnSvvkWTnatFl3bt07Qrfr/4g3+DZMb319bEIWyA1L0LGyYfmqDQ3TNiVTo/n48VFRnoT4MotGowevDTm9Ec3f7rhjHlv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c88:b0:303:7518:f784 with SMTP id
 b8-20020a056e020c8800b003037518f784mr5091367ile.295.1673455821594; Wed, 11
 Jan 2023 08:50:21 -0800 (PST)
Date:   Wed, 11 Jan 2023 08:50:21 -0800
In-Reply-To: <2265390.1673430114@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb290605f1ffcbed@google.com>
Subject: Re: [syzbot] kernel BUG in rxrpc_put_call
From:   syzbot <syzbot+4bb6356bb29d6299360e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4bb6356bb29d6299360e@syzkaller.appspotmail.com

Tested on:

commit:         8fed7565 Merge tag 'mlx5-fixes-2023-01-09' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b40d1c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=4bb6356bb29d6299360e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11834e5a480000

Note: testing is done by a robot and is best-effort only.
