Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E2749048
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGEVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGEVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:52:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B6199F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:52:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so4288a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688593922; x=1691185922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG5sHhRilqQNOqdg7J34jIBo6Ejr3LEqWSkoVpRsi9I=;
        b=eIV+QNlYmoIToossEO8Dr2P2tCM4DMYnFyd5SjAMU/ToJzxZEKeOH5CBebCKRd9IAZ
         Cug25UC1mzVYGrUHRpn40fvyuB3KTlWODuncWkgEnRCidvIkHtFTREZGTGzx8q+6UXXS
         zZ8g1kJvPy2+AAfkx48C4DvCYAejkrTmrU2IoDNhQK+00FA8tUapR61Og+U7m5jVk3Nr
         CeYazCkSM6CI4gQ47nhtTODWMAS9RsPyt03z3OlXdfGiiayAZcJBWhTpNYfp9IWI9Dui
         brgQK37yVZodTIc1tD9lr+mC4evztPGbPgrXeb/hdVYiLCqmyhUWD//V05PGb1uAbOi7
         NjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593922; x=1691185922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pG5sHhRilqQNOqdg7J34jIBo6Ejr3LEqWSkoVpRsi9I=;
        b=dKElWEVWBfAy536awkSRp4Kchu1E6dt4wWQVDvy7D3AeKxUjcVAmYvIlEE/Ag+nN2V
         JJGY8J1+VRRVm4EDy+Z6Sxtxf4SrHG/tt6vrDau+nGMHrOpmmE4xsVKAEDanZuZAUT/5
         Y1FwXWhkRhgzqUgM/e6XuXNvKeNTKG9LrxrT+jSjP9blY4eGr3GhEWf3yD4MohqAGJHw
         OJiMr4VFSRuSBceTrMsaq3IweOp43MQajTCXFYQ78G4ub94yMqCeTIZSGIRn7EIopv+F
         VXKyq4MKDnGOqZcgWdeseAl/IBQOEuG4sBYHo93Uraj6F9l82YuoO54vkzGW1m1XIqu+
         c/Nw==
X-Gm-Message-State: ABy/qLbpsbeUTFBePT/pZNkBZiIj5IjW9kZ22MyBzeuqv3f35b+mBUt9
        bmh2HdeC10PJK8u///c10lMOAQ==
X-Google-Smtp-Source: APBJJlFQBL/wCz465Zw1ZtK1mNIEpYPnxpiJxI3FGjpuhJIYr7DbB8e4FbPxfBYA+///mA+qmWO+Ag==
X-Received: by 2002:a50:9fce:0:b0:519:7d2:e256 with SMTP id c72-20020a509fce000000b0051907d2e256mr21130edf.0.1688593921725;
        Wed, 05 Jul 2023 14:52:01 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdd4c000000b0030ab5ebefa8sm87738wrm.46.2023.07.05.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:52:00 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH] ubsan: Clarify Kconfig text for CONFIG_UBSAN_TRAP
Date:   Wed,  5 Jul 2023 23:51:27 +0200
Message-ID: <20230705215128.486054-1-jannh@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clearer in the one-line description and the verbose description
text that CONFIG_UBSAN_TRAP as currently implemented involves a tradeoff of
much less helpful oops messages in exchange for a smaller kernel image.
(With the additional effect of turning UBSAN warnings into crashes, which
may or may not be desired.)

Signed-off-by: Jann Horn <jannh@google.com>
---
 lib/Kconfig.ubsan | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index efae7e011956..e4f19ba9a029 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -13,7 +13,7 @@ menuconfig UBSAN
 if UBSAN
 
 config UBSAN_TRAP
-	bool "On Sanitizer warnings, abort the running kernel code"
+	bool "Abort on Sanitizer warnings (smaller kernel but less verbose)"
 	depends on !COMPILE_TEST
 	help
 	  Building kernels with Sanitizer features enabled tends to grow
@@ -26,6 +26,14 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
+	  CAUTION: Selecting Y will (depending on architecture) cause your
+	  kernel to oops with an undefined instruction error with no further
+	  details when a UBSAN violation occurs.
+	  (arm64 can show some basic information.)
+	  This may make it hard to determine whether an oops was caused by
+	  UBSAN or to figure out the details of a UBSAN violation.
+	  It makes the kernel log output less useful for bug reports.
+
 config CC_HAS_UBSAN_BOUNDS_STRICT
 	def_bool $(cc-option,-fsanitize=bounds-strict)
 	help

base-commit: d528014517f2b0531862c02865b9d4c908019dc4
-- 
2.41.0.255.g8b1d071c50-goog

