Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB366C7ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCXNcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCXNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:32:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67117144;
        Fri, 24 Mar 2023 06:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BBA48CE25AB;
        Fri, 24 Mar 2023 13:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B417C4339B;
        Fri, 24 Mar 2023 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679664718;
        bh=62XefeNgbUzKOt6Wsxi7gqaceV0qRla+72DwVepokhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnPSgVnLdEPDupUqjAckGNdfAXc0muBXiHFxbhnqMNokawz5TPonnPCV7VAL3G6r1
         3oMkj9fJ1rlUGxtkKrqYs5aLTfZ4/UoVqtbBlFFa26+3VLvyGFpNwNlgSw4iRi74cN
         rh+/dIB3uS8nt9Tt4B8aMZpe8d2cKnMovJyP1Pmlrkfef98ITlpQ2u+3hOXNQJ9vU9
         plIw1C06dkKmeVBXdB4V+Qb4uKVwz3kjKdRCAnjaDj3+VDY5OWEIgxY/Kg/JV9AnfS
         hHxyiO28IaaWa02OC7n8Bopo28fGcyEwe1vCQGBfvJ4Y23QXaQsxiwUQHHUJvgZovS
         aIKweCK1YB9ww==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Dhruva Gole <d-gole@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1
Date:   Fri, 24 Mar 2023 15:31:49 +0200
Message-Id: <20230324133150.43224-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324133150.43224-1-rogerq@kernel.org>
References: <20230324133150.43224-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhruva Gole <d-gole@ti.com>

The property "ti,vbus-divider" is needed for both usbss0 and usbss1 as
both USB0 and USB1 have the same external voltage divider circuit.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 67dc26fc23e4..be027fad5f61 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -482,6 +482,7 @@ &usbss0 {
 
 &usbss1 {
 	status = "okay";
+	ti,vbus-divider;
 };
 
 &usb0 {
-- 
2.34.1

