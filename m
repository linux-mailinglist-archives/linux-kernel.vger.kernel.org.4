Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB6626BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiKLVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiKLVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:41 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BDD15837;
        Sat, 12 Nov 2022 13:21:37 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so4887281qts.1;
        Sat, 12 Nov 2022 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MThhfi/+6K/LOJrqVDZeVBTVPExj3Q+f1CKmXTQaNyE=;
        b=AXOzRqyTDqtG7FZH8oEjR5QhNTkyr2FlKau53ZFDhVib8/PNf3gjqWtsOM7WzW1POP
         Mcsr+vDOSi7xwYwij+2JrEfpTNWySGA1Fn0c68CsMxt+/w6pFzB1W6AUfpItAee/Bhou
         E9LrxymO110qQgsYT6c6heWr85C/3PQojXd5fWJeMGKdptulmEsNidex8RUQl93A1cRi
         t3oiG8QQ1xlDhrOSNb87f8L1vugHuQewTvX2FWwZu9zfNk0+wTwYdfxMbIX7W7zIZ04h
         g1w+I8471NbkxRzuu1D0xkr5EiVGjo+gOXdmlRUuWZ2BJ9NO5AsUiYXx9G5CXdApOOOv
         Ir8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MThhfi/+6K/LOJrqVDZeVBTVPExj3Q+f1CKmXTQaNyE=;
        b=vsxKS7KSnYwmo6p5Sc4xBmwgEod4AODa42MjNLKrlBhhSpM4OXhKULEPYND+kqfVUA
         f17h/LeS6eAzomrZUYvaeg0QkMGehy1eQVtI1trCglNrnFkPlEKIDoEEbB2wvfxh9bmk
         kgLDoofaxE7d/mQPQahEr2bOhdONy6uqKogGakLy/MQsYR92a7ilB15I8ObwGVC+P2EC
         ts/S/JGLGlmGGw59UWb9SiNUIEI/QYuBkO/XwVESFM+8WP3GzcZ1DnujvQkuG4Xqjj4U
         MgPVgJzrssZJ71exELy6+4JtwwVtJxKYkfouM+Wj2GbGCfYBmSc1JrnHT7isu3gcfHCA
         5vSg==
X-Gm-Message-State: ANoB5pnBSOVu+eU1b0cpg2b7ydEhM0rV/nQbDN8VOnOv1EKi2nuwFyv0
        2Fr8k9TColOW3gjh45EGd4WtPJXJwYvuXA==
X-Google-Smtp-Source: AA0mqf7KT7/puQTnvyn7b/0aDs9Jlhff0nTEpnRSr5ep4SBi4A/yZo+xMVVXS2w2NVbh40Q+I7n6lA==
X-Received: by 2002:a05:622a:59c7:b0:3a5:4c53:8923 with SMTP id gc7-20020a05622a59c700b003a54c538923mr6815383qtb.267.1668288096553;
        Sat, 12 Nov 2022 13:21:36 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:36 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 05/14] serial: liteuart: minor style fix in liteuart_init()
Date:   Sat, 12 Nov 2022 16:21:16 -0500
Message-Id: <20221112212125.448824-6-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221112212125.448824-1-gsomlo@gmail.com>
References: <20221112212125.448824-1-gsomlo@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 5b684fd198b7..047d5ad32e13 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -398,12 +398,10 @@ static int __init liteuart_init(void)
 		return res;
 
 	res = platform_driver_register(&liteuart_platform_driver);
-	if (res) {
+	if (res)
 		uart_unregister_driver(&liteuart_driver);
-		return res;
-	}
 
-	return 0;
+	return res;
 }
 
 static void __exit liteuart_exit(void)
-- 
2.37.3

