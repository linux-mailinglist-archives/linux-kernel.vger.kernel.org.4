Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07E62C676
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiKPRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiKPRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:36:19 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54F58BC7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:36:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z139-20020a6bc991000000b006dac0d359edso8927950iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIBMIUlEv2vA4/PacwH55R4V2Z07uwQvktbQ5zVwV/4=;
        b=TBO8l4v6eiX8UUE+SipLvp9fYQKIEl9He/wViP1OnLCv5gQInlkzev5pfZKyFLww8c
         9+Aa75aBl20uqczCkrpJbhE7dt1s/19xCTY8nC+4rlJgUbCZuJfV82ROaadFf9VFJYzW
         uH09V2Vm59t/vaakzLXZB7cg9k/KQFp5g7801/gUWl1KtyIkKBMgg3jj0bSoh/bMowRS
         XzYe4YFYz9dGO4S6OjterN00HKgCi8h99HjGIOBAGO/3fLsKNl5FY+yLT7LSqKNi4pq5
         qdQ6VvbhzFRVua7QNSznm15DqBmDeGE92Bgog5n5B8VRDF80RkqYsj7wH7W0xJtsqJaQ
         cx7g==
X-Gm-Message-State: ANoB5pmftoDXUVn98PDOgHzbeaNZ/rolpbqVRw+xL9BLsqpZFJSab9Ie
        QBX4fpCK2fl+daB/d3EiChHWSlL8hwM8qVkIGzKGg9kKsA+0
X-Google-Smtp-Source: AA0mqf6FMdeh0AhnbiI6JMMc+ZTmkb9utBkiT/Cz4NQzF9XqimlvojrqkRJlwNkIbdhbdNtmRoSMxZIT6GQtQ69QSyVjyajKGxRj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1046:b0:2fa:f363:2696 with SMTP id
 p6-20020a056e02104600b002faf3632696mr11532789ilj.174.1668620177656; Wed, 16
 Nov 2022 09:36:17 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:36:17 -0800
In-Reply-To: <206f349d.191969.184808e4f19.Coremail.linma@zju.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4537405ed99e87b@google.com>
Subject: Re: [syzbot] WARNING in nci_send_cmd
From:   syzbot <syzbot+43475bf3cfbd6e41f5b7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, linma@zju.edu.cn,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+43475bf3cfbd6e41f5b7@syzkaller.appspotmail.com

Tested on:

commit:         1c96c97c nfc/nci: fix race with opening and closing
git tree:       https://github.com/f0rm2l1n/linux-fix.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17699f35880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c42faa14acb6dc7f
dashboard link: https://syzkaller.appspot.com/bug?extid=43475bf3cfbd6e41f5b7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
