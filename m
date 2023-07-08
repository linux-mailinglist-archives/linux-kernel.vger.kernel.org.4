Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6874BBE0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjGHFAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:00:39 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321C1BC3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:00:37 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55bf5cd4fb8so2840714a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 22:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688792437; x=1691384437;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZNILPFcs3TJOMuepnacYUvmOKZrUyYf04IPeSreRsc=;
        b=YjaVAt6q+hjAiRTv2jcYD1x43/3J9cWU94tE6M3FoDoQqrs/PZzt28/JUw8+hUiJ/F
         A81SZlyS/+5o5/kn7F83cbSUpG3uGnPMk5kT0hObEZM4kFyhyC1837IyAsPb7sEmG6s4
         fIn0BzlbRXcrvetamvGjKaFUqCKuvWItkmovyB9xFHYbK3CPvBxqaise4DpNdeiUk68o
         DdY3Kd92oAAbmfUab5NXu+t2bibFsvvUeCnB/15lzxGOiI77yPG0JXFYSef5Fzt+zYSO
         aseMxCz7+xhDqvT6tRnzA9OcXWTT0H5psT84uoQo/70GispOo8LKx001ydwo4DJpQVDK
         /wkA==
X-Gm-Message-State: ABy/qLZ4frmyl7VLuVs/omnq6ZUV6mwtyT+C+9ocv7SRUygP16DfhMXO
        X7tyy9HqD/2IXt9lT2DQq8BDqeIEE9ASi2FEbgZwk+gUZeWg
X-Google-Smtp-Source: APBJJlFjEfpshaCuUBT/LVegrYYDuDPvY/GqGU6YmI0Ny75dbpOmxAIYAkGvZKn67MbDCRlirCLmJaiFMrbsKhhKp8NSMo+eS832
MIME-Version: 1.0
X-Received: by 2002:a63:9316:0:b0:53f:f32b:1f20 with SMTP id
 b22-20020a639316000000b0053ff32b1f20mr4868089pge.2.1688792437384; Fri, 07 Jul
 2023 22:00:37 -0700 (PDT)
Date:   Fri, 07 Jul 2023 22:00:37 -0700
In-Reply-To: <20230708040910.1547-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000546c9c05fff2a178@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From:   syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com

Tested on:

commit:         296d53d8 Add linux-next specific files for 20230703
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15368de2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5241eb40bbf2c7cf
dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f7258ca80000

Note: testing is done by a robot and is best-effort only.
