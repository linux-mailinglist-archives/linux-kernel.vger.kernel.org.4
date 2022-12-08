Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B38647A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLHXe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLHXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:34:23 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709156ACF9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:34:22 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g7-20020a056e021a2700b0030326ba44e4so2579115ile.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enLA9J6ia7e0zA3s8bn36Xnsc9YRoeIDjVYNsPkLy2o=;
        b=S1I+dEqu2Wn5FLaVPzKsk46R1n5sszU7fVvdqmdvzxED2qEa75U+NsEdNOs5xxws7A
         fU7s56gMrAKKiT912VNFcWx4h4WBIl+NS+SbHs9xIH1nN0sprb3wzP0Z9yUVgsbs2uTw
         iyLseUqydRBkLVYLd26DxIuUHvg1sTNvFL+eUHI2bSNoCSbxV2OOMn9TFWpPwENmX7NS
         Bqs9Wz/sqcEXuX9MSjS/+1Y4GYXICC+R5bUSwxACB8rv8pZ/Mn6Vqeuo3XNUIwnxZWlI
         1JkyTv0mSHNelXSiPSnckFF8a8xg+5YEnfPCPWngR4tVE46/j6339yMfP9/+LKPGWbeB
         M3iQ==
X-Gm-Message-State: ANoB5pm7Oggzi7nkwmb/2dUWWZO9Eb8B7gr02fRgN6nJjspPrmborIz/
        /Ezy5oZ/9BRNFZKZxzVihzEl5NG3CrIP8XEDLGN+Fm6YXG2U
X-Google-Smtp-Source: AA0mqf7PamxopZOAzFroBrJsGl/oxCYoaA9SykqyyQp/fWt3Wxjr17wiqPQ3a4ozzQxWvebdU9tQDImJgKFUO0WU0vqMuXDBQUR1
MIME-Version: 1.0
X-Received: by 2002:a02:a117:0:b0:38a:7675:fd26 with SMTP id
 f23-20020a02a117000000b0038a7675fd26mr1757483jag.300.1670542461837; Thu, 08
 Dec 2022 15:34:21 -0800 (PST)
Date:   Thu, 08 Dec 2022 15:34:21 -0800
In-Reply-To: <1805037.1670508559@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000526e305ef597a71@google.com>
Subject: Re: [syzbot] kernel BUG in rxrpc_put_peer
From:   syzbot <syzbot+c22650d2844392afdcfd@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c22650d2844392afdcfd@syzkaller.appspotmail.com

Tested on:

commit:         efb7555b rxrpc: Fix I/O thread stop
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/ afs-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13660d6b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=331c73ac8d6e1cab
dashboard link: https://syzkaller.appspot.com/bug?extid=c22650d2844392afdcfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
