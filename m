Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C25BAD58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiIPMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiIPMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E97DB0B04
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l8so10614403wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=faurfbZAdufbwG0Pq7O5pFThfS/Hbeg3b/K0Ts9wUP4=;
        b=Yu6U7+5FEvjJr//foJmjT1es1X7vn8Uqz0Yx1FabUFRM4If9vTWuDpeGpFxEBk7ThK
         MEFLNRMuadX0T636jpZ57y5A7jSenX5nosWO5s/mbRRxAo3XffCzWnbVL/KmxMS+hnvq
         F8k47OnRaBfDP9CZvijlWWASPVSI3oEFVTgFq4EVFEADaG5RhQMGcm8XmZZEBbFf559H
         SwD3fpfagHkgBFPtQWEHBnncJkxznSSnwyLm4X+v9+aTTnrACuVab1dJ057ZkGoWfWFu
         fngf5cTXcd/FncreqMYJSjFC4HrfDcvoAA1J+nasW+LGk4bOZEkvTSVhjeLyjIwvfT/R
         oU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=faurfbZAdufbwG0Pq7O5pFThfS/Hbeg3b/K0Ts9wUP4=;
        b=dP7GS/f8vwfk27UFUJT9MdXzxYDBfOrCMq6mPejiBr2oQMOaHs2oXkgTVYtIeQ1dBB
         P30GqX3MvbrYaDU5olICtupqb1K78dXMS5IrY6YvLTjEM34K2i29sm7Jodr6xmsVaGpq
         oB9EceA8pjhme6foKoPcQYFNMrZodrqns3DQw5mIFZFQocFuytXo2RVnsUQC4hBg1+mw
         V+7J1l4y7C6yQ1vbmM1wDx4CO3+vo1eUT+ZqCcUXpaw0pud/amf/L8JdRwoI94YcWjJd
         QJ7RUzoYWa0Bt2dl4rZGf9vqrBEh5jX5oMb05GeIBD4NlYISldt02uhWEP8PZ5bGKMaF
         FCZg==
X-Gm-Message-State: ACgBeo0psM16+q6jhMpdkn/s16g05YD9BZ40Xr/1Uk8uWTPrh2kLxOJy
        fu/5n45K8kaAtFGMAXIa1FV6Rw==
X-Google-Smtp-Source: AA6agR6iOvhLTJ8EncEWyfPK4O5Pw7I5NIOHHns+DFS7//6mAiYaA5trXVfx4YibURs07qaOuO3nKA==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr9872798wmq.189.1663330881325;
        Fri, 16 Sep 2022 05:21:21 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel test robot <lkp@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/13] nvmem: u-boot-env: fix crc32 casting type
Date:   Fri, 16 Sep 2022 13:21:00 +0100
Message-Id: <20220916122100.170016-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This fixes:
drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment variables")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index d17a164ae705..8e72d1bbd649 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -139,7 +139,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
 	}
-	crc32 = le32_to_cpu(*(uint32_t *)(buf + crc32_offset));
+	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
 	data_len = priv->mtd->size - data_offset;
 
-- 
2.25.1

