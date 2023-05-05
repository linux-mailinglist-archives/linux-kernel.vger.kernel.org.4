Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A066F8263
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjEEL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEEL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:59:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655391884B;
        Fri,  5 May 2023 04:59:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345Bx0J5119236;
        Fri, 5 May 2023 06:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683287940;
        bh=+FJrfXC9RXZ7hEc6gYJ+SpjD/MV5D6z3AAn4ws3tAWs=;
        h=From:To:CC:Subject:Date;
        b=JEs6Rp65UAfPRbDq1uTvR00jjabZJCLEHWNpjvPdH8rGVsglzNYrCZf+RXBDarSC/
         KUGQkrH06mH9TWf3Aj5ipOEUPne/rJZT4Ulkvn7zNc99VQyPvROlAiz9SoXqCH8UjV
         i1Gh+SvQkKoVePeee7Z9ZeSqDgJzOGcvSG3hwPZ0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345Bx0Rb029013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 06:59:00 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 06:58:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 06:58:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345BwwkX033861;
        Fri, 5 May 2023 06:58:59 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v2 0/3] arm64: dts: ti: k3-j7200: Fixes for various dtbs_checks warnings
Date:   Fri, 5 May 2023 17:28:55 +0530
Message-ID: <20230505115858.7391-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few fixups for j7200 dtbs_check warnings.

This is V2 for the following series with the feedback addressed,

V1 : https://lore.kernel.org/all/20230424173623.477577-1-nm@ti.com/

Bootlog with basic hyperflash testing:
https://gist.github.com/vaishnavachath/f7265e932725fd992dbc4e48b993e9c0

NOTE: lets see the discussion summary of [1] to see where to take this
series, but, will put it out here in the list for discussion anyways.

Patch 3/3 depends on the following patch under review which enables reg-mux
to be used when parent node is not syscon :
https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Changelog:

V1->V2:
 * Address feedback as recommended in [2].
 * Address feedback from Udit to limit the FSS register region size as
 per TRM.
 * Use reg-mux changes in [3] to simplify the hbmc-mux modelling   

[1] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
[2] https://lore.kernel.org/all/20230503115130.c7m4a7crub7kmfjw@gluten/
[3] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Nishanth Menon (3):
  arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix
    from nodename
  arm64: dts: ti: k3-j7200-mcu-wakeup: Switch mcu_syscon to
    ti,j721e-system-controller
  arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss node and hbmc_mux

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.17.1

