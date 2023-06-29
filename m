Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BBB74269D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF2MiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjF2Mhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:37:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46626B6;
        Thu, 29 Jun 2023 05:37:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so379992b3a.3;
        Thu, 29 Jun 2023 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688042268; x=1690634268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78HEVmEjmFpvxQbMk1UNKcuReRPdqi1Nqjvw5I13jqc=;
        b=hihUc+KU3FXYTfTqMkEWitlfu7oMsKzgcqBiGh2Gb9mJNs+GdwK9iOratFTLvG829w
         Ecsp4zpGFoRZMRNm7r06G5W+YqljvlTzGe0rf+B8jegq4VVy6uV7lI7+1nihE4WhYCnK
         9gBMuEAiN1dMIwlwROEd/NGayY0beF/HO8NQjN2+i33vbzS3AMflJ+XBdrPx1vVUQhSY
         wtY20uCTHnkE08TGjcmjPWsQDBrX7pxID2uHYQ1KDUmAAiwvVDyxmCxB+bKc6Rpg/KpM
         JynntmYskjZcmSqKwqXqzTmJwy36EVcoLTj/RFlXRwxZR9J9k1c49GBl7DN7sB1fSddo
         rMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042268; x=1690634268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78HEVmEjmFpvxQbMk1UNKcuReRPdqi1Nqjvw5I13jqc=;
        b=Q3udJUApYsexwDIjpAfbCNl7alNS5wrnNbqthoUt03PgSMaCvWwiJGP/nNNxWmaSur
         owRopNk99BErvCoVE7+blz/nf5ULUFf4LKNKybGszsnFWzytuSU3QDiNBDP3RstICWbX
         sdLExCqs38KmtglsID7MO1DsWXDb4ZGPU3ULFnokzCYnhMygkm9FEmnhwh6G6sXNgZpS
         R8tcU5OOE/XK4uDZICqeFsADmajFut7ovcfTTHc93K303EESbP0yawiJAFUvMORx/+tX
         ierZLL7NkD7YZrh/vEr4mQiUOCYvMi8SuOxo18dWp4Cw1q5bgJBpHmlYWHB4B4bFxlJz
         EPLw==
X-Gm-Message-State: AC+VfDx9ptY1k2n9uk7C+H73NN22dqpcJG61CxhOjkf2hnwb/fkyhIiL
        32NcW+trIsmiy/Yl2DELm3I=
X-Google-Smtp-Source: ACHHUZ5Nx6H4eKwbzr8P1xbLa4WUqjY09ozxrUYIzS+x4cZG/YZ5hsXDPx+fu4MW5G/WMImehozpmw==
X-Received: by 2002:a05:6a00:2e29:b0:682:2152:45df with SMTP id fc41-20020a056a002e2900b00682215245dfmr2645207pfb.9.1688042267466;
        Thu, 29 Jun 2023 05:37:47 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78dc7000000b0064fe332209esm8618580pfr.98.2023.06.29.05.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:37:46 -0700 (PDT)
From:   Ruihong Luo <colorsu1922@gmail.com>
X-Google-Original-From: Ruihong Luo <luoruihong@xiaomi.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     colorsu1922@gmail.com, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        luoruihong@xiaomi.com, weipengliang@xiaomi.com,
        wengjinfei@xiaomi.com
Subject: [PATCH v2] serial: 8250: Preserve original value of DLF register
Date:   Thu, 29 Jun 2023 20:35:30 +0800
Message-Id: <20230629123529.62232-1-luoruihong@xiaomi.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZJ1lq8mVU8NbZRcV@smile.fi.intel.com>
References: <ZJ1lq8mVU8NbZRcV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is aimed at preserving the original value of the
DLF(Divisor Latch Fraction Register). When the DLF register is
modified without preservation, it can disrupt the baudrate settings
established by firmware or bootloader , leading to data corruption
and the generation of unreadable or distorted characters.

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
Signed-off-by: Ruihong Luo <luoruihong@xiaomi.com>
---
v2:
- add a tag
 drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 75f32f054ebb..d30957722da8 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
 	struct dw8250_port_data *pd = p->private_data;
 	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, orig;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	orig = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, orig);
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
-- 
2.39.2

