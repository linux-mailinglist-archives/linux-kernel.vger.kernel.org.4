Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DF561A6D7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKECO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKECOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:14:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE341989
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:14:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so5009703ila.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 19:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtM/gu2fObeNqMmez4g/cF2qcigw/qedoG+FcrO9org=;
        b=Nbvy5kcP/HwUVv8SNUKn7Rv0BzPkGEPtYvQdXIlorhwskWpmNAOxuU0KNhGSFy3ttW
         YvsHYd4QRozl31DLd9H3UJwFRMGZxmQjFv1KhZxnTTYanMJ2v6LUjDaxsucD63Nj1Q/V
         ZuzLJCEv3BYh3NTuCx51YFcnISc4fqmwjZKETUOQae+UEfNAhFeRCEyrdGTFT3E9nVyx
         vvdcBHuy1C1AffDhSC/ioBLwROY4O5mfPwHWQ3TniMcOCv7QWq/7A/Ovc9zA2GrX82kM
         Ov4dpMebZ4UQIEQ/wei7W+/vDvZqGrTriJmrHFKGgRyqCnESXXEnbxZDbJGDftxHK34m
         +Rmg==
X-Gm-Message-State: ACrzQf21oksx6IY0jMrLktdxvK4YvrvLG7OdaFh5uGO6jBdskD4MDDY1
        TRN1rR7FDinhahDVxbJ9M832VaYE5BVp2xOw2o0CCWpmIOyz
X-Google-Smtp-Source: AMsMyM6H0VRqE2iG3u9Q55DjSC37hYwztUOtEYmhBgdB2Zr5NmiTeTvaT5aEtEGQpW2QeBKuSEfKn6aYMcKz8/ZKdEKBXhJCOyBK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c4:b0:300:ac44:b69c with SMTP id
 v4-20020a056e0213c400b00300ac44b69cmr19262544ilj.300.1667614462301; Fri, 04
 Nov 2022 19:14:22 -0700 (PDT)
Date:   Fri, 04 Nov 2022 19:14:22 -0700
In-Reply-To: <20221105012229.711-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5dde405ecafbf8d@google.com>
Subject: Re: [syzbot] WARNING in kernfs_find_and_get_node_by_id
From:   syzbot <syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com

Tested on:

commit:         f2f32f8a Merge tag 'for-6.1-rc3-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2c339880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=2fdf66e68f5f882c1074
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b8c196880000

Note: testing is done by a robot and is best-effort only.
