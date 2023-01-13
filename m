Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731F76689BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjAMCvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjAMCvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:51:25 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E144F60847
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:51:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso12584605ioj.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kHpmFrlXNh10xHxDPEpwrHdPzPE2XyL+lKjHsMt0bk=;
        b=k8ZZHXlu/GYHyTf50ISc4GOF3Exv3azRIWuGF30ojw4/bNM2/AIdTv56pDPBbseT5h
         FrRAm8DxP3zNVH90+i4o9vQQtQKD9qsanps2b5QusZ4E38z17Wlu2SU4Z66maVhrmJc3
         lG+ZaEdwuhhSQD2rTKG6zQYslIaWUwTdHDgpwrZEUzQ9vJEELyaAxMNjnpUehSxjWLE9
         PIRmspVnZRciGZ/sK0uFPi7FKTYXn+zWKKt7nzdooBOy6UbUEyAR4+Q4ZBTVGgAJjnmH
         5JerHC6RFMwRwmbciOvEu65M6YY2p687uLmzw1Ixt1QRVfTln2Kuninv40WUAeSu/IY8
         Oa/g==
X-Gm-Message-State: AFqh2kq4kBKh/P3i5VgBQHhVyUZeSPSUdutlCqALw5QSd2vENN8EQeMO
        iLmjUYPFM/VwvJX4hCBS0VuNXYetkfInCEuKAdITZztxePVL
X-Google-Smtp-Source: AMrXdXuQpLmbHOvL5SrId88JUPVFYPBRH7F8fF7X4NcoS8UFWJlXQ70LUW9hQmi8sZe3CB1wD2GcxzPd8gUX64uH9g17YUBGxLmW
MIME-Version: 1.0
X-Received: by 2002:a92:c0c4:0:b0:30c:46af:56fb with SMTP id
 t4-20020a92c0c4000000b0030c46af56fbmr5681253ilf.12.1673578278270; Thu, 12 Jan
 2023 18:51:18 -0800 (PST)
Date:   Thu, 12 Jan 2023 18:51:18 -0800
In-Reply-To: <746dc294-385c-3ebb-6b8e-7e01e9d54df5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7bf6a05f21c4e23@google.com>
Subject: Re: [syzbot] WARNING in io_cqring_event_overflow
From:   syzbot <syzbot+6805087452d72929404e@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+6805087452d72929404e@syzkaller.appspotmail.com

Tested on:

commit:         7b9484d4 io_uring: lock overflowing for IOPOLL
git tree:       https://github.com/isilence/linux.git overflow-lock
console output: https://syzkaller.appspot.com/x/log.txt?x=177064a6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bdd5369dfff2192
dashboard link: https://syzkaller.appspot.com/bug?extid=6805087452d72929404e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
