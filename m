Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2B6D98B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbjDFN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjDFNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:55:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4683CE;
        Thu,  6 Apr 2023 06:55:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-216.ewe-ip-backbone.de [91.248.189.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF18C66031C7;
        Thu,  6 Apr 2023 14:55:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680789355;
        bh=2xzVk10bLnRIinh3EylqLxL0KlAjJyUAKhmLqVYA9wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXd0xrj9CIppu2p/zkb3ClUVMn39n7QaID9rYSRVOMk7ei5c0Vw4xvzLNNzxI6zhg
         +IuFkyi3VmMv/A2uY3dE8nad2U58//ORyHl+iQhc3SBTPliSNVAZciem6uoyLg6FRq
         Q61OcO3C6Aeb+ivnIsXC4JpktXp2VsvK1JFfQT2CvAMiAWMVA0LpI4/fgJFPxzPjdi
         5ILDaW/T122Q1/xykBgnpc+YOeIfmqeNSmZGuf57TFKqwCTLlUiSX1GB47Apq/wf6X
         +fM0HfJzHpZ7hSetn1WLZ0Vc0nr3WPlN9TV07Fc30Z/gzlYqjZVBClyT3xPvSl0WIu
         Dx0EymEFvw2Qg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id EA6974807E3; Thu,  6 Apr 2023 15:55:52 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCHv1 2/3] dt-bindings: usb: Add RK3588 EHCI
Date:   Thu,  6 Apr 2023 15:55:51 +0200
Message-Id: <20230406135552.23980-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406135552.23980-1-sebastian.reichel@collabora.com>
References: <20230406135552.23980-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for RK3588 EHCI. As far as I know it's fully
compatible with generic-ehci.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 050cfd5acdaa..01bfbc6ded5c 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -61,6 +61,7 @@ properties:
               - ibm,476gtr-ehci
               - nxp,lpc1850-ehci
               - qca,ar7100-ehci
+              - rockchip,rk3588-ehci
               - snps,hsdk-v1.0-ehci
               - socionext,uniphier-ehci
           - const: generic-ehci
-- 
2.39.2

