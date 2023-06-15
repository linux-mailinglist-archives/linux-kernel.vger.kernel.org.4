Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2C731B96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjFOOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345101AbjFOOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:41:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7932952;
        Thu, 15 Jun 2023 07:40:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8d5262dc8so7039385e9.0;
        Thu, 15 Jun 2023 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840055; x=1689432055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Usc6x/BqXUwuzZHQ2o4g2n/2VrbmycWMBR5m/TRW5nE=;
        b=V7nisqTclY6JQNhLF0D6wWbOY4hdbKdpYasOoeefJ+2Ve5775k+I6S6TZQIbYtmjdC
         m1KiVz4IfuBQ53VkJiYo1NDJoEY9oOcLxMghcwvU89ucFxk57AhJy9+Q8EfjFKBPFl1P
         xJA5aL/wM6ah+KZ/RLTyhuF/5NP6I3NYXSEiquH4oNFAuv6lgto202fe9oVdm1VI8PXU
         r718meptj3IfkJk07IJvfJ2nRS1QlNmECMsRCr513PI4p7q0wt5oggslRjAlUuJDuy0O
         LcAcwBb5On/cRotKINO1i2pQuqqN17z8N3fjLCRJJRzEmKAqaYDIh3yb54G610yDGs9+
         AJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840055; x=1689432055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usc6x/BqXUwuzZHQ2o4g2n/2VrbmycWMBR5m/TRW5nE=;
        b=ec4zAYCbkOeo1ivVvlxGn2gOLsDXS2i+zsFB65id6WnckCzwPUYw8Dedztle97YqJG
         xLrrABYV6Zrn7zsL+s235x0yM+1Je6QgevFKeP32nY4JqngjCgwp83GxTJWQD7hPBADw
         /VtJGX4nnBwhboGAY+0zGjUk9VSjWhHnirXwZXHeMFHBs27Gy1ictYpyyD0ALM0MOM+p
         w7RXPjZHvCeQXz3/+sFZimBj+ORDg/snPWubqU6+pSym+v957Fs1ic+JMkdDrwvPBAdi
         CThMaA9yEFg7aqiweBX7b0CKEuzn8oOn+14l41qjjI50YWtxEHBxk+34mnCLfuCv6EIs
         UGOw==
X-Gm-Message-State: AC+VfDxxw4w6AwKtehpCJPHoYtg+m39IcYsKjg/K/3XJVIkP3ow35yXO
        lxzdihl6EUiUF8Q6P8j6B9I=
X-Google-Smtp-Source: ACHHUZ66E+Hx47+uO19xLpQ6m4shXXkkbZs1ZEIZ+3orsfrg2y2nhbnULL/HeCrMbqRpdDaT7xweow==
X-Received: by 2002:a05:600c:4e87:b0:3f7:ec1d:21b3 with SMTP id f7-20020a05600c4e8700b003f7ec1d21b3mr4620285wmq.5.1686840054425;
        Thu, 15 Jun 2023 07:40:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003f7eeec829asm20709865wmi.10.2023.06.15.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:40:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: cdns2: Fix spelling mistake in a trace message "Wakupe" -> "Wakeup"
Date:   Thu, 15 Jun 2023 15:40:52 +0100
Message-Id: <20230615144052.2254528-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a trace message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-debug.h b/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
index fd22ae949008..be9ae0d28a40 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
@@ -36,7 +36,7 @@ static inline const char *cdns2_decode_usb_irq(char *str, size_t size,
 	ret += snprintf(str + ret, size - ret, ", EXT: 0x%02x - ", ext_irq);
 
 	if (ext_irq & EXTIRQ_WAKEUP)
-		ret += snprintf(str + ret, size - ret, "Wakupe ");
+		ret += snprintf(str + ret, size - ret, "Wakeup ");
 	if (ext_irq & EXTIRQ_VBUSFAULT_FALL)
 		ret += snprintf(str + ret, size - ret, "VBUS_FALL ");
 	if (ext_irq & EXTIRQ_VBUSFAULT_RISE)
-- 
2.39.2

