Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5980730DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbjFOEFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjFOEFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:05:07 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685172132
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:05:03 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3C4FD2C0295;
        Thu, 15 Jun 2023 16:04:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686801894;
        bh=SUSkUWLnjDnM6Q1oJEeOM0aUpiPD5yy/VyS5vIjY4aY=;
        h=From:To:Cc:Subject:Date:From;
        b=G2m16jUiT3PJFc1WNePThzY2fSHOUZuMC7YTahnqrmDYTKF/c8fBz7e75bxyrNZmk
         PyZxSlCPIsULxUj2QPRAgwHeCM95FXxSr6VhePS6q+vVYVJZXZTYBcbzqzMtiPWJkf
         BYZoMT+RLMVUOJBgMuAAiFUaCS7/x24NDbDI/1XlAHj3KCTtAYA12TQYTKvn7KXJTG
         JNqWFkgQ/u0kjvbC5RPMgqJ/YUZTw3IOA4bAbelXZ5qs2g/NbybVfftRLcmhZKI2hu
         4NPHAE6ENtLg+1htfyTh6BOoiEbKxbDBY1PlnjWrJTNtTQ8f2ge0cHoHWMkQw1t239
         DO7QDmXlk8EOA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B648a8de60000>; Thu, 15 Jun 2023 16:04:54 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 1573313ED5B;
        Thu, 15 Jun 2023 16:04:54 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 12C3D2815D4; Thu, 15 Jun 2023 16:04:54 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 0/3] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Thu, 15 Jun 2023 16:04:44 +1200
Message-Id: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=L0yewt80EUckiTMxMrMA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML scheme for the Marvell's NAND controller
to validate it's DT bindings. Old txt file is deleted.

Also fix node name in cp11x DTSI according to nand-controller.yaml

I've picked up this series to hopefully get it over the line. I think I'v=
e
addressed all the feedback from the earlier rounds of review.

As of v7 I've re-ordered the patches so the fixups for the device trees c=
ome
before the schema so if the series is applied in order the various checke=
rs
should pass cleanly. This is reliant on a series from Miquel tightening u=
p some
of the requirements on mtd/nand chips so the checkers may complain unless=
 those
changes are picked up too.

Chris Packham (1):
  ARM: dts: mvebu: align MTD partition nodes to dtschema

Vadym Kochan (2):
  arm64: dts: marvell: cp11x: Fix nand_controller node name according to
    YAML
  dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme

 .../bindings/mtd/marvell,nand-controller.yaml | 218 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
 MAINTAINERS                                   |   1 -
 arch/arm/boot/dts/armada-385-atl-x530.dts     |  14 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 5 files changed, 226 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-co=
ntroller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.tx=
t

--=20
2.40.1

