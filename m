Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FC734ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjFSEIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:08:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842831BB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:08:00 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5C9AA2C018D;
        Mon, 19 Jun 2023 16:07:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1687147672;
        bh=u0LwYlY+UmwjUoeVHHn56ui4IJQF/Y74vq7Rjx1yvDY=;
        h=From:To:Cc:Subject:Date:From;
        b=YwzuOYkfVD2mXP7ZfDIfkiBRcxg3qrUcNW7OhdY3GHmyerm/PZPg6DKhjKFX+zSUM
         g7+BhEUDm9bMpvkCfxPPDNTaqD03Wtyo7yBDlLBOQ6aFFQu1DQ2BeD7mbI51P7eOdx
         z8gQfidzrJUHKobmC8J0uS4Qg4Y1n1OhN0Y/akrQLZbaDArTMZs60oHeIrgH0FGD/o
         frx1MQIS3H1blFvOLSyeCIwMtnwQ+NAKN9SMsZujU+oWF5Zn9/Im6xUFVZoQDOrYWJ
         gJeTvCKEwEDbbj4XSgiAJ+uGxoVW2ae7zXB8RrdWkJZA54dWoJwHdAHZEp74CEe2jd
         n/uAWVek6X/7Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B648fd4980000>; Mon, 19 Jun 2023 16:07:52 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 268BE13ED5B;
        Mon, 19 Jun 2023 16:07:52 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3A427283B18; Mon, 19 Jun 2023 16:07:52 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v10 0/1] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Mon, 19 Jun 2023 16:07:41 +1200
Message-Id: <20230619040742.1108172-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=L0yewt80EUckiTMxMrMA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
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

For v10 the dts patches have been picked up by the ARM maintainers so I'v=
e not
included them in this round.

Vadym Kochan (1):
  dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme

 .../bindings/mtd/marvell,nand-controller.yaml | 226 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
 MAINTAINERS                                   |   1 -
 3 files changed, 226 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-co=
ntroller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.tx=
t

--=20
2.40.1

