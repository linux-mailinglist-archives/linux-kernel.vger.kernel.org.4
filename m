Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1C65CFBD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjADJhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjADJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:37:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935D0DEB8;
        Wed,  4 Jan 2023 01:37:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 28B5C42037;
        Wed,  4 Jan 2023 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672825046; bh=LVorCvTWQkz/Q2WObjMPReptUQz5qI2RIky6WbFd8ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FoXDLqQ9RJ5PImr1LqyPYsRNBNO4bSKH61SINclpT988VTvJ1vEqCI5lCEC5J6ePQ
         FPsZvNqk3caFL9tYimvlB0lZ/cB+e5rEe66VCkomQMaQpA+RujCsHSNpnQegzh8jpR
         QRmAP46ut4paie3FM8Zo1Mw4Qh9wo2yWoqK/qcao4ikw7THfXnKBCtYz77kRCkvoYO
         dcGEjXjX28FKa4oS+vZVNkvG8D/ARjh7M/OK9ge18pgB8J4aoe5r2AV6Tkg1ALsg+l
         5otvzwYClu7BMGuJT+UrKDsdqcy3UtMnMjnQaD9Zzm380LvqTPIujaza22/IwVoNXF
         1qovWHKLEcibQ==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 1/5] spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
Date:   Wed,  4 Jan 2023 18:36:27 +0900
Message-Id: <20230104093631.15611-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104093631.15611-1-marcan@marcan.st>
References: <20230104093631.15611-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other delay values follow the delay-ns naming convention, so unify the
newly introduced spi-cs-setup-ns property for consistency.

Also fix a typo while we're here.

Fixes: f6c911f3308c ("spi: dt-bindings: Introduce spi-cs-setup-ns property")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index ead2cccf658f..9a60c0664bbe 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -44,9 +44,9 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
-  spi-cs-setup-ns:
+  spi-cs-setup-delay-ns:
     description:
-      Delay in nanosecods to be introduced by the controller after CS is
+      Delay in nanoseconds to be introduced by the controller after CS is
       asserted.
 
   spi-rx-bus-width:
-- 
2.35.1

