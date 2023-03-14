Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7126B9DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCNSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:06:41 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB11AF2AB;
        Tue, 14 Mar 2023 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678817196;
        bh=Y50vybzJcxi++meRhzVjFFrYYDiXaEQgBQmDbk4WtSk=;
        h=From:To:Cc:Subject:Date:From;
        b=Zzkg58ovmLf6ZABdWMynLG/tNpnfACXcrcNK7SGnTWLJYYiQrPpicZXlKVV49Y6W4
         oedbvEpHmk/z4MJVf1v7Gcr7gAuhW2Qku3H3i5DRk4uU01RKfMSrdouqRLAigAUkuV
         CrbXBDTT7Y8snkTiX4a8xz+a7vdC2jdxU1fvrOB8=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.30.161])
        by uho.ysoft.cz (Postfix) with ESMTP id 7F56DA01E0;
        Tue, 14 Mar 2023 19:06:36 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 0/5] Add support for new boards in the imx6dl-yapp4 family
Date:   Tue, 14 Mar 2023 19:06:03 +0100
Message-Id: <20230314180608.44482-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches 1,2,3 are new in this v2 series and fixes minor issues for
the already supported boards. Patches 4 and 5 adds support for some
new redesigned boards based on i.MX6 SoC.

Michal Vokáč (5):
  ARM: dts: imx6dl-yapp4: Move phy reset into switch node
  ARM: dts: imx6dl-yapp4: Move status to the end of property list
  ARM: dts: imx6dl-yapp4: Remove unneeded status "okay"
  dt-bindings: arm: fsl: Add Y Soft IOTA Phoenix, Lynx, Pegasus and
    Pegasus+
  ARM: dts: imx6dl-yapp43: Add support for new HW revision of the
    IOTA board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi    |   7 +-
 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts       |  58 ++
 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts    |  42 ++
 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi   | 615 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts     |  58 ++
 .../boot/dts/imx6qp-yapp4-pegasus-plus.dts    |  58 ++
 8 files changed, 841 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts

-- 
2.25.1

