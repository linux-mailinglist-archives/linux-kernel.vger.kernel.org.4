Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7E068DC6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjBGPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBGPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:03:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC713D6E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:03:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so13814431wrg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFW7tNlak5JNTFgYIMMRwtC1A6KUFtjNBI4Nk45Lvrc=;
        b=GPdFjyMvf71VLRCDW/2J5DzEOsghLE8D+Xb2lSXMQ6Md9fZCxbvYYgLjnymhq1IaM5
         7U31PpSbLdHSxL9Eq276+JJ8sQZL+sl+oEBMKc0AaclU28W+9WtjfCSPUHfzyXmOqmoX
         X0ntnCdCvjOhynvv1w0zKzcZS7mMbQdww8TP9OHGuxD5qJguU3LaC8twn1tjPSwVh0jS
         53UJm/uNVhgL/78h6Z30WL4yu12ZbFVSo44XihwkKvxgNrdXfltEHHfof2B6fdddEbZl
         EejCBwye57dfhJwygT8aAREBcBJ+jm9/PlLxmPha3sLqvmLl8IcHSdEn0MXqkgDC9WJ6
         qarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFW7tNlak5JNTFgYIMMRwtC1A6KUFtjNBI4Nk45Lvrc=;
        b=3/5Q08zT/kkkvOROIMfGaPIChSxfLdN+KNPhUg4Wl/QcDnzBbanIFsBuIhlU7mvlwW
         2BWBGP+uR1KgfpYHitfOvCO0Pmtzg0+S8y525/EsiuKCdOTHfwhmGXW8cdwNlzpf3mQE
         CC6QY6516SlQKGhpxEH7RiNo799Bm0hMqzEd4WvKmlCIMYlJQixww911bveBSKJbq8s+
         6W/Ng9j6AIsq/kEZeXyRadhUyAe9LAUOQMrhPXK9SisuW2ojfMz8CygfUfrE+HUykvQC
         HQQDhjIKQj2aFvm2fgTDbdUc65J/oDXFlKwOhoAnRsk2tSmaVYiHREWrYJzLg1vkXq0x
         e3yA==
X-Gm-Message-State: AO0yUKW0uPLFPKTq6pDt+WggDeye3Tp+XZHwm1sSL7N9HxRPAmMFlLjN
        6iFbTyrnY2nKYdbU6+zjBXsPmQ==
X-Google-Smtp-Source: AK7set/f5d5Gpi6UhKbDfQwgEwNZt0VF3yOdB/3oaOKJUnDOa+42YSsOXezDfmrEfQNbLfJUts4jNg==
X-Received: by 2002:adf:f350:0:b0:2c3:da3f:1def with SMTP id e16-20020adff350000000b002c3da3f1defmr3354645wrp.7.1675782235101;
        Tue, 07 Feb 2023 07:03:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id t15-20020adfdc0f000000b002c3f81c51b6sm1174395wri.90.2023.02.07.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:03:54 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:03:53 +0100
Subject: [PATCH] dt-bindings: phy: amlogic,g12a-usb3-pcie-phy: add missing
 optional phy-supply property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFho4mMC/z2OwQrDIBBEfyV47oIxSQP9ldLDrq66YI0oKS0h/
 17poafhDcNjDtW4Cjd1Gw5V+SVNttxhvAzKRsyBQVxnZbSZtNEr0Az4TFsQ+88wGoS90QTFCkO
 JH/DyBloc+mX2tLqr6j7CxkAVs43dmPeUelkq9+3vwP1xnl/W7GQOkAAAAA==
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing optional phy-supply property used to power up PHY regulators.

Fixes: 87a55485f2fc ("dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
index 129d26e99776..3314711292d6 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
@@ -35,6 +35,11 @@ properties:
   "#phy-cells":
     const: 1
 
+  phy-supply:
+    description:
+      Phandle to a regulator that provides power to the PHY. This
+      regulator will be managed during the PHY power on/off sequence.
+
 required:
   - compatible
   - reg

---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-b5daf54fb7d6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

