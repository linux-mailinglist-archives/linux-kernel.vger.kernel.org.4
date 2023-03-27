Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216226CA0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjC0KJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjC0KJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:09:34 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60B49E9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:09:31 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g7-20020a056602242700b00758e7dbd0dbso5351752iob.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911771;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=C6orCa7BDPbaUqZGTPZseCLw/jtBNagnkqNxj+9r2/xPZFS7gPuD+1XhlUOMkiZcDe
         0ab75P3BHnJ8YgacqnTCxgaZIL4632F7zpFbTRUNooqZ0EdbZwyaPnnl1PIxpY9/QF4m
         rXDAoaJdgvLfd4ss5/b0o/jtbOsJlMp2fmtY3MZt5+pzXvQQgusBfFXbB451+fLjhM7o
         7okVmckBe1B4BL6WQFLgyX4pt5kpfaImTOs2H/3wDdqIxffb8RqmHtqt/pprkhCY1vIR
         yB9V1x6/IHeA0/UXNMLZdQ3AHbwhiv10VwmcyPuJeZZPcWtSSotCvyO126dWBwYKl6MY
         ja5g==
X-Gm-Message-State: AO0yUKW7asVzSNFILMv+/EicXBbdEukjoyvOt83KhJg7DOxINMSeWn+H
        Ct6innI4DZMjT1+5djQK46mx+sTmi05w6hGRB6Hj88x6cEwR
X-Google-Smtp-Source: AK7set94qle40IVKT8HROF2uZ0z0n5y6wUU4wDEytmeH7Pf86Jjg8zVGiG0Vhl3sG8+rZLmBNG5ULa1hyl/H7iZYcDNfryCHzKN8
MIME-Version: 1.0
X-Received: by 2002:a5e:c810:0:b0:752:f092:3ddd with SMTP id
 y16-20020a5ec810000000b00752f0923dddmr4052990iol.1.1679911771094; Mon, 27 Mar
 2023 03:09:31 -0700 (PDT)
Date:   Mon, 27 Mar 2023 03:09:31 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ecaa405f7def0ad@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
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

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux 4.19
Dashboard link: https://syzkaller.appspot.com/bug?extid=5f229e48cccc804062c0

---
[1] I expect the commit to be present in:

1. linux-4.19.y branch of
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
