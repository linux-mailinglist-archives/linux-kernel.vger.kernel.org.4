Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1526DC976
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDJQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDJQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:42:30 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4555E56
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:42:29 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id c65-20020a6bb344000000b00758333e1ddfso3982561iof.14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681144949; x=1683736949;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzgkkVJYtD+IZD93GUE5O69AX13d2ni7gUJpWEfE5L0=;
        b=OMcxfXm3wszQR5pQVs3ve19BORVKk5sjNdC50zrU9umTyndioqJ/y2rL63pFx/mpbJ
         LJIwiYbVXvx78i0Ega71SwcC6YjdMbPDSnXSf5pEjjvShI/St+a+fdh03K3/5Hm4zvTL
         a8g+kVhrPYKBrA51GHGPBTn08l3k6vSTZx1z6vRKypOJQrCCR2TH+a0rcttUzquIZUuo
         IoprBhxVBWYAVs/P2s/6fwjuI/XpKWorYrOBEZPVbhHdowfA9nAWk3jD8NHzMcAr+KVh
         vOlyVEtTDSr5jCSll1ki4xBx7uhWTOjnrIEJLX9vFUb52v3xXjRC31yeQQPIfISXYuwQ
         /POw==
X-Gm-Message-State: AAQBX9ck2JTt1XdA3ixqjUrci/3N4YyFeJM3v6v7yU0KKsej2ksc5UiZ
        YAs1rX0xtXJa5vkPx9Pmdaaq3Bz3zZP3QyMwhtwos/L2JisTsUc=
X-Google-Smtp-Source: AKy350YA33RVDfCG6iMzPmV0zubuDwEvtgI0XpPiLSjmkFjI0IG3DoUa7VRjrsT3pIQzFr7AQIHc1bhS+vSMMhr7mAow5Lke+qzi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12b4:b0:325:a8e7:126c with SMTP id
 f20-20020a056e0212b400b00325a8e7126cmr5458320ilr.0.1681144949234; Mon, 10 Apr
 2023 09:42:29 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:42:29 -0700
In-Reply-To: <b3b5e785-625a-4787-80fb-5727c2aab4d7@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083eae705f8fe0f8f@google.com>
Subject: Re: [syzbot] [usb?] WARNING in shark_write_reg/usb_submit_urb
From:   syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12bcc3abc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fea01b13d861cd1e
dashboard link: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f2c727c80000

Note: testing is done by a robot and is best-effort only.
