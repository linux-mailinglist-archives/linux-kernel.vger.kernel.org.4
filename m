Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C642744D66
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGBLD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGBLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 07:03:24 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23ADC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 04:03:23 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55b473e5268so3466451a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 04:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688295803; x=1690887803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW+jnssKc4axivZmxdckxWbOLeaYTizFPCkFahn0NbM=;
        b=C6/PYUkvBjnTX7e6mOxDGxv5zHPxiKlb4tlMHqc4+43oqs/kizvVTu64ue0rTu65ES
         R5WPWPCRv55sf0MhmwT6rHHIMqX7hrv/gAuRU4FieyebV2f59PfGDJaKLBXa7EnoH+V3
         Ctl4+sn4g05Rv30uGo1YNDO66Zf7iArKViXwTLaO5XMRbYttgKmbTPtJ0fmGLd+vSHyS
         TZi14JKfKr70+P/GgKK0G13pTAsubCH7VeqYRz2uTx22MXNEnQXc2NdDcrgFWsRt/9UC
         gJ0gNuSGREQEOLQ9EX589l1VmRzrSZYIjQ6gwmszstwIri4SRPn4i+Z4D4Y7LsBSKZuk
         y56w==
X-Gm-Message-State: ABy/qLb6oIAB/Sc6+gP9QBCyhpIqwXfGe9nATFbtYrTy9jlpSB1t6KG/
        a6S/Gjt2eMwIMjpoaF325DBqg589JQT8LFB3P0FHWj6fc093
X-Google-Smtp-Source: APBJJlFdfB5AenJZG4N4lFiG9XgwD5d5IoT/5ELJ7KfLxzpYuDMEclT9CiSS1XLMyJZ3BJ/21rLGPnSXDenjPaeG8ereBhIZWX37
MIME-Version: 1.0
X-Received: by 2002:a63:1a26:0:b0:553:c2df:9059 with SMTP id
 a38-20020a631a26000000b00553c2df9059mr4162075pga.7.1688295803034; Sun, 02 Jul
 2023 04:03:23 -0700 (PDT)
Date:   Sun, 02 Jul 2023 04:03:22 -0700
In-Reply-To: <20230702-neuer-anrief-61b5b722de0f@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009da2bd05ff7effb2@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in init_file
From:   syzbot <syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com

Tested on:

commit:         0ed645e2 fs: move cleanup from init_file() into its ca..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=124e2008a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78aa7bd472e7bb0d
dashboard link: https://syzkaller.appspot.com/bug?extid=ada42aab05cf51b00e98
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
