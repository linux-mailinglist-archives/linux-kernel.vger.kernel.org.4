Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8B6F5AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjECPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjECPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:20:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8818946AE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:20:07 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1puEGz-0004bF-Sf; Wed, 03 May 2023 17:20:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/2] Add i.MX8MM-EVKB Support
Date:   Wed, 03 May 2023 17:20:03 +0200
Message-Id: <20230503-b4-v6-3-topic-boards-imx8mm-evk-v1-0-1e15a371d374@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN7UmQC/x2NQQ7CIBAAv9Ls2U0QahW/0nhY6Go3FmhASZOmf
 5d4nDnM7FA4Cxe4dztkrlIkxQbnUwd+pvhilKkxaKWNuiiDrsc6oMFPWsWjS5SnghK2WwjI9Y2
 256slqwZNDlrFUWF0maKfWyd+l6XJNfNTtv92fBzHD4Eqd1+GAAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Johannes Schneider <johannes.schneider@leica-geosystems.com>
X-Mailer: b4 0.12.1
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I picked the patch series from Johannes [1] and reworked it according
the comments and the discussion.

@Krzysztof
I dropped your ack for the bindings since I adapted the comment within
this oneliner. Please can you check the current state and provide your
(n)ack again?

[1] https://lore.kernel.org/all/20230130172553.2738182-1-johannes.schneider@leica-geosystems.com/

---
Johannes Schneider (2):
      dt-bindings: arm: fsl: Add i.MX8MM-EVKB
      arm64: dts: add NXP i.MX8MM-EVKB support

 Documentation/devicetree/bindings/arm/fsl.yaml |   1 +
 arch/arm64/boot/dts/freescale/Makefile         |   1 +
 arch/arm64/boot/dts/freescale/imx8mm-evkb.dts  | 128 +++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230503-b4-v6-3-topic-boards-imx8mm-evk-94e79a9062ab

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>

