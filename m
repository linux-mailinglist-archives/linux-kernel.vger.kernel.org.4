Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111F5B5884
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiILKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiILKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:37:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FC21245;
        Mon, 12 Sep 2022 03:37:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so52773pjb.0;
        Mon, 12 Sep 2022 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ingKwpa9zKSOhbnTWnyMzZNsCBv8TeJBTxZJSWGWRHI=;
        b=GA4rituJy8VN1PzpjG4qUKNP5OJTLX7yyK7yWwUGpuATSJAH33JqBmwdlCYK2L6nwY
         4kC+FDPak4IArlfjuyaZuPARdt++xDmbVodLUO5VR2US2e/mM9TVjr46jYGGXqoLqx3d
         S5bztnLsaqUhkGeor4xYDvlQxYXI6TPNmPcBIxUIFHNcxefWh3tX8WvB8q5LDClNClzt
         MZKhIBE9CzKjsbBy/rmAdGbFA3ahBHZgEFtu5OEb+TcjaJfalcfC5xGB2h1TACGL/u+x
         BQcsAk/MswrszEa5OH3lMRxV5uZH93ZP2BTUHF9Ns5qUz8nyISrIYHL146WuvuS2drcX
         snAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ingKwpa9zKSOhbnTWnyMzZNsCBv8TeJBTxZJSWGWRHI=;
        b=B/Vr8BEfnlay1RtU/7TL44k6hkAB0XU/yQzUxwaW3FPJ2nW9/ITccdyec8rBKbecuK
         vJDUXYjpYJPdcHWhjAe/o9NyoGGwpO72HR0spov6Yt9A2PStg0GUZXwYlVUaEHyR7/CU
         n6nBdUThZiscY9tB9/9VCo/DoP9IryAMBxZPwt5mXudNy4yinyZRSc7suKNW+blDwhjT
         /R0/aSR63Ru8UaX1fm2QyGHzm9yxUX8OI+8TMnLEAhp0PSHIpKtiW/9hYf8tOkBeCPXB
         bbqRsHZbb1KQ1SRiwRlJoldfBIAmK+N06wvDJE05+XRAHhpYxtWR5OBUYLepqL1Mhcrj
         iO+w==
X-Gm-Message-State: ACgBeo2SlQN0LZfgjAwAw8Ac3delLHyfxxKBGk1Mwx6VtVOunzDz1jFE
        2fc93y1Rppjgk8F9p33cZAQvPF8dSDc=
X-Google-Smtp-Source: AA6agR4CjmYnlk0qDw55Y/gvdFyD+P6M+rG8+17LrKL3ui+3rI0vDJOWQe6wO8TnlQP+Rv7POsbzmQ==
X-Received: by 2002:a17:90a:5b:b0:1fa:b78b:ad73 with SMTP id 27-20020a17090a005b00b001fab78bad73mr23338896pjb.107.1662979049909;
        Mon, 12 Sep 2022 03:37:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0016f057b88c9sm5638507pln.26.2022.09.12.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:37:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] USB: serial: keyspan_pda: remove the unneeded result variable
Date:   Mon, 12 Sep 2022 10:37:01 +0000
Message-Id: <20220912103700.18338-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Xu Panda <xu.panda@zte.com.cn>

Return the usb_control_msg() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/usb/serial/keyspan_pda.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 6fd15cd9e1eb..902675ac7f5c 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -393,12 +393,10 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 static int keyspan_pda_set_modem_info(struct usb_serial *serial,
                                      unsigned char value)
 {
-       int rc;
-       rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-                            3, /* set pins */
-                            USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_OUT,
-                            value, 0, NULL, 0, 2000);
-       return rc;
+       return usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
+                              3, /* set pins */
+                              USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_OUT,
+                              value, 0, NULL, 0, 2000);
 }

 static int keyspan_pda_tiocmget(struct tty_struct *tty)
-- 
2.15.2

