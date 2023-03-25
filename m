Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E16C89FB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCYBYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCYBYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:24:44 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB35B87
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:24:38 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i2-20020a5d9e42000000b0074cfcc4ed07so2200314ioi.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679707478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHt1c1tFcK1s4WV9hA/MjcYOtAbBuUxUaXeFAopMR+0=;
        b=GAb+Z6RKNvI7iNNvqC70vOopepHPsgHv+WZtl+gB96DhebzUkX0GIy1Xi05h9pXnDr
         4sC7kCUf/4oDOrY5XScrvP/LOaOMw+ByZVsuDre14bOf3IUtxiU3Hpu9CfjAHegHKl3G
         7I8gHZCJQafTKQLeNNnqjqIx4n896gq4acj4tlYpJobYLWB8LB3LV7/SGvKEtB5L3lc9
         MW9MS4KKZ94FDDZ4Dt7vyQ5SZUejSwQxxOp9hL1Ccagr2zz9fVFmBOtnltd/lNIoVvQ2
         dLTHUkrwmkanFezzXAFiQEYulZo3MtcQFPHoAsPoyWU9Y+IOF1M99hcgpjjRqfmnuS+j
         9USQ==
X-Gm-Message-State: AO0yUKWs9cL9f5YJhYsIYV2a6eIokjrxCI4Il67UyPRQ5gD793g+MDtT
        HNoiMbEsB7Lrk9quHNqJvgzd7qpYt4DQGHN3mpT3gacLMoZf
X-Google-Smtp-Source: AK7set+pzWrrAvgj0k0OoHpCZ7y+8/MaNrvUS78pi9c/nr60VtNk3Jd7Qy3LbB32mA+kYsjf3Pe4s6nSd4cSeZJ5ZeaAELpquCqj
MIME-Version: 1.0
X-Received: by 2002:a5e:c909:0:b0:744:f5bb:6e60 with SMTP id
 z9-20020a5ec909000000b00744f5bb6e60mr1806893iol.1.1679707478331; Fri, 24 Mar
 2023 18:24:38 -0700 (PDT)
Date:   Fri, 24 Mar 2023 18:24:38 -0700
In-Reply-To: <20230325011100.1765-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000929ce705f7af5fde@google.com>
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
SYZFAIL: wrong response packet

2023/03/25 01:23:02 result: hanged=false err=executor 1: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:23:02 result: hanged=false err=executor 2: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:23:05 result: hanged=false err=executor 1: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:23:05 executed programs: 8
2023/03/25 01:23:07 result: hanged=false err=executor 4: exit status 67
SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67


SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:23:07 result: hanged=false err=executor 3: failed to write control pipe: write |1: broken pipe

SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:23:07 result: hanged=false err=executor 5: failed to write control pipe: write |1: broken pipe

SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:23:10 result: hanged=false err=executor 4: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:23:11 result: hanged=false err=executor 2: exit status 67
SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67


SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:23:11 executed programs: 21
2023/03/25 01:23:11 result: hanged=false err=executor 5: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:23:11 result: hanged=false err=executor 3: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)




Tested on:

commit:         e76db6e5 Merge tag 'arm-fixes-6.3-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ac8d0ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2ca2de6ed94982
dashboard link: https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1169ef75c80000

