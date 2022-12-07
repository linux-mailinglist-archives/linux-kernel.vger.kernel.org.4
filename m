Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14E645960
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLGLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLGLy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:54:28 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54173537ED
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:53:25 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id o16-20020a056602225000b006e032e361ccso1887886ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyWZC0llqdYmncWtPwixLQNKka5YCKzs3jeozvLgpxg=;
        b=5PD+iSQIeJrVUC8YziNSidVQCNULRpQUO1CbqA6p3KQcLr9kyqCmqBUuYusBzcFKit
         T0zEASqLzMeRGRb+MrkxzaktJEvhkfGLVQ3ludlEn15mGlUSJ36DgFptQ+5+j97CBmie
         8NmOxRQiGTjh8a0Hb7vMRkmfztCRyR28XteyJIzKAzztDyq5Iaycpuuq38gGaL0MZEep
         IMgwfipp9mou5x/0p8AxBd0JDOXXAkL+X8vWoTM+Vup3m/0c3t0JKin1Uxgs6NGLvPao
         D3+a9ShyjGNK1NY8kF7BpR6s8bee3zZWC9/q6BPDnWn1wvsRYMRNpMMYLFRsyZutChw0
         qf5Q==
X-Gm-Message-State: ANoB5pl141hmA4rkWm45XS/Ctul38afad7iM6v3UvJOMYd/QZq/qa9Gw
        iiYJdcFoX4uDmtRqOhVxBI5Oev7z8Ljoi/SCYjqpF+ubsSrl
X-Google-Smtp-Source: AA0mqf6wdms/YjxSqXYyKb/iaOK6kry5gOUGzSqZT2TjxCsbC3jgbRgUjNStD+BViyy7WmW03M2kWw8GWAanogb5BHGYzVCnjKKC
MIME-Version: 1.0
X-Received: by 2002:a92:d2c1:0:b0:302:dd82:2b98 with SMTP id
 w1-20020a92d2c1000000b00302dd822b98mr30473998ilg.230.1670414004665; Wed, 07
 Dec 2022 03:53:24 -0800 (PST)
Date:   Wed, 07 Dec 2022 03:53:24 -0800
In-Reply-To: <20221207112257.7806-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060452a05ef3b9168@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in gsm_send
From:   syzbot <syzbot+52fe5933e61fb1f048ae@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+52fe5933e61fb1f048ae@syzkaller.appspotmail.com

Tested on:

commit:         e3cb714f Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13e83683880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=52fe5933e61fb1f048ae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12452be3880000

Note: testing is done by a robot and is best-effort only.
