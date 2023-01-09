Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A7661FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjAIIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjAIIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:09:42 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 159F410AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:09:40 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30989Pgw026640;
        Mon, 9 Jan 2023 09:09:25 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/4] nolibc: add support for the s390 platform
Date:   Mon,  9 Jan 2023 09:09:06 +0100
Message-Id: <20230109080910.26594-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

this series adds support for the s390x platform to nolibc and rcutorture,
reducing the init size from ~600kB to ~1kB. The work was contributed by
Sven Schnelle. It depends on the fixes series I sent previously:

  https://lore.kernel.org/lkml/20230109075442.25963-1-w@1wt.eu/

It passes the self-tests correctly and the patches are clean, please
consider queuing it.

Thank you!
Willy

---
Sven Schnelle (4):
  nolibc: add support for s390
  selftests/nolibc: add s390 support
  rcutorture: add support for s390
  rcutorture: build initrd for rcutorture with nolibc

 tools/include/nolibc/arch-s390.h              | 222 ++++++++++++++++++
 tools/include/nolibc/arch.h                   |   2 +
 tools/include/nolibc/sys.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile       |   7 +-
 .../selftests/rcutorture/bin/functions.sh     |   6 +
 .../selftests/rcutorture/bin/mkinitrd.sh      |   2 +-
 6 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/nolibc/arch-s390.h

-- 
2.17.5

