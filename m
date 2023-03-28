Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779C36CBF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC1Mnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1Mnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4051B9775;
        Tue, 28 Mar 2023 05:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE7C961755;
        Tue, 28 Mar 2023 12:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B168BC4339E;
        Tue, 28 Mar 2023 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680007406;
        bh=PbVK8hEsU/pH2vkw9lfbR9b5VjLWZjOk4C9N4xsA4JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCop1h0fove66g+f/vn1sAECEewDNGmVo8iZa+GfP2C/UwPb3fv+q9GCnr0MRpbRf
         ibmLYqdPXdN8olc5H0UlKsTQ6f/kdndcaXCZLtFI87JfCIsXm8eEFH9erCHsT3cjRJ
         k8xDQuTBx2S4sXj7rU59AOBPmOMgNPKA1K9hmhugUIXqWUsNh5nGy/IiVvjURqsuqc
         U9lcUpzbBv5Wb3vtnLVxquYiKyr/J2to6++xG8e3jeWF1i5fXqkcXKjkOhA2BwrT+h
         GYL8MJ9Hxy+hQIC8eNxbRqSo2Vp8TMimLaN2mW2YQG7jnnnZBzEI+hpy6vSf7Ysx60
         o1ABJOKGm5tjQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dhruva Gole <d-gole@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1
Date:   Tue, 28 Mar 2023 15:43:14 +0300
Message-Id: <20230328124315.123778-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328124315.123778-1-rogerq@kernel.org>
References: <20230328124315.123778-1-rogerq@kernel.org>
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

