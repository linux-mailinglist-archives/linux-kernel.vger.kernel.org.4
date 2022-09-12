Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22B5B5B55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiILNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiILNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:38:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CCB167DD;
        Mon, 12 Sep 2022 06:38:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q3so8089574pjg.3;
        Mon, 12 Sep 2022 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MGvQJSB1vj0XT662a6N9mr0USet28hdf+Av+V/BDZMY=;
        b=fmENMdxPWsFBjcyMZeQcWhtUG7d/GBDFXAtNDiwsIx6EpEb3YuvEW57IzkjvozPBog
         tUyyQqI3E6nj44tLi3EQwWvPcQDchSoiwFbxL4yvtG3HioAtd+KSgxm2XFcfrQFHDGL4
         Q7vzg46sZds61SdSVSuguSw3/mwgWM8OKRzB99hTyb7XSf/yQG9cmOdzSpipe6AcpRHv
         KKHoAh6wolU/TV/06YOKUhDyUjnB2AEa+X81M4FkSwhrB33GElwCrA/heN9P0SN52g4v
         Ks5BN18GRRbdjJuKqOixAfSa+WGiGJX9BAe12i7DpgG1QXGYuygFA4HlUDk/3H9zmH5n
         rHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MGvQJSB1vj0XT662a6N9mr0USet28hdf+Av+V/BDZMY=;
        b=63kZtvKmRA/ke1YqZLnAyqfaHU21ni0BGGqNouXvCKf0cOhi4RkqC2lE3nG7HXDUFK
         I2+tZjDkfwc3sHIeB3OerpRjbLT4ENjE7OF6fSTokU5+V727SMSOCJIbhFcV6yzROTwz
         3vbOTMinMc0hNc50I1WEXJFExMhhkjvxUCIpmXq8dEO/MqrEH4z22IcfPKnXM1ESnO7I
         RvEWxzZIaaHVbC03DBngzvca3JoGAAlOIKqsM+QEfrOzmot8GEyuYOpaU2cdoBCUtReU
         mU82IFskOFLWEMCpCcjb9lBYZkUZx7UC3j11XHi5rk56P9EFwrt954FrKMaR0kqhbc+U
         hYyg==
X-Gm-Message-State: ACgBeo3XNdfmhjYyIwOOjWAVaGqeZcvx3UvmoFJs+IxvmDUGZDJeL18/
        Ag0lK9mR7UBDIHK86NhYdnE=
X-Google-Smtp-Source: AA6agR5fwxY8Xj901KKNvRKanCbCXK3Bc1AOrQzThm0Obu4UnT4ueaazkosxz4zTq9VywUX+CwfcJw==
X-Received: by 2002:a17:902:bb97:b0:175:6721:2c34 with SMTP id m23-20020a170902bb9700b0017567212c34mr26861585pls.146.1662989921497;
        Mon, 12 Sep 2022 06:38:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f20-20020a170902f39400b0017829a3df46sm3314879ple.204.2022.09.12.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 06:38:41 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] USB: serial: ftdi_sio: remove the unneeded result variable
Date:   Mon, 12 Sep 2022 13:38:27 +0000
Message-Id: <20220912133826.18517-1-xu.panda@zte.com.cn>
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

Return the value usb_control_msg() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/usb/serial/ftdi_sio.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 0a1da579ead5..f02dcef69cb9 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1394,7 +1394,6 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
        u16 value;
        u16 index;
        u32 index_value;
-       int rv;

        index_value = get_ftdi_divisor(tty, port);
        value = (u16)index_value;
@@ -1407,13 +1406,12 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
                index = (u16)((index << 8) | priv->interface);
        }

-       rv = usb_control_msg(port->serial->dev,
-                           usb_sndctrlpipe(port->serial->dev, 0),
-                           FTDI_SIO_SET_BAUDRATE_REQUEST,
-                           FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
-                           value, index,
-                           NULL, 0, WDR_SHORT_TIMEOUT);
-       return rv;
+       return usb_control_msg(port->serial->dev,
+                              usb_sndctrlpipe(port->serial->dev, 0),
+                              FTDI_SIO_SET_BAUDRATE_REQUEST,
+                              FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
+                              value, index,
+                              NULL, 0, WDR_SHORT_TIMEOUT);
 }

 static int write_latency_timer(struct usb_serial_port *port)
-- 
2.15.2

