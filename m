Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090376C8A41
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjCYC00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjCYC0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:26:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD917CF0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:26:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id s1-20020a6bd301000000b0073e7646594aso2216890iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679711183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYDmGNunNGlcCJ7hFE26zUbj4L4HWM3FN6sFdnczUgI=;
        b=i/kUDgT1k0jiNkqQuGdZDPKxYOanMLmKy3lg/KH5mAW6QaH/5E+jiT4dJp6+1f5Ycb
         vM5h4FwUGYOWHWD0w3e+f3wnyJLPV+1MtVLxphb63AK5Oqc6x9DLj/OY0MOzaOH/VdOq
         4ozmMrCvRS6apOW9escjnVS0FqJxAbzgDyjCUI4yA17qAm+EY7li9VF1Hv7ktiPVbFvM
         szjmsgmvAQHMj2XTY8D+aRl5Dl2x9+mLefaE8BuOMRAWl0aOqKYBBzZHY/HBXGW2PtMA
         qzwOGo/xoI2i8ugWxqm40c368KzVOJVXznc3c2of/wr90vG+0YavfzBSFA2H55DohIWd
         4wzg==
X-Gm-Message-State: AAQBX9eUqg6qsQOB5fdK9rHBzAE1Vp4DNz3wvHvhld6AD+QV9s/IgcpI
        LdAIALoTwdgBzxR1XN/h/88OdCsevcn3pIGWDLDF2UtCJYfz
X-Google-Smtp-Source: AKy350YOihnnQBjbZmCA6Cmj+SnCD5MAYAD+puGqZlRTb8G1nc2KRC0yFedyH3aGHbsI4nhTVv5EWdLls72iemyYspcVbhV6H5/e
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:310:a24c:4231 with SMTP id
 l12-20020a056e0212ec00b00310a24c4231mr2844168iln.6.1679711183046; Fri, 24 Mar
 2023 19:26:23 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:26:23 -0700
In-Reply-To: <20230325020355.1913-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006411e605f7b03cc3@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in __jbd2_log_wait_for_space
From:   syzbot <syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com

Tested on:

commit:         65aca32e Merge tag 'mm-hotfixes-stable-2023-03-24-17-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=161fa54dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2deb1e902f2b9c24
dashboard link: https://syzkaller.appspot.com/bug?extid=fa1bbda326271b8808c9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1760dbb1c80000

Note: testing is done by a robot and is best-effort only.
