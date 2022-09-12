Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A65B57AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiILJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiILJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:58:20 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0663D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:58:20 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u23-20020a6be917000000b0069f4854e11eso4971228iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=MER5hBbS2xiwmECSoX6YOnHTVX9jlPRZ256sSUYp4Nw7+lm4H66BwVFiHz7NJy+qKH
         uaDc8dFO2oO12AOy3nZap9osmPVwz96/WpD6ruUt3jyARg2dJrNvTYhRkG3PpVi3RKtP
         HCawsBVuVN/Lt7jhGP2XXvBMkLdQAj9xxeU962SFRFh5lCC2M3zXFaZZmsQGryksbZAP
         Jh2wzoaLO9LQq2ioiNr6kiyQ1jO6nSeoKXLVK1UAtoGoQe5xJxXwpQNvGcqerZ6SiI1O
         9ae3JQMu+fT/xVw/UdK0OHeE3ngy1aUlf2rT65kSIeQL0Lb9HgSNyvrbfa4JQjdP4CM9
         k7ug==
X-Gm-Message-State: ACgBeo07kGkiQ5YbPAeGGbKVm9WmLelCqlLYO/l2o4Umu5DpGaKxBejw
        zrRSJCuoT7up5cPN0N4jq1GFWccHFu3OVxOTPw2vd7pNduDn
X-Google-Smtp-Source: AA6agR4qr9dkm6M3oYDOSvO8coQLPA1BsQMKdWJJqiJhKspO2yoRZ5JmSE3DAlXz/2suwmu0F2JYdUpnMxWLxR0jK4T+nn9+kInf
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1349:b0:68a:ea6e:6448 with SMTP id
 i9-20020a056602134900b0068aea6e6448mr11053528iov.61.1662976699622; Mon, 12
 Sep 2022 02:58:19 -0700 (PDT)
Date:   Mon, 12 Sep 2022 02:58:19 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007369cf05e877ef45@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
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
