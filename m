Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8B75BF391
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIUCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIUCke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:40:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F236DF8;
        Tue, 20 Sep 2022 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728033; x=1695264033;
  h=from:to:cc:subject:date:message-id;
  bh=zVh0oYIy9y1opOEwiMk1DNjymznwB43MlPe1XapXiDo=;
  b=jG0E4k3djvYgtX+x2A3CpSsn8PAzQI/3V/PLSFHi92siRdC7+YvLCA7o
   4BgJeoRkHhMyWcWxv3qZ+uYaLLlVu/FStxDS6lgQq6btE6QUIB6ETOZng
   5A0boGJKwMPqWgX+4kiSVXDuw6ywrLSuyIOuZsOssPd2m42fPJhqWqPmG
   Cm4a+YxP+dv2KOKQpDDu+3/G+BO4QFBaLKhhP6jwWKmt+hAWuMfUhPxlL
   OOhLqsgAc6X3lepJHvFqAJzvuRJ/dqBGAGsYHGXQdELPjF1xlndjwvJ8r
   GbzAzZ1FseNiFzYtv4mPu1Ln83tGfTRGNoIDuNz05DARUf0KvAdG3J+/w
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298600310"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="298600310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649856582"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.170])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2022 19:40:31 -0700
From:   ji.sheng.teoh@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: [PATCH] ARM: dts: socfpga: arria10: Increase NAND boot partition size
Date:   Wed, 21 Sep 2022 02:45:19 +0000
Message-Id: <20220921024519.92827-1-ji.sheng.teoh@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teoh Ji Sheng <ji.sheng.teoh@intel.com>

Content in NAND boot partition have exceeded 32MB defined in device
tree node.
Increase boot partition size to 37MB to support larger kernel Image
and FPGA bitstream.

Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
index 9aa897b79544..a662df319a84 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
@@ -16,11 +16,11 @@
 
 		partition@0 {
 			label = "Boot and fpga data";
-			reg = <0x0 0x02000000>;
+			reg = <0x0 0x02500000>;
 		};
 		partition@1c00000 {
 			label = "Root Filesystem - JFFS2";
-			reg = <0x02000000 0x06000000>;
+			reg = <0x02500000 0x05500000>;
 		};
 	};
 };
-- 
2.17.1

