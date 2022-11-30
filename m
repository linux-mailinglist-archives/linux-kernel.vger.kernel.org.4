Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC763DE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiK3SgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiK3SgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:36:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA84598953;
        Wed, 30 Nov 2022 10:35:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AA2BB81C9C;
        Wed, 30 Nov 2022 18:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5FEC43470;
        Wed, 30 Nov 2022 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669833353;
        bh=IvVRl4+fARp9XLGnHwE9fvcyF8luYUHd16dM9vMV/1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHDHym0fw/am9a6O1+HkdUZhYjS/i9Ib8fXUEfx3TCvQVtbQnDv5q3TH4i8PNdTwU
         T3Ll1ycSOBJ5l1LAVtpaYW75hthJoCLP4hLQ4kyh4jmHjKqTKadniT7Qaf1yTVm93y
         OJnkhsy+zZwk7VUBtd9mueaQhsH+OPdSRgUx6dpeBhW5JLhg46Tj+VsUXRsb/TmbOm
         CrKISttzd85lp40AMkRx7BpYWArFGCSF7NyD1NZnnOrPzBu6Vq97QNh8RveZjBKRN1
         L6LxCstxWJdTiYzuh9LEnu64SZLS7sggxGmn7mf9iglvHvo809ug6/csr6UukY19Gs
         UOdfbmKFJ44BA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/3] Documentation/osnoise: Add osnoise/options documentation
Date:   Wed, 30 Nov 2022 19:35:42 +0100
Message-Id: <255d17a89bcd9ca8eef6931c0052b1a520e0b580.1669832184.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1669832184.git.bristot@kernel.org>
References: <cover.1669832184.git.bristot@kernel.org>
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

