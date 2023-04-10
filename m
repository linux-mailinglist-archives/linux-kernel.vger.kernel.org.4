Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6976DC952
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjDJQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDJQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:31:27 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603710C2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:31:26 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i25-20020a056e021d1900b00316f1737173so4406197ila.16
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681144285; x=1683736285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ7f0MxXzRw0b31CctDQOgXS/USnJPA6EoKjXSbeF1s=;
        b=ohUeJHqHLljtqJVJ+Xz2SWVcmFoDBVGwvCBhCI8pyFCYZab+ph9r3PlDczVTARTnVQ
         q+qU25xQJt0owIeLP6wuG9M981Tv9wt6WtpktMb3CLG9PM2HhOke6thzhKi817moqcT4
         tDn4skM5JKcmorpoA3Ok5J3wh2+0/Kga7ZQgrQfoH2kVLVQfzedCGCYwZlXfbRf6tLg5
         UlKtDTe8hSNmPMCXeW87pyvCxLfFxZXDJlPsXssm/cyCoYPte3Ao41almuA0FGmvqFYL
         +2x1mSRCI8XMu2LjEke7HDFIi+WbPa157tMfBzikHHylVnuV0Fc9QIrCZG2J4aCDO9Zr
         NWoA==
X-Gm-Message-State: AAQBX9cBc4lGvf5/ohZNJcvuLoyTLl/lMGCvNVRI0VKsDEoaLalW9Owx
        i17uhHHIciY6fj2xREeBQO2G+9JOFxR7KNVQq5SVm8dm2rXvNIk=
X-Google-Smtp-Source: AKy350aSowdPVChQCOaWJkDGxMdKt7N3l0jHFa+RsNf1n6/+1g8SCBUcKm9rjH9myUSRTs+qI3T7FRZxzUkNZjfPZBkZHNVipfNq
MIME-Version: 1.0
X-Received: by 2002:a02:b105:0:b0:40b:d1a2:c058 with SMTP id
 r5-20020a02b105000000b0040bd1a2c058mr978048jah.2.1681144285698; Mon, 10 Apr
 2023 09:31:25 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:31:25 -0700
In-Reply-To: <1d74e8db-682e-4d9a-af69-3ec56835021e@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f727df05f8fde7e5@google.com>
Subject: Re: [syzbot] [usb?] WARNING in sisusb_send_bulk_msg/usb_submit_urb
From:   syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, thomas@winischhofer.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com

Tested on:

commit:         c9c3395d Linux 6.2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2
console output: https://syzkaller.appspot.com/x/log.txt?x=13c2c303c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b64e70ff2a55d53
dashboard link: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14649cc3c80000

Note: testing is done by a robot and is best-effort only.
