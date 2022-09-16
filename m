Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512695BAC61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIPL1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIPL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:27:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C1A3D62;
        Fri, 16 Sep 2022 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663327643; x=1694863643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqcEjdujxakv3noDHpoHtBuaB79FIa784j+2h1ikqjc=;
  b=RKOA0hvf3E/8FWa/aNzpyCMN7HilEHrPwc7CfaltYEEjmzX87IuuQCG8
   kGl8aAjc+tAsMjkfekhMV+P2SKBE92pH7inwB7OXsZeuzVi9qhvHKw9Zs
   pSbjafGRx6/lEsP7GKKeA4DRWzGpA6SobWdoTGh38B5ySeQNXj9xzorUP
   HjRWvsH2hqeEevw7oJZgOCQ3KyXirSHzy5E690R8BlOYpdGhsgWtApOnx
   7EOAkIJumYXDHYGRnqStZW6BD4xNlak+5+tj0ISo2Cp6Y/yWIEZPVgC/R
   DUzX1B/m1NWjRK2DRGgA9tJk0MEiTXF4VPm+9RDunPI5OgM3QYmWILwuf
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="114001499"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 04:27:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 04:27:22 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 04:27:19 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 03/10] dt-bindings: riscv: microchip: document the sev kit
Date:   Fri, 16 Sep 2022 12:26:39 +0100
Message-ID: <20220916112645.567794-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220916112645.567794-1-conor.dooley@microchip.com>
References: <20220916112645.567794-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Update devicetree bindings document with PolarFire SoC Video Kit, known
by its "sev-kit" product code.

Link: https://onlinedocs.microchip.com/pr/GUID-404D3738-DC76-46BA-8683-6A77E837C2DD-en-US-1/index.html?GUID-065AEBEE-7B2C-4895-8579-B1D73D797F06
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 630f82c85a0c..ab0a64cd5386 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - aries,m100pfsevp
+              - microchip,mpfs-sev-kit
               - sundance,polarberry
           - const: microchip,mpfs
 
-- 
2.36.1

