Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8AE6BBDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjCOT7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCOT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:59:32 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69F15C87
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:59:31 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id w8-20020a92db48000000b00322124084f3so10309501ilq.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678910370;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fkZBsQnQsPMHFjuCax8E+9PdzPaJ0fVJSl3B/XiDi4=;
        b=wA4KPMcTafvX3rz4UsGCCEJnPOqnDBcnqsU5LGxf43oPMffsJJnD7pDN1i3xiqytEW
         CDJWT9hKfPYqRoPZbH4USc2HGkR5cZnsYgyvtQkqeCWH2sa3ykvK4OD8e864ioV1lVNe
         yw87G0FEbMKNq3B/WCVxkA7RYU7ZOakCukfHL1Wj2oNf4kzW21Qnyi3O7sfllW2ovTft
         +SbOTdzH87b+z0av7/xa7g0CknRbf3vjMflKNMGo+46M8+cLOWjsEYXi8h0TRBpwGjBV
         81klieSFHorpMo4lsmWGL5LnzS7Ks45Cr8IYgCGGTM1seoMLm8mnDQNSXcIOiD3xpLEv
         29Dw==
X-Gm-Message-State: AO0yUKWV1YzDUjWsJV4857Xf56d/VrowcJDZIY04PX2sp2BIYPZuny5W
        LoskLBUJy5/UABAtKgI7Hdc0EWUovZY1iP6vSl4e5yrDPyqt
X-Google-Smtp-Source: AK7set+S0MaWIAa2y4YQnpaRrDpAFV+J3szFnDvOl9MfMxZvAtJruVS2OKvj2XNbMJaeGCEJS2wJvW56ImFjJGHPK5mrh87PQ90W
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:106c:b0:316:a9c6:c486 with SMTP id
 q12-20020a056e02106c00b00316a9c6c486mr3814441ilj.3.1678910370545; Wed, 15 Mar
 2023 12:59:30 -0700 (PDT)
Date:   Wed, 15 Mar 2023 12:59:30 -0700
In-Reply-To: <20230315193335.7doao26b2u3lzvq3@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f071105f6f5c8a2@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_wmi_ctrl_rx
From:   syzbot <syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com

Tested on:

commit:         34add094 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=167ddd34c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76a9330669c37355
dashboard link: https://syzkaller.appspot.com/bug?extid=f2cb6e0ffdb961921e4d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120bdbdcc80000

Note: testing is done by a robot and is best-effort only.
