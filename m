Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446A6561BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiLZJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLZJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:58:04 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636525FF;
        Mon, 26 Dec 2022 01:58:02 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BQ9vmxU036128;
        Mon, 26 Dec 2022 03:57:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672048668;
        bh=JxQrW/7JjDKzWfRlSNStXWL3EAObEqOtkObrTh1wfmw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KkPTznZDXIvrWMHoyy7qRz4kPc2nIrdoUciqKGf/ExhN3OP6HcwsoKDEOea+Mbf2J
         FztuOm1e4Av7DrpEm936xA9uSsgld/3A9dbhRYOHkF/6ES6/WvJfIbYStGOIpyyzRW
         jw492YUbjwRb+vjft7iQ12NpsDkk29P2p9zJeIbc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BQ9vm8q126041
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Dec 2022 03:57:48 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 26
 Dec 2022 03:57:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 26 Dec 2022 03:57:48 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BQ9vlvx003621;
        Mon, 26 Dec 2022 03:57:47 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC OLDI clock
Date:   Mon, 26 Dec 2022 15:27:44 +0530
Message-ID: <20221226095745.19757-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221226095745.19757-1-a-bhatia1@ti.com>
References: <20221226095745.19757-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible enum
list.

"ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
display subsystem request a pixel clock for itself and a corresponding
serial clock for its OLDI Transmitters. The serial clock is 7 times the
pixel clock. This clock needs the clock set rate request to be
propagated to the parent clock provider.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
index 8f71ab300470..0696237530f7 100644
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - fixed-factor-clock
+      - ti,k3-am62-oldi-clk-div
 
   "#clock-cells":
     const: 0
-- 
2.39.0

