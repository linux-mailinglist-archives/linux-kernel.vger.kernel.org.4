Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D936AF8A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCGW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCGW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:27:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD6B048A;
        Tue,  7 Mar 2023 14:27:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i34so58478618eda.7;
        Tue, 07 Mar 2023 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678228023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anzenqyGPX1zATM+Ik1tqHmVrqFOd5DGjw4tZBK7I3Y=;
        b=d+sTYq7beUAgj7yD5T+s85jXIjQfykj90WamxBtALfwdLz3hm1skI9C5joR2KVP+qw
         Z8PjrFdH1wPSMyXlVEqAyNb9eHHcI4KuVE4YTFqpSe8ZAhE3lPwawp2Qly14SLhbC4i5
         M6gwlXoSJ1JwcNIArAmazkhWuQd433rC6lRHeuB5Ua1Py5PK6HtMHZb42mixLaX6LWAo
         ir16XK+Q7Ei+JqrkjjEufOkGtNTemfVr3tFz6R8w3VaMUZsmwcYZ3VB5uF9oyIupACmJ
         BqWFXAmWMADPuxdugsNkDmvPHqPlWAMyeFm4Lwhrn0uvfXijtJs+8iqHzO5qq8yNkjIr
         7w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anzenqyGPX1zATM+Ik1tqHmVrqFOd5DGjw4tZBK7I3Y=;
        b=2aSnmTpRBZI2WcxjC0thnsZs5qgDxYCsE32VODq+jRtaYSPEXcvHxqgQLK+dO4X4x5
         4GkqE/V2QtdmODQkOHglmxMxb1zwXCaSdOTh4JFnaobNj3kFEUBsrTq35HBagg+iY8j4
         CdDGISuxxRfLdX1jmXXVCMNE/KrgqtvhKFTKwkIry6k+9KKJHhd7ELMwipf+45DfQCaM
         QX26qhOhZlcvUsqETbpV4cm7qKoNLNsgE9VfWWuelZQhmcAxVqWpXQf/8i1w/bbYOa7V
         M36uQBfLaR5tRzHsyM+L5I2TfzB29SRNgC9OHqexnFjtrPK7I3hMj45gMQD0U9Awhjur
         ZdzA==
X-Gm-Message-State: AO0yUKWVxdvuqaTQjEcLmlA1krSwH0A8lGEOvGiXrB/AN33NjnMwmRzM
        DY1ZY/2kNyZDu3wphc2mzSU=
X-Google-Smtp-Source: AK7set/2RZshpDSi+mZ4EnPSvbJMg/kI5SVgIRcnSFkSj5kO9oVK2qdmERpTEUwnug05sCriwqNPVQ==
X-Received: by 2002:a17:907:7b0a:b0:88c:6345:d0e7 with SMTP id mn10-20020a1709077b0a00b0088c6345d0e7mr17148160ejc.36.1678228023429;
        Tue, 07 Mar 2023 14:27:03 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c485-ef00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c485:ef00::e63])
        by smtp.googlemail.com with ESMTPSA id t19-20020a170906065300b008be996c1630sm6669412ejb.39.2023.03.07.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:27:03 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] tty: serial: meson: Add a new compatible string for the G12A SoC
Date:   Tue,  7 Mar 2023 23:26:50 +0100
Message-Id: <20230307222651.2106615-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
References: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

Changes from v2 -> v3:
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

