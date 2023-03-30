Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890AB6CFF07
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjC3IuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC3IuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208B7AB2;
        Thu, 30 Mar 2023 01:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F69B61F46;
        Thu, 30 Mar 2023 08:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19038C4339B;
        Thu, 30 Mar 2023 08:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680166203;
        bh=PbVK8hEsU/pH2vkw9lfbR9b5VjLWZjOk4C9N4xsA4JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLJD8jmbeJyUA5IVZwuOF1Cw5OrJfMSUqcNwtRgBHLO2pcEv/OmeKdtaCOnoY/38y
         kzLDj8su8nwnI0dWhZvZd/gNRFPoiUQDnNNHZ4aj8p8rlyF/rr+MAWRt6RmolLJMtT
         tDf/QgN1HsKcKaM5+hEmTxiw0tJVr85VqxwxwGtSyn4f38zAHEZ6Gr63q9UF4FzpkS
         yfqAXCh3jHBripssF3tmiFkELcinzb0LnqLB5PTD+LmFHqqquH8cNG+2yj5LbeK/hR
         KOBSBuTfSiCNEvk7d0kRW2cSEBJu6yKvQDZND7JSRoaoWOxiSbVyeaJRMvrenDMrJ3
         t2bRpQR6HwDog==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dhruva Gole <d-gole@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 1/3] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1
Date:   Thu, 30 Mar 2023 11:49:52 +0300
Message-Id: <20230330084954.49763-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330084954.49763-1-rogerq@kernel.org>
References: <20230330084954.49763-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhruva Gole <d-gole@ti.com>

The property "ti,vbus-divider" is needed for both usbss0 and usbss1 as
both USB0 and USB1 have the same external voltage divider circuit.

Fixes: 2d94dfc43885 ("arm64: dts: ti: k3-am625-sk: Add support for USB")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 54318a07d50c..80e8b9b9a5f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -261,6 +261,7 @@ &usbss0 {
 
 &usbss1 {
 	status = "okay";
+	ti,vbus-divider;
 };
 
 &usb0 {
-- 
2.34.1

