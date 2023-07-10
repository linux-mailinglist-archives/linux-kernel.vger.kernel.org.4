Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586C74D83D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGJNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGJNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:55:29 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E19D8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:55:24 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55b523cf593so5374594a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688997324; x=1691589324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpwhQd3GGiIa95tLOXG8ZVAku5Ce3TSm0qkPW2KzBFA=;
        b=RETqwvCfgjnx+KL7bw2Fw1VFTof4tR05cdOVLhnLC8cOV5N+gQOqih4raapVrIk1Mz
         G1RuCg2YHcXIYgBYCmN3PF+hYC4S/gLRfi/ryfb+NsdnHcPMQbypxFmi31NTxGR7Ii63
         4gSPiKygxwksNnrxu41PffkEDHn6irXwvdQ0p6tmtVik38r8QVB2et0G7nmRBsrcYdoc
         DcFvZ53/7mcY6bf/vwkBhToWkdEsDM8xRaoMUhYJKLm2o4rNjRQFJysWT1uLRVPFLhdG
         7pgBzAJdIJ94QJ38LWN0/Np7m7QBNx4N6vMnUr6qCVUIhYtJkHpMO8zJdKGW/2geS9kY
         /+/A==
X-Gm-Message-State: ABy/qLah/DxBIgEhdwEdSKKZXkny9u8j4O5PJourfC4u4tPxXtc4gJGE
        9pc/V/idfbeEQoMOIKdzSeS0EXzb0fKwr9qu/s6pyyZaXe4K
X-Google-Smtp-Source: APBJJlFz7NHOH1K7+W3rAgttP8WvBPJWwpxIUuxyxZHLUnFFJAeEraYSVQTrqdBzVpAh4CzADGviDQUDiQ3AW8c6/1AB6BpqoGmQ
MIME-Version: 1.0
X-Received: by 2002:a17:90a:4301:b0:25f:612:b17e with SMTP id
 q1-20020a17090a430100b0025f0612b17emr9913196pjg.7.1688997324358; Mon, 10 Jul
 2023 06:55:24 -0700 (PDT)
Date:   Mon, 10 Jul 2023 06:55:24 -0700
In-Reply-To: <20230710133521.621-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b8cd00600225531@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-out-of-bounds Read in shrink_folio_list
From:   syzbot <syzbot+c19a171264b968bf389b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c19a171264b968bf389b@syzkaller.appspotmail.com

Tested on:

commit:         123212f5 Add linux-next specific files for 20230707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=150bf612a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=c19a171264b968bf389b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1204a004a80000

Note: testing is done by a robot and is best-effort only.
