Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912F5F7ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJGUcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJGUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:32:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FA127BCE;
        Fri,  7 Oct 2022 13:32:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so8808455wrj.11;
        Fri, 07 Oct 2022 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gXEcZPe4bJb80xhYonDvyQ0ipj3DaBfk3EpBJ+supA=;
        b=Cy16cL0XaMy3pgHoRHW6fH5o95pZcbgm8uOsUyfNFq5ZTA0elnT1eVh689hsyUrITw
         vAx5d6Hm3cd6vi2QtkvpSO1QxNd6clQ9r6uv4C90jG1JBEIHgJP+oaxw+932pSgpJpI2
         pZDwVT8fxk8FopDp1ndb8lDew9gyFZbyjY0IxHyHjzqf/LHkJug5LwLfuMdX5wMRY0KO
         77QkzuZj25/krUrcHf3TN0oZ5XgetWOPUlGWsprzcRp1ycoB6X7FWabUhUe9NPo2xtp+
         xFQTsS8U7hcOAiwt3hsfRJeb02M7yCm9Mopdv4/vW/rtKC0THFGVXO5XT/+Q383nH4vp
         50xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gXEcZPe4bJb80xhYonDvyQ0ipj3DaBfk3EpBJ+supA=;
        b=qIem4YDpPsKuqr7TVpwDNVcMrKahJvnIycbLzDZWtVJI6knHVf2/IWtQFC+KDsJIIv
         AYy8tqAxBs5NEh4HX/9xQjmeSt9fILYc2q0e5djXarflI2611i7um3WBXNDC56cLb6NR
         qD5hd3Ayr6uM0iymwzIGDgmBBufNQNcw+yEMwQTlMmrtf6I5aiNzDBV5JGKPNJzD4IdI
         Jf9XkSomdl+ymfUrDiNciAEjoWSDl2GYf/jjrHwHXrPaXa18njWfjDbeatLoTzVIsC9w
         URKQ93yxB/fEqEFoBPhkl46zubIyuhR/O0nabL+fpLWIFPuEgpHU4nghLoXlK/pFCzC1
         ywdg==
X-Gm-Message-State: ACrzQf0cfJ7PrFnADI+S7vH5dQoxj9KviWAxijbSD2SjHqv7aOWZmety
        2zY7Fy7PMrXSPRl+aYPyV9E=
X-Google-Smtp-Source: AMsMyM6SRikRdH9On/AzxVsgtx46zh57g0ejS2XRsXPzn3xpQ9EjFjIZVz9k2N/fF7yDXJ2GgvEYXA==
X-Received: by 2002:a5d:6d08:0:b0:22c:cf20:387d with SMTP id e8-20020a5d6d08000000b0022ccf20387dmr4394903wrq.518.1665174731783;
        Fri, 07 Oct 2022 13:32:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id co11-20020a0560000a0b00b00228d52b935asm2908728wrb.71.2022.10.07.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:32:11 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: host: Kconfig: Fix spelling mistake "firwmare" -> "firmware"
Date:   Fri,  7 Oct 2022 21:32:10 +0100
Message-Id: <20221007203210.2756505-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 247568bc17a2..8e8db71021a5 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -47,7 +47,7 @@ config USB_XHCI_PCI_RENESAS
 	tristate "Support for additional Renesas xHCI controller with firmware"
 	help
 	  Say 'Y' to enable the support for the Renesas xHCI controller with
-	  firmware. Make sure you have the firwmare for the device and
+	  firmware. Make sure you have the firmware for the device and
 	  installed on your system for this device to work.
 	  If unsure, say 'N'.
 
-- 
2.37.3

