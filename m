Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B36FE5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjEJVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjEJVI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:08:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E962103
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:08:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so73019342a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683752936; x=1686344936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Klp0CuqpJHxhI4O+L3MmlfTlbLGWu6X4eGPiSxnBnSI=;
        b=JwjeiFB6UnwVN5uAvfMWTOvZjUOtG7e+DtdxPbcjmkpuz0YYSvL9ZrXzfV8SfjkvUq
         r9TrPbOSEkS3IKfqy+Qi8PXJCtVhazB//l5wQmSibutGIR9NS/Cbsw0vufV+PI7gKuta
         Ed5KIVXnzpV3N1NtzvdE8wcPMbStIWTqzFROHwIsbydjJ+DmQ8KHiHxWV/1SqXYo/XiD
         7hoyEgRkKEn1pdzPyaj2YlUYcfTSwbD37MMoQaxTXgwdzvMwl4Oa15eliz3R9L2yO9ST
         p0mS+a+VgSOj+bpnvMLrjg9kXwsqIAmh8QTj+iRS8ZcpFZAPYwoE5jPP7c+AmYBl/dlI
         2KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683752936; x=1686344936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Klp0CuqpJHxhI4O+L3MmlfTlbLGWu6X4eGPiSxnBnSI=;
        b=ThV85QBnPThNN7tSPGZWjiWN+onfZ06BlLPmh1V+LO6+sfbfrYKaNlX4IW+9S65NHE
         sEeaq2T1hi9+dfbJBS/fpLcD4W/QJ0qAkAS62/QIq8eHLUAntYbw3Z8P5irzlTyEqvO1
         lJN7qn+xZPfezEfGjSm6Lf3qRk4QjdvVvmOkZSKC22DGHH0XlDnIlYSVzkwYe7tx1GWR
         OLQhxGqmfFYzOB+80QHnknZgVaBBIKug6OBTYhap9R+brgdKDNv/cVtK6jxBfyyFw+6X
         DqpokndP1skZTj/S/xWsP7dyFLGvPsYfhorgUcPh9gGxRQsOx+QOMekQ7/sKPfYjdCCJ
         icqg==
X-Gm-Message-State: AC+VfDzTqCVj3VDb8EYXRU56/s+ro4bhloMBXKUCwKfv0JyfXyAYW7Ul
        W7W8SzBunoc0ryNh8Q1QDdk=
X-Google-Smtp-Source: ACHHUZ5qIS4HeK3MbSIU0JahyE4JOxNqgOyqPJvhEDQJXjfmm3bGD837sTzTbsdypjvcqa8vX4teWw==
X-Received: by 2002:a05:6402:5202:b0:506:bd27:a2f0 with SMTP id s2-20020a056402520200b00506bd27a2f0mr17050000edd.15.1683752936065;
        Wed, 10 May 2023 14:08:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-b859-1e00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:b859:1e00::e63])
        by smtp.googlemail.com with ESMTPSA id m24-20020aa7d358000000b0050bc6c04a66sm2234239edr.40.2023.05.10.14.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:08:55 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH] ARM: dts: meson8: correct uart_B and uart_C clock references
Date:   Wed, 10 May 2023 23:08:47 +0200
Message-Id: <20230510210847.996980-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Meson8 uart_B and uart_C do not work, because they are relying on
incorrect clocks. Change the references of pclk to the correct CLKID
(UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.

Fixes: 57007bfb5469 ("ARM: dts: meson8: Fix the UART device-tree schema validation")
Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net> # for meson8b.dtsi
Link: https://lore.kernel.org/linux-amlogic/trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55/
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
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

