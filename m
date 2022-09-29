Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F75EFCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiI2SPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiI2SPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:15:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08B852DFD;
        Thu, 29 Sep 2022 11:15:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x18so1371355qkn.6;
        Thu, 29 Sep 2022 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xJrfHh9m1y1mjLWU8/W5I2WoXknkHmJK5KJTG4spzqE=;
        b=UDIxp+LcQcJFtSSFzEIUAIGNalAcdctXkzZXb2q67hAIoObyOZxgIlJ2lGFFmtTToH
         a1qctPZAz+4bJbqnokw/Dwq/J+s5Q8s6DeFDqdRyAImlE9k8QKd2VfxQRtjw8xSLnisp
         1DJty/m6/9s4Qc9oSxgMz1861bMlaX0vf3AUcqCGC2S/AMSczIzM1G8YCBj2hHiLsfNO
         jRWQg8lZNWiPI38aLIazZnunTR9EI1XXavz98ybUQBN+8dvD1E/zsbRQQQ5nDH2BxPRz
         XHgaiMqwmy00DPyV3kG/2IFcpQK8XQdSTYBm/6vunQcDKb5vUIMkb5/gNa9RH82PADch
         R2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xJrfHh9m1y1mjLWU8/W5I2WoXknkHmJK5KJTG4spzqE=;
        b=GNdkNjbQYCf+YZlAqY1hdCBDazzO77yeX091AJcWh58ccOvYti1OYrmtYBZ2xZQUmO
         J2DfgwMENJ4AIbhtvQaw3llxIILyWu0Stk8L9czmJ2hVLdg1cQILNCwOGQW6Ab1+vsRd
         SpMq+HQAdHivZ8fWtbdl+xLYYcSEk3iWsio6BJDnadb0O3FCQ/oZ/c6IlFblECdW4Jax
         SO5iuWac4cZ7ygUHqOpmDOD74NO5H4k/NyT7ftdVzBPXiWaBcoNEWUpn8VwjVnYcbzEI
         KZpL5l1EfZNdu7KA9nTT2GUZ0zdouDgvGfIZCoIfdNFKZDOknfpEFziycRl8L65u+hLl
         /t5g==
X-Gm-Message-State: ACrzQf2xjbmgcj1qiiVKpvzxvs3mkiWgK/gcQoOMPPrbYdM+K1YbhDxp
        CfpCfAH/YWvR+8WI0+gXPzBJHApKOhY=
X-Google-Smtp-Source: AMsMyM7nKDCrdjQyyHNL3+Z9ZA/IbTGD9c5/dwe/hZ8iHGHVHU7+ZVvQLhULHKlC2duBXJPsq3mSmA==
X-Received: by 2002:a05:620a:d83:b0:6ce:bcfb:c4fa with SMTP id q3-20020a05620a0d8300b006cebcfbc4famr3292803qkl.567.1664475311056;
        Thu, 29 Sep 2022 11:15:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a1a8d00b003431446588fsm6246267qtc.5.2022.09.29.11.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:15:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: Update TI bandgap and Davinci GPIO entries
Date:   Thu, 29 Sep 2022 11:15:05 -0700
Message-Id: <20220929181505.1100260-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The email j-keerthy@ti.com is bouncing.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf67ee939ab1..f1545b5755ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20477,7 +20477,6 @@ F:	drivers/media/platform/ti/am437x/
 
 TI BANDGAP AND THERMAL DRIVER
 M:	Eduardo Valentin <edubezval@gmail.com>
-M:	Keerthy <j-keerthy@ti.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-omap@vger.kernel.org
 S:	Maintained
@@ -20519,7 +20518,6 @@ F:	Documentation/devicetree/bindings/clock/ti/davinci/
 F:	drivers/clk/davinci/
 
 TI DAVINCI SERIES GPIO DRIVER
-M:	Keerthy <j-keerthy@ti.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
-- 
2.25.1

