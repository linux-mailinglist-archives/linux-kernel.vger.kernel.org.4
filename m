Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC34731DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFOQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFOQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:29:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F02944
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:29:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76998d984b0so940583839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686846572; x=1689438572;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFlp6dTsaA6DhlunBCFuGZl4rO+rbbI1YI66BI+ayy0=;
        b=AEjKLBHrVEYCM+odx7akHk6h00k3xHliozb0k9vu+J/2t1SxRPWIfxl0F67JCMzfJh
         oyqjC5BbvMBG+SezRL10gIwYCOAMoUZ8sVntfG/zoHfamDPonYLmVomhD7hYk/hy05Sr
         FV/Iu9EP1BN29JIBQLWzTF48BULJ8YGqOmCHlNgPge/gbxhsV8wjjPbFKp7uQGpm1YeJ
         v23SdzqG13q1YGdooQahKItEpX0FgCl+Um57j5FOjBLMzasLZxSuPKUjO9CudpMDR8Ov
         C8JVscyKWkI7MBsaICh+zBwddX8qRyLfcGNiKDFQLYEQccsJGB68iJCab8zOoFg1pkBS
         2kFg==
X-Gm-Message-State: AC+VfDyrOC068Js8F1O6D2t2W3gw9TOM6WN1gt9+Vhjp9zYPgziTJy+a
        KYZLtLZMuMne5y9A8XTFtFOXl8WQ2HTPE6obIWUCJdICy78R
X-Google-Smtp-Source: ACHHUZ6BC1oLFaizK+dPrbWHixBXw11XLiRKPCBpLu1/NFHfMT6V5NocQP4Kg1nqUcfAa7Xz2d73qx3Bzsyo96gJOv+WQdcRn/nP
MIME-Version: 1.0
X-Received: by 2002:a02:7318:0:b0:423:19cd:69b8 with SMTP id
 y24-20020a027318000000b0042319cd69b8mr510226jab.0.1686846572347; Thu, 15 Jun
 2023 09:29:32 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:29:32 -0700
In-Reply-To: <256755.1686844894@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc6a1705fe2d92c1@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in extract_iter_to_sg
From:   syzbot <syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com

Tested on:

commit:         97c5209b leds: trigger: netdev: uninitialized variable..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1258baf7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=6efc50cc1f8d718d6cb7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c65e17280000

Note: testing is done by a robot and is best-effort only.
