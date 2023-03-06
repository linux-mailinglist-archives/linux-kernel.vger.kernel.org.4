Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F56ACE55
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCFTmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCFTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:42:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DB39B8B;
        Mon,  6 Mar 2023 11:42:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so43292468edb.9;
        Mon, 06 Mar 2023 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678131763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q41eI3CW9uAy7k5oi4qNmPdGdSMRz93rZBadRTLziRk=;
        b=qVMrDRmQn/iaiP9Wa2lsVvY0Irv1NqrUfRTXCepPG5gW4vXNaGEtS1CxDqleR6VYrx
         soQwe1Bola+ES46V3O2Ha/+bItqmj23kDdUN/5YfYEywdpla3BYqwnitqWDttTYPn6RR
         10VhYy2tVr7o0yWAsH1ouzn2but4BRxcoVp6MC9GExtFdr7epyhBqRgO6xAR/V6/K7Ht
         oW0CYLnJrkB97sERv7jp18DzTIBQmnBNf16zsCbxL1UWSD3maO/f7e8MIBMekdTayNs/
         Kabpc360zAECQGiJXsl66tEqpls+ECpFruy0gmgRGYoyWAwVsMTlimaMfWs8UkzSsdoj
         rKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q41eI3CW9uAy7k5oi4qNmPdGdSMRz93rZBadRTLziRk=;
        b=eQYpk69xTxM3JVx54dTTCZ21IFMQBjVxAezDZ5aQ8e7jLJs0pljpgOditLcdEY9eoN
         uYr/z4yejkSwXTvXw0NIDAzVfX6u5L2a1mzkYTs/gXDyPEAf6v8e82bu6fVKn7xTHLK9
         6Y3lJsNcOWIe3VvRoyF72pzx8tVfQrRuuTi58x3YyCOQ110cgDrwW03NqnKbm1CIapOf
         E0qH1p6be2UDdy765lWvF44HzoSMcBtcoqjgjEQ655zGKaChNwVvKNyhf/ftCtjcBqTb
         QycpdYuaAwikFxLgC6g65KBZDl+j1eR31kvMuUAfsMGh3g6Q1oj4rC1OY1il5O23+lbY
         RCvA==
X-Gm-Message-State: AO0yUKV71Me4GjFRXcP2LJfjQ/aJoFV1fZVFh7QxUIaBeO69alKhy4j7
        DHzluPGyqbYgpZqe6Wk9U7M=
X-Google-Smtp-Source: AK7set9HvmALN/zwsmRbaBhWZ8lXmYT6BfuINzZbe8SDfa45rG8WuMTks/HGygS9zDUm/OQ3bSgQ/A==
X-Received: by 2002:a17:907:7fa7:b0:8d7:6699:3bae with SMTP id qk39-20020a1709077fa700b008d766993baemr14147626ejc.57.1678131763279;
        Mon, 06 Mar 2023 11:42:43 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c405-5c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c405:5c00::e63])
        by smtp.googlemail.com with ESMTPSA id e19-20020a170906315300b008f2b0c6052csm4951868eje.89.2023.03.06.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:42:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/3] tty: serial: meson: Add a new compatible string for the G12A SoC
Date:   Mon,  6 Mar 2023 20:42:22 +0100
Message-Id: <20230306194223.1869814-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
References: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson G12A (and later) SoCs also have the "divide XTAL by 2" bit
as the S4 UART controllers. Add a new compatible string for these SoCs
and enable the has_xtal_div2 flag for them.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 -> v2:
- none


 drivers/tty/serial/meson_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 74110017988a..2501db5a7aaf 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -779,7 +779,7 @@ static int meson_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct meson_uart_data s4_uart_data = {
+static struct meson_uart_data meson_g12a_uart_data = {
 	.has_xtal_div2 = true,
 };
 
@@ -788,9 +788,13 @@ static const struct of_device_id meson_uart_dt_match[] = {
 	{ .compatible = "amlogic,meson8-uart" },
 	{ .compatible = "amlogic,meson8b-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
+	{
+		.compatible = "amlogic,meson-g12a-uart",
+		.data = (void *)&meson_g12a_uart_data,
+	},
 	{
 		.compatible = "amlogic,meson-s4-uart",
-		.data = (void *)&s4_uart_data,
+		.data = (void *)&meson_g12a_uart_data,
 	},
 	{ /* sentinel */ },
 };
-- 
2.39.2

