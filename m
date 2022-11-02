Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8FD6163C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiKBNSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiKBNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:18:06 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A32AC5F;
        Wed,  2 Nov 2022 06:18:04 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M9IQC-1ok7er1wYI-00CmlF;
 Wed, 02 Nov 2022 14:12:32 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Chen <peter.chen@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] arm64: dts: verdin-imx8mp: dahlia: mark usb_2 permanently attached
Date:   Wed,  2 Nov 2022 14:12:03 +0100
Message-Id: <20221102131203.35648-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/xmmR9cJUMqOUV0/TLDPRyZVYiIyvc1gu9OFauZZQGRmT8gaQDY
 gzEG0zKK2L6jCuKKOiEU0eyTIitkusx5axawO62t4zGvYosmM8KQ32UTZsaOsCscaEaGvMv
 +mqcjJE7XREmIsaOhsh4r5OjYLdQdO5dAs4gOEPltSOdTgMeXmFnPJJe81OaaxGAWsiZY1a
 Gx+Hx1q8PgbQfHyon+71g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vso6NIYTwqU=:NYEBGq8soSbWxijF72aksR
 PxcT5l3ssFzbi06j0URD4tsq3EVQABniKcJYe0CIh/dK+OJUer2OfR/KBqDqEZglKAn7wB/Ek
 PZj3fT9Kg1iR9IaGToRaB7LGWNPBCzTBgxRR5d2Jc5vHhyn3AASxFPs62IEpyY9WcU8/Xp4IM
 4p0s/f6/nNh0fqgf8u2RK5U8MnTj12Zf17U8J0htdH/A9EbNMb3NxyHxUVJWDjBRBSa8Od371
 5KBrfNt520AjgfGjyBNn2l+2npnNv+VM5wY2NloRZhw1bMtdWPer+lVYKmSZ5Ud2UfSnz5Q3o
 3qdofY4dP62ICC+BbPVhJImKcqpdW0J53FpTwf0g0CIhA51/dE77Pw9oRAjXkEhpXPwrWovF6
 +55TQkh9QyBgB4Qnoz/5ijYP3x+91odd4pBu4BZuckUMXTNcrRT4YOC24my6LE//sPRXJyFjV
 2ZalNr0OsOVt3h97EtAUzlUL3K0B8Jbdy8WS5q/X16D2oI39Tsgmf2TcJprkaK9g3uIEzu/kG
 vlxBsf4LdlyeL+4mKM0HR2UWT5G+MfwOxVkD2LPqZ2GL60za5H9Twfz3rhObWV2cglohyzlfM
 Ago2Z3KY+ytDthSY8GdMFYiJ6dEpIqOFCetoT8FIG6ZiF2Moinu5rvLu6XbCfqN0tADTI8LiJ
 UzOFu8c1prypbMYHXw+Gh3Qy4SWZHwuaxAc6k44CdVxvRSReh2no4/OtM8a9yI0mHSW2W8kwz
 movnIBxaU0tG0xaal9PskUrGUdHd6RPZXJUdbOZBbR9a3yxVnQkQ0PODAzUjqt5Sby1mKe0EL
 1Nrq8mc1sw5nlt+cR/BjVfT3k9UfA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As both Dahlia and the Verdin Development Board have on-carrier
permanently attached USB hubs mark Verdin USB_2 as such.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 4b8f86f63081..80db1ad7c230 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -116,6 +116,7 @@ &usb3_phy0 {
 
 /* Verdin USB_2 */
 &usb3_1 {
+	fsl,permanently-attached;
 	status = "okay";
 };
 
-- 
2.36.1

