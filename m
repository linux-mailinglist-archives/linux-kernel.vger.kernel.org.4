Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5691974FFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGLHBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:01:29 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F63910FC;
        Wed, 12 Jul 2023 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+NSeTWXlLaqd0QM9E2r5+dF51AyaD/+hwbdBrA7hUf8=; b=BAwbX8dW/pTaGY1CSBxc+7tKfC
        esW7y+Dj55pPzsDW3zRiqp6vfpwKnEqfiUyKfth3qh4SKvmDkmV+k5E7gMIaoe9VaHAWqRGY21rXB
        pql5AF2Yvvtlo8SQCsFiXtC7sJbGjIFVifA3iBWkiOw8Xz4mM6kVQ5ex47CN2FSG6TxDzVspDYjYs
        K4W4jXhf4B3cGPkwXMaBs7Ql6uhCU+Q3qr/gbmJ40kIW8Pd+BIL+xeZrviScMnuHKQqnO23LexvDg
        7WcLHWUxvFwru/yKwWIFIJ9lnjKTCT6ncnRS9pTDrng1DFZRQqtrxhGcEEtyD8lxid2KmVEJ5Iron
        OkyXod7A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJTN4-000ANb-Vg; Wed, 12 Jul 2023 08:30:42 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJTN4-00020e-Ci; Wed, 12 Jul 2023 08:30:42 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     a.fatoum@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] dt-bindings: arm: stm32: add extra SiP compatible for oct,stm32mp157c-osd32-red
Date:   Wed, 12 Jul 2023 08:29:52 +0200
Message-Id: <20230712062954.2194505-7-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712062954.2194505-1-sean@geanix.com>
References: <20230712062954.2194505-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 13e34241145b..55e45db1af26 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -143,7 +143,8 @@ properties:
       - description: Octavo OSD32MP15x System-in-Package based boards
         items:
           - enum:
-              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
+              - lxa,stm32mp157c-mc1       # Linux Automation MC-1
+              - oct,stm32mp157c-osd32-red # Octavo OSD32MP1 RED board
           - const: oct,stm32mp15xx-osd32
           - enum:
               - st,stm32mp157
-- 
2.40.0

