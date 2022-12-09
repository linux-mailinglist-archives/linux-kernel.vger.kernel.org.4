Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AEB648A93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLIWHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLIWGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:06:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA72BB0ED;
        Fri,  9 Dec 2022 14:06:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A4B62370;
        Fri,  9 Dec 2022 22:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F0FC433D2;
        Fri,  9 Dec 2022 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670623569;
        bh=13oCDAnt7f3rlE9DpU68cvHeHJUi8m64xEllotvf6ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmQSdEO+0XTok1DL97OAd+O33z9ldHg0Mc3wdZy6DDVpRFbmqa2P+Lu3LrpZRF5y2
         30Fcj1wrkIWjSnBh/PEe0JUjzfmGCI0FSITsU7X+JZMP4bRrGcceUxSFHFTIrzX6oO
         aTZ6CEiTwHDWq+Vjl243S/0Ux84N1EizjhNKWzpKh2zERTBfwGEhj4+JVoZA7qyMt5
         CD58o4vnOvf68dGlvcgMKm39NuoigakSmuJsCVKIYv5b/Z8Bl6a+GZqZz6MQ0hGYGE
         OFD+bt9nq4BaWHcbNav/ytZqSqJmpHnCjSpJShJYcNT3CEpBgnI4/+5u9o8rjzz0BO
         7YemLWYNj1OAg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/3] Documentation/osnoise: Add osnoise/options documentation
Date:   Fri,  9 Dec 2022 23:05:54 +0100
Message-Id: <fde5567a4bae364f67fd1e9a644d1d62862618a6.1670623111.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1670623111.git.bristot@kernel.org>
References: <cover.1670623111.git.bristot@kernel.org>
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
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/osnoise-tracer.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 3c675ed82b27..f2008e317223 100644
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
+   capture a vmcore.
+ - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
+   workload, allowing only IRQ and hardware-related noise.
+ - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,
+   allowing only NMIs and hardware-related noise, like hwlat tracer.
+
 Additional Tracing
 ------------------
 
-- 
2.32.0

