Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E779E5F9C53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJJJ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJJJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:59:32 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A75F226
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:59:30 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id q12-20020a5d834c000000b006bc2cb1994aso1113160ior.15
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=vwVuusa48Bf00hkH8KIzio+6GNm/I4NSa57Jq3pxpq3Z3/46elAGtvRhb4Z2oPv84K
         r1zp9HX6zMZGih8L/YwqSZKlpQmqUo0qZh8stvoFA/H5aWK8ZeqI4D8yYwwAf8E3hQHQ
         XOg8pXR2akAmatVbNca6pV7TtILetI3A9oXnIgDYZAcT3d6KtHu8J8QjekLUWm5ZZ7Vw
         5I+vbi8JEPirSYFLjEKpDffbCp1BKvy6IubCC2g3hWqNN9KSkZ+309Xwjm6kj1qMnUvf
         p7IYVPsLG0OV5xar7zZ6Ef87WaS62pGlm+B6/6nJsOILngCOiPjw9MKV7DPMh2JNaF1k
         C+aw==
X-Gm-Message-State: ACrzQf34VHXIMX+wG1xS2g/3xuC0NrYdyiUSdtuueJorL0UPtX1UlvNC
        EGAT89Yy3TAu9Q3FDZJgl9QOUB9WWT/cXH9G5zMIjbC57n33
X-Google-Smtp-Source: AMsMyM4yrhDnAJ+RQ4M/4ccm9QtbXKSwTqDl6yjCMHTveuHcHQ+jdCXpVDG7RmOV5kTWEmw7usIes59PTlTl8S9qk3pZnc2CJ3k0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:c9:b0:6a1:4e25:8b0b with SMTP id
 z9-20020a05660200c900b006a14e258b0bmr8074876ioe.188.1665395969843; Mon, 10
 Oct 2022 02:59:29 -0700 (PDT)
Date:   Mon, 10 Oct 2022 02:59:29 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003166d005eaab3790@google.com>
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
