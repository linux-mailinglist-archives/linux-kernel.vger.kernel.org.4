Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6966986E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBOVDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjBOVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:02:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5995C46D75;
        Wed, 15 Feb 2023 13:01:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qw12so216114ejc.2;
        Wed, 15 Feb 2023 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VUp+NjHQlk7QRhkHY/eVWdSJwlizf3fbd3NyJl4mf5Y=;
        b=kSU8hnfkTXFQSgIXcWAp6Q5sP/zmCOW0IILiw57c5yp6fHJZy2+0DVRf9mfN3kh+0N
         7HfK1SkmG0M79Rbl1w0r2f38Sl8x2b4Am5NnHPunHqoQ41TDOanhTMWkwOoj5yxEngmr
         tPMPed3dwEdXiUCYs8LKt7tBZ/aQlDhrXAlruI0gkGRZnxq3ulxoKUTRlQXprTEd2FD9
         LXtlW2UbCbUTP4gn/0egYl7Pfo5NBxxA63ibgwPj1plCYtL7iZ+BmxjzYhrvETrt8OMo
         5oquFOz0+iBhnbfwZ+j2Amlo+2UxnbEoyCTBSSrIdYkYCdBVR4T08/2JLznuHxlauu0E
         R+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUp+NjHQlk7QRhkHY/eVWdSJwlizf3fbd3NyJl4mf5Y=;
        b=UGW+OAPq8eYPUXUDldIgtiMEhJlOn9jrMO5L03qEWZ5aDaXNRWFfVh3miXkLHnW5Of
         uRJDrYntfQyoFY1vsXQ/kQsoguPRDsLqASCdJb5bvgmsj6/AaUflKE8FCR6LAtsCd+uT
         3DFkfBuLYS3+xYfX+1cy8iEMbvF8VdsXlvhdYYQYJBFnsHZzuXlKRW7Qml/52NLlaMHx
         8bdGhLWNW8gLYFuV5BLS+KFIU5B57WS7f+rjk8zq0sw55wC1B1/RTg/Djb6ucWCKsvLz
         kTZnlpCdMeDklduiqH4aGg9yGloYvYP+m/V+PZzV6jdlLPE9W6r2sFUF41GR0AabTcAE
         S3kQ==
X-Gm-Message-State: AO0yUKX/lU4uFzw7O1HFi90M138ZGgC5zWq3khTNWieHjaqf5t64/fVv
        7Ggg+q4Niy3H99YimOrCIdBPdi5E/LM=
X-Google-Smtp-Source: AK7set/1Z/v5Xz2z0uQdJVECDukHZj+cm0Gwg9IPjkNsreqh1L+qUYJBz1+XjYyyVp4LKYlb0kp8BA==
X-Received: by 2002:a17:906:a409:b0:887:981:5f7c with SMTP id l9-20020a170906a40900b0088709815f7cmr3725847ejz.11.1676494869798;
        Wed, 15 Feb 2023 13:01:09 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ov38-20020a170906fc2600b008af574e95d7sm8202046ejb.27.2023.02.15.13.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 13:01:09 -0800 (PST)
Message-ID: <038585bd-7226-b28b-93a5-e1676a57298e@gmail.com>
Date:   Wed, 15 Feb 2023 22:01:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3] dt-bindings: gpio: rockchip,gpio-bank: add compatible
 string per SoC
To:     brgl@bgdev.pl
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Content-Language: en-US
In-Reply-To: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all Rockchip gpio nodes have the same compatible.
Compatible strings should be SoC related.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Changed V3:
  Keep enum
---
 .../bindings/gpio/rockchip,gpio-bank.yaml     | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index affd823c8..2e9a5179c 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -11,9 +11,28 @@ maintainers:

 properties:
   compatible:
-    enum:
-      - rockchip,gpio-bank
-      - rockchip,rk3188-gpio-bank0
+    oneOf:
+      - enum:
+          - rockchip,gpio-bank
+          - rockchip,rk3188-gpio-bank0
+      - items:
+          - enum:
+              - rockchip,px30-gpio-bank
+              - rockchip,rk3036-gpio-bank
+              - rockchip,rk3066a-gpio-bank
+              - rockchip,rk3128-gpio-bank
+              - rockchip,rk3188-gpio-bank
+              - rockchip,rk3228-gpio-bank
+              - rockchip,rk3288-gpio-bank
+              - rockchip,rk3328-gpio-bank
+              - rockchip,rk3308-gpio-bank
+              - rockchip,rk3368-gpio-bank
+              - rockchip,rk3399-gpio-bank
+              - rockchip,rk3568-gpio-bank
+              - rockchip,rk3588-gpio-bank
+              - rockchip,rv1108-gpio-bank
+              - rockchip,rv1126-gpio-bank
+          - const: rockchip,gpio-bank

   reg:
     maxItems: 1
@@ -75,7 +94,7 @@ examples:
       };

       gpio1: gpio@2003c000 {
-        compatible = "rockchip,gpio-bank";
+        compatible = "rockchip,rk3188-gpio-bank", "rockchip,gpio-bank";
         reg = <0x2003c000 0x100>;
         interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&clk_gates8 10>;
--
2.20.1

