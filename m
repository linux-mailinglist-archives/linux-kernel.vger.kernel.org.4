Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02FE71524D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2Xba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE2Xb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:31:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2929B5;
        Mon, 29 May 2023 16:31:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2339344f8f.0;
        Mon, 29 May 2023 16:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685403085; x=1687995085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhXd8WYj09bJqozQgW47HStOyHVGilhNU/FfmqsGxfw=;
        b=sREpjYg6FDtQJgEjKRwDBbaE+/mzq+91LBSIB7FgUObatuVNi4WtWToU9R68wQL5im
         JLXKKuT6HW/sOZ/I6kHZPxzbHBCHS5dMJhTrDR+lcR1TfZMHMAl+S1MdxKQZz37/WK5p
         VVZqpd+RN5suUem9t6j75hQfgfGOquqBN7MLWdmLNS9XUnrTGpYUgJAZ+clo8Pfe033n
         XbV88/aAred+Iweu4Mfz6YDg3/jcHJ0i3FI4WFRB01Q5cYm/Pkn+0nl1JkUTL95DRyrp
         QF/wdIZaOMaJbpTB3f5OrUg0PlrmsLx2rBwnC1U4Q8/aPAxY338w9ysUi7ZU7/UIUVaJ
         FQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685403085; x=1687995085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhXd8WYj09bJqozQgW47HStOyHVGilhNU/FfmqsGxfw=;
        b=anoU5iDNzKSbWB64rko4NcdWQA4QLb22FFphUVuKHwmnjIrUV/xjCUIhMxhS7z71+h
         tjsief3x1JYIAH7eyj3gdroP6qovWYMI6VkKCma4jGlJBTitgcx/uSPTusKkUEDvhyFB
         4WayriAPOU6WC+3r/PSI61L/N7kE6suewscc7TOaK9AQF3dLTX1FM21R/Ig6snx9JZXv
         Dme4omb0h4UaBAhVzpXemcAMluv+IIgoZPjX7oTMaSH8JHdvcZoPRkK9fnqbupjO3HiK
         NUhuWh3zrv4Qbb9rOgy8tH50ngV62XLYYdmu9TchRqefWDPBidErqpAs9slZAe3n+Lai
         K7xg==
X-Gm-Message-State: AC+VfDw5OHUU+fYJliNr3yT33Y/tEmsC2vFx0iPHVZ8cbOuC40U2H4gZ
        Cq4zpftHaFDfk2aHb8RzkfU=
X-Google-Smtp-Source: ACHHUZ5AYIY2TZ0ZjgWzFS30rpGakYa5RNB3Q2JORjNSKlfZ7liiY6coKeC814z3HSFCKbn76gKpXg==
X-Received: by 2002:a5d:5290:0:b0:306:2b31:5935 with SMTP id c16-20020a5d5290000000b003062b315935mr73737wrv.55.1685403084955;
        Mon, 29 May 2023 16:31:24 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003f080b2f9f4sm19066851wmi.27.2023.05.29.16.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 16:31:24 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To:     jikos@kernel.org
Cc:     stuarthayhurst <stuart.a.hayhurst@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
Date:   Tue, 30 May 2023 00:30:27 +0100
Message-ID: <20230529233025.22932-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
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

From: stuarthayhurst <stuart.a.hayhurst@gmail.com>

Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard

---
 drivers/hid/hid-logitech-hidpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b2cd7527de19..28761272afe5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4403,6 +4403,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
+	{ /* Logitech G915 TKL Keyboard over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
@@ -4418,6 +4420,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+	{ /* Logitech G915 TKL keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
 	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
-- 
2.40.1.521.gf1e218fcd8

