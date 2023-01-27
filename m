Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E19C67E8D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjA0PB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjA0PBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:01:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F97ECA;
        Fri, 27 Jan 2023 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674831714; x=1706367714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ApPiS4EvoBtDwvRAhJt0tSF0uBf/eLVUGcW9RYtTxUU=;
  b=B5C8w2r/dJu7jpItquhc/gA2k0vKEICUteJoG42UzaDfBHpMx/kN9iSs
   f8+pGRRxVnn/QNbCa/nWqPS52gba4QBJZPlOdtzHSWsl3JN5/ZOgvL0Mf
   9UXoXWwrVE16jUB2SE3MzOkMxVl2gGP9i3SXGjbr0Zir2CRZENPJnFlN6
   2ygOT4ewGPtiMiP64TKaknmBAH99ie0hNekyIBnxkKdaAVoL1lHmAkFyw
   xHxIXvWnX8tmkNm9hXoZ9T1XP8ki06YixVjNM0/tQt2YqR+mcMoLBeVEB
   iykRS7/tVeWRiTb1SQBTTHkuhrq2Nx1k76XKmWPEjoY7QM6CJBVpphBom
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307446621"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="307446621"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663289235"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="663289235"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 07:01:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10DD91A5; Fri, 27 Jan 2023 17:02:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v1 1/1] dt-bindings: Fix .gitignore
Date:   Fri, 27 Jan 2023 17:02:25 +0200
Message-Id: <20230127150225.18148-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracked files should not be ignored.

Fixes: 44ec8b20d1e9 ("dt-bindings: Add running yamllint to dt_binding_check")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/devicetree/bindings/.gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
index a77719968a7e..51ddb26d93f0 100644
--- a/Documentation/devicetree/bindings/.gitignore
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -2,3 +2,8 @@
 *.example.dts
 /processed-schema*.yaml
 /processed-schema*.json
+
+#
+# We don't want to ignore the following even if they are dot-files
+#
+!.yamllint
-- 
2.39.0

