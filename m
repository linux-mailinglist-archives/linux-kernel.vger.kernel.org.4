Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BF697B38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBOL5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjBOL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:57:34 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C838006
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:57:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id d73-20020a6bb44c000000b0072805fbd06aso11919858iof.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YrA0X6k+ub77GDUxkXXwi3LzlEaPkZePD+VHVqlZro=;
        b=cs29DLO6VCW2ewekcqn2tKIARu86WaGGbglhkfqZ3NFr04RvAyCXF3ERMSSbGqzE5T
         +Pj9rsm1GgabIo0soiR/dMjC25ybTf/s0+mDWqLImZvGePFUEszR0PQaYVryI/++Z30M
         2vldv9Jk+Ta1X2AMS4aFc8OmlCcjb/FYV6PgzWuoIkzjfC0aXWAl9Wr6K+LC72bqLV4Q
         ls7NhlMC3VV0i3pW9dP7XON1U7EPNrG+EuWgLlHxzDyJ4S+l4/e31dHgt5upw8IdtD+o
         olcY/kB5j5ExMbr+LFDSjeBDbr15FWmikEfqOS+DPzIxj/cjMwOy8K1dwI+N/rP7FDrP
         tLXA==
X-Gm-Message-State: AO0yUKWxPXYY+5cyXK7e9e1SzDDyT7RhQBEJ15+QnGhsc4JhAKY6K1Wh
        o8slvz/+R4fWbItBEbXzvhdUolq/Gm0UVEfnXvYUUwJZn0XU
X-Google-Smtp-Source: AK7set8MkDfCAq6TvEnp8CyJTK0TgcIVYSkaa8iRdFhN0yii+Tm6vm4j5kIp1MH80GnWtob2XSdVneFImaj2hXqQ5TKmInk/tq/G
MIME-Version: 1.0
X-Received: by 2002:a5d:9bd8:0:b0:71e:2d29:aa48 with SMTP id
 d24-20020a5d9bd8000000b0071e2d29aa48mr797488ion.29.1676462245888; Wed, 15 Feb
 2023 03:57:25 -0800 (PST)
Date:   Wed, 15 Feb 2023 03:57:25 -0800
In-Reply-To: <20230215110515.3833-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5488905f4bbc8f7@google.com>
Subject: Re: [syzbot] WARNING in usb_tx_block/usb_submit_urb
From:   syzbot <syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com

Tested on:

commit:         f87b5646 dt-bindings: usb: amlogic,meson-g12a-usb-ctrl..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13c8d577480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d59dd45f9349215
dashboard link: https://syzkaller.appspot.com/bug?extid=355c68b459d1d96c4d06
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113a83d0c80000

Note: testing is done by a robot and is best-effort only.
