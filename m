Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CE639107
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKYVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiKYVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:20:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0C442C5;
        Fri, 25 Nov 2022 13:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6A0BB82AEF;
        Fri, 25 Nov 2022 21:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86710C433D6;
        Fri, 25 Nov 2022 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669411239;
        bh=fM3Z9ts7iQFlYVNcl8/0c3e3g8FbZxuJ3byH62UaVoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruupuHhKnNKrd+Mso6lNPvh33EUuONTam/VAUFnQkL+O8tbAyzVsOp/1sDpk9OSEP
         DI6IiCSrg5aRM9cuT5Jfo4qgrKtadbGxOuGJHF35yIxpgIblKn+UbI7EV5eahKVKjo
         6b9C5+nj8zH/3gp0l6WOOLzM+KFT8kv6qdPQxeghL3WGAoUY+W11p+OnK0yacnHMBM
         0fwijyXUHh5Lu43mVsZ6eUxuv99hS79K1/Jwn8WZD0LSmJJW69fQl0Bro2saEA+Xnj
         BPIqiOMa55/h+4dTDF93fsVGbwfEHompw+JvRgxrN9kOBGgTNCCgd3wz7iWDXfL0VS
         jfywj/dhuQIWQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] Documentation/osnoise: Add osnoise/options documentation
Date:   Fri, 25 Nov 2022 22:20:24 +0100
Message-Id: <0a8ecf364af29b0c1d5007f4d71265127c114a1f.1669409262.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1669409262.git.bristot@kernel.org>
References: <cover.1669409262.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation about the osnoise/options file, the options,
and some additional explanation about the OSNOISE_WORKLOAD option.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/trace/osnoise-tracer.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 3c675ed82b27..0641781b00f5 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -92,8 +92,8 @@ Note that the example above shows a high number of HW noise samples.
 The reason being is that this sample was taken on a virtual machine,
 and the host interference is detected as a hardware interference.
 
-Tracer options
----------------------
+Tracer Configuration
+--------------------
 
 The tracer has a set of options inside the osnoise directory, they are:
 
@@ -115,6 +115,22 @@ The tracer has a set of options inside the osnoise directory, they are:
    NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
    special DEAFAULTS option resets all options to the default value.
 
+Tracer Options
+--------------
+
+The osnoise/options file exposes a set of on/off configuration options for
+the osnoise tracer. These options are:
+
+ - DEFAULTS: reset the options to the default value.
+ - OSNOISE_WORKLOAD: do not dispatch osnoise workload (see dedicated
+   section below).
+ - PANIC_ON_STOP: call panic() if the tracer stops. This option serves to
+    capture a vmcore.
+ - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
+   workload, allowing only IRQ and hardware-related noise.
+ - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,
+   allowing only NMIs and hardware-related noise, like hwlat tracer.
+
 Additional Tracing
 ------------------
 
-- 
2.32.0

