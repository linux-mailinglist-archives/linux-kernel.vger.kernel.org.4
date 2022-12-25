Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47398655E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLYS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 13:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 13:58:52 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1760C0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 10:58:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so22634135ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 10:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vscXtkeQ3FoIFYrzvZO29LkiCTSGf/5Mz+OPKJqoEDQ=;
        b=dorEiwJIEiY+P7DYag5tioUVpNIh1PyTifvIJj3AYyMiw9jtjVYLBBMPITB8zADWjm
         V3DnrmZe3E7bD6kEnqGwD0ZxtcZk40haunM6h1M+aF7sPWTZ3ma3JcOmProfZZS9sgzE
         B4UVvAq7wMpU7KnKgnBUj4PS8LBh6vv8G/b0pHVQeDeva/z4Da1Guh+Rzkdy7C6GQMcA
         COhK7uFS8HK7ZGNm6XPWWPVW+fXROaJsvkiS44YOtQz7+zzgjFe57kheXGP3cT6y0Gxe
         HHZ9szFjhQNJ4yVrw3q5JW4bRaNFdx/jHkF1vH5PKfbqaiY3AmxZuQ1MjWpDF2A+6DhG
         7NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vscXtkeQ3FoIFYrzvZO29LkiCTSGf/5Mz+OPKJqoEDQ=;
        b=EIsTaPdtckvITr36Ompvlo5y+pa7yAF0bFkR9oha5iTysE/vUf8OadeNrjeM4xuG2+
         XU5aoFtPSSBmNL5S7ImlAyou9Q+NZzHqBvlXaDvmhLjgDL3EM6d7VP1h84pBNokin932
         895t4Y7plnVc4mf+wUwr564P/WNUQzmNlybpCYaxR51Jp5DV5SfaXEBHJMdQlzKtwr1F
         cs7XWtBlyBVJ6zuyPxqC/7Tn7q66tAP/uvHXhMDkfCxA7116pGPATLwdy52ieKBn4jV/
         bAnHiO60RCLLCOr4FssJXe4n4p4UIukPNy+HabxB5PSasVO2Dj1qtla4Lq8GwnEoppw+
         pxjg==
X-Gm-Message-State: AFqh2kpZw8o5u1aa+1QXPMHp/L4e9LPzHb4wyhCd4bQ958zdUjyfupYq
        OQaOowMvzjYhVtGJLCOFDfdZkCrQb2TnSg==
X-Google-Smtp-Source: AMrXdXtyjfidqtNCF/WLdGEPn1N6JotVhSlqrbviamAeGRgH/nUwqtwm8hmxRqpyDurtaBak3PzHdg==
X-Received: by 2002:a17:906:304e:b0:844:852f:6017 with SMTP id d14-20020a170906304e00b00844852f6017mr10894493ejd.53.1671994729558;
        Sun, 25 Dec 2022 10:58:49 -0800 (PST)
Received: from localhost.localdomain ([5.237.218.116])
        by smtp.googlemail.com with ESMTPSA id j17-20020a170906411100b007c0d5b181absm3968468ejk.94.2022.12.25.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 10:58:49 -0800 (PST)
From:   Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
Subject: [PATCH] Add usb serial support for quectel modules
Date:   Sun, 25 Dec 2022 22:26:57 +0330
Message-Id: <20221225185657.3962-1-ali.mirghasemi1376@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for following modules
- EC200U
- EC200A
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index dee79c7d82d5..b741fdf20f96 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -259,7 +259,9 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
+#define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EC200T			0x6026
 #define QUECTEL_PRODUCT_RM500K			0x7001
 
@@ -1180,7 +1182,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
-- 
2.25.1

