Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C31618721
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKCSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKCSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:09:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DE2182
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:09:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3I8nvc097066;
        Thu, 3 Nov 2022 13:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667498929;
        bh=aGTxsNcVNztQ+ZzE2cvzJwKkLyfKr2l61C9dShSFC9I=;
        h=From:To:CC:Subject:Date;
        b=rMGtqoclj9G+zYjwzG1vuELJOgD5GWEQJQvuyZWenki3m8+0zC4/vCbMym8K080UW
         vmmd0yB3IMRB7Mv9cnjSF+ZT+yYNFB3qzz2B3Ly/6BUrWWvZbQcoFncU3IGvuBeTNV
         7ix+BBTZ2Yi5n8PFo9anCnuOfT6Sdp0YAopoSdfs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3I8nQx106156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 13:08:49 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 13:08:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 13:08:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3I8lLE007289;
        Thu, 3 Nov 2022 13:08:48 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <bjorn.andersson@linaro.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vigneshr@ti.com>, <nm@ti.com>
CC:     <biju.das.jz@bp.renesas.com>, <vkoul@kernel.org>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <r-ravikumar@ti.com>
Subject: [PATCH] arm64: defconfig: Enable TI_TFP410 DVI bridge
Date:   Thu, 3 Nov 2022 23:38:45 +0530
Message-ID: <20221103180845.17076-1-r-ravikumar@ti.com>
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

Enable TI_TFP410 DPI to DVI bridge. This is
required to enable HDMI output on j721e-sk
platform

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 226bb30ea7e2..e29a9dc98378 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -762,6 +762,7 @@ CONFIG_DRM_PARADE_PS8640=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_THINE_THC63LVD1024=m
+CONFIG_DRM_TI_TFP410=m
 CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
-- 
2.38.0

