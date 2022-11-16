Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA61A62C158
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiKPOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiKPOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69417A9E;
        Wed, 16 Nov 2022 06:49:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x21so11768785qkj.0;
        Wed, 16 Nov 2022 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYR5NsE6sy8TKuNQHq0fl0E+u87DDSloXcW16PVAy78=;
        b=KFZjEdCF9CSmeIEcZe3xg8TnfR8mwCMghzzJIOyPI0pb9AnQvsZniKUNSpSIZttKP+
         YnsXySbsYtu/5Px/nZd/AdT02IaXnxWsL2xKNNHHGIjfUokwJ0n3+GyOcx5nQGzI8Pdj
         JN+cmxfnWngMD7qpqEPwENiAjBTof6/I0f3Zv/1XEqrqaD9RzpwE0BJlSecyAfk+2Jau
         IQAhj9qwGVOqT1QKEcNFzyoPmKToL9cdmQdYAI1lIFqTPndC46tRXtJKkOzSXiFt8qJZ
         K6Dzu3PvBrZOPxGBvgS1jUKi3Tg5u93ygIYJS2CQDwhIjQrKoBU8ZZwshtTEnjgtUiuR
         1i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYR5NsE6sy8TKuNQHq0fl0E+u87DDSloXcW16PVAy78=;
        b=5AIB3e3cg3oVXzr1eN77t9fQJ2vwuZIApg0wzDp4BkJo6Befq3Aeeu7qg876YhglRS
         s+4DdcZ6Dqo4qsJi4Qj/tFRJJ76QWiGYVyc+C2nuOzraV01AG8Bt5siYjMN69GVGsjJF
         xgaJ6MaFgRNiCCDWC30MD2UBj12UvVYK0Ttz9v0k2usqEVvwtNn/nzHnl5YHdAv46dfs
         0Yu5JMBAcDVdyQ1EX2kXDe8mnMzc+Biq6IiP2vQFalKOxKbqrJ926c/kmghZtFAqtX91
         j51wF8qSANOGaGvqm+lClsLb+VQwI7BKU8+Las0W7Izj4xMWXj9xE5/759kVjTjTIWav
         XTOQ==
X-Gm-Message-State: ANoB5pmLrx/1VmVWmtbsQHoltX8iV06bBqxUkgrA7nfFv3hcYQqgI2lc
        OfgoNT9eI8FrucCbQm+tRo/9rl+ihy86pQ==
X-Google-Smtp-Source: AA0mqf7VoTWqFbtlbXGZ1EJhSl8ENgZHEzzdBA5/F0rXVUC9T8Lrn1X3UGTdeobro+GX4K772zp5SA==
X-Received: by 2002:a05:620a:2044:b0:6fa:89:6642 with SMTP id d4-20020a05620a204400b006fa00896642mr19607031qka.284.1668610160080;
        Wed, 16 Nov 2022 06:49:20 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:19 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 04/14] serial: liteuart: don't set unused port fields
Date:   Wed, 16 Nov 2022 09:48:58 -0500
Message-Id: <20221116144908.234154-5-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

Remove regshift and iobase port fields, since they are unused
by the driver.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 989a4f8d5bd4..c6eb7eba5af8 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -263,9 +263,7 @@ static int liteuart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->ops = &liteuart_ops;
-	port->regshift = 2;
 	port->fifosize = 16;
-	port->iobase = 1;
 	port->type = PORT_UNKNOWN;
 	port->line = dev_id;
 	spin_lock_init(&port->lock);
-- 
2.38.1

