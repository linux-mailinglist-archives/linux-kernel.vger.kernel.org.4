Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3C7248B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbjFFQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbjFFQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9719BD;
        Tue,  6 Jun 2023 09:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DF4462DE6;
        Tue,  6 Jun 2023 16:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEEBC4339E;
        Tue,  6 Jun 2023 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067983;
        bh=SNMZc0L/b6GLmVD1yPrxAZQaDWAwMEPVbWJyNUZPapU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISrLLMAQMED7jumB7rUxj4NLoUAL1EUyBok+B70FXLeTV8RbWw2YEyhDwpUUt2W+8
         BSxK7qj0Xsy1sBuOEiYEIDscWsMI8kOhRR5UpQ1uYg9B2NN7A3Omlc1BfNFBZY0dvi
         4brp+zhcc4iOG+YQwY906r240v+Ox0bb7YrQqkZA2AgpiYnVG/xEO7OM3wnAUf3T1a
         tC7uJTlisTSrjMOg93qS/eQVXTnpCtKJ4KNPzc+VxwQ0RwYF7suOc5KDTQFRGDOVrk
         M4xRJ0dhiRl0bQyu6vIGQpuwUPKNMeKGpLwXJPqYVcPlyuNBp7fyJKxA9iF59EasAc
         mSJfqaSQpNEEQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 11/11] Documentation: Add tools/rtla timerlat -u option documentation
Date:   Tue,  6 Jun 2023 18:12:25 +0200
Message-Id: <bf727c8ccb8f50792200ae620141e047edf4af7a.1686066600.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686066600.git.bristot@kernel.org>
References: <cover.1686066600.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the -u/--user-thread option documentation for timerlat top/hist.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.38.1

