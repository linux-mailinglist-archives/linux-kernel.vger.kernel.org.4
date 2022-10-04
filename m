Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60165F4720
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJDQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJDQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:06:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF25F7C2;
        Tue,  4 Oct 2022 09:06:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id iv17so9219329wmb.4;
        Tue, 04 Oct 2022 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JzOBFqoHQk5sbb88IXGYAWyLYnuSbnvMiffX2ln7ZwY=;
        b=Rj+l6U3nNSIFywr93jeVy56CN03wRC/7817IVultzoSms9L4uKB4b9B3NUnPUdvHNc
         TAG6ZDXEbSAui9n/gh8ZI28TiiieT5QyzZVc8StuRCmy/LkNZ7NrGxGhc8i0G7BtGWB0
         CdOet/pA8zkgMSUZEPq8GL9aaN5873fNruP3i1cTkZemSNUn8kLZJB60Zc+LgQcbHxqe
         5oAyQeHqyQ9Pz3Ujnw6+14hSRXfo9auNVrnjUOtFr6BbwwcPTeTS8zZgkXjcx4r67zoz
         9DvuNUA4JVHiAKgutltgWA0zE/0lXbQrN2ayZ7/xjc2/Wr8wTkdRzhU4QMg5+FJjr4ZD
         +7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JzOBFqoHQk5sbb88IXGYAWyLYnuSbnvMiffX2ln7ZwY=;
        b=5McoL6CjtRwuFzPV6dHYodQ3lzBmaxx0dWBcLL8rJl7QNYP6TL09WBbns8PWcQJ8Pw
         II+96q/D21RpknkcDRNcLz3YiK0yaBEkLylTvfJpR5hMy3/j9c6pmSubduHEYpYGUKC9
         FehGiXLU6SRNzHVf3hAVbOla+e8cAG84WOFpiLaPZcVtbKNqkKdXKI4XY7VAji7dmyU5
         uCRLubbU5Vdlwn9Ay0wDJ4C5FaixiBtpAJ3rdzpCMmkv87BXSf51q8SfBFEUALH4bVH3
         ZvN0Pb3oNR0z9EGcczAF/Et6T6GK5iewtoApUNqaop6gPd/ox60Rc87HHAnkB43q2W3e
         fGvA==
X-Gm-Message-State: ACrzQf3qlpXHwpWySXW9TRfcBxSaWwDrpHI0gN4iGz49ul53MmiM7XTI
        Lws+Iu+fNC6BloX650OK+XA=
X-Google-Smtp-Source: AMsMyM6gRgaGAOCdkIrXOwLoGfT92j7KLM0C3wI+tKqR71EzYZ/Ko/ncz8DXmsZlQVl7c3hMCAbu3g==
X-Received: by 2002:a7b:c4c2:0:b0:3b4:fdc4:6df9 with SMTP id g2-20020a7bc4c2000000b003b4fdc46df9mr332508wmk.123.1664899600743;
        Tue, 04 Oct 2022 09:06:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d464e000000b0022e38c93195sm6420254wrs.34.2022.10.04.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:06:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/xenbus: Fix spelling mistake "hardward" -> "hardware"
Date:   Tue,  4 Oct 2022 17:06:39 +0100
Message-Id: <20221004160639.154421-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in the module description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/xen/xen-pciback/xenbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index bde63ef677b8..d171091eec12 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -31,7 +31,7 @@ MODULE_PARM_DESC(passthrough,
 	"   frontend (for example, a device at 06:01.b will still appear at\n"\
 	"   06:01.b to the frontend). This is similar to how Xen 2.0.x\n"\
 	"   exposed PCI devices to its driver domains. This may be required\n"\
-	"   for drivers which depend on finding their hardward in certain\n"\
+	"   for drivers which depend on finding their hardware in certain\n"\
 	"   bus/slot locations.");
 
 static struct xen_pcibk_device *alloc_pdev(struct xenbus_device *xdev)
-- 
2.37.1

