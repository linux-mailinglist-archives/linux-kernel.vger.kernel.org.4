Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75761601DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiJQX42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJQX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:56:12 -0400
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5814E7E301
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:56:07 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kZxkoIDsHJpY4kZxmoMdtp; Tue, 18 Oct 2022 01:56:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666050966; bh=AwSDPioUx7F0h3hwMs9mvaexbpHNhz0n7qe0CuDHMuQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=eKrlNnf6iWMYVwdmA6Oru3LaEqzV7r9Rc0Mi2RoxobBH8odAp/6vs/34AOqgv/i1M
         HIsJ5F05xtZRAxc1q88gKqSLnQHm6WGeLxUFB9PGNnpzbt20cM26YExINwiYB8Ibb/
         AS+tR+WQRfdc8rCssOjke1ykTq/Gg1MAlr0J9f4A4Hzx0f8/ZahQ5FIq2KyDo7G6Sn
         +x/kdjIXHeys/eVsqBWqm1HDrmuTX3e7chnKNH5ximcOPLMZNF5aQTY/SaLAmkHjwd
         8OekqwMMRHQeasP7SpCPVFGMwpsxnFZCSw7FXTS0ahQll7Lq4xlz17JAS6zWWuxl0q
         aY7aRL+QHo5GA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 5/5] ARM: dts: imx: prepend a 0 in the memory address to make it clear it's 32MB
Date:   Tue, 18 Oct 2022 01:56:02 +0200
Message-Id: <20221017235602.86250-5-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJPiiR7i7lCy6Uzn2y/6TcFw3IkBM6IvSZFACENWKfnFdxiEKvsCk201PTya2kR/sMbSF8+kn6SIFMRLEbEa9epVh9dBM9z2XG7rHdStuL9DnZyi1aX3
 wE9L05Lj8Gh4iZyg7/b5mN/4XN2WRdc8ZlhMW+dWt79tJUXGk48n1gCgHGnTuyubP3115nj9T8CQbHEWaVd2q22uji6mucyxAHW3divjewOqKB3hsZpDOsVB
 dR81CRik/xL4kbu6iHBEfGDHuulBynKZYP31InOz6FPQyDOD/LAzEeBaAvsnuySS4pZJajEgf5qSQkEvb3aDpGBrLM5BYZqhCYuHaVTaJtfUdVdhJFwuc8CJ
 DUFxOI6tZPRyjnc5Htn1GWgaOvIDlfiF9lMjOZpxwSj9gsKLP4WyticVFSblu3NyJDBUaVu4RuP27b6qK1kmQpTFeZ6mD3/4kgUTJInwn6tUZeg9QrvXa1HG
 Mwn3bFPI4SgKUuX7RkiKi/QdxxI7sb4BVrMl0OrCXI3KIROKT3QRqdpakssp/lxvERehuQ6u1iSe5GGVq5MOROxexWA72LGUsUGv5YVQvXBf1V3M3+cfCu40
 BYA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imxrt1050-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050-evk.dts b/arch/arm/boot/dts/imxrt1050-evk.dts
index 1d339f48899f..3de392d014fe 100644
--- a/arch/arm/boot/dts/imxrt1050-evk.dts
+++ b/arch/arm/boot/dts/imxrt1050-evk.dts
@@ -28,7 +28,7 @@ aliases {
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x2000000>;
+		reg = <0x80000000 0x02000000>;
 	};
 
 	panel {
-- 
2.34.1

