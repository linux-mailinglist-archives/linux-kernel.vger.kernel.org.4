Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E4609E68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJXKAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJXKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:00:44 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18955558F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:00:43 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x21-20020a5d9455000000b006bc1172e639so6126724ior.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=WYOY18s6rJ1h5F8bdtduNIG0M1LbL4a6VDyK9Q4Md0JzWQ+0/8IVJ8gVWPVwZd4klK
         Elsw0okQd62YfFmr3yBjhE7SWSMKUqMdsuB9I2pPePZ2FhsG+2PjuOKvNhZAGhrfRPFI
         vO7lEdFYsvmMtqqNPh/hkwsidmRQ1NwtIE1DvDzZD5msC3luyxkGUqNyV/iiu+xmy6gN
         yc2w95PVwfGlJ+ZWVjNmhr2d7BRYn8440mbmXkQHr0E5zSndKFtGMHO1ZgaxkumXM/uv
         vJn+zVvUKyDy+Jsm4Sfv4WCZ0w3NeBhufLLLCrdvBxwnejzmv7s4//HJTMesL/6VTWD9
         iPYg==
X-Gm-Message-State: ACrzQf2vemyH+uA1d2sNnl6kPxVWe0VbgqKxc3VrY+c00J2gFAH/A/8H
        Qd2ofF/vTGXugslZwTVz9Se4aS4paCCsZN7OBQotdmzTB/07
X-Google-Smtp-Source: AMsMyM4OadCGA7Ukw0eYaddzszBTHebgZNyDBu+d6H1pPykM/N3hYNOkunvRCPOeLbZEpSp505ZeA5N1jBcLSJlKrXqzSCH160WF
MIME-Version: 1.0
X-Received: by 2002:a6b:d6:0:b0:6bc:8256:6bc3 with SMTP id 205-20020a6b00d6000000b006bc82566bc3mr19463773ioa.43.1666605642387;
 Mon, 24 Oct 2022 03:00:42 -0700 (PDT)
Date:   Mon, 24 Oct 2022 03:00:42 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b995d05ebc4dd45@google.com>
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
