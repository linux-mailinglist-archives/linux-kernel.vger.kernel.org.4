Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C192720E37
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjFCG4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 02:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjFCG4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC64197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 23:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF8B61044
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153EAC433D2;
        Sat,  3 Jun 2023 06:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685775358;
        bh=/RGUl1kpk0bPbeQYYCx2qZ0+RQ+YidAyFQ16WECjasg=;
        h=Date:From:To:Cc:Subject:From;
        b=mjA4Y2iw4EE6WJnTu/dU6P0q9GO31goq8C3GIOfSt6rHbcMfEuIspzvaPSvcmdO6E
         LQzB6g4z4vrFNdync9gEwmxhmCj1mCJb8nAcKJwntbWYECNnzq8rQOYv1BPwlqUS+5
         nPXsOVZn+cDqxdt8mmbjfRGqknCi2bXg5FE2/Sug4jOwWWTpyl3kbDYQaiaVTfBm+J
         qkA7p5QQw9PrydELNRPPlQJEK4tnyEkxpd5nO7WSlyEvyUmEBgHOc/YE4O7j74qyAo
         M4M42dgDhRMIg/pYu5VMnG7Cvs06/DDbcfeSO9l3ukpMLVsyY3DnmH0UyGcgWo6H40
         Ps/mtI9SwR/0w==
Date:   Sat, 3 Jun 2023 15:55:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu (Google) <mhiramat@kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] probes: Fixes for 6.4-rc4
Message-Id: <20230603155554.9ab2f3edf0c503c312595258@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes fixes for 6.4-rc4:

- Return NULL if the trace_probe list on trace_probe_event is empty.

- selftests/ftrace: Choose testing symbol name for filtering feature
  from sample data instead of fixed symbol.


Please pull the latest probes-fixes-6.4-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-6.4-rc4

Tag SHA1: e32a1e7c0274b7329b45173353a1b8ac253cbdc0
Head SHA1: eb50d0f250e96ede9192d936d220cd97adc93b89


Masami Hiramatsu (Google) (1):
      selftests/ftrace: Choose target function for filter test from samples

Pietro Borrello (1):
      tracing/probe: trace_probe_primary_from_call(): checked list_first_entry

----
 kernel/trace/trace_probe.h                         |  2 +-
 .../ftrace/test.d/filter/event-filter-function.tc  | 45 +++++++++++++---------
 2 files changed, 28 insertions(+), 19 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
