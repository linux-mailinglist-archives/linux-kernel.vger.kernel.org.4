Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5646D361F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjDBION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:14:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F77A191FF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 01:14:09 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3328E20h012122;
        Sun, 2 Apr 2023 10:14:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, v@vda.io, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/2] tools/nolibc: assorted build fixes for nolibc-test in rare cases
Date:   Sun,  2 Apr 2023 10:13:55 +0200
Message-Id: <20230402081357.12078-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

please find in this series two small build fixes. One of them concerns
two missing include files for building the test against other libc (at
least glibc) since we added the tests for integer types and ranges. The
second one removes a single occurrence of a variable definition inside
the init statement of a for loop that breaks with older compilers which
do not default to c99. They're still convenient to test the portability
of the lib itself and I continue to use them for this purpose.

I consider that there's no rush on this, since these issues only affect
developers adding test cases, who should normally rebase on top of your
dev branch. So it's fine if it goes there.

Thank you!
Willy

Willy Tarreau (2):
  tools/nolibc: tests: fix build on non-c99 compliant compilers
  tools/nolibc: fix build of the test case using glibc

 tools/testing/selftests/nolibc/nolibc-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.5

