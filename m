Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A26D2ED3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjDAHJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 03:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDAHJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 03:09:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A94CDF7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 00:09:26 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id 187-20020a6b15c4000000b007590817bcfbso15043115iov.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 00:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680332966; x=1682924966;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZwZ/Ve9yOutPyaMebU4kP6lnJh2KxjcVyMt6bxcn1k=;
        b=kxz+AQjwWRwVL7OLfgubVKsaLutuSkgWtmc+eAEDrDxAgsBlm2gd1rsYsUIp2/r65v
         mj3QCf0uzk016eseYpsD+zdiczqUtQT+a0WWjlevRAs7Ty5OlSDais/18UO+6KWaC4T3
         OkAwKAVkPWfJQBxJFD7i4/X2Ybf/xh6P5Yt2HMqzY8loVPl0rpUFeE3L427UvPSdLfk7
         88FvoAhiW5bNv9kbyV8Y+G7ifCgUf5M1CPHj0ZkeAaFU0WVlWZ3ah7pyo1z60cgjqwEI
         5tCzRtiJt3v9yj2/IwKdEjBheQR0ho34l01G4cxzK2hZQy7ds6eCR6ghjILE76gPHfZr
         LkoA==
X-Gm-Message-State: AAQBX9cSUzVHEddW5gi61VZ+xYM6uBWk7ia5uu2ZBfmKp2s5CkYB9S8D
        jtD5k9/AUIfK9WKYn+9a5yD6OxLLYaXnhtUFwAZ5XWqY69jO
X-Google-Smtp-Source: AKy350bfgYUk3g2Ngge2q+tH/KvOoP4jIvjtzca9a+i676G5E8/fIParvHctgGiacjzHv2kYSjnjvKDZjUIMaxKl4iivqIKGYA4M
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d51:b0:325:e737:9d62 with SMTP id
 h17-20020a056e020d5100b00325e7379d62mr13949140ilj.6.1680332966172; Sat, 01
 Apr 2023 00:09:26 -0700 (PDT)
Date:   Sat, 01 Apr 2023 00:09:26 -0700
In-Reply-To: <20230401064852.3375-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008da06505f84101ed@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_hw_pagetable_detach
From:   syzbot <syzbot+3b81771e32dd5b2f9931@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3b81771e32dd5b2f9931@syzkaller.appspotmail.com

Tested on:

commit:         4b0f4525 Add linux-next specific files for 20230331
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1391d1cdc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85cc4b935a1f7194
dashboard link: https://syzkaller.appspot.com/bug?extid=3b81771e32dd5b2f9931
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1729c4c9c80000

Note: testing is done by a robot and is best-effort only.
