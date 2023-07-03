Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E974553D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGCGCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:02:30 -0400
Received: from mail.inventec.com (mail.inventec.com [218.32.67.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE22CBB;
        Sun,  2 Jul 2023 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=sEx03; d=inventec.com;
    h=from:to:cc:subject:date:message-id:mime-version:content-type;
    bh=dcvSYvSNU+uro1iISYrrd705f26G2TyH8iwSt1QWGqw=;
    b=pQcJPw1vKC/BVgGR4Lkr+ZRGD8aZQ53szY8rM9aAsb1FJayAYlhFDJwhRK+9mJ
      m5AkjFdk+mEQx3jypH+GfZ44/gN8kEYM8MCKFsxEHN5dj+QtHgUlnaKnSkxeeL
      FvAkoUN76ndnjNa7srNkozM4SeiHdoqPwAZIzCfZerQkZK4=
Received: from IEC1-EX2016-04.iec.inventec (10.1.254.222) by
 IEC1-EX2016-03.iec.inventec (10.15.2.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 3 Jul 2023 14:02:24 +0800
Received: from TAO-MailRelay-1.iec.inventec (10.6.254.133) by
 IEC1-EX2016-04.iec.inventec (10.1.254.222) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Mon, 3 Jul 2023 14:02:24 +0800
Received: from charon ([10.6.141.37]) by TAO-MailRelay-1.iec.inventec with Microsoft SMTPSVC(8.0.9200.16384);
         Mon, 3 Jul 2023 14:02:23 +0800
From:   PJ Chen <chen.pj@inventec.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>
CC:     <ye.vic@inventec.com>, <Huang.Alang@inventec.com>,
        Chen PJ <Chen.pj@inventec.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add Inventec starscream-bmc
Date:   Mon, 3 Jul 2023 14:02:21 +0800
Message-ID: <20230703060222.24263-1-chen.pj@inventec.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:02:24.0048 (UTC) FILETIME=[EFD1AB00:01D9AD73]
Content-Type: text/plain
X-TM-SNTS-SMTP: 3E1DF7C11C547A2FC99E3D2474257FEF65628B9BCDE1CD7826B620155397CAE42000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen PJ <Chen.pj@inventec.com>

Document the new compatibles used on Inventec starscream-bmc

Signed-off-by: Chen PJ <Chen.pj@inventec.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1b585e554791..fb4ce5df2fa0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -82,6 +82,7 @@ properties:
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
+              - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nuvia,dc-scm-bmc
-- 
2.25.1

