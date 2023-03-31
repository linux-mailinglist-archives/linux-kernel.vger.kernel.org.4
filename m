Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22A6D1BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCaJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCaJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:18:36 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699BBBA9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:18:26 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso8519951ile.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680254306; x=1682846306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmPcbqpaBJuvNK1Czq9g2eMVy/Cwz4Fq0JVRSI4nfIA=;
        b=HpowEzAD07xtYRtTJf4grAm9qi5iA8nmKIG3yV9XIMN//+NTYYlpVH/BAOE07NDCJD
         UzXn2srtOpXGvTcsRUdPNLIjU5KoUAFu+4xzsdr/VLwCVp4hQ61OOZT2DRzAIT/Kn6Vp
         Oj+S830YNRA0xtADGcegf+0ilZuydZ6KmLQfiaLN7WWZL9T5nrBShj4nSRUFbW4mNNyZ
         WelvgHafEUITEbM7UaWGLZkvwyXn99doUAHoMcO4gOCgURjA80kzCiHmX57nb+WJyEWx
         YeQk5aJYvXdRhpybXsR1ke9s9xfcom9FOrtp6s77hPLo2JTkliWiI1Ljyhc1clpctBpZ
         oIZg==
X-Gm-Message-State: AO0yUKWy5ntzaza2mQ4pBU3D83Fh+s//8QJ9bWXoi4RnL93M8LhL2T9j
        zSS7eStyFBP5fU7yl/+NjJtCrJOalpl3vbkUftl2Pqga41Fg
X-Google-Smtp-Source: AK7set/QLdgAarrLtOVaNockUiDJV7M4nNHvoEvhB8pN5XDMgyMIGSDnvj2btvpXLlZVqJAvpfq51QTjO7+6BT5AGgCRF2a0xZkL
MIME-Version: 1.0
X-Received: by 2002:a02:95c3:0:b0:406:2cd0:a668 with SMTP id
 b61-20020a0295c3000000b004062cd0a668mr10655867jai.2.1680254306200; Fri, 31
 Mar 2023 02:18:26 -0700 (PDT)
Date:   Fri, 31 Mar 2023 02:18:26 -0700
In-Reply-To: <20230331084907.3220-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000db75105f82eb1b7@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_dlc_exists
From:   syzbot <syzbot+b69a625d06e8ece26415@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+b69a625d06e8ece26415@syzkaller.appspotmail.com

Tested on:

commit:         a6d9e303 Add linux-next specific files for 20230330
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134609cdc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133a6835c80000

Note: testing is done by a robot and is best-effort only.
