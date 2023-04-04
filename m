Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8230F6D6A87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjDDRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjDDRYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:24:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234049C3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so133624578edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAEqSElgDVGM5o/UBJBKZXNuT/CdyDaLnFaIEgRZepU=;
        b=YO8Qhmdl6K5H3uQVYIiiwcRc2OoL429H9mAllTm7ZtmwbDzJcID1fW9BWGyA3S0nKG
         wUrwdDmnS3d+L7lrFoM1mbmvgZFaPpE+Rl7PuTudbg/6q8EoH6RdBpC/oyifzVcrLkAh
         mEJ+oaKbZByt3NC1PyNqJB4GFyfeimYlt0ZAke3NqSlDUq7PpSe0QZMdzRO/k89y8FcE
         LELYkTVCPxbXYKqN8VEKzSDkushNl9qP8sk71ZhG/GXh2NKl8c96TRydK62x9hF7CLCD
         S+mnc0Q0y2ehj1zB9qay2LDGb2SE6UbptVng64zMdWh+H0wZlx9SOGcJWfn2HYAlxhcV
         uHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAEqSElgDVGM5o/UBJBKZXNuT/CdyDaLnFaIEgRZepU=;
        b=ixct9iYId/ww2Pdi16H/DIuVudmOcanz2FlpxWIHckPrL8FQajxvvTxnhsZ9zjWnZO
         Waw8DQKVJUXX7bpPBCLDpzmhRqyGuNIn4x2GRrGr9eVaz0OqjHLYRj2HkD//InvUSIXR
         g6xEV89vuDYX7axlcZKgNItk9jcxaBtBck59d1z5dOPsZsgU7GltocvruBjTdCcVZAzA
         DVtCfG8EWPuzL5dwKosVXmuMVE9JUaNuQuIAzhbRQIXaY99Wt5FB5ti1I6EXoBXZ0V8e
         5fd0yTbrlZKxqX5o97kb1+8IOYjsFhA3JyA1A+vvsFDDuYZMnstYPmGjTuLvZEXi6Rzp
         jlHw==
X-Gm-Message-State: AAQBX9fEZ9cgVDpW4hgMh/2swy1sevHleT6YgPie/jcAvWaSb1nnT/2Y
        Sa/6yJPtMOr7cORFqROho/xe/g==
X-Google-Smtp-Source: AKy350aPqDjGf5zdihJRpUGXsxMjsHfF1Nr2e/mLmeyTzMgQdZuFk66zd1/rtbMZJpTyil+ZnkM8oQ==
X-Received: by 2002:a17:906:2319:b0:932:b790:932c with SMTP id l25-20020a170906231900b00932b790932cmr329683eja.44.1680628992374;
        Tue, 04 Apr 2023 10:23:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 36/40] nvmem: Add macro to register nvmem layout drivers
Date:   Tue,  4 Apr 2023 18:21:44 +0100
Message-Id: <20230404172148.82422-37-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Provide a module_nvmem_layout_driver() macro at the end of the
nvmem-provider.h header to reduce the boilerplate when registering nvmem
layout drivers.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/nvmem-provider.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 8ffb42ba0f62..dae26295e6be 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_NVMEM_PROVIDER_H
 #define _LINUX_NVMEM_PROVIDER_H
 
+#include <linux/device/driver.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
@@ -242,4 +243,9 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 }
 
 #endif /* CONFIG_NVMEM */
+
+#define module_nvmem_layout_driver(__layout_driver)		\
+	module_driver(__layout_driver, nvmem_layout_register,	\
+		      nvmem_layout_unregister)
+
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.25.1

