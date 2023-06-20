Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C470736271
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFTD6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFTD6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:58:32 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BB971A7;
        Mon, 19 Jun 2023 20:58:30 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 35K3HaR0027553; Tue, 20 Jun 2023 12:17:36 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 35K3H0NN007271; Tue, 20 Jun 2023 12:17:01 +0900
X-Iguazu-Qid: 34trY2IxWanTrAOr0j
X-Iguazu-QSIG: v=2; s=0; t=1687231020; q=34trY2IxWanTrAOr0j; m=uPfg4gTq+4w8KdHfdGDYGPgWvBdyDLW7FEhIV6vhsMc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 35K3Gvl1013553
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Jun 2023 12:16:57 +0900
X-SA-MID: 2939651
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
Date:   Tue, 20 Jun 2023 12:11:11 +0900
X-TSB-HOP2: ON
Message-Id: <20230620031111.3776-6-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620031111.3776-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230620031111.3776-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entries for visconti Video Input Interface driver, including;
* device tree bindings
* source files
* documentation files

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- no change

Changelog v3:
- added entry for driver API documentation

Changelog v4:
- added entry for header file

Changelog v5:
- no change

Changelog v6:
 - update path to VIIF driver source files

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f794002a1..4673bca45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2957,17 +2957,21 @@ F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
+F:	Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
+F:	Documentation/driver-api/media/drivers/visconti-viif.rst
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/clk/visconti/
 F:	drivers/gpio/gpio-visconti.c
+F:	drivers/media/platform/toshiba/visconti/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
 F:	drivers/pinctrl/visconti/
 F:	drivers/watchdog/visconti_wdt.c
+F:	include/uapi/linux/visconti_viif.h
 N:	visconti
 
 ARM/UNIPHIER ARCHITECTURE
-- 
2.25.1


