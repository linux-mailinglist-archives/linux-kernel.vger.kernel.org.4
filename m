Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA696AAA6E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCDOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:30:40 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA5BB1F5DC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:30:10 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ETwCP006727;
        Sat, 4 Mar 2023 15:29:58 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/3] tools/nolibc: add LoongArch support
Date:   Sat,  4 Mar 2023 15:29:52 +0100
Message-Id: <20230304142955.6682-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

this is the third and last series of updates to nolibc for today.

It contains Feiyang Chen's work that brings in support for the LoongArch
architecture. I have tested that it builds fine and does not break any
existing arch. However I have not rebuilt my qemu to add support for this
new arch yet, but Feiyang has already run these tests so that's fine by
me for now. I'll ensure to have an updated qemu before 6.4 to continue
extensive testing of all supported archs anyway.

This series is to be applied on top of the second series titled
"tools/nolibc: cleanups, statx(), getuid()" since it depends on it.

Again, it would be great if it could be queued for 6.4.

Thank you!
Willy

Feiyang Chen (3):
  tools/nolibc: Add support for LoongArch
  selftests/nolibc: Add support for LoongArch
  selftests/nolibc: Adjust indentation for Makefile

 tools/include/nolibc/arch-loongarch.h   | 200 ++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/testing/selftests/nolibc/Makefile |  78 ++++-----
 3 files changed, 243 insertions(+), 37 deletions(-)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

-- 
2.17.5

