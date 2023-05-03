Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766E76F4E09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 02:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjECAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECAOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 20:14:22 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1521BFC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:14:20 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-32f23e2018fso6363915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 17:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683072860; x=1685664860;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEdJNQ3lVemRBJ6NDcWKHIv1GrI4GPEwiZ9AMbObejI=;
        b=jau1mJBmVHt19Ni0kwAC4jXo+w+SUWWlkuJxo1dbu49HHKijCrHRpP62GHTzSH9r62
         EMZ33+3/UIgXETtylB4YvN3warxVjBRTasKbJvBgNX0OHK5/SwWI6L87s1KCaCKDdVwo
         inVE1JUTg6aW2mOOSh/dL2cP6W3jJ4Gsubsuumg0CvU+WWhBKs9W3t4+W1gZ1TNN0xml
         aERgveSjgmGa+gOd1L/UGAnt4961bFC7xDOznXGmZIilFCHTZ/DuklnRtDjHF/A4plIX
         sijSmqDgYYkrR4QSUuTSc9MOpsGbLOsuKCISW9NcNi8movK/zTYXGiATRVzlb6ekFpXD
         yScA==
X-Gm-Message-State: AC+VfDzRnev3FM1vzGsRGwZT2ZZkiDUa8jNT/DqFPQC0inmCqfXHn12b
        gnrbTUjFoRl9aJUnB7BvIhKfNM9DYfDJ1tGjE0JMmkWAgDbz
X-Google-Smtp-Source: ACHHUZ5e2IPTjcLMfP6jQLHxh4OYc6OTUlfjWdAA5ZTwkTyRYf//kTp+GPJd+erhDob5I1HICqBbh/IITvBBI5MUjeGLg8TdIa1F
MIME-Version: 1.0
X-Received: by 2002:a02:966f:0:b0:40f:9d2e:24ae with SMTP id
 c102-20020a02966f000000b0040f9d2e24aemr275427jai.0.1683072860029; Tue, 02 May
 2023 17:14:20 -0700 (PDT)
Date:   Tue, 02 May 2023 17:14:20 -0700
In-Reply-To: <20230502220039.GC15394@frogsfrogsfrogs>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f40bf505fabeeff7@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xfs_getbmap
From:   syzbot <syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com

Tested on:

commit:         55901cd7 xfs: fix xfs_inodegc_stop racing with mod_del..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git inodegc-fixes-6.4_2023-05-02
console output: https://syzkaller.appspot.com/x/log.txt?x=11a2556fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64660a60375eadd7
dashboard link: https://syzkaller.appspot.com/bug?extid=c103d3808a0de5faaf80
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
