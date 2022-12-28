Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE16575F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiL1Ljq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiL1Ljk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:39:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD0D2C1;
        Wed, 28 Dec 2022 03:39:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so37753531ejc.12;
        Wed, 28 Dec 2022 03:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvi6sBw7ki9dgaGuzIYTU1IrH3J6sZPrceOSxNB0Qmo=;
        b=Dz82XmNtSPfQfl+OCy/aFOccsyEQsmM8cLvX4v8mTSr/nzR5oI/fka+BPGhSbe/g7P
         gI8eO2wqNUReGsIxvrReKVcxNE6lVBTdj23rPFFTKeteFVq6hfm3EwflJDex2BF0Srda
         DMZ1bsXYeupGOF1Jo8L92ORunMPoc/SDvVVPD3taurAAKTScK2N/g40bHUZpeW0ePe+P
         J1Eu7kxc79SDNVl4EZYDnjfMfUGzv3IzsqFDMmw6/J9SUfbgDoy8W0Ean6RDQy4pskIs
         c6IlCeALUQV1mWZGW9welTQgm2FTK9Y/BuE95soif6lFp65WUUOhkqXNg419oKMynrAb
         qhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uvi6sBw7ki9dgaGuzIYTU1IrH3J6sZPrceOSxNB0Qmo=;
        b=cYI3qUPZLkNK/abBrSdY96Nddg8Spbrp/h72lfvP2YI9EI3tJZZJLh79PaGW1UygMN
         i28qWcboaN7W8FUzKKKY9rlazbweEqpbzQDvD2oA4Jwm/15Y7pcbqDn8w9ogYG1cbRDQ
         77haaIG8ZNMOjEqo28V/Zh5ikjaRVe0Qc/qam7xPJ1iLfEjus5MDbFiPOBSMTCkd2Pj3
         tKxwJT1DHJeEVfyVr75qJYMWPXM0Li7DLK82ADE9jemHKBRS+tmQcRWhSQPqjqZ95cch
         Wfr2vGB998ihQVNcbN6OoP7utt/mGjA7AK0FWszG9rT37mY5IHolK3W9Lx6dCHrrfT3m
         fSwg==
X-Gm-Message-State: AFqh2kqEJPTomUu3u2hNKKOZmiAJqU7TN9+NvKd4pt2vI/OdXHqN6Ru3
        K0OtcZlEqvzxGLV8F+NVTEGT74aBZqNNfCTx
X-Google-Smtp-Source: AMrXdXvyrrIn6nDMkr9ANMaPMX7uTZVDeUKFJB/akTfWo1mFqRtRdkrUdfjLyaUxATl9e4563qun8A==
X-Received: by 2002:a17:907:c24e:b0:7c0:1db5:ea10 with SMTP id tj14-20020a170907c24e00b007c01db5ea10mr29065914ejc.53.1672227577221;
        Wed, 28 Dec 2022 03:39:37 -0800 (PST)
Received: from localhost.localdomain ([5.237.247.245])
        by smtp.googlemail.com with ESMTPSA id jj20-20020a170907985400b007c0b6e1c7fdsm7271884ejc.104.2022.12.28.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 03:39:36 -0800 (PST)
From:   Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
Subject: [PATCH] USB: serial: option: add Quectel EC200U modem
Date:   Wed, 28 Dec 2022 15:08:47 +0330
Message-Id: <20221228113847.8550-1-ali.mirghasemi1376@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Add support for EC200U modem

0x0901: EC200U - AT + AP + CP + NMEA + DIAG + MOS

usb-device output:
T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#= 4 Spd=480 MxCh= 0
D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
P: Vendor=2c7c ProdID=0901 Rev= 3.18
S: Manufacturer=Android
S: Product=Android
C:* #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=400mA
A: FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=32ms
I: If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=83(I) Atr=03(Int.) MxPS= 512 Ivl=4096ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=89(I) Atr=03(Int.) MxPS= 512 Ivl=4096ms
I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index dee79c7d82d5..2918064dddaf 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -259,6 +259,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
+#define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200T			0x6026
 #define QUECTEL_PRODUCT_RM500K			0x7001
@@ -1180,6 +1181,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
-- 
2.25.1

