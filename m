Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6F61177A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ1QZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJ1QZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:25:20 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8D72EC2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:25:19 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso4637998iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0M2eNGrrFy1lqBx+Mbj7u6/ivikymdyJDCkEXUlOf4=;
        b=W3mC/WzJCkAnd28SHf7n0sKoBu27cbrvUlU/JZqsFtlxa+t0MxvmPTSPWYQ7GYysvY
         Z18+wKGo2k+Rs8Wj8dQoEAzjXRbPur17WSaacB4Xm/W1+fYeSjpsOUKCK3ALDtZlkJRp
         Av9JMcP8xzJlwMbmrEECU7FkEMR4CkV0cRRp+dadW7UWp1Y9cJjglT8DOVH6NyBc1XHy
         uUr823GIST0rJeE3+NF8Ijla3kSm6sZYn6aFZCOceM8jd70viyCWsUpCsztWCVf7cyuv
         5MPXJlK/MLY8Exxf/KvQQiU45wbuu9HxPCUw5CXWXlQeEpDocNRQJlOOQKmzmneRFQSx
         NkWg==
X-Gm-Message-State: ACrzQf2KgqawisEBtxIE0wGctu7fwbQFZWXICoxjkG5cTUWFa5BjNFTX
        mmxT+Z8CO5C5HKPHVQoJwqyjESTjIna/BBgGBGBJW7h6en0L
X-Google-Smtp-Source: AMsMyM4+dAFAySyvCpcZ0y/ApLfH48HExaDis7YotuSsW4mMSrDjl7EZangPlAlQPtKflrLKT035o6bJhkEHpeYNzXQn4FKwZnPt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bee:b0:2fc:793c:aa5c with SMTP id
 y14-20020a056e021bee00b002fc793caa5cmr127203ilv.126.1666974318783; Fri, 28
 Oct 2022 09:25:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:25:18 -0700
In-Reply-To: <CAKrof1NyNjozshnGPgxKHuBoKgnd79tC50M44UL_DfeVBad+Kw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ef38d05ec1ab476@google.com>
Subject: Re: [syzbot] WARNING in btrfs_block_rsv_release
From:   syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To:     18801353760@163.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com

Tested on:

commit:         493ffd66 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17bdd716880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e315ce880000

Note: testing is done by a robot and is best-effort only.
