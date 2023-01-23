Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284D678413
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjAWSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjAWSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14DD14EB4;
        Mon, 23 Jan 2023 10:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2AE32CE13D8;
        Mon, 23 Jan 2023 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E909C433D2;
        Mon, 23 Jan 2023 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674497084;
        bh=OByf8UAQM1froAa+EUYWH+/qVy3lENGQq0kU0er7rIg=;
        h=From:To:Cc:Subject:Date:From;
        b=PPvjHG53TbpIbBr3Hnznki5PAgCGX8jgVoYqJt5LM9JMrYEyCFVrjjm9nZyCx1sqt
         cJsdpCwIpx6hJ6JONade8ZXntrS9NfzgwjdLh4Y2rEMhaz6lS6Sd58qb2WFi8of0aJ
         SkqpuFZqUiRY96bXwue5KnpTI9/5Q910oP0JqDU2h0KQFqRDrSsP9fuw23gmGahDsL
         6yZr8RqGVe5MjJws6ICQbQt8gAocDm7rdIoHMwSlBXGP2OAo9kG2asFIhQGmAxdjwf
         rZK5SDKHmGfaUirLjUkYK1UWtkEBs0czoDpUfBhBJuzz5GVcdSvIFLCMbkH8QxCbu6
         ET9ZKE0tOuvdQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] printk: Document that CONFIG_BOOT_PRINTK_DELAY required for boot_delay=
Date:   Mon, 23 Jan 2023 12:04:40 -0600
Message-Id: <20230123180440.901793-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Bjorn Helgaas <bhelgaas@google.com>

Document the fact that CONFIG_BOOT_PRINTK_DELAY must be enabled for the
"boot_delay" kernel parameter to work.  Also mention that "lpj=" may be
necessary.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..b0b40b6a765c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -480,8 +480,9 @@
 			See Documentation/block/cmdline-partition.rst
 
 	boot_delay=	Milliseconds to delay each printk during boot.
-			Values larger than 10 seconds (10000) are changed to
-			no delay (0).
+			Enable CONFIG_BOOT_PRINTK_DELAY and also specify
+			"lpj=".  Boot_delay values larger than 10 seconds
+			(10000) are changed to no delay (0).
 			Format: integer
 
 	bootconfig	[KNL]
-- 
2.25.1

