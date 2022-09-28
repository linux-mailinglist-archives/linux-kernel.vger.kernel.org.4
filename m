Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9D5ED63C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiI1Hfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiI1HfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875FFFA50;
        Wed, 28 Sep 2022 00:35:12 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0ML6Nr-1odAaz0f5d-000LBF;
 Wed, 28 Sep 2022 09:33:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm: dts: imx7-colibri: remove spurious debounce property
Date:   Wed, 28 Sep 2022 09:33:35 +0200
Message-Id: <20220928073336.63881-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928073336.63881-1-marcel@ziswiler.com>
References: <20220928073336.63881-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EJPZyuEcUzyDYXWxHi8G/xQHV1sJid+zYdyrHYMySxh4XsussSi
 DuJC0TaFftjPqL0jWq4Nh6V4dnNBfN8rMxAK7E6eUpRJOH11DkgIzVFHZ6HN8ZZcBJpGK/G
 WEI8CMy5BHcAMFF9SzBgkFKdhBwU+6kwW4WrLm9LuKY7zM+hZlyQE1sWd4xIOt1XfSX37Xt
 Kujbjga7PCJZtq0Y78Jqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AFAcgsrlQSc=:5OstOsRYHo9uJNhotkSJjh
 VfUyh/gmNO8Q6y90hoYsa1T+/8yZeY3FmGMsJ6fFTbvBzHPAFVWFmU4Pwqx1at3Cvf5tPquOf
 J1njdXZyfeigmqbbhjflhTk5yB6MBQCmfsrjbiDyeCWS9Wkm4SxAySzbga0xRmfNtnm84c76+
 gp/QkA7iw+KXjKdszUyy8e7etSClhViapeNF/e9yMVqzaKOfBV6YoGUBAI7Y1w3bdhlE4gh+u
 ZKi9I+OlJsIUNXeWGEjUJcDa9VEJnWKgoWwMT2Aj8BMr/veKYfN/K3q1OYEE6sN232Cgs/eMG
 JNBsMumuj35kkDrsGeFgvARBZ579Ohizzik0WFvUjwOUDkJTgaxwKkfnL1NI4oPXa6esdWAMq
 Chgj3ANAeOJiJE/lpoCyDZhTJ78n6hhvDRx5zHb5UGWbBHlntIm+qtteF8/qyASoceinRYGYB
 RW+Gb97V32m54hLoi+e3fEAasf3RdHKEov/wWyBkkJafc3lqVKJkR196fsQc9cDUuSCd1ovGX
 TIEQPfybSU9dhbOP6LSVPoaQjXiQc6/p0OoDfJDY/PZHSwul14WzMn2kMmRdEL34Eq6qU7PHI
 5cj28MiwxCmisLFv0vPwJxic1wtvEQQprzsZL2qh5FAPXIjs3n5YSHziIMLba1xsnZHseQSfF
 O6qq4ZmoFYpUiF9FP7oqnX9pIbixSP9FMrx7eN1ozU3Kf6/LVPc7/ymQYIHhoaoEeb31FQxuB
 ThCQcjfiuTZoG6tWvSBw6L+qL4pNYJJ4YzyuXZuRtC1QTC3mTOmC7R5JAYgNjorePfTofpUYB
 /6XT0lu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove spurious debounce property from linux,extcon-usb-gpio.

Note that debouncing is hard-coded to 20 ms (USB_GPIO_DEBOUNCE_MS
define).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Dropped fixes tag as this change is rather cosmetic.

 arch/arm/boot/dts/imx7-colibri.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index a8c31ee65623..840420f9a1cd 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -29,7 +29,6 @@ chosen {
 
 	extcon_usbc_det: usbc-det {
 		compatible = "linux,extcon-usb-gpio";
-		debounce = <25>;
 		id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / USBC_DET */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usbc_det>;
-- 
2.36.1

