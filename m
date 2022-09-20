Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D45BE1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiITJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiITJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:22:55 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6565240;
        Tue, 20 Sep 2022 02:22:54 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mg4yR-1oxTcy331Z-00NSKL;
 Tue, 20 Sep 2022 11:22:34 +0200
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
Subject: [PATCH v1 0/4] arm: dts: colibri-imx6: usb dual-role switching et. al.
Date:   Tue, 20 Sep 2022 11:22:23 +0200
Message-Id: <20220920092227.286306-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e/HpDYBrATkipc+19r8nOoE93W4o1keSfWinjQxJDW1UqUk4AmU
 ryxBokYEfNfsOvWWqO8t+qmshTP+Cu6VGND1CfwYidKj/pur8fkERCSb+sGIDk7yMOtdL+X
 KrLKXVQtMJt3SWzn12Q9Ag76gxbdMK3zTvMBQfsemlUAWfHHUU4XrAJ8r/xVn2rKrF37rWA
 ibsL8SS7mlEaAv+NMfhtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rOKFENmZWns=:MHtnd5AZcJGpu3sLWdmzdi
 CjSTu2PwfJN5TefIF3++HGGZwk60BjBvI34QCTdsHPgEPfuI7MYgbAnZFOvGbuAqrk0hDsFAA
 z8r32sfTx8I1aR99nIqIlL4KcJRCvcJ1vXWccqcTYfJOJw3dIXQKiXMY+TmdJNGWyKcVsBOUN
 Z7CIij3LXR2wL9E3X1809tVlysk5aEhmpO+LzzZ7KYLY67Z1MlyutP4Ui4k/smURPbNnuG0XB
 /mWn6uA2ZpcsHmMb4WCUg3aE+A2wabwLhhran+cLHwKK6AVcEWAmQ3M45i2ry/kdXAIn6mTKv
 1SEwa+GK6gXC74TTD4+WkowAiszcnrYXUs/MW31fWRkVtPGwS9wygsgHnEQlKjoNZynJsl06l
 SyqjqTyJF9kNgpC+lwnPA1yxVGCMfQrDAhAlUpq2B4z+pBL4H/GkcjxjG95S5fDWRzIpX3fqt
 LM7gBIBdzKECZo7aHt1x5Z3gHwKxjEERJvY/YEcjySRU1QFNY6xeOmFrsU2liGuNOGrkiDNu7
 gVbDveqoA2ey/btdVxZCXR31GskaSqqyCfuQP/2A14EIBcsxGWvKwzAuW6sAN/4ku2tNVbATC
 vvgugIk+1djfZ7N7VII1KgYj03p6eR190d5104qKugER7GaQmfn/KOIN2tunZpdWS4W4Jw9kM
 Su/gnshgrz5cjRKvVRSQkDIqIpnOd37vFDFvGxLWWXG0iLb7jMCxCMZ2KNvypX4W7YA0gaM0y
 inJZoR09SSWPmDMZ+RkdmAr1hXoDwd+JUsQ4QZJTY3u1gqM06o+ZMz7cl8V16gs/WatEh+KSO
 Rekf9aX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series is an assortment of USB dual-role specific commits as
follows:

Introduce USBC_DET GPIO based USB dual-role aka device/host switching.

Move USB VBUS supply from single carrier board to module level device
tree. This pin is as per Colibri module family standard.

Specify USBH_PEN GPIO being active-low rather than active-high
(cosmetic only).

Remove spurious debounce property from linux,extcon-usb-gpio. That
commit is actually for Colibri iMX7.


Marcel Ziswiler (3):
  arm: dts: colibri-imx6: move vbus-supply to module level device tree
  arm: dts: colibri-imx6: specify usbh_pen gpio being active-low
  arm: dts: imx7-colibri: remove spurious debounce property

Philippe Schenker (1):
  arm: dts: colibri-imx6: usb dual-role switching

 arch/arm/boot/dts/imx6dl-colibri-aster.dts   |  1 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts |  1 -
 arch/arm/boot/dts/imx6dl-colibri-iris.dts    |  1 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 22 ++++++++++++++++----
 arch/arm/boot/dts/imx7-colibri.dtsi          |  1 -
 5 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.36.1

