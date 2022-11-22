Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B922C6340C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiKVQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiKVQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:02:10 -0500
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 08:02:07 PST
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C17720B1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:07 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NGpjc6phXzMq7K1;
        Tue, 22 Nov 2022 16:54:44 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NGpjb6yJ8zMpr8F;
        Tue, 22 Nov 2022 16:54:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1669132484;
        bh=T48oXY7iv1p1XRzA008sRJQ4rvaDmex5xBYmZlgHKHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YRxqpLwlrT0IrXCQktEzvSMU0QTegr9gG92lkTsZXiG8VGflFh79cfoMP/PfVO/hD
         1PluhMsfgrXItCAoaDAe0O8QyyS+C9oP6Hi3p+KJN94LmwAsYyNRxdRmo/U2W8Y2Jd
         degAw1oOK0PNPM1YFN52cKfqk0ZGfGd4L9Dca59A=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Unify USB Over Current Settings on Toradex Boards
Date:   Tue, 22 Nov 2022 16:54:33 +0100
Message-Id: <20221122155439.456142-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>


This patchset intends to disable the USB Over Current for Toradex i.MX
boards using the USB chipidea driver.

We do this on the Carrier-Board device-trees due to the reason, that if
a customer of us inheriting the module-level device-tree (named -.dtsi)
does not inherit settings from us that may be incorrect for his
use-case.


Philippe Schenker (5):
  ARM: dts: apalis-imx6: Disable usb over-current
  ARM: dts: colibri-imx6: Disable usb over-current
  ARM: dts: colibri-imx6ull: Disable usb over-current
  ARM: dts: colibri-imx7: Disable usb over-current
  arm64: dts: verdin-imx8mm: Disable usb over-current

 arch/arm/boot/dts/imx6dl-colibri-aster.dts              | 2 ++
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts            | 2 ++
 arch/arm/boot/dts/imx6dl-colibri-iris.dts               | 2 ++
 arch/arm/boot/dts/imx6q-apalis-eval.dts                 | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts           | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts                | 2 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi                   | 1 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi                  | 1 -
 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi            | 2 ++
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi          | 2 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi             | 2 ++
 arch/arm/boot/dts/imx7-colibri-aster.dtsi               | 1 +
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi             | 1 +
 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi             | 1 +
 arch/arm/boot/dts/imx7-colibri-iris.dtsi                | 1 +
 arch/arm/boot/dts/imx7d-colibri-aster.dts               | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts          | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts        | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts        | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts           | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi               | 1 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts             | 1 +
 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts             | 1 +
 arch/arm/boot/dts/imx7d-colibri-iris.dts                | 1 +
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi        | 2 --
 26 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.38.1

