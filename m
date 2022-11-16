Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA862B330
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiKPGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiKPGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:22:16 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2F15FE6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:22:15 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso8315709iot.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2p9atn487j+G8I10QWpWVsUr+oAxo+WI7t+OE8oQ4k=;
        b=vel36YZvzB+76I/SinFmXQl46s23q2G53XP+35+wbxd+uKmp00+D3BoezTSjnVWnvp
         81k2lG5XcMvIsukqLtu4DYbnEjCrt2PXYMRX8mxVsOEvddxdmagIDg+63ZkxNeayyjP5
         SiWcCktGnyvjYQFxFnWQpCv3D0NW/FqPnLvq5O5UNnunigZJYJB/lWA9rBZsjUDcvli7
         EJOotbvoQzpBfrh49Wi/bBK1udw2ovaem61zHQdQo92Q3vi3vI8sBFd7WEhMrt7CLAku
         TgROSqoMZ0wy2D8+FlkpF61fYRq7o6bOXwZVCbzIMdz901br82ZRfE1C3kzWWvcl3+/l
         iS+Q==
X-Gm-Message-State: ANoB5pm1N0Y53V2Lov/KAYEujbPEm2wlSTuRrqwbhd/br4rDlXY9mp0Y
        r6pU5aBSfdn3QBn+bga+PZXMNJ45Tyk9DhjKB2n6qrSy5Eog
X-Google-Smtp-Source: AA0mqf4/x3zEi1OElML4e2ZjKdH97lcWwCrfpc57NsXDkRk0yNEWlUb/4xXiHunQIvoXN1SSjWvj0e+y6YB8dalbAWxYP4Q7qOlU
MIME-Version: 1.0
X-Received: by 2002:a92:c9ca:0:b0:302:501a:a25d with SMTP id
 k10-20020a92c9ca000000b00302501aa25dmr7623839ilq.311.1668579734733; Tue, 15
 Nov 2022 22:22:14 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:22:14 -0800
In-Reply-To: <20221116050320.2937-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e4c6805ed907e70@google.com>
Subject: Re: [syzbot] INFO: task hung in nfc_rfkill_set_block
From:   syzbot <syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com

Tested on:

commit:         9e4ce762 Merge branches 'for-next/acpi', 'for-next/asm..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f00a95880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ffacc1ce1c99b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d75735880000

Note: testing is done by a robot and is best-effort only.
