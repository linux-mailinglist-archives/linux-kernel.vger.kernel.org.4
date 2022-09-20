Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7515BE1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiITJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiITJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:22:59 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577AD65276;
        Tue, 20 Sep 2022 02:22:58 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lpu1h-1pFPzn2EMR-00ffvz;
 Tue, 20 Sep 2022 11:22:45 +0200
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
Subject: [PATCH v1 4/4] arm: dts: imx7-colibri: remove spurious debounce property
Date:   Tue, 20 Sep 2022 11:22:27 +0200
Message-Id: <20220920092227.286306-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220920092227.286306-1-marcel@ziswiler.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:R5iDO3BfrzcBJI9dpElBGyNAuFPMZ4qHJTfHWq9pX5e360uphW9
 BiGWxdzDxk63v2hi/jwLWivgjj5khAyPePkxMgT46nAM5XKQUjH9kYem3MbFIJANavO2sZL
 ygdJZXwKTOK3DH1yHNJ+xVFjKJlucKdeoRDy/v7h1s5RK20YjdfHfy6KO6+v2QrDT9ZOI3+
 WhFejUT/mwtIqhre5A3MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S8leuyfUFJQ=:oKXpngvgNEqePPNrW9jvd3
 qEKOZ27ea6Oupd+0/08gUVMLMZwqNbBTnsbqRzhXHc5xFRR9oxzXhjkHK6H7bBshGdwB6foTX
 koYsrd45XpDFcR+Fy1+1dX9jRJ4fnf4AGMBQePz8C/7nUvA54XbAG+SKsqhTnqjg3XPs7VpXh
 vDdWEzc2mDuWWlrV8W3+teOsUBkLDmjXsXghGyT9h8U4/zeG+knoDyDkWLwJWeeH2AaWJJfjj
 H0Fjbr2kFwh9lDZpDKjl5pA2pujSyhJMDH4u9XIm2tyxDx7+ikuGWNfIGc4MID5fpshso1gQf
 3g16tcBLLn4rBNtfoVBmm5dbl8fVSbOh7CvFAHVFuc6iKJKibcNfZOgkhnvb/1SdeBaHmukyr
 30Hb4axYr00QL5gygji2doWMK1nPAQFcUUfiGuV4RaVBZu/1gePmtKWydZzd7PyZlIRLs8WPx
 RkbKxxhEPNQvauZAFfEuQGPMbgCXbnAXTy38HXRJ1EAW+EvZpTVePA6x2+GZN4ZVrD/6JujNK
 YqotwkDjUiYsVa3uhwSE/X713UMghCWdClgcfohm5CIJOB3YZX0Nb1jJehTW1VpAx47hdallJ
 zS1Lm1N6CmQYXrBTMTqYra+VLvWVG0mJ6Z0aZ6++3RUsQbNmT//Xez77Soq8ZdsGwZSG5Cx7v
 aGziS1JxDqg4RlkM0zUJKjGCvvWiGhpOtEIE4F562iFB3yMQggnBSuIZYO6nfOJZ0fpDxF9aN
 067uEfAQV1I3vkgZxVMN1jHoDQkPGOBqlhBF6uU7R74ofac8oGJ3+d7KvjRfLiUQI6aJfsxWT
 Ejzb9lu
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

Fixes: 0ef1969ea569 ("ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

