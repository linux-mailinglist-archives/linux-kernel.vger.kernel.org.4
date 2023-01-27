Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67567E2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjA0LSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjA0LSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FADE16336
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so4200193wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmitWArQk6CIBydogs7WRFxwX5Xsu7yBBRQ1KBB+uN0=;
        b=zPdHoXpThmIqr0jmxocruEX6GLSarmPoJe9nlPSN3ubS+hCFBWZ3CtOzaEhXMB9IEC
         /BD89Pv2SJUIV6hi420tZtxNMHXYRKZnSDN+HQOaW8OPSmA8od9mo77d5DldsDSnqfy1
         AueWeJxgmHmNiOQ4jObzMtMZGz1Fr+Cq/MmFtd4D3QT72iofiAgqJbH6alBeorr3Bxxb
         Xc2lKu8HhTgP7rnnfkQQTLTF8QBJRIEN3IAKjSB4yukvXUuEuwOgJNxrWx8WCY+AJoji
         ZBNJGV/Ta92KflOb/2Z4gcQvtYDBws4iFWywAkKLhiMpzxteCyc3RV7Fnxk4Hn3WAEEo
         h0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmitWArQk6CIBydogs7WRFxwX5Xsu7yBBRQ1KBB+uN0=;
        b=zxbYk+Tdzflhj4L+RstpDljYdLlaCVxVat8IpsRngIJc1KHAhRRhWRrMDHkh9NlSIz
         fAk7JR7RE0DcEgodNUkEAyBCBIhXHn1h23+cfJYjBkk9L/FFp1CxYrAgy06w0NrDQ64N
         39zHT4HNQvHCz2Tey3yUvpxxjma/v6h0P1d+/U3C3FrYuJfUuXBAAJ13aX9JP4N6Ofqf
         9VFshWu6dhR1hOV/oVU0pHO6H5PFuD7mZAtwSnpm3/AeZqzbnjoykOh2s2iqURRc1DUY
         dWVNsGtbk8RSaWkQ7rKHJ+eHagS93GMKjrO7znfb0Vhpyf7MtjGNmVdQNzQ3pVlTpvv3
         2vkA==
X-Gm-Message-State: AFqh2kqBZa1274yIcWk76faDhvi4t4bLUO3YuLIaubyTA07GNPv6Z1HZ
        1nsiIEpFycZXQyWvWODo+ng36g==
X-Google-Smtp-Source: AMrXdXsO735n9vZYojALaO3iXZOQYdlxx5zg8IQ7Awz1iWHT4rgorJGim5zJ4teBbon8zh9mSjqszA==
X-Received: by 2002:a5d:4cc6:0:b0:269:65c0:79fd with SMTP id c6-20020a5d4cc6000000b0026965c079fdmr30949094wrt.53.1674818270152;
        Fri, 27 Jan 2023 03:17:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/37] nvmem: core: remove spurious white space
Date:   Fri, 27 Jan 2023 11:15:35 +0000
Message-Id: <20230127111605.25958-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Remove a spurious white space in for the ida_alloc() call.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 34ee9d36ee7b..233c6c275031 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -764,7 +764,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
 
-	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
+	rval = ida_alloc(&nvmem_ida, GFP_KERNEL);
 	if (rval < 0) {
 		kfree(nvmem);
 		return ERR_PTR(rval);
-- 
2.25.1

