Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5636F0D41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjD0UfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344266AbjD0Ue4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:34:56 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7258D3C07;
        Thu, 27 Apr 2023 13:34:54 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2135FC76A8;
        Thu, 27 Apr 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682627692; bh=XjGdRhsmtUEv3bL4pUwAXfQDROOKgUXLSYiUh/MFUrQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ZgHtK0UoWneELUdHO6tFQX/gYw6e0e5yN8l3Oe5UwMDXvg3YUVGb5+SjamFpOrmVV
         Rh4DRAvt0gt3v1szg3AXT/3FgQIxs5NWpkMp+vCJWxNxqRv3iYe/TIrHx3kEjYcvxV
         u0/UiMDOE5kf4Yqbo0BpJDw2B1AiK5bU1oYig0oc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 27 Apr 2023 22:34:26 +0200
Subject: [PATCH 1/4] dt-bindings: input: pwm-vibrator: Add enable-gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-hammerhead-vibra-v1-1-e87eeb94da51@z3ntu.xyz>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
In-Reply-To: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=740; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=XjGdRhsmtUEv3bL4pUwAXfQDROOKgUXLSYiUh/MFUrQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkStxkdAWfDnqz7TT/GzawAYKxSbg4VfTYvJYj3
 9mZFU6UGb2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZErcZAAKCRBy2EO4nU3X
 VqD+EAC3ymL3raVAm5oHlfbA4tZF+cRBNV+pegJxIBpJoalzqCt7AW5ZK2vLhEe7iPVFp4Lzoi3
 FDTq3G9Eza2r6Nm8k7tgnRwWSAdpkG5yEWMVfFjgKkG3qUbsmxu2QOCkr4Z08OvZTv0LopyeHsy
 OY433yovFjEB21j5KAix4HRHFd1Ce01k4wOceHfWFSd4liia02jE8GBwBuOUYmlmY3FbCHFKn2X
 9g3X9osAYzeiC2myDQ7+je6C5XaE/y8F40VxZsZx4xgVdI0jiUi9qyZow7//5EEwb2ljJlJagY1
 e2dXBY8czw5UtoKGZ09KUqeRUi3dS9mRRmt7iZhzHqGjXy7YPnffBvWm4oEDFiPFl0W9tFyipHe
 h3y8w+jx3Bhpmob4Fb6USpKxvyF/w0008gIGYPEiewNHhSA2ITsBHmj3jMG7f52cCSDO5VOdY4R
 11YY2zSpVSClI9jfwvQLlPJT+TRPav+jsEuF2aXl9ahSKpTC37nZnW+rXbskAHP3LoGKZn12FU1
 haK3ztGRJDvCu3xu5pstp0vpI7+WMg7N9nxglV7c+h57Tb7wX0WehgfDZfNqlEs0+ThUNJivytF
 AMIQGcuC9Yhf5b+naYJ2IGkyDAOOpt1fq3ekDBXGpCiOT5SWbWeXzQcVJjyg7rsfl3jQquzEwf6
 yMQKVZPy2sU5GnQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pwm vibrators have a dedicated enable GPIO that needs to be set
high so that the vibrator works. Document that.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/input/pwm-vibrator.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
index d32716c604fe..6398534b43c3 100644
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
@@ -32,6 +32,8 @@ properties:
     minItems: 1
     maxItems: 2
 
+  enable-gpios: true
+
   vcc-supply: true
 
   direction-duty-cycle-ns:

-- 
2.40.0

