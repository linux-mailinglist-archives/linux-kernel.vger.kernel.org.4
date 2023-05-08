Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374BB6F9E85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjEHECS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEHECP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:02:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF54224;
        Sun,  7 May 2023 21:02:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965a68abfd4so761799466b.2;
        Sun, 07 May 2023 21:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683518533; x=1686110533;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRDFA2Oq3a7TFMTFPjEDpCf3c96bA2T/fIIJ3Z+9UNA=;
        b=Kl05KRFvCTs1ljKqfwvJrspDTYYwuJGHUrj/k2AEMXP5zWezRj2mMKeoDLxEbbYhj/
         BXla76hGiGt9Lpa5vpm7n8JT19kABnpbgZjyrvBFTG0IIWdLcZEVdy7vkwj/QuC/MCtf
         vKmHEjjOWbtRW14l3jLavWEddU0f8j+sxo4Ph0wppOvlu4oq6jxi36VmcN2nJnJ0/czc
         9mJ8TTqJkQdQjbcwqWhnlFXtnQVjdMAd2cBmADh/nKHoYD4I1SAU3EUN3aduq32oiOp0
         +f8iOWov9rEqda5MA3dAZrE5AQ/LWoQHWGN3sGC78pTo78XHPXAC3s+HqGChNKt9Nyf7
         LO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518533; x=1686110533;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRDFA2Oq3a7TFMTFPjEDpCf3c96bA2T/fIIJ3Z+9UNA=;
        b=bqQlqWPcES9e1N/ydjGZz7+CWw39qAqrSWI7K6WM/aOA9TMfLGkbiJqMLOsRV1u76J
         reWTlGEytuW0UUUIvi89ptdwfr316qhAZ1SZ8J/4ZmFKRAswIt6b22JBRIk7jUk5d+Yx
         1rJIfNNi1c2wD4ekfPHsHqO/N4U+4Eh/zEI7Tb6fy+l9rOkwqwhK4428qnpx6t8OYueo
         TBp8Cwpm6S9PMygBsKJOxJ5CKog5yvuPXQ537EkCUbTjGDT3IJVH9KtH54voRAHL2EW2
         rjzGM6prGvgYLNSAxIV12cK3HVVQuEU89lv9S9aZsO+hnD7xHkCFd8+Vum2Mss/ZxJyw
         +hQg==
X-Gm-Message-State: AC+VfDxXHTwWK8G9fZbpIrAM3To/J5n+xUv+J0h8tqMIAR12BmOYb3SL
        vNPhGeGxbS09TVq5A6EkoWs=
X-Google-Smtp-Source: ACHHUZ5Vm0lEgqoo2PiIBq8J3bwbjgKEAhZ5fqiRC1wZTDsdtsIHBU1VlBQFNoJtAsw9IkhspAYJEQ==
X-Received: by 2002:a17:906:9b8a:b0:961:272d:bdbe with SMTP id dd10-20020a1709069b8a00b00961272dbdbemr8053329ejc.35.1683518532543;
        Sun, 07 May 2023 21:02:12 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:8906:f99a:ce33:2033])
        by smtp.gmail.com with ESMTPSA id ka7-20020a170907990700b00947ed087a2csm4391606ejc.154.2023.05.07.21.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 21:02:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] iio: dac: build ad5758 driver when AD5758 is selected
Date:   Mon,  8 May 2023 06:02:08 +0200
Message-Id: <20230508040208.12033-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 28d1a7ac2a0d ("iio: dac: Add AD5758 support") adds the config AD5758
and the corresponding driver ad5758.c. In the Makefile, the ad5758 driver
is however included when AD5755 is selected, not when AD5758 is selected.

Probably, this was simply a mistake that happened by copy-and-paste and
forgetting to adjust the actual line. Surprisingly, no one has ever noticed
that this driver is actually only included when AD5755 is selected and that
the config AD5758 has actually no effect on the build.

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/iio/dac/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 6c74fea21736..addd97a78838 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
-obj-$(CONFIG_AD5755) += ad5758.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5766) += ad5766.o
-- 
2.17.1

