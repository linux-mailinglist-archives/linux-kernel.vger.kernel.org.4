Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA26D101A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC3UjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjC3UjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:39:22 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D10CDBEC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:39:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so12168628iow.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208760; x=1682800760;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFbffXJR0JL9PDHMNwY5NVqIQ/uvZ93Gi0qNlmzxWos=;
        b=bjnUU2TalKJ4CJVGIhettLOhPTeJskJ5xIFrO5/tggqeDSfP1yrpFk0wsB1Z1vdJRy
         j/V0noeMDSp8BB1eObY+NLsNPPCrThPSFcfe24qse0yblJBeMSwmk3FBC7MLqmRZ77QE
         cjSAWxthyCM6K0oE8NDPJO7qGIs93H6/GzjjDddgFK9e+NW6Pn6TM9rEoFxU36Ntzb+h
         ozXFrkBsOBwKUqeqSwIeuQq6Utlv462NSTHRSevZH0mryn6shPn7TSmWQik5jxuaK7/N
         j2us7NGbaVsssSQNDs1uLRf/A/1u2OlZ4X9ZgGUa/hl73njqhQMdXk4JebNZePW7n2Wy
         BH+Q==
X-Gm-Message-State: AO0yUKWQvup4KMRwI5+657Bi6cF2ZgazxskmFdZ6l7PRIGGWv+fyC24/
        DTP8tePT5yEbKHFKfBrxNh5yLe/Mux1JDWrlvAj17nAlV3fh
X-Google-Smtp-Source: AK7set+0oavY+0jKy0ek5WpcstbGWarENmcFKtA+8z1+E0AQn/vJmAFoPbgf7h8KMvihhKAX1KqGlfyWGrrCnL+4C0k9lCPKQeHW
MIME-Version: 1.0
X-Received: by 2002:a5d:93c8:0:b0:753:34e:2ee7 with SMTP id
 j8-20020a5d93c8000000b00753034e2ee7mr9264465ioo.0.1680208760480; Thu, 30 Mar
 2023 13:39:20 -0700 (PDT)
Date:   Thu, 30 Mar 2023 13:39:20 -0700
In-Reply-To: <e382763c-cf33-4871-a761-1ac85ae36f27@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051298605f82416f5@google.com>
Subject: Re: [syzbot] [usb?] WARNING in shark_write_reg/usb_submit_urb
From:   syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>
To:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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

Reported-and-tested-by: syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com

Tested on:

commit:         c9c3395d Linux 6.2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2
console output: https://syzkaller.appspot.com/x/log.txt?x=16d9f695c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fea01b13d861cd1e
dashboard link: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1134ea95c80000

Note: testing is done by a robot and is best-effort only.
