Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2344E70969C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjESLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjESLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:34:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398A191;
        Fri, 19 May 2023 04:34:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34JBYbmT009516;
        Fri, 19 May 2023 06:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684496077;
        bh=pB8EcmG5DRzsmWnHsMkw+rVBSGV0lFJeOB+vpG9qRv0=;
        h=From:To:CC:Subject:Date;
        b=D41gHbMhW5b4SXzEzdfdVSMt+mN+tCqvpdu09kaTUV5SUsmtdrg3xuxPE0dFFRz5L
         GJjnZ3kSoEnP3mP3eOenVxyv5P5RFzmsLYsTSYfsCcUuVCffNApq4d/qH1YC7iK+Fd
         M7NyB+hwPSZ9Gm9GFWu37ZMVuKrs6kM4fyC8ucOk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34JBYajV064353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 May 2023 06:34:37 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 May 2023 06:34:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 May 2023 06:34:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34JBYZu9009404;
        Fri, 19 May 2023 06:34:36 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add minor updates in device trees
Date:   Fri, 19 May 2023 17:04:32 +0530
Message-ID: <20230519113434.1024206-1-n-yadav@ti.com>
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

Changes in v2:
 - Added comment for sa3_secproxy node in k3-am62-main.dtsi
 - Replaced 0x0 from 0x00 in sa3_secproxy node.

Nitin Yadav (2):
  arm64: dts: ti: k3-am62x-sk-common: Add main_uart1 and wkup_uart nodes
  arm64: dts: ti: k3-am62-main: add sa3_secproxy in cbass_main

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  9 +++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.25.1

