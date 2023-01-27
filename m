Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4294F67DDCF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjA0Gkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjA0GkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B369B26;
        Thu, 26 Jan 2023 22:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MQhbP0hMtr6BqR9ppLU18nCzMDHRZuJTLBNnsV14sTQ=; b=HPZzIxZ2Y24tVIs+wsteg0TY9K
        82s1noli9pOZWZV0YLGeW3+rmF40e5pIBOrH2uSR9FeesJVFoLE7ATLRnDRJKo8CF+z35x3LJV8vH
        CEzENprql+0E7oCG3LmmoA0SJ0BwUtOdGdE3cHrGA00LBXMLfxO2dFOnuuxhc5nYdy1zjYNJ8IF3B
        RitQNiZb0Ut3fS1HoBNat58IxFaAIS5jO2lTNjfytu7+Lpl5JIk3d+QNw+5yUHJzTEMOm04xRXYOe
        G7QlKMMsMBy7l//VBoiE+uT8iYF0I8kqVh4P/9KEJ9s8sFxuajCcYqLpEXMJ75FRSs+kCzc8SCen6
        DOdw9cOg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPE-00DM0u-V9; Fri, 27 Jan 2023 06:40:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 08/35] Documentation: features: correct spelling
Date:   Thu, 26 Jan 2023 22:39:38 -0800
Message-Id: <20230127064005.1558-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/features/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/features/core/thread-info-in-task/arch-support.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -1,7 +1,7 @@
 #
 # Feature name:          thread-info-in-task
 #         Kconfig:       THREAD_INFO_IN_TASK
-#         description:   arch makes use of the core kernel facility to embedd thread_info in task_struct
+#         description:   arch makes use of the core kernel facility to embed thread_info in task_struct
 #
     -----------------------
     |         arch |status|
