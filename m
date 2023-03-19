Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362876C0226
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCSNvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:51:27 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59F4616318
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:51:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32JDpDB5031995;
        Sun, 19 Mar 2023 14:51:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/1] tools/nolibc: always disable stack protector for tests
Date:   Sun, 19 Mar 2023 14:50:59 +0100
Message-Id: <20230319135100.31952-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

Thomas noticed that nolibc-test fails to build on compilers that enable
stack protectors by default. Passing -fno-stack-protector when supported
addresses the problem.

I verified that all supported archs continue to work after his patch is
applied, and that it applies without conflict (and works) both on top of
your latest dev tree and on top of Linus' master branch. Thus I think it
can make sense to queue it with your next series of fixes and have it for
6.3 given that it addresses build issues for some developers.

Thanks!
Willy
---
Thomas Weißschuh (1):
  tools/nolibc: always disable stack protector for tests

 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.17.5

