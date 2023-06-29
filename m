Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887A742C14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjF2Snx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjF2Snk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:43:40 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D252693;
        Thu, 29 Jun 2023 11:43:36 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id A99DF605D2;
        Thu, 29 Jun 2023 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1688064213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKwn4pI+xbCMED6ZrjRNts/9bUc9vmXTiZ+7Mh6MCJo=;
        b=IuoPkO4nES4sD7aKHkl3yJuMO9wW83z8euR0VrDgqxiD4ItrWnf57ouhYuJaBZxvn7Awcd
        tosMG8V2vFIr8FsCGgrRB+ucVrOwuzr7W6gmpfqDmh5KydHrSgF6VohYv5O4ANOqpcWYRq
        +H0bMt/M9A8r6wQyhcwS1Xu8ysdteoQ=
Received: from frank-G5.. (fttx-pool-157.180.227.241.bambit.de [157.180.227.241])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id C0D411007BC;
        Thu, 29 Jun 2023 18:43:32 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: drop assigned-clocks/clock-parents
Date:   Thu, 29 Jun 2023 20:43:17 +0200
Message-Id: <20230629184318.551317-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629184318.551317-1-linux@fw-web.de>
References: <20230629184318.551317-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d645d265-62e5-466c-9f7d-58ccb7702d42
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

MT7986 has 2 clock-parents and these properties are not needed in driver
binding. So drop them completely.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- drop assigned-clock* completely based on discussion with Krzysztof in v1
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 46eefdd19a2c..3fffa467e4e1 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -91,16 +91,6 @@ properties:
       should switch dat1 pin to GPIO mode.
     maxItems: 1
 
-  assigned-clocks:
-    description:
-      PLL of the source clock.
-    maxItems: 1
-
-  assigned-clock-parents:
-    description:
-      parent of source clock, used for HS400 mode to get 400Mhz source clock.
-    maxItems: 1
-
   hs400-ds-delay:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.34.1

