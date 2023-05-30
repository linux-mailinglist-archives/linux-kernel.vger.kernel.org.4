Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6E717225
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjE3XzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjE3XzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:55:16 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70613E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:55:06 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3147F2C0615;
        Wed, 31 May 2023 11:55:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685490905;
        bh=CR/D4HszLFw7g5PkmVVQf15ez0ihtAw6SzCP2pi70Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWOIvWVJ1cMewbloLAT4l3zII898ttc0dOOfEeoiVTv0L/Q1mAMH6E4L5PUgdAEua
         bQ2dxk3dy0HjBRNzDB3M5sIS66uXWpSegq1k7R5BVPDkLFoCGlXkuorvYrfd83ErxN
         ZodcnJkq3jQ4AOJFHni8YsWO8pasQE9REXI9l/rkcIL9eJlgRsICnfZ6HqrFU883cW
         kZ1JFLCnIpaONfwTtvUCs94dH5kw3FDLVYL6zi33jconAV587dxFK+N6iuRbnQWS23
         na6I33S0I3gRmuVOPYnetHEPvvhO0E23kNC2az3g1q25q+sDERwz5xfGrEIwnPw05h
         mh+JI2C238gUg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64768cd90000>; Wed, 31 May 2023 11:55:05 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id F2AB913EDD5;
        Wed, 31 May 2023 11:55:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id F1B93280AFE; Wed, 31 May 2023 11:55:04 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 4/4] dt-bindings: mtd: marvell-nand: Remove deprecated compatibles
Date:   Wed, 31 May 2023 11:54:56 +1200
Message-Id: <20230530235456.1009082-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=v2geHv6J5O549XUBZ50A:9
X-SEG-SpamProfiler-Score: 0
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

Remove compatible values that were marked as deprecated in the old text
binding.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/mtd/marvell,nand-controller.yaml       | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
index 7cd4a2e99343..80ce854291cb 100644
--- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -18,9 +18,6 @@ properties:
       - enum:
           - marvell,armada370-nand-controller
           - marvell,pxa3xx-nand-controller
-          - marvell,armada-8k-nand
-          - marvell,armada370-nand
-          - marvell,pxa3xx-nand
=20
   reg:
     maxItems: 1
--=20
2.40.1

