Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DF6D7AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjDELO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjDELO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:14:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F052122;
        Wed,  5 Apr 2023 04:14:25 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335BEDf3107831;
        Wed, 5 Apr 2023 06:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680693253;
        bh=3B3CcRJuA4383XpN40q6vjgRX8xzg5FtIzLr8LsCPTk=;
        h=From:To:CC:Subject:Date;
        b=DJ7Q6oMIHlrUY5g8w8pUg5+7oog3CNhgefw4p7bLYTXi0uv0HjuAvJl41UFicerno
         PEI16/eBMOrNagT5h4BQQ7k/xVQZ1tU/AFNRz/CWP1jjpaT8TS77QLMrmdr8jRPFgU
         q17WHldeBBReGkuQEMDHvUo34Qy4EhNytOpdKTIM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335BED0u004417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 06:14:13 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 06:14:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 06:14:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335BECaM026096;
        Wed, 5 Apr 2023 06:14:13 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 0/6] Add peripherals for J784S4
Date:   Wed, 5 Apr 2023 16:44:06 +0530
Message-ID: <20230405111412.151192-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for:
- SERDES, WIZ DT nodes, Serdes lane control mux
- MAIN CPSW2G nodes
- DSS and DisplayPort-0 nodes

This series depends on DMA support patches for J784S4[1] which are
applied to linux-next.

DisplayPort has been tested on local J784S4 EVM. Test log:
<https://gist.github.com/Jayesh2000/3cf965bb076968eaf4213f818d0c0541>

[1]:
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=00e34c94987e4fe866f12ad8eac17268c936880c>
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=82e6051a48957a89066d15b17bb85d2f662f2bad>
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=436b288687176bf4d2c1cd25b86173e5a1649a60>


Rahul T R (3):
  arm64: dts: ti: k3-j784s4-*: Add DSS node
  arm64: dts: ti: k3-j784s4-*: add DP & DP PHY
  arm64: dts: ti: k3-j784s4-evm: Add DP0

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane
    mux
  arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
  arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY nodes

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 164 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 338 +++++++++++++++++++++
 2 files changed, 502 insertions(+)

-- 
2.25.1

