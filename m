Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C186F3C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 04:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjEBCdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 22:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBCdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 22:33:33 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495226BE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:33:32 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3294f07346aso19915195ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 19:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682994811; x=1685586811;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Lp/hZcG6Kt0syNeva58klbKUxX4Y7jC6eWYuthsljk=;
        b=cZXK0hjo4Z6UleZyDrRzExwTsxT+KoO8YHFzx+LhBlxmmDERhB5oEPlQPYYMho2TLS
         rX9lP6hhhRIWTcoycs4Ta8Ht3kTxTZVTdxVZ+qMzbFWHTwvqWLHYV/MkNLxd5ygJlzyS
         A/KnP0xlTFCDlTvOQ30a8BIgFMc7s5YD55Kn4WW35ds6d5O+7Rhrtz0uG5X3SSQu6q+m
         c3mQbSp66jWeiwp8o80Mn3X5t8oVJpFI8EwzWQc9YgrnINvE871WL2QwyxOiSupckcVv
         2QfQMs8J26eZ0o9CD9boMbdBqS8qtIgUCM6WD+B9bJuYyoZiM7+kIFSOzhHzmMImlzUI
         /cjg==
X-Gm-Message-State: AC+VfDz2xmqOoF+TbqexLMmmvdMgMLvcsx/inquu6fFdphbx282dlMeT
        reh2Q8c0XMseaa+Ct/8H9KqHtPiEZoQpV4pvKA0ESJDL3Llh
X-Google-Smtp-Source: ACHHUZ5DQ+iwFoAFhpD6MmvBenzWC7pkX+zHSmrWFF3bW3I1ffvzXPgFACkNsDtDb6t2LuZZdVKHRkEg3XKYDI7L+B1llFpKTv+r
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:681:b0:32b:12a3:f955 with SMTP id
 o1-20020a056e02068100b0032b12a3f955mr6464355ils.2.1682994811481; Mon, 01 May
 2023 19:33:31 -0700 (PDT)
Date:   Mon, 01 May 2023 19:33:31 -0700
In-Reply-To: <20230502015215.3335-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5b6bb05faacc3ef@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_write_single_data_page
From:   syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         58390c8c Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe6ef8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141e43c2280000

