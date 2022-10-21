Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017E2607DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJURrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJURr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:47:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E024B335;
        Fri, 21 Oct 2022 10:47:27 -0700 (PDT)
Received: from jupiter.universe (dyndsl-037-138-189-087.ewe-ip-backbone.de [37.138.189.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 252B066025FA;
        Fri, 21 Oct 2022 18:47:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666374446;
        bh=H47s4Vww46ISyx+X7Wz7KvqsX1h10yHB4Z5oppVpziM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b93aAqBSJSJYyKb0dFqjUcIII/z8/XELYAUfNcuzvn6J0tCsP9X8caIzeBhRaFL+q
         JMfyngQ2plNxcKa8l2UFMIBv8y+aLRooKNO+U793hKJ/8XIh/ArG8mh43eLFbvEnnA
         vpsdrn/FPLGtAYSB8sNrAlPUPttC7NaLl2EzX6mzhKusxnH0ESnjrL1kMiywKtzJwI
         4EYEPT959vl00OE1XIbgsTS690LVBjXOtdsgAfpRKN2KdbfB9R/EpSg6ENr1GYovg7
         Yi4vyh5yyCnRCqxjU0Gq0jICp90UGWE5bWTC5QWUZQOfHuwENXIvaq57GJAZX7umY6
         PzHDmwzdfi3Uw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6644E480897; Fri, 21 Oct 2022 19:47:23 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/2] dt-bindings: rockchip-thermal: Support the RK3588 SoC compatible
Date:   Fri, 21 Oct 2022 19:47:21 +0200
Message-Id: <20221021174721.92468-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021174721.92468-1-sebastian.reichel@collabora.com>
References: <20221021174721.92468-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for the thermal sensor device on RK3588 SoCs.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index f6c1be226aaa..55f8ec0bec01 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3368-tsadc
       - rockchip,rk3399-tsadc
       - rockchip,rk3568-tsadc
+      - rockchip,rk3588-tsadc
       - rockchip,rv1108-tsadc
 
   reg:
-- 
2.35.1

