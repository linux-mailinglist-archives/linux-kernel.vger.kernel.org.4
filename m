Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07CC6AF170
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjCGSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjCGSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:43:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363B9EF41;
        Tue,  7 Mar 2023 10:33:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0AD26CE1C86;
        Tue,  7 Mar 2023 18:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67791C4339C;
        Tue,  7 Mar 2023 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213740;
        bh=86KQLMriTm2rEbApaorsRI4bA6ciwDz7r8N+iPI0q2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qID2ndgLHMBKTJVy/U/jXfv4TjPd/cIaAVgijlVrj1laJ87yNDO0eGQ0/hwasTYoc
         del+NqvbHWY5MvRVSX3m2CDfe4iADyLHbMAVnb81wcPsPgOenD5YCHFzlcbrZC8/yl
         nQukjG0jQiNEVh9ukSkKd21aUzfTHQv/uXomatL/8zFcLFvR+LFnb3Tx7+6UevX4nQ
         mJ8LxPPLBNmkg17nE//GYNYKXPaTAmi/kz7zGyZokTfrxW2IZCnaiQ+woUy0uH05g1
         mWnscDXkBf2OAFhlvDcGzRtnewFThEQ6cdf+05Z7UvjwwHf/Cl3KyLD1W7kWt51Fi/
         QrBG0sqxwN5gQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 05/10] scsi: csiostor: Remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 12:28:37 -0600
Message-Id: <20230307182842.870378-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org>
References: <20230307182842.870378-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/scsi/csiostor/csio_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index ccbded3353bd..0c32faefad7c 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -38,7 +38,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/kdebug.h>
-- 
2.25.1

