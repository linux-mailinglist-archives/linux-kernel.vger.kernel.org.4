Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D006922C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjBJP7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBJP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:59:03 -0500
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Feb 2023 07:59:00 PST
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FD1CF6F;
        Fri, 10 Feb 2023 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676044183;
        bh=8WNurBHNpjnkYbdUk17Xl/AJxXjEbpmjjB0j/bt9OA0=;
        h=From:To:Cc:Subject:Date:From;
        b=OjauiQtO6yJo1SUJF+ITlJd0zaUepjYvSYKYUuMxKEOGEyiI+tFUo6FnXAdOK1UMS
         FmmipDoEoa2op6AYZ7/h1x53AHhC2nL8hnbE0+d41Y7/2lus1JN7U4FvYMxcEOGHyn
         Jy6up9BMwNcKK4gI1m540vvSoSbmsZ2mJr0Y4Rts=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 90F47A0081;
        Fri, 10 Feb 2023 16:49:43 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 0/6] Add support for new boards in the imx6dl-yapp4 family
Date:   Fri, 10 Feb 2023 16:48:49 +0100
Message-Id: <20230210154855.3086900-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches 1,2,3 fixes minor issues for the already supported boards.
Patches 4 and 5 adds support for some new redesigned boards based
on i.MX6 SoC.
The last patch 6 adds record to the MAINTAINERS file stating that
we do care about all these boards.

Michal Vokáč (6):
  dt-bindings: arm: fsl: Fix copy-paste error in comment
  ARM: dts: imx6dl-yapp4: Change LED channel names according to
    dt-binding
  ARM: dts: imx6dl-yapp4: Use reset-gpios property name
  dt-bindings: arm: fsl: Add Y Soft IOTA Phoenix, Lynx, Pegasus and
    Pegasus+
  ARM: dts: imx6dl-yapp43: Add support for new HW revision of the
    IOTA board
  MAINTAINERS: Add Michal Vokáč as yapp4 boards maintainer

 .../devicetree/bindings/arm/fsl.yaml          |   6 +-
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi    |   8 +-
 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts       |  58 ++
 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts    |  42 ++
 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi   | 619 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts     |  58 ++
 .../boot/dts/imx6qp-yapp4-pegasus-plus.dts    |  58 ++
 9 files changed, 854 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts

-- 
2.25.1

