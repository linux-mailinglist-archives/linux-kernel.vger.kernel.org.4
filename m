Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9163D4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiK3LuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiK3LuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:50:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411F3E0A0;
        Wed, 30 Nov 2022 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669809006; x=1701345006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8XKqgebmXUSiaMQSAtHQW4ztiKX0139fFBUxXffoEs=;
  b=HQT1TzgAXlQKiib7NtUFWAZwVUh868cQMTEnMualdRlWSIU1nK/OTojl
   0zcvP7IBCUBxmDIJZj0mEG69c0w0YJWDgm6rx9tpHR4SOcJmV8/Zmz+BR
   BZam8CMzNsPDJjb+ORNUbLwZ28Most0aE2FSRHdFQBLqmQITyj8gcP+ZS
   BQQVejabkwdo7EnMZNhm5OMZ+VQZrTfkbP0M1AFnCDnfPpImbSIMIqsoI
   dONQOUen+g/webfTVp0YuAmzaraZWHmgehZPvqOujPdcrre2oFsXoRxIi
   vNj39H7VbbW5g6aJCWjNJ38vxGClBsFY8pynVd5gS84/+1H+mlSgpGHlO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="298748041"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="298748041"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 03:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="732959314"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="732959314"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2022 03:50:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D15EC6A; Wed, 30 Nov 2022 13:50:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 2/3] lib/string_helpers: Add str_high_low() helper
Date:   Wed, 30 Nov 2022 13:50:21 +0200
Message-Id: <20221130115022.68956-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130115022.68956-1-andriy.shevchenko@linux.intel.com>
References: <20221130115022.68956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add str_high_low() helper to return 'high' or 'low' string literal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 8530c7328269..fd72393e7975 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -128,6 +128,11 @@ static inline const char *str_enabled_disabled(bool v)
 	return v ? "enabled" : "disabled";
 }
 
+static inline const char *str_high_low(bool v)
+{
+	return v ? "high" : "low";
+}
+
 static inline const char *str_read_write(bool v)
 {
 	return v ? "read" : "write";
-- 
2.35.1

