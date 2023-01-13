Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FAD668EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbjAMG7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjAMG6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:58:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15D6B1AA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UsXPpGy/prM95VIkrYPWxazmIK7wikvyDgfHZokAbC0=; b=pEff5wEaytnycOvdCYcYpe3qdv
        pXp1RmcpO703r6xc8M751KvRrHKrnx82ZXg68BbCIrK7nR3fOVIoM8fP31MDGPEta0R+XubtBL6uy
        CzofoDqG9kw97ZSaAGQiO8FdLZyXiBQbsKpGGAbCzTuRlBHqJ5K2AeIKLFN346XWGeLttQz4VFSGC
        8nQtqohiF91hBuInqoWIRahzCw2LnqFzTxdYxi4v3o9vcaCeVh1PRFdFvzqio3Y5Jf8oBvacPVXPt
        BlElvkSjDGxbfYW3P3f6cAIUMVlCEBUHO0qzgNjxuiEKES+cvfl5jPW52SSXUo6mnsZb8xKxz4/bx
        HPn1qssg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDnQ-000rra-Rl; Fri, 13 Jan 2023 06:44:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: act8945a: fix non-kernel-doc comments
Date:   Thu, 12 Jan 2023 22:44:12 -0800
Message-Id: <20230113064412.11038-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
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

Don't use kernel-doc "/**" markers for comments that are not in
kernel-doc format. This prevents these warnings:

drivers/regulator/act8945a-regulator.c:19: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * ACT8945A Global Register Map.
drivers/regulator/act8945a-regulator.c:50: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Field Definitions.
drivers/regulator/act8945a-regulator.c:56: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * ACT8945A Voltage Number

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -15,7 +15,7 @@
 #include <linux/regulator/machine.h>
 #include <dt-bindings/regulator/active-semi,8945a-regulator.h>
 
-/**
+/*
  * ACT8945A Global Register Map.
  */
 #define ACT8945A_SYS_MODE	0x00
@@ -46,13 +46,13 @@
 #define ACT8945A_LDO4_CTRL	0x65
 #define ACT8945A_LDO4_SUS	0x66
 
-/**
+/*
  * Field Definitions.
  */
 #define ACT8945A_ENA		0x80	/* ON - [7] */
 #define ACT8945A_VSEL_MASK	0x3F	/* VSET - [5:0] */
 
-/**
+/*
  * ACT8945A Voltage Number
  */
 #define ACT8945A_VOLTAGE_NUM	64
