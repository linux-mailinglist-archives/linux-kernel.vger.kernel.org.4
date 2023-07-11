Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB674F50C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGKQYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGKQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:24:31 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA099
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:24:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689092667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gt34itJE/Z3AqIvun7fuPxxD4OBg9/zlMYtPRzQmwvc=;
        b=CveunfMoLoenMr5OGZobNJQ0Ahx2c1s+DqSOG6s8FiGLfu7Oo/WQgpjaKVNvBT1SeAh+yR
        78jSZpr40BFZMQL3Ve3xy2e/X6YsnS6BDGI2LRkDEPYqS/d2NVaQy4ya/w712nfSiDJC3O
        omPo5euMd43YRRatqnsebFx3hnuP724=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, arnd@arndb.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH] arm64: dts: sprd: fix the cpu node for UMS512
Date:   Wed, 12 Jul 2023 00:23:46 +0800
Message-Id: <20230711162346.5978-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The UMS512 Socs have 8 cores contains 6 a55 and 2 a75.
modify the cpu nodes to correct information.

Fixes: 2b4881839a39 ("arm64: dts: sprd: Add support for Unisoc's UMS512")
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 024be594c47d..97ac550af2f1 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -96,7 +96,7 @@ CPU5: cpu@500 {
 
 		CPU6: cpu@600 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a55";
+			compatible = "arm,cortex-a75";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			cpu-idle-states = <&CORE_PD>;
@@ -104,7 +104,7 @@ CPU6: cpu@600 {
 
 		CPU7: cpu@700 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a55";
+			compatible = "arm,cortex-a75";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			cpu-idle-states = <&CORE_PD>;
-- 
2.34.1

