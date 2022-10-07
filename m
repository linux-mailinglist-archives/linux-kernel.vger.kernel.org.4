Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAD5F7EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJGU0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJGU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:26:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4C104516;
        Fri,  7 Oct 2022 13:26:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l8so3533225wmi.2;
        Fri, 07 Oct 2022 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4nmogirtyltfQSoXR32GlJP0e7NdBgg7DXc5ypMrBU=;
        b=W7i6uxvUcLnG2Qo8Vi0KxgphxqjWBkkhEkmOX3Gp5zOkdgsx9g/QRKry0oAx5MlhsF
         mNhbnJ4dsYU1lya+qi+RleqbCxP9QCj9155z+Tbq6jnLiR6fuhZyk1b+4lj1klZ+gC0y
         kAQFGLmLr1GSO2RHGWNsB3omcB/jqaF1Pu8WOl1OZ5DDJKGiuhXMJfwuFieDx+aRdVfR
         3cq0E3O8NOmeyJsdDSWYeDiuIbuRiP3kag7wdtjPcS7Sm3kLrmfddfj7366/81U/HROo
         Pt15k/4z6L3u16HZ3fRSFJe/ZIPjlkzhzi3I618mK0tww3lxOgeIFbXPRVo0Ckv+7TZR
         Ftfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4nmogirtyltfQSoXR32GlJP0e7NdBgg7DXc5ypMrBU=;
        b=0WJhQHlKuhryQSUpE/m6+VhZue77bMHymc/9ZpICcXpw4qnr9pjPr8pbp7mwk8cWWw
         npgCb3qt5+9xmAgRBuDbQVTBboqAmOjfG8s8l8CXyPeCa1/JytczoOHHxIjD0hKwYBCH
         OoNW6gpwYm1uN77zlqwNhTfDm5hCn2eGN+tfamvG4Ndj9hXonxTv5pPAUT0+6O9kaGM+
         hQaJvv4uVBUs1UmM7sUuY9vmx6YjLbYmxoo98DPLha7vZTyYgL0Etxq2YVUs3KMzOtEl
         KFFm/dVX2ggccr9HxZNxv3TYwyZVKHLVEQT8WJ3mnRM9IRYvz2vZXEHDe3xz60j08z2V
         oaFA==
X-Gm-Message-State: ACrzQf238myo5XTxRWzrMVMrI/rRdEUNQbkTMHDVCSdaMWP7oTQdQSLG
        wR6DHdHuURLbQwHTPGy7p+s=
X-Google-Smtp-Source: AMsMyM6lyZn4iK7TKa0hvIyQlDAoGLbdoQJJiMswOkFgPVvPL2pNNICf+GwgOZJgrDkBfbVtkZQvUA==
X-Received: by 2002:a05:600c:510b:b0:3b5:4a6:9a32 with SMTP id o11-20020a05600c510b00b003b504a69a32mr4377418wms.81.1665174397788;
        Fri, 07 Oct 2022 13:26:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k10-20020adff5ca000000b0022ed6ff3a96sm2000349wrp.39.2022.10.07.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:26:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: Kconfig: Fix spelling mistake "controlls" -> "controls"
Date:   Fri,  7 Oct 2022 21:26:36 +0100
Message-Id: <20221007202636.2755985-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ec8a49c04003..755f551426b5 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -164,7 +164,7 @@ config NVMEM_MICROCHIP_OTPC
 	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  This driver enable the OTP controller available on Microchip SAMA7G5
-	  SoCs. It controlls the access to the OTP memory connected to it.
+	  SoCs. It controls the access to the OTP memory connected to it.
 
 config NVMEM_MTK_EFUSE
 	tristate "Mediatek SoCs EFUSE support"
-- 
2.37.3

