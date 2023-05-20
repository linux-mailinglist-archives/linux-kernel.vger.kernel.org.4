Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8070AAAA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjETTJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjETTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 15:09:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2BFD;
        Sat, 20 May 2023 12:09:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510f3db1cd8so4176870a12.1;
        Sat, 20 May 2023 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684609763; x=1687201763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Liz5Dg4FexydxAHAog0MQJzFgR4/1Nt82myf27DAU2g=;
        b=R0CfSQu+hMLrhno/D5JAHpmhdZi05gFJbZSlR3tuNEydH5yJx+OKYM/CKoiJ+n7VZN
         7RS7tOqVM35ccT7fOAYCTmJyW3wY3h1lV8Ph/KIZpRfIwx8fnXtSq9HTfpcJCXdI4srg
         lpFCoTSks5KQnVydSwzDsMEk3hv4Xqz3NBOkRmcpiPUQHnN5NmFyinDZFo1tAt4vaDmH
         n/SGNffJlJAwisPiQfznL1wMQo36Le+E6q6/4VLZVThnroLErFPRhAzc70RZIvAI6v6K
         M222L2yOUeT43XApFvqfsnCxLGsvZ3QhG8h+zbOSEFfL/SKIfFMtwZy8cVRdc7WhLyb/
         tOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684609763; x=1687201763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Liz5Dg4FexydxAHAog0MQJzFgR4/1Nt82myf27DAU2g=;
        b=OvXOEuYDEY8+EnP7j9dqALhLoltNStJSScSALYis/3xQmtBsay/vB1m//uE18Pyzym
         k9raygnb28paokWH+XEjndxj/m/w0r2QBcAjw1iqc/7tmZ0XID6DyqDUS81WsEzY6djb
         6FeQeg6wzZlJlHFvZAYmxyfO7YPxzQJD9aIUT/Z6hVcQOXLmREDR11PAzAQ2wmV7FfH0
         2DxRIMrlAVJ9lwo/ubOFFlRBPLK5LJjWg/AN/H0fa+Q+XKAPlI0DLQsIrYUfkqb4HyC9
         jbBVJboA8WMz4XhV3+PYULnaUPG9uPYhVPjDp0KAJM7XrrrtUBeCoFv5leYNo/AEQaRF
         UiWw==
X-Gm-Message-State: AC+VfDzTqvhKmFO/V9qaFOXoAca5DF/ytZigTJuLFnpM4Bd0DqX+e4+7
        kDnFhzUUZcV+vHkWJnsa0ak=
X-Google-Smtp-Source: ACHHUZ4Q4Gg9nU2iYf22SEZ5qd35Lxxxnhppfn4OdwDLMfZQ3G0ZYwaJxtB8V5caPx/MmbGoiEcxSw==
X-Received: by 2002:aa7:cb51:0:b0:50d:1e11:eb9 with SMTP id w17-20020aa7cb51000000b0050d1e110eb9mr4953165edt.1.1684609763205;
        Sat, 20 May 2023 12:09:23 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900cb504b662390cd6b.dip0.t-ipconnect.de. [2003:c7:8700:c900:cb50:4b66:2390:cd6b])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050daa883545sm1065889edb.64.2023.05.20.12.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 12:09:22 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] spi: spidev: add two new spi mode bits
Date:   Sat, 20 May 2023 21:08:54 +0200
Message-Id: <20230520190856.34720-4-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520190856.34720-1-boerge.struempfel@gmail.com>
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to set SPI_MOSI_IDLE_LOW and the SPI_3WIRE_HIZ mode bit
using the SPI_IOC_WR_MODE32 ioctl.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c850839..c8b938e0f342 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -64,7 +64,8 @@ static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
 				| SPI_RX_QUAD | SPI_RX_OCTAL \
-				| SPI_RX_CPHA_FLIP)
+				| SPI_RX_CPHA_FLIP | SPI_3WIRE_HIZ \
+				| SPI_MOSI_IDLE_LOW)
 
 struct spidev_data {
 	dev_t			devt;
-- 
2.25.1

