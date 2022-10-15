Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35B05FFA0D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJOMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJOMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 08:45:30 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A445F68
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 05:45:27 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h8-20020a056e021b8800b002f9c2e31750so5763019ili.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 05:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvR5LrF3PVmfrV+e40z1IBiEl1iuwKENWCYVMpXuLvU=;
        b=iXM3m/YeMyHpACzXLsj+/cdY4ebFBP5s3PWsyac/QXbEQH0UuHZNf9kxGyAzz47j8l
         0Mwz/zbi53T8U66uB4rqX5JHR5sH1QuJcVDSen7CLZ+1HcQenMpBhqc8qEYPFPUq47bh
         8Ec12noO7LOljD3Va+AHXDeb+Cr3ex5rRFKZB857mSs1T4h9XsZ1lSB0xZa7XgfyzehO
         NjOdAgh8IxVm8MBXiluelD2q3DII/MGpxedC2WbYytCIzCXkgXZ2s/MJyP8Z4bqvFSqJ
         7f2UqVteFeY3qcs8uqDMVDvktIZyAocwaLZlrJ+PacO2EVi33RshAcaPr8gctVrF6nbd
         I0aA==
X-Gm-Message-State: ACrzQf0NV4/6yX8hP4nMNaDQ2atK5tISY6iY+faFOEOSsYFKkspeZL29
        OecCRmMsYFDCTfzlygK/IhCCe9fFjwmBcuW+0QNq+GmTdoNF
X-Google-Smtp-Source: AMsMyM51/BPM8LSwp4OBWCiDuOOSNHCgjj8Mz7RZtb3AWuIZCKg3FGFMYmyiEUpU30u6/OYP4o6OqU7JOzS1fs223utBu4Ujni/J
MIME-Version: 1.0
X-Received: by 2002:a02:c05a:0:b0:363:73d2:82 with SMTP id u26-20020a02c05a000000b0036373d20082mr1279069jam.183.1665837926461;
 Sat, 15 Oct 2022 05:45:26 -0700 (PDT)
Date:   Sat, 15 Oct 2022 05:45:26 -0700
In-Reply-To: <20221015062245.370-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc371805eb121d82@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in ieee80211_led_exit
From:   syzbot <syzbot+25842f13c5ac135060f4@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+25842f13c5ac135060f4@syzkaller.appspotmail.com

Tested on:

commit:         a6afa419 Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1481eb8a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5376a2f09d6389
dashboard link: https://syzkaller.appspot.com/bug?extid=25842f13c5ac135060f4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b3e206880000

Note: testing is done by a robot and is best-effort only.
