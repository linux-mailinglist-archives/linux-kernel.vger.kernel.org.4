Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB885E686F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIVQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiIVQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:15 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5845055;
        Thu, 22 Sep 2022 09:30:04 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N9dHN-1pMx9W08WL-015XQB;
 Thu, 22 Sep 2022 18:29:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: pcie. et. al.
Date:   Thu, 22 Sep 2022 18:29:17 +0200
Message-Id: <20220922162925.2368577-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4637eWeTPry5ikx6C4DgjsxAeXIpEEmMNpsVJznParNZVSKIiT/
 ew87uBY8tqpIlhLljNJJg/VO2fAWfm+tjVy2zIAYZoI0Ug75iCIgBfEKW1h15uzDblrlHis
 V8Qi8fKiQ8DU5OXAp5aH/Nks7KpSh0pZ92ItWoAqdzBSxrGWQqTF9EphPnUto/GWkgf3Yy3
 qID0RFJHVf+Wz0Pzrc7Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yezxiKWF5RU=:4+Nji9/75mJFEuzdiySFDZ
 vl/7cu3pVzkat/1uTo95eX0PfR/OQSRxudjM7hQthYeiN9bEANdZK7OZYLa7tJ8sahXYWz/nP
 0q27iJRSDZpFMjFbZfGy+DESpuy838QhLhPxp+lGuf5kA3w+fgNfZKU2sbAIkzyXDRDjkJU/x
 W/BxOM6h7U9MMU0FqtILklCUYShEfVsS2HWwXnvNxf6H0NL1y1VbEXAkVM8+OlC2MtIS5DYxj
 eLUctXh14JUiW30iY4Uz8MJVw7+Z95DarBVA+K8XZ95lU7XK6E/oqvrUU4qF9vxn4wdHxxjvx
 7cMy1WxomP7vS7mVT28kAkrzm3RVMbSm89VT6O21dXE2stX408jyja13YEmea74z2kUAVIf45
 32OPW3qCgble6XR9REah31M36VKLR8WVIFiwRKw6gCWHVnhJ2yt2g73AbsKjsRdE1akHgf1x9
 a14I0abk7QLYmFc38Lv01lCh+N+tfKZ8O3iBpQB1q2DlAzGkJWUFjZNaQjY4isc9T84hUh12m
 0cNAyL+aci8tfUnWpBlTcC9LhPFX5SoxDdRw0MaYg/F/G3H8uCxbBvIV7A35a1nnVQxNp449g
 cRNdTqIcx+lx57TtVvX9iSCAIshStbXO+15bcrpo+HjkgvDhaz3mU/dII4eGLaJRpUXOTSNyM
 eQc7aX7r1bzsBkn0KWM8FvOI72YamZGIzSMT2dMtVWDydzYl2UvIrmdwoCVfZw8iGlJtVm/lk
 RaABPCgwKL0LC+bfrJSfZJd9tKRVcvx3yfJjPXk9k3e2jIIYuieIOOH6l6FWmVu1APDL7Uj/l
 ZGnrW7G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series contains Verdin iMX8M Plus PCIe enablement and a few other
improvements for the Verdin iMX8M Mini and Plus (and Colibri iMX8X for
that matter).


Marcel Ziswiler (7):
  arm64: dts: verdin-imx8mm: verdin-imx8mp: improve include notation
  arm64: dts: colibri-imx8x: improve include notation
  arm64: dts: verdin-imx8mm: verdin-imx8mp: rename sn65dsi83 to
    sn65dsi84
  arm64: dts: verdin-imx8mm: improve pcie node
  arm64: dts: verdin-imx8mp: add pcie support
  arm64: defconfig: enable snvs lpgpr support
  arm64: defconfig: enable i.mx 8m plus specific interconnect support

Max Krummenacher (1):
  arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci

 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 10 ++--
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  9 +++-
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 51 +++++++++++++------
 .../freescale/imx8qxp-colibri-eval-v3.dtsi    |  2 +-
 arch/arm64/configs/defconfig                  |  2 +
 5 files changed, 53 insertions(+), 21 deletions(-)

-- 
2.36.1

