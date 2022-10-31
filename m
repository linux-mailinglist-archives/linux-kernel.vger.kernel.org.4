Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838B9613FED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJaVcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:32:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D5101C8;
        Mon, 31 Oct 2022 14:32:47 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VLWeN3037547;
        Mon, 31 Oct 2022 16:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667251960;
        bh=hyqPOve8K4dEXgmRmRXSf+ygMWtM+hnvpMCUdYeSWns=;
        h=From:To:CC:Subject:Date;
        b=OvP7zNQwZkEXSiIHaEmJNpCwt8koy2RDD80Rysh2GmrE204VcxX4VG56pcwa3nua1
         QNNqwBIbSDhMqfWh9ogKhPBNxo6lM+TyVaQvXmzlsz8YHEwm14sUcyG75cdASbaxM3
         qFdXjGx9soD3AWW76gI7V6ffelSg3r9r6TdNrOJs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VLWej0077720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 16:32:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 16:32:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 16:32:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VLWcRt051229;
        Mon, 31 Oct 2022 16:32:39 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <afd@ti.com>,
        <j-keerthy@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 0/3] RNG clock property cleanup
Date:   Tue, 1 Nov 2022 03:02:34 +0530
Message-ID: <20221031213237.52275-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
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

This series removes the clock property from the rng node of
K3 devices for TI SoCs as that clock is not dedicated to RNG
module and it cannot be controlled by the rng driver.

DT binding fix:
<https://lore.kernel.org/all/20220901171041.32056-1-afd@ti.com/>

Jayesh Choudhary (3):
  arm64: dts: ti: k3-am65-main: drop RNG clock
  arm64: dts: ti: k3-j721e-main: drop RNG clock
  arm64: dts: ti: k3-am64-main: drop RNG clock

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi  | 1 -
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 -
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
 3 files changed, 3 deletions(-)

-- 
2.25.1

