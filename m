Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D068E5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBHB5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHB5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DCF1968F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F49B61485
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D167EC433A4;
        Wed,  8 Feb 2023 01:57:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiE-006dN4-2f;
        Tue, 07 Feb 2023 20:57:30 -0500
Message-ID: <20230208015730.639442891@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [for-next][PATCH 02/11] tracing/histogram: Wrap remaining shell snippets in code blocks
References: <20230208015633.791198913@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bagas Sanjaya <bagasdotme@gmail.com>

Most shell command snippets (echo/cat) and their output are already in
literal code blocks. However a few still isn't wrapped, in which the
htmldocs output is ugly.

Wrap the remaining unwrapped snippets, while also fix recent kernel test
robot warnings.

Link: https://lore.kernel.org/linux-trace-kernel/20230129031402.47420-1-bagasdotme@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/linux-doc/202301290253.LU5yIxcJ-lkp@intel.com/
Fixes: 88238513bb2671 ("tracing/histogram: Document variable stacktrace")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 93 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 5c391328b9bb..8e95295e39b6 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1864,7 +1864,7 @@ A histogram can now be defined for the new synthetic event::
 The above shows the latency "lat" in a power of 2 grouping.
 
 Like any other event, once a histogram is enabled for the event, the
-output can be displayed by reading the event's 'hist' file.
+output can be displayed by reading the event's 'hist' file::
 
   # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
 
@@ -1911,7 +1911,7 @@ output can be displayed by reading the event's 'hist' file.
 
 
 The latency values can also be grouped linearly by a given size with
-the ".buckets" modifier and specify a size (in this case groups of 10).
+the ".buckets" modifier and specify a size (in this case groups of 10)::
 
   # echo 'hist:keys=pid,prio,lat.buckets=10:sort=lat' >> \
         /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
@@ -1945,7 +1945,7 @@ the ".buckets" modifier and specify a size (in this case groups of 10).
 
 To save stacktraces, create a synthetic event with a field of type "unsigned long[]"
 or even just "long[]". For example, to see how long a task is blocked in an
-uninterruptible state:
+uninterruptible state::
 
   # cd /sys/kernel/tracing
   # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
@@ -1990,7 +1990,8 @@ uninterruptible state:
   => kthread+0xe9/0x110
   => ret_from_fork+0x2c/0x50
 
-A synthetic event that has a stacktrace field may use it as a key in histogram:
+A synthetic event that has a stacktrace field may use it as a key in
+histogram::
 
   # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
   # cat events/synthetic/block_lat/hist
@@ -2183,11 +2184,11 @@ The following commonly-used handler.action pairs are available:
               wakeup_new_test($testpid) if comm=="cyclictest"' >> \
               /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
-    Or, equivalently, using the 'trace' keyword syntax:
+    Or, equivalently, using the 'trace' keyword syntax::
 
-    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
-            trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+      # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
+              trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
     Creating and displaying a histogram based on those events is now
     just a matter of using the fields and new synthetic event in the
@@ -2320,48 +2321,48 @@ The following commonly-used handler.action pairs are available:
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, a snapshot is taken.  As part of the setup, all
     the scheduler events are also enabled, which are the events that
-    will show up in the snapshot when it is taken at some point:
+    will show up in the snapshot when it is taken at some point::
 
-    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
 
-    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
-            if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+      # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+              if comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
 
-    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
-            onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
-	    prev_comm):onmax($wakeup_lat).snapshot() \
-	    if next_comm=="cyclictest"' >> \
-	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+      # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+              onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
+	      prev_comm):onmax($wakeup_lat).snapshot() \
+	      if next_comm=="cyclictest"' >> \
+	      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
 
     When the histogram is displayed, for each bucket the max value
     and the saved values corresponding to the max are displayed
     following the rest of the fields.
 
     If a snapshot was taken, there is also a message indicating that,
-    along with the value and event that triggered the global maximum:
+    along with the value and event that triggered the global maximum::
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
-      { next_pid:       2101 } hitcount:        200
-	max:         52  next_prio:        120  next_comm: cyclictest \
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
+      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+        { next_pid:       2101 } hitcount:        200
+	  max:         52  next_prio:        120  next_comm: cyclictest \
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
 
-      { next_pid:       2103 } hitcount:       1326
-	max:        572  next_prio:         19  next_comm: cyclictest \
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+        { next_pid:       2103 } hitcount:       1326
+	  max:        572  next_prio:         19  next_comm: cyclictest \
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
 
-      { next_pid:       2102 } hitcount:       1982 \
-	max:         74  next_prio:         19  next_comm: cyclictest \
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
+        { next_pid:       2102 } hitcount:       1982 \
+	  max:         74  next_prio:         19  next_comm: cyclictest \
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
 
-    Snapshot taken (see tracing/snapshot).  Details:
-	triggering value { onmax($wakeup_lat) }:        572	\
-	triggered by event with key: { next_pid:       2103 }
+      Snapshot taken (see tracing/snapshot).  Details:
+	  triggering value { onmax($wakeup_lat) }:        572	\
+	  triggered by event with key: { next_pid:       2103 }
 
-    Totals:
-        Hits: 3508
-        Entries: 3
-        Dropped: 0
+      Totals:
+          Hits: 3508
+          Entries: 3
+          Dropped: 0
 
     In the above case, the event that triggered the global maximum has
     the key with next_pid == 2103.  If you look at the bucket that has
@@ -2439,15 +2440,15 @@ The following commonly-used handler.action pairs are available:
     $cwnd variable.  If the value has changed, a snapshot is taken.
     As part of the setup, all the scheduler and tcp events are also
     enabled, which are the events that will show up in the snapshot
-    when it is taken at some point:
+    when it is taken at some point::
 
-    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
-    # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
+      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+      # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
 
-    # echo 'hist:keys=dport:cwnd=snd_cwnd: \
-            onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
-	    onchange($cwnd).snapshot()' >> \
-	    /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
+      # echo 'hist:keys=dport:cwnd=snd_cwnd: \
+              onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
+	      onchange($cwnd).snapshot()' >> \
+	      /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
 
     When the histogram is displayed, for each bucket the tracked value
     and the saved values corresponding to that value are displayed
@@ -2470,10 +2471,10 @@ The following commonly-used handler.action pairs are available:
       { dport:        443 } hitcount:        211
 	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
 
-    Snapshot taken (see tracing/snapshot).  Details::
+      Snapshot taken (see tracing/snapshot).  Details:
 
-        triggering value { onchange($cwnd) }:         10
-        triggered by event with key: { dport:         80 }
+          triggering value { onchange($cwnd) }:         10
+          triggered by event with key: { dport:         80 }
 
       Totals:
           Hits: 414
-- 
2.39.1
