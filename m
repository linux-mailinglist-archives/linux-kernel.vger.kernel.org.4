Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C90690103
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBIHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBIHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0142DD2;
        Wed,  8 Feb 2023 23:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MNKfm6PULo8UHz4xHdtd4kw2mnDgIXUWhuKV0k7P4rc=; b=p9hCVlyIYb2YjIe5w7mEE57rmS
        TYBz51S2dnLL5LSIeuktgKFlR1865ruD++p2zGBQUG9m9J/vebQWEkI4xP0bmMiMD/WBgTmE/q9qB
        fIn8W+2rPFjypw/EvUbaIH2tuNLEuSTluctoqtSsjvXWPP7OayXjTl8V4b+ibvQsnbWxMIGHXA5it
        LLa2r9Ke3BeacG0iyJ6UWASp0BBC+scgg4fznpxlYIfyC+GpZqx2y9qySMvqSbektWhbutccTfVqi
        J4dYitP64Y5Tjw6+L3ZDVSsGSmAzJf0VZ9raroYv4qOy6beDp1mrAM9YTQrJXXysVUIuns4H05LFV
        1ycga6cQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18H-000LPt-Fx; Thu, 09 Feb 2023 07:14:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 21/24] Documentation: trace: correct spelling
Date:   Wed,  8 Feb 2023 23:13:57 -0800
Message-Id: <20230209071400.31476-22-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/trace/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com> # for coresight
---
 Documentation/trace/coresight/coresight-etm4x-reference.rst |    2 +-
 Documentation/trace/events.rst                              |    6 +++---
 Documentation/trace/fprobe.rst                              |    2 +-
 Documentation/trace/ftrace-uses.rst                         |    2 +-
 Documentation/trace/hwlat_detector.rst                      |    2 +-
 Documentation/trace/uprobetracer.rst                        |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff -- a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -675,7 +675,7 @@ Bit assignments shown below:-
     reconstructed using only conditional branches.
 
     There is currently no support in Perf for supplying modified binaries to the decoder, so this
-    feature is only inteded to be used for debugging purposes or with a 3rd party tool.
+    feature is only intended to be used for debugging purposes or with a 3rd party tool.
 
     Choosing this option will result in a significant increase in the amount of trace generated -
     possible danger of overflows, or fewer instructions covered. Note, that this option also
diff -- a/Documentation/trace/events.rst b/Documentation/trace/events.rst
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -903,7 +903,7 @@ functions can be used.
 
 To create a kprobe event, an empty or partially empty kprobe event
 should first be created using kprobe_event_gen_cmd_start().  The name
-of the event and the probe location should be specfied along with one
+of the event and the probe location should be specified along with one
 or args each representing a probe field should be supplied to this
 function.  Before calling kprobe_event_gen_cmd_start(), the user
 should create and initialize a dynevent_cmd object using
@@ -983,7 +983,7 @@ The basic idea is simple and amounts to
 layer that can be used to generate trace event commands.  The
 generated command strings can then be passed to the command-parsing
 and event creation code that already exists in the trace event
-subystem for creating the corresponding trace events.
+subsystem for creating the corresponding trace events.
 
 In a nutshell, the way it works is that the higher-level interface
 code creates a struct dynevent_cmd object, then uses a couple
@@ -1056,7 +1056,7 @@ to add an operator between the pair (her
 appended onto the end of the arg pair (here ';').
 
 There's also a dynevent_str_add() function that can be used to simply
-add a string as-is, with no spaces, delimeters, or arg check.
+add a string as-is, with no spaces, delimiters, or arg check.
 
 Any number of dynevent_*_add() calls can be made to build up the string
 (until its length surpasses cmd->maxlen).  When all the arguments have
diff -- a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -111,7 +111,7 @@ saved at function entry and passed to ex
         the instruction pointer of @regs may be different from the @entry_ip
         in the entry_handler. If you need traced instruction pointer, you need
         to use @entry_ip. On the other hand, in the exit_handler, the instruction
-        pointer of @regs is set to the currect return address.
+        pointer of @regs is set to the correct return address.
 
 Share the callbacks with kprobes
 ================================
diff -- a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -193,7 +193,7 @@ FTRACE_OPS_FL_RECURSION
 	Not, if this flag is set, then the callback will always be called
 	with preemption disabled. If it is not set, then it is possible
 	(but not guaranteed) that the callback will be called in
-	preemptable context.
+	preemptible context.
 
 FTRACE_OPS_FL_IPMODIFY
 	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
diff -- a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -14,7 +14,7 @@ originally written for use by the "RT" p
 kernel is highly latency sensitive.
 
 SMIs are not serviced by the Linux kernel, which means that it does not
-even know that they are occuring. SMIs are instead set up by BIOS code
+even know that they are occurring. SMIs are instead set up by BIOS code
 and are serviced by BIOS code, usually for "critical" events such as
 management of thermal sensors and fans. Sometimes though, SMIs are used for
 other tasks and those tasks can spend an inordinate amount of time in the
diff -- a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -55,7 +55,7 @@ Synopsis of uprobe_tracer
 
   (\*1) only for return probe.
   (\*2) this is useful for fetching a field of data structures.
-  (\*3) Unlike kprobe event, "u" prefix will just be ignored, becuse uprobe
+  (\*3) Unlike kprobe event, "u" prefix will just be ignored, because uprobe
         events can access only user-space memory.
 
 Types
