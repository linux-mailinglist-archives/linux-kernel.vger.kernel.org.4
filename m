Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FC5BB298
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIPTAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiIPTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:00:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1FE371A9;
        Fri, 16 Sep 2022 12:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BE0B82055;
        Fri, 16 Sep 2022 19:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918DCC433C1;
        Fri, 16 Sep 2022 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663354834;
        bh=pITHOG3XiMpOygf5N7xHvQ2HYp5lH+CVDS0HOuIp0BI=;
        h=From:To:Cc:Subject:Date:From;
        b=HvXfWnuN9ie9YL6VtZM3wqunV8xS5LIVp++h3KeANlVmpWIPmyTlR9DPyvEC6BwkA
         xbr3WrgIM5Lq2j/fr2esjx3h98lRVqKct8wiHieAwi6SljjVsjuZUbSWlVdu/eqsXe
         zaeec6neBB4HnGV7Fb81XVL4eaAvzrEa1mG0zsKSeugmvV9ed1zOdAobHqYYCbhTOV
         IeVjcWb++YPqGjEBSC6bLEvBynsXfUJjuGsSoN+xUjinR2Kuk44jar92KP6nvHZJj/
         UA1qdGdIl3w+x7PHfNMlz9M2ndMOHwYsaDl2ktKDi/51k9q/NhlUf2mtbpHI5L0om/
         6B/IsdLKBNmpQ==
From:   Conor Dooley <conor@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] dt-bindings: mfd: dlg,da9063: add missing regulator patterns
Date:   Fri, 16 Sep 2022 20:00:10 +0100
Message-Id: <20220916190009.2292223-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Commit 5621d3977e29 ("dt-bindings: mfd: Add missing (unevaluated|
additional)Properties on child nodes") exposed a flaw in the original
binding, where "merged" versions of some regulators were missing,
leading to warnings on the HiFive Unmatched Devicetree.

Add the missing patterns (and merge some of the trivial ones).

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I opted not to include a fixes tag for the conversion since it just
converted what was already there. I figured the original text binding
is just incomplete rather than "broken", but if you don't agree the
fixes tag would be:
Fixes: c7f15d43a5c5 ("mfd: devicetree: Add bindings for DA9063")

 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index 54b47bd4c6aa..e8e74e91070c 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -73,7 +73,7 @@ properties:
     type: object
     additionalProperties: false
     patternProperties:
-      "^(ldo([1-9]|1[01])|bcore[1-2]|bpro|bmem|bio|bperi)$":
+      "^(ldo([1-9]|1[01])|bcore([1-2]|s-merged)|b(pro|mem|io|peri)|bmem-bio-merged)$":
         $ref: /schemas/regulator/regulator.yaml
         unevaluatedProperties: false
 
-- 
2.37.3

