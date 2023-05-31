Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB9718F29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjEaXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEaXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:49:35 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8A137
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:49:33 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E79532C00B8;
        Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685576969;
        bh=JIh3FKEV4AmqhnmtnVLTx9kvmjGqUSmH2UcfmnCgf5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=TEGwcpmjIiHaKlSngTD6pAfAxAPpnq3bj0DpgQgAF9wEXgGM9rrmzqMa+xwesJKj3
         uwnwSbeU5oOVk4Ov7RCu2DugdW0yibkI031ijCU4Vs03tZSNOEk9pX9sTtFfuZx9zx
         IxB3ne6RRYblOb2d4dqIfLYQN+BJ2aAZ9dX6SHb4TapH5qZkdeV3H5IJKSQzN+MnB5
         9r+35DJJNNw8+gwY0/HQQbrx/+1YrX57IYjwhzyZr5WfgqF50gRjZf30OTEah0FPfZ
         TW8QCdyRE0JuLaCMKV0t1yHN8WBwnnJOHbg+RP2wMlZMYq8kjWqHkLOeAcOQoSlIv9
         qiuMO6tgAbTUg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6477dd090000>; Thu, 01 Jun 2023 11:49:29 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id ABAA213ED2D;
        Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id AABE7285285; Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, conor@kernel.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 0/3] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Thu,  1 Jun 2023 11:49:20 +1200
Message-Id: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Score: -1
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML scheme for the Marvell's NAND controller
to validate it's DT bindings. Old txt file is deleted,
not included the compatibles and properties which were marked as
deprecated.

Also fix node name in cp11x DTSI acording to nand-controller.yaml

I've picked up this series to hopefully get it over the line. I think I'v=
e
addressed all the feedback from the last round of review.

As of v7 I've re-ordered the patches so the fixups for the device trees c=
ome
before the schema so if the series is applied in order the various checke=
rs
should pass cleanly.

Chris Packham (1):
  ARM: dts: mvebu: align MTD partition nodes to dtschema

Vadym Kochan (2):
  arm64: dts: marvell: cp11x: Fix nand_controller node name according to
    YAML
  dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme

 .../bindings/mtd/marvell,nand-controller.yaml | 223 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
 MAINTAINERS                                   |   1 -
 arch/arm/boot/dts/armada-385-atl-x530.dts     |  14 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 5 files changed, 231 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-co=
ntroller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.tx=
t

--=20
2.40.1

