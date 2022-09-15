Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB695BA1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIOUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIOUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:06:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0F4663A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:06:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y17so39548295ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vycmJ4KaZAk7CzlOuVCprBT5/i/n7HJryZHYZXyoNN0=;
        b=adNAW5/TlO/J8iQyzUdXEzXa1JMG9pFDJXH/9iQ2WhCMDJYjaguJVelnsuKv1fuOOX
         kRIBY/+EAaQ65G+ZO2mPbt5KoNjJ6Xv7hOdD2Hal0o+1Aa6oNiRgMYVq4/1n4WRCjoO+
         hnnsaSu4zExf0cko2bHrZsGJRE+HQnHhFcRomprYMQ6GdrA6m/LMeSpOb66MF1uTcHIh
         dGONwK4CmCZZZOnxQPoqANcBFnxCaJNuyTC6AR/kUVpfI6MuxlCOJ8hfQHK1KGYngmC/
         bnZdc1Fri9Wpr0N7JfLHh3kyPTeFYQrdSjvRZJo3c6NvN+3BwzaDtD+HSRaKq2eRx8TI
         merA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vycmJ4KaZAk7CzlOuVCprBT5/i/n7HJryZHYZXyoNN0=;
        b=W8J1tIJIfQV90gCGj7+oUXQR8tJHqMlW2kRtyfDqVN0Qtkqodr/3xL06r0Xpm93I/Z
         kkwcxSAzgyk8SkiQZq26Cy5vRa6M+8CIQ2v6p37jb084nvlCiwKmUP+jRax8z8HuC4wj
         AqqiX/X+vgj2QOfm4B2MJw2CVC43V12a6InjXksRXRmv4Lm66l+kMpM06pa+at/plEaQ
         bwaPtkWlB5iz+w2zkmUap/DVyyBqhv+txNMUX7YASgYOaz3Z/qPPrLeQCeoYxLcsUcF+
         93p63FZk4INqZurMR8VxgbK6px1XpCmkmKg/FkZ//ijzbWRNgf1NURk09bDvcDH6XmSW
         cdhA==
X-Gm-Message-State: ACrzQf1vtT0QtIC9TcvLprhD7QiHCXDOplyzBsOcuGELPmKuq5wjjEHS
        gLg+1tpxttJrhKa/AG9FBug=
X-Google-Smtp-Source: AMsMyM5mQDXzHK6KUdvG+weZB9xH81LSJyAp98vY/CykfCpwBs5YqTDDymHQg6sOlWQiiHN6X8DL0w==
X-Received: by 2002:a17:906:845b:b0:770:86da:9702 with SMTP id e27-20020a170906845b00b0077086da9702mr1086554ejy.244.1663272410566;
        Thu, 15 Sep 2022 13:06:50 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id i20-20020aa7c9d4000000b00448176872f7sm12212147edt.81.2022.09.15.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:06:50 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Tom Rini <trini@konsulko.com>, Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] nvmem: u-boot-env: find Device Tree nodes for NVMEM cells
Date:   Thu, 15 Sep 2022 22:06:29 +0200
Message-Id: <20220915200629.10270-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

DT binding allows specifying NVMEM cells as NVMEM device (provider)
subnodes. Looks for such subnodes when building NVMEM cells.

This allows NVMEM consumers to use U-Boot environment variables.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/u-boot-env.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 9b9abfb8f187..d17a164ae705 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -92,6 +92,7 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 			return -ENOMEM;
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
+		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
 	}
 
 	if (WARN_ON(idx != priv->ncells))
-- 
2.34.1

