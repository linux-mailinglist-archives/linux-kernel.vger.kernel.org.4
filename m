Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB326F541A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjECJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjECJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:12:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B059EB;
        Wed,  3 May 2023 02:12:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3439CKGK129044;
        Wed, 3 May 2023 04:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683105140;
        bh=3YA2PMZcSKiIdt6cUAIQp//I/c7gz0wH0GeQMzN9cPc=;
        h=From:To:CC:Subject:Date;
        b=BkfFOy/CqekJXqD9miVSERLWu4bEP7wTAxim2d/lSf1EJg1qTjGMhuywQ177BodIZ
         bnJiSCpmIfsd6zKLDkAivgULwwVlgyhR+Znb53/jb4EEwEvVjNG5eHVGw8JCVsNvGM
         r/BeEgM4+zfVNlFXo/5ObsrxeqUEXaOSBDlQmbWg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3439CK7i036422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 04:12:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 04:12:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 04:12:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3439CI2j066026;
        Wed, 3 May 2023 04:12:19 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: Describe flash partitions for J7 platforms
Date:   Wed, 3 May 2023 14:42:14 +0530
Message-ID: <20230503091218.25899-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds flash partition description through DT, currently
the flash partitions for J7 platforms is described through the mtdparts
commandline parameter passed from bootloader, this requires maintenance
of the partition information in a mtdparts string which is error prone.

Once the flash partitions are described through DT, the support for
mtdparts can be removed for these platforms from u-boot also.

Vaishnav Achath (4):
  arm64: dts: ti: k3-j721e-som: Describe OSPI flash partition info
  arm64: dts: ti: k3-j721e-som: Describe QSPI flash partition info
  arm64: dts: ti: k3-j721e-sk: Describe OSPI flash partition info
  arm64: dts: ti: k3-j7200-som: Describe OSPI and Hyperflash partition
    info

 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 72 +++++++++++++++++++
 .../dts/ti/k3-j721e-common-proc-board.dts     | 46 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 46 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 46 ++++++++++++
 4 files changed, 210 insertions(+)

-- 
2.17.1

