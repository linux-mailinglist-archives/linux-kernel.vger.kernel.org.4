Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA574C1B7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGIJhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 05:37:20 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06489109
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 02:37:20 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55bf2bf1cdeso5200050a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 02:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688895439; x=1691487439;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbCxluaqZn9eK5hEFBQXHXuh4Z7zNbzMlbI65rnNI4E=;
        b=coE6pnybJjwNdXy0Uxl/tcOngktOY+ioumfsPlUvnvE15EbnbsS7NAbqiH117cJ6Ap
         DBmx/C/PsY2ZXP09AGPiDKhvgVn8UKL4a6yXejwzJDmGAU6v2VR6MjQ4Iqa9W5zDBy5P
         qacNHPfkw/7CLdjZANQoyYLOseSVdluRXvuLMqMbWxYb0AgNvitbAP+uuPu+B478nzQs
         EYNo0j51KBul85XwKpkH+zPo/guLAXRJwxCEPMrf0H6MN+tBRecI7etu4iY2pRMRpB9z
         l7pShObmqaY68p+eNIqmh7TTphEUOrpzai7jJqpYjQxxQuax6AQY5bMzxdNCPrN1cyg3
         Bqaw==
X-Gm-Message-State: ABy/qLaYPRQCCwOh6B+H1R5oxQ/Y4gaHxpB7+XTS1NRCuPj9j1QChLEm
        8jnkX9kf1SVhXJxDJ/4eby9EAxWtzJYAqyLPsbDPIXw7IVVZ
X-Google-Smtp-Source: APBJJlHMHI3k2bVKXJLvL4eAKHDeLUZrxMleUuO/0sIrq7m2UTKyOYW+pOrO+D2DDfHzJrwMpweRNdt21U+spg/RPMntl8qN8iwZ
MIME-Version: 1.0
X-Received: by 2002:a63:b70a:0:b0:55c:7d6:4c75 with SMTP id
 t10-20020a63b70a000000b0055c07d64c75mr5995921pgf.0.1688895439450; Sun, 09 Jul
 2023 02:37:19 -0700 (PDT)
Date:   Sun, 09 Jul 2023 02:37:19 -0700
In-Reply-To: <20230709091408.1740-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb386906000a9ccf@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in sco_conn_add
From:   syzbot <syzbot+37acd5d80d00d609d233@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+37acd5d80d00d609d233@syzkaller.appspotmail.com

Tested on:

commit:         3674fbf0 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161333e8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=37acd5d80d00d609d233
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167f9074a80000

Note: testing is done by a robot and is best-effort only.
