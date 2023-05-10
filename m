Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77E6FDDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjEJMcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbjEJMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:32:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93249F7;
        Wed, 10 May 2023 05:32:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34ACWI1C117236;
        Wed, 10 May 2023 07:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683721938;
        bh=PZN8WyZ2pR45oUMyI7Bugm98MWZG9HyapnGIPimpSNQ=;
        h=From:To:CC:Subject:Date;
        b=ZgxnEsOlHNUf86Hox7DRGThmXU/TkGMRcFNjl9fmjbWEY6Q71xjkswQehsGGZpCsI
         KaKuFk1owB/x8izZWWhXLoi4gEPpklF/tUTfZ320CreEHtlINEoZze6krHPZqO1WXS
         aXZwStd5/HNDZx4XSh3538A18iIF9nmu9jOSInVE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34ACWImE011834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 May 2023 07:32:18 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 May 2023 07:32:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 May 2023 07:32:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34ACWG9K076795;
        Wed, 10 May 2023 07:32:17 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add minor updates in device trees
Date:   Wed, 10 May 2023 18:02:14 +0530
Message-ID: <20230510123216.3440019-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor Device Tree updates to be able to use common Device
trees with u-boot. These updates include adding main_uart1
and wkup_uart1 into k3-am62x-sk-common.dtsi and sa3_secproxy
node in k3-am62-main.dtsi

Nitin Yadav (2):
  arm64: dts: ti: k3-am62x-sk-common: Add main_uart1 and wkup_uart nodes
  arm64: dts: ti: k3-am62-main: add sa3_secproxy in cbass_main

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  9 +++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.25.1

