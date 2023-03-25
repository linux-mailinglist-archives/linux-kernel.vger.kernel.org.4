Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072F26C8A43
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCYC3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYC33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:29:29 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036CC1A498
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:29:28 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l8-20020a056e02066800b003247f2ba648so2254773ilt.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679711367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TajFkja3T0gLGV3AnXr59wGUN06t4s8QKsV8ooacjyg=;
        b=6VeM5rEmLe18iqrPE/zVTFmvgGS2SZX0nj8ML5vLuTjgqY5mt0UME3brE+MsXBn8KL
         exhN39jYTLBOkef+hjMQW0Mn4AtWvSQB+TGVcCauojjifoFebaXamyi6pX8+T40eIlZj
         p9wfzWsZq+QhehLKtaZmo+igEopKjigv2BBLnWYkBjfJk7zjs5TnEc6CCHh8hd7f8dWC
         2vUZ+7Y096OrkYCS02ksk5QoQjojfv6YzRZiL1f2wtKNDOnqdDJE+TipBS3jtdsMyHBm
         Z1K8wsBIFIqLbZ9HJS0cr7ZPfq9KJJ2zr7tf/fPUV/Bc3qmWsmRXuBWOBI54ay3zaXcH
         wPqA==
X-Gm-Message-State: AAQBX9cGRFRi8ZueeAwPlIpLmwVekTAUPYtgYyEKykZJGC+4IzaZLHZZ
        OZzyt1kwSBlH8Mn8UJFefwtN66UIj6VYdmu2Ybo1tw9UIt57
X-Google-Smtp-Source: AKy350bWq8n/m5XsoawxSXcBxKYWpEh4jfhH6x2dFq+/tRYqZd5nVAbHLd9wmIxmGw1/dxc3af1T8pYC7iJu9qPjRbxuft4DOhRV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:323:cab8:3c0a with SMTP id
 k5-20020a056e02156500b00323cab83c0amr2752153ilu.5.1679711367364; Fri, 24 Mar
 2023 19:29:27 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:29:27 -0700
In-Reply-To: <20230325021143.1968-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060888105f7b047ce@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in switchdev_deferred_process_work
 (2)
From:   syzbot <syzbot+8ecc009e206a956ab317@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: initialize_wifi_devices: failed set up IBSS network

2023/03/25 02:28:33 executed programs: 6
2023/03/25 02:28:33 result: hanged=false err=executor 0: failed to write control pipe: write |1: broken pipe
SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 02:28:34 result: hanged=false err=executor 1: exit status 67
SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67


SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 02:28:34 result: hanged=false err=executor 2: failed to write control pipe: write |1: broken pipe

SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 02:28:38 result: hanged=false err=executor 1: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 02:28:38 result: hanged=false err=executor 0: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 02:28:38 executed programs: 27


Tested on:

commit:         65aca32e Merge tag 'mm-hotfixes-stable-2023-03-24-17-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13227efec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2ca2de6ed94982
dashboard link: https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
