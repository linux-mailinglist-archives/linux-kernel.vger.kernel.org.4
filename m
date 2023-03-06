Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F66AD18A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCFWam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFWak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:30:40 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFC4A1EC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:30:38 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326MUNhp052700;
        Mon, 6 Mar 2023 16:30:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678141823;
        bh=oiJ924q/QZp5Phdfe3T7YiQFP+wbldkIbyadg4ySWRY=;
        h=From:To:CC:Subject:Date;
        b=OZWklo7WHNHXnK6x85VxvcjZukzPCQZ4/cazT3mBG8J3Sih0v4ZGhTL28/KMbvz59
         EXTKAVwS+mSBOHn2HP2sSfES7kUaiMj0vIlc8AK2txGQFW+a+rPVdvVQg8sjde/4hv
         V7dQWkOmD3EEl+NZBSKbs0FS18Vu4umS15TkOxUg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326MUNAb024015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 16:30:23 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 16:30:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 16:30:22 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326MUMjU014052;
        Mon, 6 Mar 2023 16:30:22 -0600
From:   Andrew Davis <afd@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm64: defconfig: Enable TI SA2UL support
Date:   Mon, 6 Mar 2023 16:30:22 -0600
Message-ID: <20230306223022.23757-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI K3 devices include an SA2UL security accelerator engine for crypto
offload. Enable this module.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..98b5738bdbb7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1440,6 +1440,7 @@ CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
 CONFIG_CRYPTO_DEV_HISI_HPRE=m
 CONFIG_CRYPTO_DEV_HISI_TRNG=m
+CONFIG_CRYPTO_DEV_SA2UL=m
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-- 
2.39.2

