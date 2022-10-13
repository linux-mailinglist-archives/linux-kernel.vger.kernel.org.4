Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC325FE483
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiJMVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJMVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:50:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99188E78A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 3so3142930pfw.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=cc8ts6e6IPQ2UBJfZ8eMXHkwlB0Au8KQnL7X5hyUiWM=;
        b=Sn41dp5gbkadgdgtRkVd/qIPZDhGmosKKcCOLhljWIgzfGvgdL2pWV+BgfItdjuVCH
         J+OgJI6lErO+hplXeBT3crqI366txJ+6yhc8+gHBsAssXGgGp68w6lXixl39r5yuTlV0
         unhHg1IC4P0ggjB8rFXJ8i5YqS/bXnnPr198j4JK6nKXUrDcUkNdF3oig6AepygNHZw0
         vNiJKf8Ox2CnO5Hil8dNXM7qOJSNqTxWzZkXtj6Xw1HX/ggsnEvgYvSHBszriOHT5qBw
         hTakYuVhfjOWBBSISxUNwhQfJJOfBt+41BXLoan+qnHqoFhEB4He1RsQhZujkylXBofU
         PuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc8ts6e6IPQ2UBJfZ8eMXHkwlB0Au8KQnL7X5hyUiWM=;
        b=6p/zi4nrIIy94mZA9/lpzxSd+/LPDIAlZ0FBxUZI6DtMdBoRO30s59j4CKJ/tgXByn
         H2ISNWzAiLgt5vNWurg9nsLCqS5fsSAEK40xcEkoZcxD9vDzxcKXwX4PNGABZzneRVZm
         Idwdb17ztyYPwIJfviYa1sWGykGncbGLjj7ioKwh1Wr4Be9bkae160RxAjnotilt8UDW
         6uU/1oBwCTMXIguF8jFXDPcWQ0ovt7qJIvCURFe1H2yhPptVNo1lNV5rbtXf0Jz9uzvv
         AdsK5UZOkJuIeVppmLn+4z7AhzoSfNZWuuaZj+/U6yCFw56KvDEzr/gAzo2Dmmh5D9/E
         ipsA==
X-Gm-Message-State: ACrzQf0SFMCwkWeycbY5BIEjvN7o1ZM1ged+1qmwF6zHRCnyDHUszq/N
        X8h5kGgnzHCMozSFTa21ImeAFWnzhRx4SiaP
X-Google-Smtp-Source: AMsMyM6uGYisrwdoqAUAELs8UjXKFwhG8p0EbdYazTskK4Ob30XvDxp55fKGGFtoqw/9BT/2vmkqYw==
X-Received: by 2002:a63:5762:0:b0:43c:c1b5:3e75 with SMTP id h34-20020a635762000000b0043cc1b53e75mr1674135pgm.380.1665697761640;
        Thu, 13 Oct 2022 14:49:21 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b00179eaf275d5sm336788plg.27.2022.10.13.14.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:21 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for AlbanBedel
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31114-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     albeu@free.fr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a7194bd66d8..79f17e53cb30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3301,7 +3301,7 @@ ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
 W:	https://github.com/AlbanBedel/linux
-T:	git git://github.com/AlbanBedel/linux
+T:	git https://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/gpio/gpio-ath79.txt
 F:	drivers/gpio/gpio-ath79.c
 
@@ -3309,7 +3309,7 @@ ATHEROS 71XX/9XXX USB PHY DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
 W:	https://github.com/AlbanBedel/linux
-T:	git git://github.com/AlbanBedel/linux
+T:	git https://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 F:	drivers/phy/qualcomm/phy-ath79-usb.c
 
-- 
2.38.0

