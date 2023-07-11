Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206C074F0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGKNwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGKNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:52:36 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B1CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:52:35 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-395fd55e523so5073391b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083555; x=1691675555;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=SBJU3VamMQ88ZC9eHz6mjLq5EjA1Mwm1/RGpdsyTXxl5GUaVS5jFd3caWP3jVSUykn
         Q4KW6ql0J07LOkxnt4vtBb/rCEFwS4TsHPZIpkkr0cy/FBavbtShNHxl/07qpDlSh5SH
         ZB/FzTvr6NDaVlivuTTHtA+cVjj1kiNMm8wwjLC99iBjfNJenB/uQ+hDyjzUTw+WB03f
         PXE4fYQOYFhQ+WX7qOc3GupVywV08c+0HyZUU38/4VItzN6lbDlVhOGuQZtRMgDk3jHZ
         E/HXBGDWIRLldIL9S3Iu0IjqkbtDXGSRUYDokRb1k1WGoZlyMFXMfsiZTF84iIUWwp4m
         BeIQ==
X-Gm-Message-State: ABy/qLbDlVuW/750Nkuc8DBLNjBVQ71NG/ZSOOZTd40/BZtPUiewHYkY
        eux6ETW45mjsl6Fl8Fcn+DiuAfFCZa2VbaiTxxBFdQqjJNqo
X-Google-Smtp-Source: APBJJlGDsG+nOMkSJbLXJKRNGNJfHOn13Ov445zenjdwf+cSdHKoP10U8UttX2mqO6muw59vtWRMSKpRyJ6QOj+P2/CyrzrHnT/T
MIME-Version: 1.0
X-Received: by 2002:aca:bd03:0:b0:3a3:a8d1:1aa1 with SMTP id
 n3-20020acabd03000000b003a3a8d11aa1mr1493645oif.2.1689083554789; Tue, 11 Jul
 2023 06:52:34 -0700 (PDT)
Date:   Tue, 11 Jul 2023 06:52:34 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000477efc0600366975@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        jose.abreu@synopsys.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        nogikh@google.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
