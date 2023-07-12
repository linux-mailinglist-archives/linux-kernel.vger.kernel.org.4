Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55827750924
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjGLNDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjGLNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:03:19 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370CE1BC2;
        Wed, 12 Jul 2023 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Je9kA79nmo/Vu3w4VCbOv1zsr8QBZH+1p9WUpYaU9Qk=; b=BfmNVPkqgjp+ncmZ00AtpJEK7Z
        IInCLl08bFBs+yhLcLVHJjBqTtRLZluSruWBAyTLmGunS7wBJYftkY8duLOdED9HOZWmZZgVSScNc
        cPN3ZqmnsnjQvqqqp1daGqqa/w24y3N7tfZScvw1kTBZldFUH7/dqdTW3BKwJ1zGPS2f4WDagujlK
        UkxdkKf0N0SsuyjmwQ25xoJwO2c6yumJOgOhNt/e8ypLiaIjZz4rj2DdbR2dKyu31DI3Dn4TigY9O
        aGlo0ZqNGsKRDHy3dfT0jrWD3Jqk6suVMauS6RvlpCYn8PxRbifNzea0jeJjp5Wvp6LIwD4IpdNjr
        GM4GjNsw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJZBj-000NNd-PH; Wed, 12 Jul 2023 14:43:23 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJZBj-000L9W-5z; Wed, 12 Jul 2023 14:43:23 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] dt-bindings: arm: stm32: add extra SiP compatible for oct,stm32mp157c-osd32-red
Date:   Wed, 12 Jul 2023 14:42:46 +0200
Message-Id: <20230712124248.2400862-8-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712124248.2400862-1-sean@geanix.com>
References: <20230712124248.2400862-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding support for the Octavo OSD32MP1-RED development board.

General features:
 - STM32MP157C
 - 512MB DDR3
 - CAN-FD
 - HDMI
 - USB-C OTG
 - UART

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 4bf28e717a56..232abdcef0fd 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -143,9 +143,10 @@ properties:
       - description: Octavo OSD32MP15x System-in-Package based boards
         items:
           - enum:
-              - lxa,stm32mp157c-mc1      # Linux Automation MC-1
-              - lxa,stm32mp157c-tac-gen1 # Linux Automation TAC (Generation 1)
-              - lxa,stm32mp157c-tac-gen2 # Linux Automation TAC (Generation 2)
+              - lxa,stm32mp157c-mc1        # Linux Automation MC-1
+              - lxa,stm32mp157c-tac-gen1   # Linux Automation TAC (Generation 1)
+              - lxa,stm32mp157c-tac-gen2   # Linux Automation TAC (Generation 2)
+              - oct,stm32mp157c-osd32-red  # Octavo OSD32MP1 RED board
           - const: oct,stm32mp15xx-osd32
           - enum:
               - st,stm32mp157
-- 
2.40.0

