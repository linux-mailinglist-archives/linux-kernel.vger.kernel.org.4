Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979A7085CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjERQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:18:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B2130;
        Thu, 18 May 2023 09:18:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965ac4dd11bso431478966b.2;
        Thu, 18 May 2023 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684426679; x=1687018679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XW1YARE7E8K+MhlpqrqLzPXi7UUbr9A30X0rShV3GA=;
        b=LSbx/kUGhv7jlzMGDp6/+uLQKWlrnlIxuB5wnTCX4yO8RFnUKUMzpmCvZ/6l6Y2aMU
         tHyv+f+aLoZuy5CYp5s8BGbJFEzZInmGwWaxXshvXSoFCM36gHMUSj2NyaU738LvzfYL
         AOsAr7oeSpraAfZO7zFhgghN50flUsLJp5Qcn/tv/rw681S2negkLW1xQIag6St2EfoR
         yb0fk3uTWkmTn0WprFtWUIneV9fsFdGhb14YJrkCkl5nFdTYvTgiwJGuBRleN4K9R+Mj
         sJUTcO3yBAxzpu6tv3wp6860RejArJZIaxjlF4a8jT9GdHNk3dGEp9yUGc1xXV8IFoTI
         miaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426679; x=1687018679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XW1YARE7E8K+MhlpqrqLzPXi7UUbr9A30X0rShV3GA=;
        b=blz4HiObGvXOzzknGs4oQx2NQamhJRSMtVzVJFzoWyXQypxxgm4KjUAWTy2dpK5wkG
         ThRI//lIksx7zmyvKIpBBDOAzAGyqOIGL8ZOHEWA90o9ddGaQC5OyagIauC+Q0kyYhN2
         Fr56xgSDtig7dIQVmBTNz+fEBfYbNDl+BBiCLWzaQuLd0tfU4TkCstaOEbSowiD0XTHB
         al6xX8ms5ptE9mKGCEPa9HZNk6Ti2Su9fLhKBAkGypAKWH8uVGhJFPpp61t9CCl2i7dq
         ao+7OzSvlWaO6uJFP8hi4Q1bAIGEw5mgzUOHegqQTG9BRgUEdRcALx3pdAESXS0KlNje
         m7Aw==
X-Gm-Message-State: AC+VfDygrP8k9Fu+dqo/9XK59QykdNjf1YbS4V53E5zNNTNtivhDjhR3
        fim4GyXkkTCq4I0+a3GuOZB69svLz6U=
X-Google-Smtp-Source: ACHHUZ5ySQcXTbv70UijR3P/lbLGTK0uiUtd2zWmkV9xU/1iU5IHKgar/xj/CR/FSazv4tLd48YRCA==
X-Received: by 2002:a50:ee11:0:b0:50b:febd:3cde with SMTP id g17-20020a50ee11000000b0050bfebd3cdemr5264776eds.42.1684426679492;
        Thu, 18 May 2023 09:17:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73e5-9e00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:73e5:9e00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020aa7c74e000000b0050bc13e5aa9sm756307eds.63.2023.05.18.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:17:59 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v1 3/4] mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
Date:   Thu, 18 May 2023 18:17:48 +0200
Message-Id: <20230518161749.1311949-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTL8723DS comes in two variant and each of them has their own SDIO ID:
- 0xd723 can connect two antennas. The WiFi part is still 1x1 so the
  second antenna can be dedicated to Bluetooth
- 0xd724 can only connect one antenna so it's shared between WiFi and
  Bluetooth

Add a new entry for the single antenna RTL8723DS (0xd724) which can be
found on the MangoPi MQ-Quad. Also rename the existing RTL8723DS entry
(0xd723) so it's name reflects that it's the variant with support for
two antennas.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/linux/mmc/sdio_ids.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index c653accdc7fd..7fada7a714fe 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -121,7 +121,8 @@
 #define SDIO_DEVICE_ID_REALTEK_RTW8822BS	0xb822
 #define SDIO_DEVICE_ID_REALTEK_RTW8821CS	0xc821
 #define SDIO_DEVICE_ID_REALTEK_RTW8822CS	0xc822
-#define SDIO_DEVICE_ID_REALTEK_RTW8723DS	0xd723
+#define SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT	0xd723
+#define SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT	0xd724
 #define SDIO_DEVICE_ID_REALTEK_RTW8821DS	0xd821
 
 #define SDIO_VENDOR_ID_SIANO			0x039a
-- 
2.40.1

