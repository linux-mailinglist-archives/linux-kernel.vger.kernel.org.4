Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B05E9E75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiIZJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiIZJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:58:29 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA63F27CE2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:58:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y10-20020a5d914a000000b00688fa7b2252so3552685ioq.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=cly0eLVRGduJIJeqJ+HZfXL7UEJXmcft+EFec7ZNloCux/6XsCszIsvLG0lAPorg3e
         LgVZ4JjMKMVwXGJp2VIV9PEHPoouSWWXbVsjZZfAvXj/JD8QjxiGxlPIEZS2hTlTah+8
         +8L9uOmGa54W/1kLi2Z0t/9+NbrvZvrYOQuNeuK+F5D3DWyfP3ojW1NHZoWUpYnW0gsB
         yyaS1Foin8RcCYHrBvdPWpcAV4lZs4ynvlQMkpONleLE0Bh6fl0uNTuKhIVbDP5Aq4Ff
         +Qowy9HNzG9xrPEPaiZ3xevssGcciPRdzyN0Pz8+RlSOYBmte7dzAgAvakI46pwI50bb
         CCow==
X-Gm-Message-State: ACrzQf3gIkTsGE3n79zwGO+yO2LwR7nZkcsJY0prJpevxL5Cf0QUdlb1
        /1bfotKrrmWwU8n+FadQiTUtCBABoU4Rh6vyVzKsOgt63kUh
X-Google-Smtp-Source: AMsMyM6LCArOmFmUUaFfdBA1XVhSSnXiqjvnEu32K9QrU3KieOaTBem27PPdtM9KYQcH4LfEltpYqyHGPm3CpFkye2VXhn/U4r2G
MIME-Version: 1.0
X-Received: by 2002:a6b:5f0b:0:b0:69e:dbfb:2db8 with SMTP id
 t11-20020a6b5f0b000000b0069edbfb2db8mr8664108iob.73.1664186307190; Mon, 26
 Sep 2022 02:58:27 -0700 (PDT)
Date:   Mon, 26 Sep 2022 02:58:27 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae283205e99191ca@google.com>
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
