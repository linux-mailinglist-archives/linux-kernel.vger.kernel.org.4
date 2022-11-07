Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29461EB49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKGHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiKGHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:00:36 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4DA1A7;
        Sun,  6 Nov 2022 23:00:35 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A770EXb030636;
        Mon, 7 Nov 2022 01:00:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667804414;
        bh=OTo+Xm0LLMpKYjcmo8+Nfpz0pR92+Aad1tJoD/qnJ/s=;
        h=From:To:CC:Subject:Date;
        b=SnnnTZk2v7IKw1EAFO63uwVzX3nmuGbXkfOEuiSgKLujyM1VgJR+E5sQxvpLj6YNk
         Pb3xLOSCfTgUldn25szvZKthliiNGPcBadjfJZmgvAf9pUHXG8uI3ohqkFhWbqVCMN
         mazS141HG3DoQXJ5CqHfsEc5RkPp25coVL6AHx+Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A770E6N002568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 01:00:14 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 7 Nov
 2022 01:00:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 7 Nov 2022 01:00:14 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A770Dmc109678;
        Mon, 7 Nov 2022 01:00:13 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <r-ravikumar@ti.com>, <jkridner@gmail.com>
Subject: [PATCH v8 0/2] Enable RPi header on j721e sk
Date:   Mon, 7 Nov 2022 12:30:07 +0530
Message-ID: <20221107070009.11500-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches enables RPi header on j721e sk. It is a
40 pin io expansion header which brings out i2c5, ehrpwm 2,3 and some pins
of gpio 0,1

v8:
   - Fixed the wraparound scheme in commit messages to 75 characters
   - Added explanation in 1 for why the nodes are disabled

v7:
   - Rebased to next-20221103
   - Move setting status diable to main dtsi

v6:
   - Rebased to 6.1-rc1

v5:
   - Enable only gpio's and i2c on the RPi Header
     as per the discussion in the v4

v4:
   - Correct the node name in dt binding example

v3:
   - Change node name from clock to clock-controller
   - Add correct description for clock-controller node

v2:
   - Add full path for clock property $ref
   - Remove the discription for clock pattern property,
     since $ref is added
   - Remove the label in the example
   - Fix the indentation in the example

Rahul T R (1):
  arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header

Vijay Pothukuchi (1):
  arm64: dts: ti: k3-j721e-main: Add dts nodes for EHRPWMs

 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 68 ++++++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts    | 59 ++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)

-- 
2.38.0

