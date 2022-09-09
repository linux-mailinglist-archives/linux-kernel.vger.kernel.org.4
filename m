Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2323E5B3FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiIIThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiIITgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:36:39 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A3B01153BB;
        Fri,  9 Sep 2022 12:36:37 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6602ADBE;
        Fri,  9 Sep 2022 22:40:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6602ADBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662752421;
        bh=wYx4YZQxrd0X1DNHR+uvu1prpgP1TFhOgzBZNgxVtkg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ISH/lFNkRqQ0b2n9GqTdZQoZ0TN34V0kKKFH2GI5krA5iuCV7qhvwbY5i0in2OO0c
         5D8yRBgaxdaaqM4oTUvkKvxzRyig7m+A1JzMkSCCe5ZU983wfMWAiZPITJzPllxh3g
         nIq8uxfqUDODAlPeWIPOi5yRvggpRRAep+bFNNP0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:36:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 05/23] dt-bindings: ata: sata-brcm: Apply common AHCI schema
Date:   Fri, 9 Sep 2022 22:36:03 +0300
Message-ID: <20220909193621.17380-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom SATA controller is obviously based on the AHCI standard. The
device driver uses the kernel AHCI library to work with it. Therefore we
can be have a more thorough DT-bindings evaluation by referring to the
AHCI-common schema instead of using the more relaxed SATA-common one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v4:
- This is a new patch added on v4 lap of the review procedure.
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
index 4ee74df8e58a..fa8ebc8f243f 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -14,7 +14,7 @@ maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
 
 allOf:
-  - $ref: sata-common.yaml#
+  - $ref: ahci-common.yaml#
 
 properties:
   compatible:
-- 
2.37.2

