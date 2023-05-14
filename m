Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83290701F7E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjENUTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:19:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D2A1B6
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:19:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96aa0cab88dso452752366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684095574; x=1686687574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAZGDRgIzX5FxRnFiUuhXBp78w1oVd47wiPNPhXAe6I=;
        b=ArSPJz3lBX5aXI8VdTFkH5lzFoT+Pn84eoU5b3DqOpN6MQ2722X4ARnVQMP9lYOS0Q
         Lo01D8kPnjDFzT2XXGUvhd3YQ14w//o9i3m2yhbhK9BELU3Gu7++JpzDvkRHYLBYSIRO
         g8UstJ2eNsPengUYiaZdFSxzWKnjZ6Zn6Fx/fJLOW8gLZVm2bR5peUcW3kmz7331NK4P
         +RQ5MvowhsjeH2KGR6yxdg/32ubIKO+pLJ08U3CdiGM2Cez5EtqdniQVxjwLKA9dPHfn
         By2mQvdoc766VOFHlH1Mu5JukW2uUQzegjALkroaDDQU5QohebjASlQuwagesM0B7W9C
         MCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684095574; x=1686687574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAZGDRgIzX5FxRnFiUuhXBp78w1oVd47wiPNPhXAe6I=;
        b=JNub4UU17PBNl//FFoHX1jo+LFVoiREmKP8lqGjeLMSR3EteQ0VFABpOGf6luKClZn
         5pNmRDdMhrkD9JDVyawds3K8Ffl1oL1o95dnAslkEk+YwHlLuk0ZCm2uhhrB/iXngtBi
         aJhGLmIUosj16vLGJTMagPXeyELdx2F4NQlujAeUB+NH5q8fcoTLa+8QwczaZbA5I63K
         C7QS5PPRrL504I1HI0LUd/E9cPW7U3ZIG6pPH0d9ozS7eRIu6zNqZQ4ulWFc9G8HIlDx
         EBJIzO65sk5DfPmoUwIaWcDDo77YYzGZ3DWo8qQ0ihqVOLXrgt51xIC2T+owW4RRdUUA
         2Qhg==
X-Gm-Message-State: AC+VfDwsVU/EPH+YTAy5fQmgyGKCBEqMy8hiQiObnzSkES1V0ktcRzXn
        c9QYu/4zyC6FgxHa1rGdxJM=
X-Google-Smtp-Source: ACHHUZ7n4NGNuyH7m4b/27oPWm+NBnaOfblAd/I9alEfoRukF+KLrmKgITtn7lWZsLnvmLV46W56pw==
X-Received: by 2002:a17:906:7304:b0:921:da99:f39c with SMTP id di4-20020a170906730400b00921da99f39cmr35343433ejc.12.1684095573386;
        Sun, 14 May 2023 13:19:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7ade-5d00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7ade:5d00::e63])
        by smtp.googlemail.com with ESMTPSA id ze12-20020a170906ef8c00b009659fa6eeddsm8529291ejb.196.2023.05.14.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 13:19:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH v2] ARM: dts: meson8: correct uart_B and uart_C clock references
Date:   Sun, 14 May 2023 22:19:09 +0200
Message-Id: <20230514201909.506090-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Meson8 uart_B and uart_C do not work, because they are relying on
incorrect clocks. Change the references of pclk to the correct CLKID
(UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.

This was originally reported by Hans-Frieder Vogt for Meson8b [0], but
the same bug is also present in meson8.dtsi

[0] https://lore.kernel.org/linux-amlogic/trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55/

Fixes: 57007bfb5469 ("ARM: dts: meson8: Fix the UART device-tree schema validation")
Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net> # for meson8b.dtsi
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- move the link to the original report for Meson8b to the description


 arch/arm/boot/dts/meson8.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 4f22ab451aae..1054297fa69f 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -769,13 +769,13 @@ &uart_A {
 
 &uart_B {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
-- 
2.40.1

