Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95B62C15C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiKPOtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiKPOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:24 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8A2D1C7;
        Wed, 16 Nov 2022 06:49:23 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v8so11715355qkg.12;
        Wed, 16 Nov 2022 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1hUB1CG0ZAd5p0bPUclNpK4BZ15p3GlgtAxgJ6lCak=;
        b=WbrkarbYRAipvYkcAzjHvEMKaXGegCTc2uv+unvZycfM2jKpbqhhxtEoo3npceJIgy
         iaZ+ccJlQNGyWtx22hVeX3ljjW2T5ygfoWpGYwBMDsnYAIVJQM1Gbl4k2CyEqbBp534S
         3+v6EtLyVmWy3FLsN5Jtw/oBpelIlJgtRWf7cthl17gH9s4cGb6ZpC+u1K8GFvzi/Q3Y
         QVkvBW+pEjskqdsaO+X4x4L6ZTiTICAK58tVq33t1KNew1nZcIma5dAGjiTP9pcvuolS
         cEn0ZOAK4Xiq/cZAPG7KhWf0jPOqsrcRc2vr13WIeZ076Z1VPebixf4aJxvwF7+1k6Dl
         qimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1hUB1CG0ZAd5p0bPUclNpK4BZ15p3GlgtAxgJ6lCak=;
        b=AFBQWJ78A1CrxWPo6/gh6GKiUDfMjWt7F6ddbJqKf4A2DgRCx3Jd99nmQNB6RCwgqm
         i/amFgjs0FInxF6+vmJrrfyQBqzNrfLvPhQm611S8dAlSzYOLTF6m56ByPPLXWSI3gpg
         v2Io3KB3cMKgDgoVQc0ql9W63Qyw/wIVFpK90Hwvgl7dmLIyPHnmvT2zuwZpNx+TphE1
         ckxDR2TkjCccqgLyrOhZkqCDhjdYhCK8AMyeocPfoBNFRrwDa9aYGKuaOaVeefjgl+6w
         5uVnsVG6xKVqiTXFwCFlM/Zoru1tFMCQdo7zDi5mSvkRrtTj11OhF7Z+4gUEBbk1nZ7f
         yY/w==
X-Gm-Message-State: ANoB5pkBT8jvo+hNntSfwtmT2HKwBCccNJqgN2II/hNVtdkDGJsxB6sB
        WoPe7zBH2rs3FnM1mgZKtKYLuAfhcp73uw==
X-Google-Smtp-Source: AA0mqf4PUu1pfZAjTRzZ3fOghb2DCSzQiUgjzsQtawSyorZiUtKh8dPoupxHrtcUh8A5CeT7Bqmd8g==
X-Received: by 2002:a37:92c6:0:b0:6fb:5561:40a8 with SMTP id u189-20020a3792c6000000b006fb556140a8mr16479070qkd.669.1668610162272;
        Wed, 16 Nov 2022 06:49:22 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:21 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 06/14] serial: liteuart: move tty_flip_buffer_push() out of rx loop
Date:   Wed, 16 Nov 2022 09:49:00 -0500
Message-Id: <20221116144908.234154-7-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Calling tty_flip_buffer_push() for each individual received character
is overkill. Move it out of the rx loop, and only call it once per
set of characters received together.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 1e3429bcc2ad..81a86c5eb393 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -87,10 +87,10 @@ static void liteuart_timer(struct timer_list *t)
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, 0, ch, flg);
-
-		tty_flip_buffer_push(&port->state->port);
 	}
 
+	tty_flip_buffer_push(&port->state->port);
+
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-- 
2.38.1

