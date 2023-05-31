Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B77173FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjEaC7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjEaC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:59:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA49126
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:59:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C70F82C05F6;
        Wed, 31 May 2023 14:58:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685501939;
        bh=fnLWAwzW4HcUaGPzX4yrZBg7arlSfGoZ0Vz/F6qEpwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0/oU9/EXZFR89hamM3kfhnzjMQAr/ddbbpKpCU+DBJ2I3CfO5TXR0OwdUvrcum9M
         o2xDG3iUyHTauJn5yqnoZ8N0MajEP234FOV2ccFCAcSxWV7px0J5w/JDNwQWAJ0F0u
         NeB4XAFJ0Lh6xB14D0q+wLawpbfsE53bb5SIRC/BSvCtnrkCnnjE4k3uuetk815duO
         2SEoYWzvYjo4ZzK8BJ96fIh4CZMxP7UfdvO7FeS55i1JWpuY0En9mpr+loh8IdyhpB
         AnPZ7SmY+D4513TlsjII5UEqyhDk34+298BMoKVBaIHp//ZcBQ1EcZdi5RQpP+tdLj
         d7FjQoWJjOutw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6476b7f30001>; Wed, 31 May 2023 14:58:59 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6AF7B13EE43;
        Wed, 31 May 2023 14:58:59 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 64E5A2804C4; Wed, 31 May 2023 14:58:59 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, arnd@arndb.de, daniel.lezcano@linaro.org,
        neil.armstrong@linaro.org, f.fainelli@gmail.com,
        christophe.kerello@foss.st.com, liang.yang@amlogic.com,
        jdelvare@suse.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] dt-bindings: mtd: Add AC5 specific binding
Date:   Wed, 31 May 2023 14:58:46 +1200
Message-Id: <20230531025847.1284862-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
References: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=0frGRbVW35lbK5GUCdUA:9
X-SEG-SpamProfiler-Score: 0
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

Add binding for AC5 SoC.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/mtd/marvell,nand-controller.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
index 80ce854291cb..c09efd7a0043 100644
--- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - marvell,armada370-nand-controller
           - marvell,pxa3xx-nand-controller
+          - marvell,ac5-nand-controller
=20
   reg:
     maxItems: 1
--=20
2.40.1

