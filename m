Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093425FADA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJKHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJKHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:44:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8AF02F;
        Tue, 11 Oct 2022 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665474287; x=1697010287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQasmftOz/ylqQhB4r+CTnjw/m5QECuEI7OAGsf6I14=;
  b=PQb+BjWOZHHb4Gygxb6hEpf9WYLsQjDHMtabNZvn4m2ul5nws2aqnfIH
   m+b1eSrjZThBhb4xCS0c8dgEFPrU1ihphAYpghn4ygVzTXsV9RtE57I1O
   6dsZATysL2hMUVofRCMA90VdeV+R+T9GIvb8Xt0xeaRavFANsHRU9L8vS
   zCO255/8+3sjMr+pPX5b/miGEWzoqa5nQ2ICNlXb8kCW4S6yB/RTjISQ+
   +IgJCm/BAuiekDqYfWBctiPfl4ciAzipjSPn8RlliLW5kWV3auNHwiVZw
   lOOUrsKvC1czpdItsJ+NMswzrulwR5YKEEl4auHdEWb/ndtRfw9R/ndoe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="306058690"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="306058690"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 00:44:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="715417258"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="715417258"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 00:44:43 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v2] dt-bindings: iio: dac: Change the I2C slave address for ds4422/4424 to its correct value
Date:   Wed, 12 Oct 2022 13:14:46 +0530
Message-Id: <20221012074446.726409-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
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

v2:
1. Subject prefix added
2. DT bindings validated

 Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
index 264fa7c5fe3a..1955b1a97cd6 100644
--- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -38,7 +38,7 @@ examples:
 
         dac@10 {
             compatible = "maxim,ds4424";
-            reg = <0x10>; /* When A0, A1 pins are ground */
+            reg = <0x20>; /* When A0, A1 pins are ground */
             vcc-supply = <&vcc_3v3>;
         };
     };
-- 
2.34.1

