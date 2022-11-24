Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670E637BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKXOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiKXOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:51:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BA134128
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7905B82847
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706E4C4347C;
        Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYs-001X5U-1n;
        Thu, 24 Nov 2022 09:50:46 -0500
Message-ID: <20221124145046.434583980@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 07/11] Documentation/osnoise: Add osnoise/options documentation
References: <20221124145019.782980678@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Add the documentation about the osnoise/options file, along
with an explanation about the OSNOISE_WORKLOAD option.

Link: https://lkml.kernel.org/r/777af8f3d87beedd304805f98eff6c8291d64226.1668692096.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/osnoise-tracer.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 963def9f97c6..3c675ed82b27 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -109,6 +109,11 @@ The tracer has a set of options inside the osnoise directory, they are:
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
    be used, which is currently 5 us.
+ - osnoise/options: a set of on/off options that can be enabled by
+   writing the option name to the file or disabled by writing the option
+   name preceded with the 'NO_' prefix. For example, writing
+   NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
+   special DEAFAULTS option resets all options to the default value.
 
 Additional Tracing
 ------------------
@@ -150,3 +155,10 @@ tracepoints is smaller than eight us reported in the sample_threshold.
 The reason roots in the overhead of the entry and exit code that happens
 before and after any interference execution. This justifies the dual
 approach: measuring thread and tracing.
+
+Running osnoise tracer without workload
+---------------------------------------
+
+By enabling the osnoise tracer with the NO_OSNOISE_WORKLOAD option set,
+the osnoise: tracepoints serve to measure the execution time of
+any type of Linux task, free from the interference of other tasks.
-- 
2.35.1


