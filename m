Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C872EEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbjFMWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjFMWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773A10E6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1031F63B92
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82202C433AD;
        Tue, 13 Jun 2023 22:08:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9CBd-000EHW-1v;
        Tue, 13 Jun 2023 18:08:25 -0400
Message-ID: <20230613220825.415487197@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 13 Jun 2023 18:08:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [for-next][PATCH 11/11] Documentation: Add tools/rtla timerlat -u option documentation
References: <20230613220750.330146797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Add the -u/--user-thread option documentation for timerlat top/hist.

Link: https://lkml.kernel.org/r/bf727c8ccb8f50792200ae620141e047edf4af7a.1686066600.git.bristot@kernel.org

Cc: William White <chwhite@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/common_timerlat_options.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index bacdea6de7a3..88506b397c2d 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -26,3 +26,10 @@
         Set the /dev/cpu_dma_latency to *us*, aiming to bound exit from idle latencies.
         *cyclictest* sets this value to *0* by default, use **--dma-latency** *0* to have
         similar results.
+
+**-u**, **--user-threads**
+
+        Set timerlat to run without a workload, and then dispatches user-space workloads
+        to wait on the timerlat_fd. Once the workload is awakes, it goes to sleep again
+        adding so the measurement for the kernel-to-user and user-to-kernel to the tracer
+        output.
-- 
2.39.2
