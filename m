Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0607F6D65D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjDDOyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDDOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:53:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8A10EA;
        Tue,  4 Apr 2023 07:53:55 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-190-097.ewe-ip-backbone.de [91.248.190.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1F71660316C;
        Tue,  4 Apr 2023 15:53:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680620034;
        bh=IikQJ836mxZhL60P2UeGpbmM635QXQAuIZfGvIX+ffE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DretyPAM/9kQgPFkgyScXTFEQw5hvWe4ejl4xR50sqhhfwicebNK/PrBBkp3pQvGI
         chaHB6nKmVKi6wHid+nHrXg2BZV9e8dqWF3Zb+fHP/qwID6jmkYVuRn6a+UQmPES0V
         sfJRdATjmSedkmw6/1V5WDesd9gbZxwn0lQg5C72ZwWlVOrzVoNfjjn2SegoeZC9q3
         ZFTYG2FwK7qcY+qVrgngCvot8fDTtLqZ2Gn62EMy++3ytgPGft8Ekm7IUsiXHxitvO
         9vaEi+0BO2pQHtt8XcYTkb5abCDbxLQdzB/GJqr5/gFW6JcYzicfvRuPXxdrWP4MZ9
         +Lk9GUB/A6l2A==
Received: by jupiter.universe (Postfix, from userid 1000)
        id BC3164807E3; Tue,  4 Apr 2023 16:53:51 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 2/3] dt-bindings: usb: Add RK3588 EHCI
Date:   Tue,  4 Apr 2023 16:53:49 +0200
Message-Id: <20230404145350.45388-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404145350.45388-1-sebastian.reichel@collabora.com>
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
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

