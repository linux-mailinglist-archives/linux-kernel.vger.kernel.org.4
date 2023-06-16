Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214DC732F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbjFPKyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345419AbjFPKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CA127EF;
        Fri, 16 Jun 2023 03:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A435262134;
        Fri, 16 Jun 2023 10:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B69C433C0;
        Fri, 16 Jun 2023 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686912366;
        bh=0x7t1g8daL8i3jr7qX7O4gRvhVWJIsgPU5r60pL859Q=;
        h=From:Date:Subject:To:Cc:From;
        b=N6An/e8roTDGqNHPUonI3qtPu9G8NCWBoFvj0M07M/XvHMY/pTctc0pp8hnfo8YMZ
         Oh4qy7J9feVBRDbhyB15Fi8N+8AijyqK/kf0rgNouxkhXw+ZnTsC3jg4W6xPjDbZFh
         lSNp3lqgHFRL1zTRPCX9QvE+hygdpJqmif1ol+CRKkersu2JOU2X/72t8E1y70PZBm
         LaB5n6COqaj5KrEeFoz5IiLl9b7gMn5C2wGhYuRen+pYBfudEHp5jfYPznLZs7gPnR
         l6M575TcT6I+L8ZYjoWboAe57VW8SvwuAsiaqecD98c6rsjD9AigCViWeNpwSr59s5
         zojez8n7aEwYQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 12:45:57 +0200
Subject: [PATCH net-next] dt-bindings: net: phy: gpy2xx: more precise
 description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-feature-maxlinear-dt-better-irq-desc-v1-1-57a8936543bf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGQ9jGQC/x2NQQrCMBBFr1Jm7UDTShZeRVxMk187YKNOogRK7
 27q8vE+72+UYYpMl24jw1ezPlMDd+ooLJLuYI2NaeiHsffO8wwpHwOvUh+aIMax8IRSYKz25og
 ceI6jE8D7swvUUpNk8GSSwnLEVsltfoiXYdb6/79SQuGEWui27z/ehho7mQAAAA==
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Michael Walle <michael@walle.cc>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention that the interrupt line is just asserted for a random period of
time, not the entire time.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index d71fa9de2b64..8a3713abd1ca 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -17,11 +17,12 @@ properties:
   maxlinear,use-broken-interrupts:
     description: |
       Interrupts are broken on some GPY2xx PHYs in that they keep the
-      interrupt line asserted even after the interrupt status register is
-      cleared. Thus it is blocking the interrupt line which is usually bad
-      for shared lines. By default interrupts are disabled for this PHY and
-      polling mode is used. If one can live with the consequences, this
-      property can be used to enable interrupt handling.
+      interrupt line asserted for a random amount of time even after the
+      interrupt status register is cleared. Thus it is blocking the
+      interrupt line which is usually bad for shared lines. By default,
+      interrupts are disabled for this PHY and polling mode is used. If one
+      can live with the consequences, this property can be used to enable
+      interrupt handling.
 
       Affected PHYs (as far as known) are GPY215B and GPY215C.
     type: boolean

---
base-commit: f7efed9f38f886edb450041b82a6f15d663c98f8
change-id: 20230616-feature-maxlinear-dt-better-irq-desc-fd31aee6641c

