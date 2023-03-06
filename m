Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4826ACB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCFRyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCFRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:54:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD27A8D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:53:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F8A26102A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5CDC433EF;
        Mon,  6 Mar 2023 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678125234;
        bh=HrMAYgRbyKbvdTHooA1jmdKIEFHJhhNO3MXBKLs6XWw=;
        h=Date:From:To:Cc:Subject:From;
        b=Tyddujhqjb8W5Jax065cDV+H4oc9bq+OTi+vmB6/moNGdNFDB1PYyeRVwN03Qcd5/
         MZALdhSoOWvDlRiE65+8TNXWynblvh4U57yyE1PUTTd3dfI3F+pdmeGO8ENqTHvyGL
         VuLTNSs33BprPSI8gA4l3nb1ERG2a0kmBJ6IxTIE/ihCljt4TFP/JZCkmEzObrUg19
         vHBQndI4e4CpMfodKR/upBYLif9Ewpe57S0ITWXX5C4w4I2OFE5V/GHK1JBjWs4rKu
         EIy1X2JC9WMCrccNh5mpNoh6bnanumpzFUfDMcX++E+cc5mG9WBbLtX4Rv38BjKOJq
         FjGocy+SjJYNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E69A4049F; Mon,  6 Mar 2023 14:53:52 -0300 (-03)
Date:   Mon, 6 Mar 2023 14:53:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf tools: Add Adrian Hunter to MAINTAINERS as a
 reviewer
Message-ID: <ZAYosCjlzO9plAYO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ack :-)

--

Adrian is the main author of the Intel PT codebase and has been
reviewing perf tooling patches consistently for a long time, so lets
reflect that in the MAINTAINERS file so that contributors add him to the
CC list in patch submissions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66b5d5a51d5b1110..8e46fa10a631e4d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16425,6 +16425,7 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 R:	Namhyung Kim <namhyung@kernel.org>
 R:	Ian Rogers <irogers@google.com>
+R:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.39.2

