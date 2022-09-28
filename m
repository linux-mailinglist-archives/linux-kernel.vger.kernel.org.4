Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737605ED63F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiI1HgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiI1HfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D917FFA56;
        Wed, 28 Sep 2022 00:35:13 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MVNfs-1okTEt3tqY-00YiWI;
 Wed, 28 Sep 2022 09:33:54 +0200
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
Subject: [PATCH v2 3/5] arm: dts: colibri-imx6: specify usbh_pen gpio being active-low
Date:   Wed, 28 Sep 2022 09:33:34 +0200
Message-Id: <20220928073336.63881-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928073336.63881-1-marcel@ziswiler.com>
References: <20220928073336.63881-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FGWmuOY2YK1iqQS2bXQ2FTeM1v9QsAVrOrGS++SDPzuGV3rfHzw
 WDLJqWJUr2BT6I3wmREor0EGfU3eS9+Ly4NtRP8cKDO5IdxI9GPZqcnrHWKljVKIgpqNBVP
 3eZU34mIUsLt9thp4571uhaF5u7cTAWPtiYuxw9NIwEmxxFbNb/TvafJcOO8OoWH05ZEC+G
 Nc9GdZH5wlaTIo805ZH4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2AlgoefTcdw=:ywpl96VcQ+KljZju0P/gB5
 AgkPuetedxm57Wo8/Z3quESGIX20WUQhW5F2ua+5KrN0HuTn3OIG1kiSa5O+sNfNzPB3Omdu5
 OXiUlWqZFA2MQ2Pdk0lbx7WcuPF3SF62ByCES4AUbDcIqdgmpl2xrrojR3jkeQ+gWZq/F21rt
 tlwHJw5tJlqH6huRwS7H9+6xyRatQBjTuVZ1wvj3PoIlpCQ2aHwEGRPQxL9ebQlRkPWvAbZxh
 bb8w66BJqREmFMRfcnj/Hn/7b7NLzIaemkUwGkiyGav8KJPkF4cO7bClGq1b3DSHtsq+iq1Wx
 o4YdbyhZrIopR1o9E9zSg5lUPZigqPFHXg8OKIZyE3/dTvuoxPe/7mFzlMAkDM6b7s/mjibd/
 HQlznwPjPxdmOtwLdwQ++ktpH+ch1P4/ycQCbMW6I/PDfg1r2wyiYGWCkL9B76HKBtTqxpIJP
 /RidQ28iSMpJxIVdmCeW5mMp9IDUHheJ8lDW2wgMy1deBUG2Pubwr70dpsz13cZErPkpBMFPm
 nodNr/T4swAXzJNOcCg8FG35O/zl2A2iIo9bsSv6/N4q5JdGvBfIRf0500PlAdKFYh3xrA6pK
 zBfszAzUrXDEXgDQBlSVdUJncYIRINIFNbBksRDQGQUqragPIr+Iw1H+g7FT/78icC+gTl8si
 JHdZNTXkzIhOR+NX+ZOHUuP+6UgXpkBErXoXs2hO9gkXfFwt9yxVOl7RejK/mRik556D7+0zJ
 O1MG354uAx4XDR5OrL8FZGkcZR3ylX63/seA8unSVc/HiurIlLzwUtFaPWOGQsjHOWAqKiZ8d
 tBze3Fp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Specify USBH_PEN GPIO being active-low rather than active-high.

Note that this should not have any functional impact as for fixed
regulators the regular GPIO polarity is ignored and a true active-high
enable GPIO would need an additional enable-active-high property which
is/was not the case here. However, this may be rather confusing which
this patch fixes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 21c5049bda4e..d8f985f297e4 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -112,7 +112,7 @@ reg_module_3v3_audio: regulator-module-3v3-audio {
 
 	reg_usb_host_vbus: regulator-usb-host-vbus {
 		compatible = "regulator-fixed";
-		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>; /* SODIMM 129 / USBH_PEN */
+		gpio = <&gpio3 31 GPIO_ACTIVE_LOW>; /* SODIMM 129 / USBH_PEN */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
 		regulator-max-microvolt = <5000000>;
-- 
2.36.1

