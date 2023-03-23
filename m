Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B866C61ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjCWIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCWIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:37:13 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8F32502
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:36:05 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so11121413iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FJc2PRgtPuqBc++D7i9JExdmTxp08tlgFUYSaSG8Bk=;
        b=scwzjPNcBX1Q4ze0VgRVwMMLVAdf3T73GTlJau3IWvF2df3Yu1tMnQHs2fDEYPj2j6
         q86cuJgAK4tiCUJCFZduP1LH4/EiWwMyDbNzE4GoTlzwuuC70N4nEjN+tRJf7n+Vctcv
         YMOmehQw8nksUK9/B85q6adGWDSOWcUBjTyMg73z5nsDZoZ/Q/mQWLnST38zHfh6g2kF
         piYpS7YL14FVo9anTIYWMaJ1lD1XV+hGtKMtsusEuLcCGuxlI0jJN0aOe/86XpFFdQh7
         BtfAk3RQAdXwsRGH2w/H3aNATQWfYJLOY1KsoLyff+4oqFKIK2eNVAjjSNwIgx48PQkU
         vz1Q==
X-Gm-Message-State: AO0yUKW7pESpMoiGinEavR/q5vYGTS7SnGaPovfG0isYLMeHrBjusZyL
        FzRDV6ul4sgnbPlqaRJDPAoxdQq/ZZqinFaZGHMDhVMqrjaa
X-Google-Smtp-Source: AK7set9RFHPe389J7ND9CJoL3cR86u//reQFdUkb1FNy9eWI6RO9hcHppF+uY81U4+26NUuiQF0E5lueJ0hx1mD4W8hFkd5E8Ghd
MIME-Version: 1.0
X-Received: by 2002:a5d:93cc:0:b0:752:fc52:a200 with SMTP id
 j12-20020a5d93cc000000b00752fc52a200mr3892735ioo.2.1679560523293; Thu, 23 Mar
 2023 01:35:23 -0700 (PDT)
Date:   Thu, 23 Mar 2023 01:35:23 -0700
In-Reply-To: <20230323074312.2770-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005eade805f78d28c9@google.com>
Subject: Re: [syzbot] [sctp?] general protection fault in sctp_outq_tail
From:   syzbot <syzbot+47c24ca20a2fa01f082e@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+47c24ca20a2fa01f082e@syzkaller.appspotmail.com

Tested on:

commit:         cdd28833 net: microchip: sparx5: fix deletion of exist..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13650781c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=47c24ca20a2fa01f082e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1144c67ec80000

Note: testing is done by a robot and is best-effort only.
