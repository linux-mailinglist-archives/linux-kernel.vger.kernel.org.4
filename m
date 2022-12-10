Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20B7648F12
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLJN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87A18B1D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C385860C1C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E270C433F2;
        Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40N0-000kvM-2S;
        Sat, 10 Dec 2022 08:58:26 -0500
Message-ID: <20221210135826.629673261@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        kernel test robot <lkp@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 22/25] Documentation/osnoise: Escape underscore of NO_ prefix
References: <20221210135750.425719934@goodmis.org>
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

From: Bagas Sanjaya <bagasdotme@gmail.com>

kernel test robot reported unknown target name warning:

Documentation/trace/osnoise-tracer.rst:112: WARNING: Unknown target name: "no".

The warning causes NO_ prefix to be rendered as link text instead, which
points to non-existent link target.

Escape the prefix underscore to fix the warning.

Link: https://lkml.kernel.org/r/20221125034300.24168-1-bagasdotme@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Link: https://lore.kernel.org/linux-doc/202211240447.HxRNftE5-lkp@intel.com/
Fixes: 67543cd6b8eee5 ("Documentation/osnoise: Add osnoise/options documentation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 3c675ed82b27..fdd562d7c22d 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -111,7 +111,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    be used, which is currently 5 us.
  - osnoise/options: a set of on/off options that can be enabled by
    writing the option name to the file or disabled by writing the option
-   name preceded with the 'NO_' prefix. For example, writing
+   name preceded with the 'NO\_' prefix. For example, writing
    NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
    special DEAFAULTS option resets all options to the default value.
 
-- 
2.35.1


