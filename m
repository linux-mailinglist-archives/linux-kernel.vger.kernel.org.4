Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12001615752
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKBCGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKBCGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:06:09 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F6186E1;
        Tue,  1 Nov 2022 19:06:04 -0700 (PDT)
Received: from canonical.com (unknown [106.104.136.95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 864323F5E4;
        Wed,  2 Nov 2022 02:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667354762;
        bh=PWxdG3RH5YhR4VW2Sn19vb8hwaB5J/+s0QpSAvkBRJc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Zr5hdTyN/aLrOrG4ndjZWp76LCqt8VA68DpKVZ/9bqh0MO2S+bRmFMXjOtlG17khm
         QQLakKFwSMKGOEouMW4DlEvXyV61QsVbuE7457ran+d0I9+rpFqbWcAhcwcqL3hWKI
         F8t/d8yqFQz2YizWl7RLf0Yvgd96y59us1Qi2p6AsJV/HdS1NICPGfYno453AIW3rB
         5pNHILEOWY881iT/8GgqdkQett9g8aCka1YqQB1src/JY5MLKLRCKiOgsE/JEXSjg/
         ThtDQ4//L6wrovsa421bTR/4UZct6XESHV/9mgZlzqHpvhLjDx1C8Mme/vCvFoEBhm
         t/MFpQXfuoyDg==
From:   Ivan Hu <ivan.hu@canonical.com>
To:     alex.hung@amd.com, hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel: hid: add some ACPI device IDs
Date:   Wed,  2 Nov 2022 10:05:48 +0800
Message-Id: <20221102020548.5225-1-ivan.hu@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add INTC1076 (JasonLake), INTC1077 (MeteorLake) and INTC1078 (RaptorLake)
devices IDs.

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 drivers/platform/x86/intel/hid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 79cff1fc675c..b6313ecd190c 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -27,6 +27,9 @@ static const struct acpi_device_id intel_hid_ids[] = {
 	{"INTC1051", 0},
 	{"INTC1054", 0},
 	{"INTC1070", 0},
+	{"INTC1076", 0},
+	{"INTC1077", 0},
+	{"INTC1078", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
-- 
2.34.1

