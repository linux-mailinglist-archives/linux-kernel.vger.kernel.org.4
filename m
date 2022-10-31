Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D26131FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJaIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:55:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEEF1D3;
        Mon, 31 Oct 2022 01:55:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y69so16439727ede.5;
        Mon, 31 Oct 2022 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaCDtOb4CC7gCLWXRM7LGCFxZ6xhFeLhKQUZBpqIEso=;
        b=hdlOjmenZzoST2wbo4cyhw3wk4diAkv2VwDcj3K7YhHbF8sAePBzEkEYizt/IeO4oX
         sFyXthuSgOYtzZjG2wWGXyy+ItgCH3D81+MRMmY0gqj1pBDGfCHR7D88n55g73LM0dpK
         kBocVf2jnnFPb2H7JOmbG/EvZn2uxxKhxm2K+hPFJCX8Gf+UWQsCn9/6H5kayNRnqJ4P
         YyOT0BYMlrgxsHx+1iYt7X+iR+xUGf4r8fW7IkwS8jgMzlFtP2ULAaZoMkqW4Sss72Bp
         ccgpVOQZJtrjxE9XIYNU8eYD3FbZOC+USxBJS/9s3Nyahowmwmx7skTkvH3hZBq9aBue
         kGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaCDtOb4CC7gCLWXRM7LGCFxZ6xhFeLhKQUZBpqIEso=;
        b=0IKVOgrruPMbb8yAaY4nZoFmb+5CXYuc0ACbzBnu2e7nSCASUHjDAdApvWH/P5HAs0
         wUDciXwXpHS5ZUFBqNexADE/hrhKUOwqkFTC92tow/0DxmHaEf2Hp/q/DwwCVHhBUiCD
         KnhzALtt0F6K3dOk9M3W6jL3HS/AMXEfxc6w9D+hNhHD9K9FDWj7M+MfBm5ibMkGIsMh
         AHnesT3duRGMIC1yinnmCfex1T2IIuMg9Q3Uz78GDxb2Yu1HXzpk9dBl9BxnBsT3CTpe
         YU3zVtof8TJdOZ+hoi+EGgVL8Behp4kpwPRg9EoAtQrBk9/i7yuJUCC/xHT70HVQWpL6
         2yZQ==
X-Gm-Message-State: ACrzQf0WJSYu+3pVjyNpWGQ0gkNhhJ+1NxJKLntdbvwsdhUCV54fTeM5
        jH8+ROKkx579qhDb08dGPhU=
X-Google-Smtp-Source: AMsMyM7zMEdcCSwHGEAdX+SK16Z1tsH6y+lkgVydYyeJF3nH2MZmfQBdDl5kEaSPxIULpqdaP4178g==
X-Received: by 2002:a50:fc03:0:b0:461:5d8d:5811 with SMTP id i3-20020a50fc03000000b004615d8d5811mr12612570edr.351.1667206501456;
        Mon, 31 Oct 2022 01:55:01 -0700 (PDT)
Received: from felia.fritz.box (200116b826c494005d8b6b3bdc900ff8.dip.versatel-1u1.de. [2001:16b8:26c4:9400:5d8b:6b3b:dc90:ff8])
        by smtp.gmail.com with ESMTPSA id w25-20020a056402129900b00463597d2c25sm1156048edv.74.2022.10.31.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 01:55:00 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] usb: musb: remove left-over after USB_TI_CPPI_DMA removal
Date:   Mon, 31 Oct 2022 09:54:26 +0100
Message-Id: <20221031085426.17175-1-lukas.bulwahn@gmail.com>
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

Commit 32fee1df5110 ("usb: musb: remove unused davinci support") removes
the config USB_TI_CPPI_DMA, but misses some left-over references in
drivers/usb/musb/musb_dma.h.

Remove the left-over dependent on this removed config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, Bartosz, please ack.

Greg, please pick this patch on top of the commit above.

 drivers/usb/musb/musb_dma.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 7d67b69df0a0..e2445ca3356d 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -61,12 +61,6 @@ struct musb_hw_ep;
 #define musb_dma_cppi41(musb)		0
 #endif
 
-#ifdef CONFIG_USB_TI_CPPI_DMA
-#define musb_dma_cppi(musb)		(musb->ops->quirks & MUSB_DMA_CPPI)
-#else
-#define musb_dma_cppi(musb)		0
-#endif
-
 #ifdef CONFIG_USB_TUSB_OMAP_DMA
 #define tusb_dma_omap(musb)		(musb->ops->quirks & MUSB_DMA_TUSB_OMAP)
 #else
@@ -79,11 +73,10 @@ struct musb_hw_ep;
 #define musb_dma_inventra(musb)		0
 #endif
 
-#if defined(CONFIG_USB_TI_CPPI_DMA) || defined(CONFIG_USB_TI_CPPI41_DMA)
-#define	is_cppi_enabled(musb)		\
-	(musb_dma_cppi(musb) || musb_dma_cppi41(musb))
+#if defined(CONFIG_USB_TI_CPPI41_DMA)
+#define	is_cppi_enabled(musb)		musb_dma_cppi41(musb)
 #else
-#define	is_cppi_enabled(musb)	0
+#define	is_cppi_enabled(musb)		0
 #endif
 
 /*
-- 
2.17.1

