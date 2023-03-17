Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C76BE1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCQHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:15:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB64B479;
        Fri, 17 Mar 2023 00:15:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so16755777edb.6;
        Fri, 17 Mar 2023 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679037340;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq9nxA1qio6sHiPpysjGP5/YY8vR6Z5D1TNGlUNP8IU=;
        b=o6syNwWOXuj89QalIA8NDAwlkjXJyLJJY8bM5ljdEu6ARdegjLasqz1alEkl1U4Nr7
         4mctbKGozjiQQuVw7Q/JjttDccEw45SGLqoWuiKZFz4qbY9O1B6AA+7KRXy2T2a/lk96
         F3wJHX3YLJOc508q1WI5UgOVZ1BqOnSbscZqdT/4YYhhqrWy8hFNh7v/rCV0ItIqtXUF
         8ABhvyL0+fG7uqJ2toLms9cUgNbauVQtJ6cfCDTjP5qsUCU/SRYPJ7fvMEw9wWrQXxf6
         o8mnRbt8/0MdguEB86hiuMjlBYC8YDNOfHiIHwL+IQwRVcGa2RQi4lgDnmxLwOUju+tg
         01rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679037340;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq9nxA1qio6sHiPpysjGP5/YY8vR6Z5D1TNGlUNP8IU=;
        b=DjbaVNjCo4kN3nursecXkcHBB/l2n0AfrCsTw6ByKprXzd5CyAILzGhTw8Qx5Vfh96
         9/sUvIGNxPelH47JtjOKSx1TQ+lhVd57P5O1EGWFwBRCayB2bMJ3zHLBtPGPSG2JYbnC
         t92Xc5G28cw2piDjMyjIZWadnU0mkn3AiPMGpV3ado478irqMQohU0/8YbWVwveGhkYD
         2zHLFhqcQ+t/yKk/BL1uu3CM4CfwPcDLtCpL6SnHrZNXt1svSPfdGOy/p0SuIiXYBG9V
         /JShQNwyjcOFyQ/O7UdIyQC4lqsOMJQQS3PQL6yLl0xlua3OL99U5hjZ9uU9TLGOiWcP
         G85A==
X-Gm-Message-State: AO0yUKXhTht696gOjOWogFEMmohOMJoJu0nA5kVGJSGHYCUmtFjL29TW
        pL+SBsad+puYx+amWU/8Ybc=
X-Google-Smtp-Source: AK7set9/hQB+19dBuwQn53wi6HeRunc/rW+F4LLLcY/Y6YJHsmy/XWiipCsPGNYohznhu8OlytA4bw==
X-Received: by 2002:a17:906:3714:b0:92b:4f8e:dde1 with SMTP id d20-20020a170906371400b0092b4f8edde1mr12375573ejc.20.1679037340179;
        Fri, 17 Mar 2023 00:15:40 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d59c:b746:d2ef:469])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060d6a00b008d044ede804sm595192ejh.163.2023.03.17.00.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 00:15:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] tty: serial: remove obsolete config SERIAL_SAMSUNG_UARTS_4
Date:   Fri, 17 Mar 2023 08:15:38 +0100
Message-Id: <20230317071538.29366-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks"), allows
simplifying the whole config logic for SERIAL_SAMSUNG_UARTS, and did this
config simplification. However, it misses that SERIAL_SAMSUNG_UARTS_4's
effect was just to control SERIAL_SAMSUNG_UARTS, and with the commit's
change, the config SERIAL_SAMSUNG_UARTS_4 has no remaining effect and can
be deleted.

Remove this obsolete config SERIAL_SAMSUNG_UARTS_4.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please ack.

Greg, please pick this minor clean-up patch.

 drivers/tty/serial/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0072892ca7fc..39a0078f54f6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -248,13 +248,6 @@ config SERIAL_SAMSUNG
 
 	  Choose Y/M here only if you build for such SoC.
 
-config SERIAL_SAMSUNG_UARTS_4
-	bool
-	depends on SERIAL_SAMSUNG
-	default y
-	help
-	  Internal node for the common case of 4 Samsung compatible UARTs
-
 config SERIAL_SAMSUNG_UARTS
 	int
 	depends on SERIAL_SAMSUNG
-- 
2.17.1

