Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC5718F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjEaXtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEaXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:49:36 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83481133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:49:33 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 145FE2C0274;
        Thu,  1 Jun 2023 11:49:30 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685576970;
        bh=HSmU/jfAgtf+HDugcnKG02Sm6nrjvpVXrEaWsS9cpjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpRt/jtSm0JDoPvT6qOVR8qaTlKfVvpUR9JRDjmbPDWzdfpw8IhZFXpcuaagv73uP
         bzOjtq7Q/w4UedZF/PtHXezT9MlI719yHp/pOKrYBEHnNLHtbbJjlHQLzt9gEkckeK
         pEBFissdMypw6940I4Ikdsr1sDv8BwlPE5EPmTuoMYAvq7JubA78SgQ4hx2c1j97Ap
         8l/6OFpuHUxxTf+SznUxjKnZFUlHiFn/ouSAdoGak3y0BER/P+8i4G6HNWQzTzfDQt
         0qaq/O6oC4TlB7qQSxecFQZfwhrQqMNBTzN1uaQeSpiJo7lbkRlXrr+O4rPmz/RWEY
         Ysy9JET3sasng==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6477dd090001>; Thu, 01 Jun 2023 11:49:29 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id C42AD13ED2D;
        Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C50AB285285; Thu,  1 Jun 2023 11:49:29 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, conor@kernel.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com, Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 1/3] arm64: dts: marvell: cp11x: Fix nand_controller node name according to YAML
Date:   Thu,  1 Jun 2023 11:49:21 +1200
Message-Id: <20230531234923.2307013-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Score: -1
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>

Marvell NAND controller has now YAML to validate it's DT bindings, so
change the node name of cp11x DTSI as it is required by nand-controller.y=
aml

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Notes:
    Changes in v8:
    - Add r-by from Miquel

 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-cp11x.dtsi
index 0cc9ee9871e7..4ec1aae0a3a9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -468,7 +468,7 @@ CP11X_LABEL(uart3): serial@702300 {
 			status =3D "disabled";
 		};
=20
-		CP11X_LABEL(nand_controller): nand@720000 {
+		CP11X_LABEL(nand_controller): nand-controller@720000 {
 			/*
 			 * Due to the limitation of the pins available
 			 * this controller is only usable on the CPM
--=20
2.40.1

