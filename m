Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE86CC7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjC1QTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjC1QTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:19:08 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BBA4DBF2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:19:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32SGIxo9009627;
        Tue, 28 Mar 2023 18:18:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/1] tools/nolibc: tests: use volatile to force stack smashing
Date:   Tue, 28 Mar 2023 18:18:44 +0200
Message-Id: <20230328161845.9584-1-w@1wt.eu>
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

as previously discussed after Alexey's report, Thomas updated his stack
smashing code to use a volatile pointer instead of dropping compiler
optimizations. It's both cleaner and safer this way.

I verified on all supported archs that it doesn't change the behavior
and passes the test without issues, so I'm fine with it:

  125 test(s) passed.

It can be queued on top of the existing series either for the next merge
or the one after at your convenience, as I know that you're running long
and complete tests with your series, and I don't want to make you change
your tests at the last minute. This one is not urgent at all, it's more
of a maintenance improvement anyway.

Thank you!
Willy

Thomas Weißschuh (1):
  tools/nolibc: tests: use volatile to force stack smashing

 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.17.5

