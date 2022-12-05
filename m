Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C364248D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiLEI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiLEI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:27:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371BC631C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3F0FB80BA7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE96C433D6;
        Mon,  5 Dec 2022 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670228867;
        bh=Ua9UvicTWdmfiQzfItuIQ0rvFf4ztlHlLpyAYSU1PII=;
        h=From:To:Cc:Subject:Date:From;
        b=kiCtAFr00DZDsnilkYWYcicYvTT0uk7Dm9FHWyBBPjWAbs1bQ+zPSnjTAkVWKYfEL
         sGpwJ8RFcD6yUB0XwktuS0PTvBz8LdPoBMMZNaUluERRI7mFHpvWg+WZ4CsKFxd8uq
         tzvtOXZU0elebbRkyyFaRypo35/ZRw+DqKvo4nBwzGaQI21QvLQXU/vUCQUvfPTtbP
         j+1OqyUdClUo24Mni9L+YqlpgX2KDy/C1ApZ104pP7pLSLlFxDxQrO/IUwEvGUORPO
         PCpe6W8wNSjvY8kKHZK7QU+63w8+MCrG7vWNL3/Eizdb2Cb0Uq4fXi/CaHEObLV3Cf
         Fx/VFKyqBYSNw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/osnoise: Make osnoise_options static
Date:   Mon,  5 Dec 2022 09:27:38 +0100
Message-Id: <63255826485400d7a2270e9c5e66111079671e7a.1670228712.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
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

Make osnoise_options static, as reported by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0ec8bb54180f..f190bd43e79c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -67,8 +67,8 @@ static const char * const osnoise_options_str[OSN_MAX] = {
 							"OSNOISE_PREEMPT_DISABLE",
 							"OSNOISE_IRQ_DISABLE" };
 
-#define OSN_DEFAULT_OPTIONS	0x2
-unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
+#define OSN_DEFAULT_OPTIONS		0x2
+static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
 
 /*
  * trace_array of the enabled osnoise/timerlat instances.
-- 
2.32.0

