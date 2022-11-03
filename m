Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49D618693
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKCRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKCRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:48:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632281D665;
        Thu,  3 Nov 2022 10:47:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3HllGr092639;
        Thu, 3 Nov 2022 12:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667497667;
        bh=SCFoXo6JQqijKivQIzRSBvFg0c19eJmk4BQWe5F8eOc=;
        h=From:To:CC:Subject:Date;
        b=oZ7gfnQNeMe3vTwsuWojiWsaY2NM7lOsk4/xKkx8OIkU1O3mi4n7Pbg2YfdhppAec
         hxs7WPXzTET6bqR+vGmq7uD5kFHgldI2v41QZcZHacuXlO5tzZGM4uY4Z9gzRW6Kj8
         w5FrdG8z8TBwzc8fkKikuP/rZexKu8Y0mZPlL3MY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3HlloX000688
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 12:47:47 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 12:47:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 12:47:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3Hlkir120221;
        Thu, 3 Nov 2022 12:47:47 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <r-ravikumar@ti.com>, <jkridner@gmail.com>
Subject: [PATCH v7 0/2] Enable RPi header on j721e sk
Date:   Thu, 3 Nov 2022 23:17:41 +0530
Message-ID: <20221103174743.16827-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches enables RPi header
on j721e sk. It is a 40 pin io expasion header which
brings out i2c5, ehrpwm 2,3 and some pins of gpio 0,1

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

