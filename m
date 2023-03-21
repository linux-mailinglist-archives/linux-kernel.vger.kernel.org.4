Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA356C2A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCUGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCUGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:42:30 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F034DBE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:42:27 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w4-20020a5d9604000000b0074d326b26bcso7290181iol.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9h9oIu852GTd1FYS+q5c9exAvd3RycGNvbw7deN4KCs=;
        b=ofkB3JP8YEGlijnQrWCL+f9QWNESejwYLNodghSGO3WEAuUWHCAAIyIGMGZXyYK2WA
         QCqx3tK58KKW9Cn8iFQ11bZMWBscvKgHim7aiI2ftwAHXTuNz/R3e0611IUV554YE3DV
         haLJ3/W5DQWFQiuWXg8K7tJDNn7BrPwTxyYJSPDagaZ0l6PHy3c6yFBPLz/7OvVq/yI8
         RtUrRD0RCbXHv4O0AZFv2vI3/+pvD+NG8ogl03NuAUhemrAMGVc4qx/65ImhAEozhKbW
         BJSO5jgqgu4xmq0aav2399V1J9pvD+hAmEginCUzwrLs7tMsrd3H2DG+gfaCXBi9vxiV
         gkkg==
X-Gm-Message-State: AO0yUKUJbWZUNsDjSNoUyTQS1puvOlIQKZTkuJWR0SXshLU7AC984erp
        U/nwC9r5vmMA4I6H2EDgyLsJ5K385fiP+q5sfvOzOmQ5m3pv
X-Google-Smtp-Source: AK7set9lo+DmHQZcNasJ1b6VRdYjKfGFKirS9fy3mu5+KTDWnmWHTDlMjh2Iaxs6Da7FyRSxZZ/tmaW/hXmrvk8yGW0OUj5mCEUn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:88e:b0:310:a24c:4231 with SMTP id
 z14-20020a056e02088e00b00310a24c4231mr496897ils.6.1679380946775; Mon, 20 Mar
 2023 23:42:26 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:42:26 -0700
In-Reply-To: <20230321061905.2368-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6738e05f76358c7@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
From:   syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com

Tested on:

commit:         6f72958a Add linux-next specific files for 20230316
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1719c87ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd64232230d3a0d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e6dab35a08df7f7aa260
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178213a6c80000

Note: testing is done by a robot and is best-effort only.
