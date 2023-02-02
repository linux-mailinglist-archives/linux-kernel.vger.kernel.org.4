Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23796888D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjBBVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBVQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:16:30 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B5518E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:16:29 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id t15-20020a5d81cf000000b006f95aa9ba6eso1899123iol.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YbYrisVg+rUMlfc+ZTbTP5txmI4PVaRYzb4aIG716E=;
        b=M75fRt7jD1NsKNdXyd+caJUp07AI9RDgFixuNVw6Kniip2RqqI5Kra9oleRBPtUcvS
         dTjykb/8DqWV87F59Rp3aM+GR++fSSzYizR/9Ge2Cka1x1BUI10iXG+6Ux1AYH3FWyyg
         X8nSEW8Paln+ubwCx0/ySVOEnLZjbE5+XLmfqwZziyElG70LHAMvKg4fAq4/2a6sPc+G
         ymfL9nqta7bHkDHyLPJzR9vGu7w+V0TbSvxkG2i6PFKILRDe24jCo1XTVOD0SSokMA0c
         Q6XidTKtZ3RoL1iZ8NfCE65FhDZ9y7MaAI8Ow63FO7xCtpu1VcuqppV02Db8Ew2nrDzj
         k+kQ==
X-Gm-Message-State: AO0yUKX54uvs9RiMFT30EgD4woQ3B1a52oSYYrnXkfvOkvHBL7j6gl1Q
        iqmlyoX2sAjmpbsRKgQTJuEef3Q4Se3lODHGCtW37typmPsQ
X-Google-Smtp-Source: AK7set9iDhmuB+0/B75YQ9dp6pYxfnN++6k6LDppqbGnv35zHEk/f8aqTpgfmaZNX6aL4LXxYfLT6ZrZqVONGUPX2UgNDdAVBFKx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a6:b0:3ab:d5a:e20f with SMTP id
 w38-20020a05663837a600b003ab0d5ae20fmr1813657jal.47.1675372588686; Thu, 02
 Feb 2023 13:16:28 -0800 (PST)
Date:   Thu, 02 Feb 2023 13:16:28 -0800
In-Reply-To: <Y9wh8dGK6oHSjJQl@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003e49a05f3be1479@google.com>
Subject: Re: [syzbot] WARNING in __usbnet_read_cmd/usb_submit_urb
From:   syzbot <syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mailhol.vincent@wanadoo.fr, mkl@pengutronix.de, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com

Tested on:

commit:         9f266cca Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=157cfe31480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f93727847d4d81
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0e7abd24f1eb90ce25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173ddea5480000

Note: testing is done by a robot and is best-effort only.
