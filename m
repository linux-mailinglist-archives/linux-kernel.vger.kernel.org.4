Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96776B7BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCMPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCMPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:21:42 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED826A9CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:21:39 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id v14-20020a92c80e000000b0031faea6493cso6663674iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720899;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwxm/im7HSKkBlWL3LbIFQcJ54sQue4oc8N4dX6l1Kw=;
        b=mARw+fqZlghKa+dHyPC4XA0enzXgqlwnDChe6fjfYBjEoihU4QSnKo+hiNuW+aDU5G
         n13IEFO9fVv7PLfU+T77M5dN52HqSvxWkTsT7gQD9SDR0bjB2PCbq5QigrX2PkUcuVKi
         kI0cDIMNTPoTco43NYZZvp1Um2lOd0fl5eLAY2V1QPO38wJcxYP+NV0PaQ/gWew6GQdS
         PXsIXwEhktcn2QlPdlW2kpwpmL2rfzwD6NdXhgJuwxV0JfrDgXdCmL7BLxUlvtTCWYgW
         SptcKjecplZNTe3YHHzvPIJCwS6FNObffHrlwzXwzTf1yuTiY3OfaKee6AtZ4SpvOrJ+
         BMmA==
X-Gm-Message-State: AO0yUKV3qxO6vQbH1MkSwlvi1098sJgNBRsSIJzar7OBD61T4j3CZs2M
        zncvkxGOsDEsjcZewUTBKGXKWy7mKED5mUzyZFlMKv+nAO+Z
X-Google-Smtp-Source: AK7set9YOJTrQDBAf2rzM2eE+80tEAqbk66InTH4MeMFXzS7iQ388hA9rKqcjnPyXTfZCSNNLK97irt2F+PjfGlNs/ZVwPTPoqvQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d42:b0:314:b2cd:b265 with SMTP id
 h2-20020a056e020d4200b00314b2cdb265mr5062837ilj.1.1678720899186; Mon, 13 Mar
 2023 08:21:39 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:21:39 -0700
In-Reply-To: <20230313120105.1853-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df96cf05f6c9aa88@google.com>
Subject: Re: [syzbot] [scsi?] WARNING in remove_proc_entry (5)
From:   syzbot <syzbot+04a8437497bcfb4afa95@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+04a8437497bcfb4afa95@syzkaller.appspotmail.com

Tested on:

commit:         13423166 Merge tag 'staging-6.3-rc2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159f590cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aef547e348b1ab8
dashboard link: https://syzkaller.appspot.com/bug?extid=04a8437497bcfb4afa95
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fe5fdac80000

Note: testing is done by a robot and is best-effort only.
