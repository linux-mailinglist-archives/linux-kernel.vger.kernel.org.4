Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A695EF71F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiI2OEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiI2OEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:04:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE115D653;
        Thu, 29 Sep 2022 07:04:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd10so3058690ejc.2;
        Thu, 29 Sep 2022 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=aaTqeDdRO+djhzLgpWsYFsBYnZe7c1ZyDlDKq9kjNlM=;
        b=AsbbTHW/qkgPUXo6+GibyYTqC/UvT11BzBBoZ7djQe4SKUDh8YwZbXI89PHugMfbNm
         1egcxR39HYIKiFXIrgH7hhOa6nkR1mMQcU3nYCkmyFLoecJxsKcajd/3Z7aqKOUB1XLg
         7hcQua+I953Nx/QUnjkWlCQFKpbpMFFYEgvhesUy7OrLMYzXpxdXGWdNkiv1lOPSmfa5
         JwZYI/h4SzIcgPDHa3nVqak44JL+CQj1bmURpsV0KnEGzOD2SGnXuZFBtrs2IDxyvXA4
         0SiPs4WMCvmeCL/jH63Wk3DxAwZHVj/FpnIPrbrjCYhquvEePHqmYkBpmxkhtAl7AfXi
         +ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=aaTqeDdRO+djhzLgpWsYFsBYnZe7c1ZyDlDKq9kjNlM=;
        b=bHbsKFnilyHhyiet2g3OhdKuNeVpbkY1jtcghdQqn3izMElaU4RAzcncomGAq7zNLu
         WhpnSdI3JSrjzlfgnVf0bQY1ZV7VbjBcIm9bpitohbER/a4+qqkJpo5BUn43G5WrzwCz
         5A/mNf+KFWxjZOJxwjSk+TBsoEAvGQ1iG/iZ4GXz6M3N4mtea9M4fyxYg1o9G9XHYqMu
         Q3g/+a8u1SyUCzSJyhJneGm+K7uO6uHZZ58MG55KqgwihXLY24RGhFsm1qcgyx+HcU59
         IKyQVIeFhqkaRWQXLjrthCTVC3T22qdSypJB5Piq386N76A7FZ8VFoiuhCN+Q65UfOfm
         EALA==
X-Gm-Message-State: ACrzQf0jeeb3ey+xO11OD6EuSC+O8TZ2/+Gy1Peq7m8oQFSqRLJfYW8S
        Sf7qig+v+udk/XM20cme4YM=
X-Google-Smtp-Source: AMsMyM6J1MsnlGw55LN2xdQKGrcd4z5IXbVJSVMbllTOO4YiYid0p3lSXe8daZsBKfE9a5aoQ6rRWw==
X-Received: by 2002:a17:907:808:b0:730:54cc:b597 with SMTP id wv8-20020a170907080800b0073054ccb597mr2831906ejb.434.1664460247776;
        Thu, 29 Sep 2022 07:04:07 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-20020aa7c1c7000000b0045726e8a22bsm5554595edp.46.2022.09.29.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:04:07 -0700 (PDT)
Message-ID: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com>
Date:   Thu, 29 Sep 2022 16:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 2/2] ARM: dts: rk3288: add the interrupts property for
 PWM
To:     heiko@sntech.de
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, wxt@rock-chips.com,
        kever.yang@rock-chips.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
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

The Rockchip rk3288 SoC has 4-built-in PWM channels.

Configurable to operate in capture mode.
Measures the high/low polarity effective cycles of this input waveform
Generates a single interrupt at the transition of input waveform polarity

Configurable to operate in continuous mode or one-shot mode.
One-shot operation will produce N + 1 periods of the waveform,
where N is the repeat counter value, and generates a single interrupt at
the end of operation.
Continuous mode generates the waveform continuously and
do not generates any interrupts.

Add interrupts property to rk3288 PWM nodes.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>

---

Original patch location:
  ARM: dts: rk3288: add the interrupts property for PWM
  https://github.com/rockchip-linux/kernel/commit/16b7b284618d1652e694f6286f575ce82f5f03e5

---

"rockchip,rk3288-pwm" is in use as fall back string for Rockchip SoCs with combined
PWM interrupt.
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 487b0e03d..1223aa369 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -675,6 +675,7 @@
 	pwm0: pwm@ff680000 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x0 0xff680000 0x0 0x10>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
@@ -685,6 +686,7 @@
 	pwm1: pwm@ff680010 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x0 0xff680010 0x0 0x10>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
@@ -695,6 +697,7 @@
 	pwm2: pwm@ff680020 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x0 0xff680020 0x0 0x10>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
@@ -705,6 +708,7 @@
 	pwm3: pwm@ff680030 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x0 0xff680030 0x0 0x10>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
-- 
2.20.1

