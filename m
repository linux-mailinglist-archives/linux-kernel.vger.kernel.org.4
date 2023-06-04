Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11D72141E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjFDC3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 22:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjFDC3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 22:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DCD197;
        Sat,  3 Jun 2023 19:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDE9160C02;
        Sun,  4 Jun 2023 02:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A632C433EF;
        Sun,  4 Jun 2023 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685845755;
        bh=y88we4Ac5oqKMeA+6cCyWjkxfe/UMHngQ2wGime+q2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeGo+OzExfIcaVTrUQgTEBsZvOwNXFMpeRHOsfIOqR4FtAA6UqEW7LVaIYZIDsl2u
         WMsWqdYzcamlrzjxlusrQwktdYNJFZmgpOI1TG34aSijw7JWc3Mk9vzz4CUdmvzDEr
         6xYT86fkLlBMAxt2rQX9sLyRgf68ZfApkE88zg+lkKgSYw9FGuuKBSz6WmsPwqqABl
         7f7kQNa7Mq6mwlnmvKgxgYL7MT5O5Z5Xyl8lcOjvUtiTvp4uSJr8dy4NdXlAhhr3Po
         +s7jEP0HcpPIvv4pKU1+HXbLNEgVsPvUOpumgmyhNOpZZq/GO5zqiW1ZcTueeFT/g4
         P2Hg2Uicv39vg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] Documentation: Fix typo of reference file name
Date:   Sun,  4 Jun 2023 11:29:11 +0900
Message-ID:  <168584575125.2056209.5771945721143181243.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
References:  <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix a typo of Documentation/trace/fprobe.rst.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306040144.aD72UzkF-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index e949bc0cff05..7297f9478459 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -38,7 +38,7 @@ Synopsis of fprobe-events
                   with a digit character, "_TRACEPOINT" is used.
  MAXACTIVE      : Maximum number of instances of the specified function that
                   can be probed simultaneously, or 0 for the default value
-                  as defined in Documentation/trace/fprobes.rst
+                  as defined in Documentation/trace/fprobe.rst
 
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function

