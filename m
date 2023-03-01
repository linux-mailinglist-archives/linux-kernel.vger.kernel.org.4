Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAA6A69FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCAJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCAJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:46:19 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD5392A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:46:18 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id g21-20020a6be615000000b0074cb292f57dso8111045ioh.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 01:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QrQUf6ej2wz53TIG3vIEKOpH2aHZ+BAGa988Q8VvIA=;
        b=abfMD65dnG1fVayB1AqPvB4ixa6BjN3eA3cJhvwEEFSgYAcRLrys8VO3rMrAvprGvY
         RoCAqr6vPCh7Do8TJph6V7uzd24jbiSz/b7CeW/HgxIWp1lcZA2vsoogRrPtshB/WffU
         9VOboTotBm1ZSUgssDkcb125z7zmfBiRPruVBO5cJgskyd1qr8RC6i+mh40jMAQNmd6h
         W1yCypcG38wsS7qs/2EUTyJ2xjZHZ9s4EN1Ccj5wIJENLQgevfzeO6hd4SMVb5v8PlTU
         D4DG1PCpNNkFnJLchiEigYFiVlaX8ljYY9zw/CTVSTjQb6YASCawq/1zrJTML/pRK6av
         +qMQ==
X-Gm-Message-State: AO0yUKWHOFvWBWKlnVwTFX95Bdpi+1lTAUFoqYzQWKvbKiQSzhFbsltB
        ydc2/7RIFIOMZ7tlwwyDcPgtXYDJwgtD68uBOWs5TfRHG6jX
X-Google-Smtp-Source: AK7set8D145GSkzva4l9km20SwPR26iKGqrzXKn8D9F8M6Ur/iyipDU3jUtYVBIbT7RpC3k8f7l1Ef5rNi8gAgrBYxR5FJhQp1H9
MIME-Version: 1.0
X-Received: by 2002:a6b:dc09:0:b0:745:a722:4a15 with SMTP id
 s9-20020a6bdc09000000b00745a7224a15mr2795120ioc.2.1677663978072; Wed, 01 Mar
 2023 01:46:18 -0800 (PST)
Date:   Wed, 01 Mar 2023 01:46:18 -0800
In-Reply-To: <20230301025550.2322-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077347205f5d3954b@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in jbd2_log_wait_commit
From:   syzbot <syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com

Tested on:

commit:         e492250d Merge tag 'pwm/for-6.3-rc1' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10692674c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140fceb0c80000

Note: testing is done by a robot and is best-effort only.
