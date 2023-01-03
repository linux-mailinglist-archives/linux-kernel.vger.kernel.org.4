Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9865BDE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjACKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjACKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:20:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC18F594;
        Tue,  3 Jan 2023 02:20:18 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 303AJvNC065995;
        Tue, 3 Jan 2023 04:19:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672741197;
        bh=0xN9TZmdjhOev0M52dFR/CYSWTBXVP70B4RkI64FGFs=;
        h=From:To:CC:Subject:Date;
        b=yz0w2TCt/j8jTwbXFCVAR4IKQtp/Tn9bTtIqJY6Pa5jMyhHrFkRIXLcIgwFedvJts
         1AUeCaNCalu9tZT9j2PbTowjXO52yTZIFw8jCdIC+gPLRvp8k5GwObc4I3Ye2Usl+9
         L9TSJB1GxjlHTvQT7HNZj3b3+1GBGfggsfALwtZU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 303AJv9u028214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 04:19:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 3
 Jan 2023 04:19:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 3 Jan 2023 04:19:57 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 303AJtQl032179;
        Tue, 3 Jan 2023 04:19:56 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v11 0/5] Add support for CDNS DSI J721E wrapper
Date:   Tue, 3 Jan 2023 15:49:46 +0530
Message-ID: <20230103101951.10963-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following series of patches adds supports for CDNS DSI
bridge on j721e.

v11:
 - Wrap commmit messages at 72 chars
 - Fix the order in Kconfig and Makefile
 - Clean up the includes, move macros and some headers to .c file
 - Add missing forward declarations
 - Add __ prefix to header gaurds
 - Change dsi_platform_ops to cdns_dsi_platform_ops
 - Add documentation to struct cdns_dsi_platform_ops

v10:
 - Rebased to v6.2-rc1
 - Accumulated the Reviewed-by acks

v9:
 - Fixed below based on review comments in v8
 - Added more info on wrapper in the commit message
 - Fixed the description in Kconfig
 - Fixed the formatting of of_match table
 - exit -> deinit in platform ops
 - Remove duplicate of struct declaration in cdns-dsi-j721e.h

v8:
 - Rebased to 6.1-rc1

v7:
 - Rebased to next-20220920
 - Accumulated the Reviewed-by acks

v6:
 - Dropped generic definations for properties like reg, resets etc..
 - Fixed the defination for port@0 and port@1
 - removed the ti,sn65dsi86 node from the example, which is not related

v5:
 - Remove power-domain property in the conversion commit
 - Add power-domain only for j721e compatible
 - Fix white space error in one of the commit

v4:
 - split conversion txt to yaml
 - seperate commit for addinig new compatible
 - conditionally limit the items for reg property, based on the compatible

v3:
 - Convert cdns-dsi.txt binding to yaml
 - Move the bridge under display/bridge/cadence
 - Add new compatible to enable the wrapper module

v2:
 - Moved setting DPI0 to bridge_enable, since it
   should be done after pm_runtime_get

Rahul T R (5):
  dt-bindings: display: bridge: Convert cdns,dsi.txt to yaml
  dt-bindings: display: bridge: cdns,dsi: Add compatible for dsi on
    j721e
  drm/bridge: cdns-dsi: Move to drm/bridge/cadence
  drm/bridge: cdns-dsi: Create a header file
  drm/bridge: cdns-dsi: Add support for J721E wrapper

 .../bindings/display/bridge/cdns,dsi.txt      | 112 -----------
 .../bindings/display/bridge/cdns,dsi.yaml     | 180 ++++++++++++++++++
 drivers/gpu/drm/bridge/Kconfig                |  11 --
 drivers/gpu/drm/bridge/Makefile               |   1 -
 drivers/gpu/drm/bridge/cadence/Kconfig        |  21 ++
 drivers/gpu/drm/bridge/cadence/Makefile       |   3 +
 .../{cdns-dsi.c => cadence/cdns-dsi-core.c}   |  83 ++++----
 .../gpu/drm/bridge/cadence/cdns-dsi-core.h    |  84 ++++++++
 .../gpu/drm/bridge/cadence/cdns-dsi-j721e.c   |  51 +++++
 .../gpu/drm/bridge/cadence/cdns-dsi-j721e.h   |  16 ++
 10 files changed, 391 insertions(+), 171 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
 rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (97%)
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h

-- 
2.39.0

