Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92864529A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLGDmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGDmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:42:22 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD76155AB4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:42:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so8959630ilt.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 19:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZyh3AfUyX94svegFlynysJ+yi96ec/SiSH2LS//Udc=;
        b=DymHN5f+a7DDtsWo86AGrNeTZ4hNjzLWEJer70JnqZDKq/H9N1iMFfN+QsB5AJHMNM
         GDPykOq1pgIFcFyTRjjgpJ3cbMqULri3Lf2Zf7DhUtdCjfdEj/wSBg7SI4u2BS3ckK2c
         GAa38+AKF9csM0ThXXA81BAfr5sDguT63RmpMJCDJpKV7s4yT2F0dSADRm1uaf5TwVHg
         m6eLs8kj7BZCRWHtOVteljy0cEEIHnrOa2WvH8nPbSckbhYuvkp/sJkTUuGuttIn/m/H
         XHSdC9bJ4xUzKbpY62JvOlPHKyG5fkuF3R1lPwZ+ZIlpMQxGHTBdVDazft30QSTcr8Z1
         vTJQ==
X-Gm-Message-State: ANoB5pnlYJmYj6NHdC7nsrdGLYwvgbiHolHTVF1Gn21h+lV7Hb+sENlG
        mSQn/DlCFFv4oiUvjBrm954ZQxKeeiadtJwuTLfDdsZHSomg
X-Google-Smtp-Source: AA0mqf7niVu5EpbhUn/1Je/UK0nO1DNcwzpiWsG9J6hwqLdZLf+BlCGsbOHS/GQ/thV7alWkF9ivDLoX4CwgGGi5dfjui2a0G6MI
MIME-Version: 1.0
X-Received: by 2002:a5d:971a:0:b0:6d5:2f6e:834 with SMTP id
 h26-20020a5d971a000000b006d52f6e0834mr41394099iol.181.1670384540907; Tue, 06
 Dec 2022 19:42:20 -0800 (PST)
Date:   Tue, 06 Dec 2022 19:42:20 -0800
In-Reply-To: <20221207030740.7663-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033009b05ef34b511@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_lookup_local
From:   syzbot <syzbot+3538a6a72efa8b059c38@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+3538a6a72efa8b059c38@syzkaller.appspotmail.com

Tested on:

commit:         c9f8d736 net: mtk_eth_soc: enable flow offload support..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1205f597880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c608c21151db14f2
dashboard link: https://syzkaller.appspot.com/bug?extid=3538a6a72efa8b059c38
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c7a51d880000

Note: testing is done by a robot and is best-effort only.
