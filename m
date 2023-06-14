Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0961730ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjFNWmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjFNWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:42:37 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780C1BF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:42:37 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77ac14e9bc5so789938339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686782556; x=1689374556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE73eWAx50Q9c0pRDTsurXPQzo7ErFkWRWSNLKelXl8=;
        b=lyG617a/FMYvFKgmrqe9PegKll6eC2c83/QnulxhM9Cg2xkl6rYGvaEqhJzsN8otLH
         WeqbwXEick6zGf1/0qdm0R4domwnCKdsHlYOPFQU5tAORMRW2S1YRg3p56lzsBL6uaPS
         oTag6V0OSr0V3lwCDqory/OStKFMwGV8DDTSBtReX+0GcACOM2/9ejfOvIYk1yY2c16k
         zXMZP+TZPeaNopeVb41HNRxJA0Y9h1yfqlLN/XYwOIwKgfpaN7CYuU4Wa6MERWS01RNj
         SjlDW9j7YXg6axJxFuTD6USnIqdzWn6Hr5F39zrbQkK2woJnU38Zp8E9jQb+DgmaPJ8M
         cqKQ==
X-Gm-Message-State: AC+VfDz+t028qIqZrGMZ0kPgfWQmeOxLS/TOcJxFG7kFpJAdI7nsUd2S
        ITgSvacxQ2HwJZGhUO+eBV0++iZPZkSWlpHcwqqA5XoBPab6
X-Google-Smtp-Source: ACHHUZ5d+qMhMNOUFWZyzwX1QZfMj8e4pEaKvgbexuUfTL0QemYLd2k78ajcnQjdBEvahD4oj+jPD0jc4iq5zak1PLa3SgeT60kY
MIME-Version: 1.0
X-Received: by 2002:a5e:880a:0:b0:76c:7d48:d798 with SMTP id
 l10-20020a5e880a000000b0076c7d48d798mr6300645ioj.0.1686782556283; Wed, 14 Jun
 2023 15:42:36 -0700 (PDT)
Date:   Wed, 14 Jun 2023 15:42:36 -0700
In-Reply-To: <1604628.1686754446@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014bf4b05fe1eabfe@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
From:   syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=12ae3673280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=e79818f5c12416aba9de
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172d9e8b280000

Note: testing is done by a robot and is best-effort only.
