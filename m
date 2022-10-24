Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E9609542
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiJWRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiJWRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:50:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5C326DA;
        Sun, 23 Oct 2022 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666547401; x=1698083401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mG1GlUqs4r9Epxshg2wIumi9qx2R46z0xR8xpQ4Cc9Q=;
  b=S6jBkfiD+hYozeP71/MAF1XMyZkQdBz2j2CBqRti5n+ccRlu+8ZZ1Oja
   FiYobh1GNYEqP6taWldDRMyUqgwHTrV04e2S2jsKMCJ3tUwglEDZshvAG
   k+7U09WFSgFLtVBqw7LmNGqcLZ+NCPmkiqg5IDNgrzAhbaJR8vQF/by2M
   lqHLOPWRxlOYxDx2mcXTOH4HfX338MyN4hjuHBembnpyre5FwtxX2m/AF
   fXoSygsXHomdSqFaIPZ77BoposLwZ5w+Za7GW2qhiJpBilEyWf2i0nADC
   EzmNQxxjcHJupn2lHrEGA1W4bhbG3aKIECxW1vltxlspe3XvUaUCqB2S8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="306018039"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="306018039"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 10:50:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="773599326"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="773599326"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 10:49:58 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v3] dt-bindings: iio: dac: Change the I2C slave address for ds4422/4424 to its correct value
Date:   Mon, 24 Oct 2022 23:20:08 +0530
Message-Id: <20221024175008.196714-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet states that the slave address for the device is 0x20
when the pins A0 and A1 are ground. The DT binding has been using
0x10 as the value and I think it should be 0x20 as per datasheet.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---

v3:
1. Subject prefix added
2. Improvised 'examples:'

 Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
index 264fa7c5fe3a..e7c7c103d1dd 100644
--- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -36,9 +36,9 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        dac@10 {
+        dac@20 {
             compatible = "maxim,ds4424";
-            reg = <0x10>; /* When A0, A1 pins are ground */
+            reg = <0x20>; /* When A0, A1 pins are ground */
             vcc-supply = <&vcc_3v3>;
         };
     };
-- 
2.34.1

