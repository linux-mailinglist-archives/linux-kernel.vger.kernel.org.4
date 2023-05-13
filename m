Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABC701618
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbjEMKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbjEMKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:14:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6CA59F1;
        Sat, 13 May 2023 03:14:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DADjNm049618;
        Sat, 13 May 2023 05:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683972825;
        bh=VZiGaSRwfxQ1m1Ftgi42TfZjHfxaE9EtRyEDoM9SDZg=;
        h=From:To:CC:Subject:Date;
        b=vn2VUgVLUy3P6P/Tl78U4uG3nTDgyBxdEgLlROt8cFYcxYMLDpN5XKGyCHUlqYDhg
         O/TPglQjxb1ShDBnxNOpvpPIWY2jJgOINMWE2LE7ezu8bnYqrZmSDHlnLy1/XYKQ1D
         lBtgcA+vUHDEiULBIVd5n+KjMT79b5a2G+9/L5E4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DADjZE039606
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 05:13:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 05:13:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 05:13:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DADiWO096468;
        Sat, 13 May 2023 05:13:44 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 0/2] arm64: dts: ti: k3-j7200: Fixes for various dtbs_checks warnings
Date:   Sat, 13 May 2023 15:43:41 +0530
Message-ID: <20230513101343.785-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Hi,

Few fixups for j7200 dtbs_check warnings.

This is V3 for the following series with the feedback addressed,

V2 : https://lore.kernel.org/all/20230505115858.7391-1-vaishnav.a@ti.com/
V1 : https://lore.kernel.org/all/20230424173623.477577-1-nm@ti.com/

Bootlog with basic hyperflash testing:
https://gist.github.com/vaishnavachath/f7265e932725fd992dbc4e48b993e9c0

NOTE: lets see the discussion summary of [1] to see where to take this
series, but, will put it out here in the list for discussion anyways.

Patch 2/2 depends on the following patch under review which enables reg-mux
to be used when parent node is not syscon :
https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Changelog:

V2->V3:
  * Drop pinctrl fix patch as the fix [2]  is already merged to next.
  * Keep register regions unchanged as it is correct according to memory
  map, update commit message.

V1->V2:
 * Address feedback as recommended in [3].
 * Address feedback from Udit to limit the FSS register region size as
 per TRM.
 * Use reg-mux changes in [4] to simplify the hbmc-mux modelling   

[1] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
[2] https://lore.kernel.org/all/20230510091850.28881-1-tony@atomide.com/
[3] https://lore.kernel.org/all/20230503115130.c7m4a7crub7kmfjw@gluten/
[4] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Nishanth Menon (2):
  arm64: dts: ti: k3-j7200-mcu-wakeup: Switch mcu_syscon to
    ti,j721e-system-controller
  arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss node and hbmc_mux

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1

