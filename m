Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7561EFD3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiKGKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKGKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:01:37 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A54645D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:01:36 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso6801884iox.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=J+LPj/F5mHaOU2kcE3wrsQCU8tzH+Dvov+bKVSNrUJnQDV7QnDRZlwIdvbbdXAyDrE
         R3ZXX1ym2wMAJLy9VI1JgqM8MbrzEDaLZ/7xq92WG4ZrMKp8Nv8nUpPk04QA80CzCw82
         HjILZzLzchcCPmBdUWvGjTAxP8pnl9H9ww4uczbihoKSCN4S/s/E9P21n1cNvNxlvzvN
         5ZTILW1R4DdnrbRoGa1mJ3sBiaI8yB9T0LAS297ual1lpJnlAkBbHPauJZjMAL0fX0Pv
         3ZkwtsUYOTGDKL11ReurACyWVRF4a33iabzfyPIiAIpHgz66A6uH+34rveyQbQmnfarS
         YMVQ==
X-Gm-Message-State: ACrzQf3vP35S3eL1xCC64/bfrQtNfSCn4+WYW42+EvO6Q54rqppIA3Sd
        CmbIPNEFaiHJyE7WWbQn7Qj1aXLC9ZC7VyOu/q5tDhrQ4sNG
X-Google-Smtp-Source: AMsMyM4bdaS7YynhSN14HbxQ/Wme4D1BCDuJeSMTQ2aReeng3UX2J1E3m9kfrtv8IDzU8lNVM0y/7zZ1mvV5UidtjmeoaePQzMEb
MIME-Version: 1.0
X-Received: by 2002:a92:c910:0:b0:300:bfb8:65fa with SMTP id
 t16-20020a92c910000000b00300bfb865famr19947042ilp.276.1667815296058; Mon, 07
 Nov 2022 02:01:36 -0800 (PST)
Date:   Mon, 07 Nov 2022 02:01:36 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045cc5205ecde82a7@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
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

This bug is marked as fixed by commit:
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
