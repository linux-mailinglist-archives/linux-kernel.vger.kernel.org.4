Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6871B6DF224
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDLKpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDLKpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:45:24 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB483D6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:45:20 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d20-20020a056e020c1400b003261821bf26so1978989ile.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681296320; x=1683888320;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phEY5JrOJ7bL5ArsZNO3g5AGRU38lwvq/bBXqMuMhoE=;
        b=bRYWPuHPEfpIcqbq0Jm1zTRnDdG44YsnGtQvpnHTnMK7kGcPV+b5Wb1YSCf7Z3kEwp
         63Q/Bj0gKf+Pq8pphWMN+EXih35Ljj5ZpaLX5UxrANGiMysQ4WREcdvNVDcT8/W1yBux
         nEcFfXQ2nm43mRVYLkmFjVQ00oXVINk6f44NBzC6MBdNqEyaHSzJ2ATUY5xHUpnkCCDC
         T85yFB8fHD5H7UW1sF0xUqZg7njLGNYC3G7AkJJzgHdtpEtoWCGAc+JNamZwkJIccrJ5
         BGfrnY+ZUDeaj0gMNIUEGU2jmw6JJFm638OVkt/nlcXdvMC4i6AZvPS6MuhUNptYLUSJ
         t4BA==
X-Gm-Message-State: AAQBX9dT8SZYkeR4x4xdHyfh0AC3A9xVDWJaeU/ZxkjHPlN8aQ50bdQS
        QclZG5jpJfF0bbWgKtupCwE+p367rU4pP6Hm27mXofE8ofAX
X-Google-Smtp-Source: AKy350aR0QR/aDQVYs8GizD8CoW+L/wGtwuimNdmVHFR7PfEhhEkF8gxpwLZewDyHDj+7GWzYDufYaJm4Wg70QLjap7CPIAaIUKm
MIME-Version: 1.0
X-Received: by 2002:a5e:8905:0:b0:744:f5bb:6e60 with SMTP id
 k5-20020a5e8905000000b00744f5bb6e60mr5494942ioj.1.1681296319962; Wed, 12 Apr
 2023 03:45:19 -0700 (PDT)
Date:   Wed, 12 Apr 2023 03:45:19 -0700
In-Reply-To: <CANp29Y4V7LsaJk0h3GyWV-chE8YkwM2qX33_hy9ZF5si8ZLdDg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9e5a905f9214d8c@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp
From:   syzbot <syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        nogikh@google.com, rodrigosiqueiramelo@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail.com

Tested on:

commit:         7d8214bb Add linux-next specific files for 20230412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1387763dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=923e20c1867d7c1c
dashboard link: https://syzkaller.appspot.com/bug?extid=75cc0f9f7e6324dd2501
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
