Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0703663710
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjAJCF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjAJCF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:05:27 -0500
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1116.securemx.jp [210.130.202.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6AE19282;
        Mon,  9 Jan 2023 18:05:26 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1116) id 30A1lc5m012349; Tue, 10 Jan 2023 10:47:38 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 30A1l79l024492; Tue, 10 Jan 2023 10:47:07 +0900
X-Iguazu-Qid: 2wGr5g72QFywIxOWl1
X-Iguazu-QSIG: v=2; s=0; t=1673315226; q=2wGr5g72QFywIxOWl1; m=XRaq7Z66F2+9OgIBWwjmpCJqGHKS1gM3LBz9yal2G8k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1112) id 30A1l576017317
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Jan 2023 10:47:05 +0900
X-SA-MID: 48793552
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v4 6/6] MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
Date:   Tue, 10 Jan 2023 10:41:43 +0900
X-TSB-HOP2: ON
Message-Id: <20230110014143.18684-7-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 886d3f69ee6..e83ec3af09e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3014,18 +3014,22 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
+F:	Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
+F:	Documentation/driver-api/media/drivers/visconti-viif.rst
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/clk/visconti/
+F:	drivers/media/platform/visconti/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
 F:	drivers/pinctrl/visconti/
 F:	drivers/watchdog/visconti_wdt.c
+F:	include/uapi/linux/visconti_viif.h
 N:	visconti
 
 ARM/UNIPHIER ARCHITECTURE
-- 
2.25.1


