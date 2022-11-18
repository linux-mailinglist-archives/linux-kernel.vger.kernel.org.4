Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A662EDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbiKRGky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiKRGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD419BA2F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so7736770wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MA9ZD3iFElXlGRPd3wWm0rRUc2HV800z0qztQD/gIM=;
        b=kjkGIWF8TgRBYW0eH7/edn8/Qq1pa7+hiNPCoIlbyq36xNpm4gDS3qz0sKs7gFu91b
         ZYGrEFSLfOUwHefWOU68DjUZ8pK2Ca+JOlr5t7DF3rsiOd4U79BHgC6ldn0OX5HN14BR
         x/nBFYYFCaPt/kC8ZMl89E8lW2ah+Rk1PKxJ2b3fOQEdxAuBYV3jMQhxHHnqoSVnlvuV
         dWJR3+DwgCZQ7hlqsm3GqifaMMYGJ2AloKd+VBdJMyfB8169uc/g3Ki7nYxZom89LnBv
         bw6FdWM+jRLJfk4GawkUNWbF/clP8xkkvRrAAa7cw2o59wzfPUxmt135b9KzhYAgA7Zn
         KfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MA9ZD3iFElXlGRPd3wWm0rRUc2HV800z0qztQD/gIM=;
        b=uYjxj+fg/pXdhob1AQ3XuzxqdIXoSjI0yyH9zvrP6+w88E1mGMf8VPhGTGvR0yf+Bj
         9X5cNdv51g6iPui6rtHpyfk8Dfb79FIl7vPlMava7hNEBVQN7/PHvoomFPKrx9afPDAx
         Qz/Pax/QcbB3yjUDRHJFD9i4WhifDSvvjg5XCBG9G3yzx5MPcmT7Nfto33PX4In08sRF
         QjQt6XeJ5kIuL31KC2TdM2OWXFEK3p+AIwMJd5zkcb4vavpQKKz1wuu9ViC0dNRccnZw
         YKqz+yTuuUxVcBTOInqimfW0usr1aAGzp6Lgjk3nW3sdgv6S5PcjBZ3hnhBy8hadIuTn
         /xHQ==
X-Gm-Message-State: ANoB5pnhwhP8/Rd6nx24NBCXhD38E4SXLcwqdflnsrwHNSL0gO//AOWT
        roqoQmm8W19yqzytDu8+ghyXZA==
X-Google-Smtp-Source: AA0mqf7PUNj8vgqvIhFsK5GWR0fewzJMwkpyZY7AEb4wOZtstPUDg0o/a+Lx8XeESVPVE3vpKNJ+sw==
X-Received: by 2002:adf:facd:0:b0:231:482f:ed6b with SMTP id a13-20020adffacd000000b00231482fed6bmr3397564wrs.253.1668753601062;
        Thu, 17 Nov 2022 22:40:01 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/13] nvmem: Kconfig: Fix spelling mistake "controlls" -> "controls"
Date:   Fri, 18 Nov 2022 06:39:26 +0000
Message-Id: <20221118063932.6418-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

