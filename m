Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C66F0E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjD0WrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjD0WrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A52123
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431FE64033
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4A3C433D2;
        Thu, 27 Apr 2023 22:47:19 +0000 (UTC)
Date:   Thu, 27 Apr 2023 18:47:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Rong Tao <rongtao@cestc.cn>
Subject: [GIT PULL] tracing/tools: Updates for 6.4
Message-ID: <20230427184718.3af785b5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

tracing/tools: Updates for 6.4

- Add auto-analysis only option to rtla/timerlat
  Add an --aa-only option to the tooling to perform only the auto analysis
  and not to parse and format the data.

- Other minor fixes and clean ups


Please pull the latest trace-tools-v6.4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.4

Tag SHA1: 7dbb2068408e2410521723eff538c39bb9ea67c0
Head SHA1: 82253a271aae9271fcf0aaa5e0ecc6dd38fb872b


Colin Ian King (2):
      rv: Fix addition on an uninitialized variable 'run'
      rv: Remove redundant assignment to variable retval

Daniel Bristot de Oliveira (2):
      rtla/timerlat: Add auto-analysis only option
      rtla/timerlat: Fix "Previous IRQ" auto analysis' line

Rong Tao (1):
      rtla: Add .gitignore file

----
 Documentation/tools/rtla/common_timerlat_aa.rst |  7 ++++
 kernel/trace/rv/rv.c                            |  2 -
 tools/tracing/rtla/.gitignore                   |  1 +
 tools/tracing/rtla/src/timerlat_aa.c            |  2 +-
 tools/tracing/rtla/src/timerlat_top.c           | 49
++++++++++++++++++++++--- tools/verification/rv/src/rv.c                  |
 2 +- 6 files changed, 54 insertions(+), 9 deletions(-)
 create mode 100644 tools/tracing/rtla/.gitignore
---------------------------
