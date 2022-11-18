Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2295662F86C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiKRO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbiKROzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:45 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C56D4BB;
        Fri, 18 Nov 2022 06:55:27 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l2so3220613qtq.11;
        Fri, 18 Nov 2022 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zatoQ8/a+60T2AmPXnfE9c4vLIYDpN6MzKVzyD4F9Ww=;
        b=LwCD4TSOe13o84ZJbI4EQqySqnhs8SOlAzjGAXtXrhXlRTy4QzkzYb8pJot6uRcgqg
         Xriz+j/vyhewZfJp0VtqsRaWvDpPz2SCC0NqBoUCZcAOcZiu9N22U5FJ0OWgFmdP89yw
         2ldmPpdXe7VD9hoN2rgLVWX9Fjs3CjefIKffF3MIaubvNdAEYtKdEuZV54CXfDuv7xaS
         MFg64dxU70q3nP51bDs/bl2EhLGpA6B0psYwZ/hPnWoicRJfk2H/4xco5RZvB1wTWfsZ
         xkMCvbeIsf5xkWkzeZANAMOFDooW1lAvs2Mrv0YOYUrRX3FGMftucaXq6dP3t87WhBPO
         UtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zatoQ8/a+60T2AmPXnfE9c4vLIYDpN6MzKVzyD4F9Ww=;
        b=0qdJdebxGS4U5+nBagYbHHzB3NdG3aHPGXDsU0i+kInnX4HEI/N8Fn17hTh8rwOnjf
         VhePV+VWcH1zkRxB3Gk9KKi26VUIKGZrk2K492wpPB91MufBys31a8fwXtoCU6uUo4Zz
         yT/Cjf8TFOI5w/yqRSFid64C3H1QzcfR4K3QRcMfYg2LE9ev434J6AK1IPPHeSeWU7yl
         5rkjqZFMMnM8oX4chQghMoluc/N3V+X3GFsYuoMkNV86Kh6bJQHLqe9JTD9D/8ghy314
         vfgihYbqrwasLVIaggHRvHK8qTlzCcXyDTuxeTBGEAX0y+2hg/pvpbsw8pabPu1CVqqa
         vMvQ==
X-Gm-Message-State: ANoB5pkSJMiw1jfDKMjORi99/zHPvt9kI/Pk/IQJgMwznfjXw7boqs0B
        bHcE1mpcdMisHz1Jl2fvrvsk7NFYAfx2XQ==
X-Google-Smtp-Source: AA0mqf6cSNFE1mh8Xm83C3t3EWE5C/6TFeDyDfed8hhLizTM1VqFxmIBfYS8vRAQmhtSJypvyf2fTw==
X-Received: by 2002:ac8:5483:0:b0:399:4a68:c578 with SMTP id h3-20020ac85483000000b003994a68c578mr6686834qtq.202.1668783326029;
        Fri, 18 Nov 2022 06:55:26 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:25 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 05/14] serial: liteuart: minor style fix in liteuart_init()
Date:   Fri, 18 Nov 2022 09:55:03 -0500
Message-Id: <20221118145512.509950-6-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
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

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index c6eb7eba5af8..1e3429bcc2ad 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -397,12 +397,10 @@ static int __init liteuart_init(void)
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
2.38.1

