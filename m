Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4E6BB1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjCOMaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjCOMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:30:35 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BD9E665
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:29:36 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id c7-20020a056e020cc700b0032305bab689so5002852ilj.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYoIqneX1R5tsy/OHCZvWxQlyWBvBWvX9mZJflxo6lI=;
        b=wIYK0l+ZkmkA6ddtgYLnAba4Jhc4Bxn+4lfSQiJfP39Vg14WPNGthkjcSdjiuXcGne
         D3CxPWaETWUQ2rd4H/GwgrisLQmp8kFClC6qI8FCT1LA6B65m6aVhekWDql+2wLp71eS
         SPmJehesAex+X1oSuDQsv1Oax+tCWerEntcbHyAMkI4Jgk0P8nQNikKgXluzZghCJXDa
         VxlDPwnUAIGnICIhEr1ci+uMz1AJQsks4m19Qik99qhJ01hAWxrjCzGkRS4Fmtk1ptI/
         N36J4piUb2bTax4SPCwXF30E90W22Okt1yh2GN0ggAYqK0Bc9L0PNaX5c2Bb1RqFdMDc
         dl2w==
X-Gm-Message-State: AO0yUKUJ3FgcMykSWjJr4Rlzt8SYMMrns5XS3fI5qQnSJmtFpzhnUvpP
        oSR7Uu9nDeF8HRBhrSYAlE35cu6pwgyCshATB/hbxAmrZZoK
X-Google-Smtp-Source: AK7set+q6RHDzdkkMUmRviONblJgN9BCqbtT3oUunhC/hF6Yd7SH5aJjLpxaMhJYnCHDJIu1M5TW+PIcc8Ktf4rdK8a2v8rrvnDN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5cd:b0:322:eaaf:7c6c with SMTP id
 l13-20020a056e0205cd00b00322eaaf7c6cmr3012444ils.4.1678883367105; Wed, 15 Mar
 2023 05:29:27 -0700 (PDT)
Date:   Wed, 15 Mar 2023 05:29:27 -0700
In-Reply-To: <20230315091201.2080-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7442705f6ef7e30@google.com>
Subject: Re: [syzbot] [block?] WARNING in copy_page_from_iter
From:   syzbot <syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com

Tested on:

commit:         6015b1ac sched_getaffinity: don't assume 'cpumask_size..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16c8effac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=253e7e1012aef938
dashboard link: https://syzkaller.appspot.com/bug?extid=63dec323ac56c28e644f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ff3156c80000

Note: testing is done by a robot and is best-effort only.
