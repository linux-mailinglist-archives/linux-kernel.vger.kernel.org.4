Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF45F7EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJGU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJGU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:29:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53164B7E6;
        Fri,  7 Oct 2022 13:29:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so8803503wrp.10;
        Fri, 07 Oct 2022 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acRXa3EbxjDyuWzNCvorzoeftSZn5YgHw3PgsDGMlh4=;
        b=ejhUykAcblfBmQrplTJ1MOeHuxLMSdvlZGi/Zyp4Htc37OoT3TCD+E199JOXX8ET2S
         9kf6GTe3w8/gHeaTZm/UnnBLeOTWnQT5TXEdzs9UjqtceNJDCym/b9SJ/XzAgOxNga19
         wM5h8hLITh6aiuR3pBTXv63m5W4/jTCCqONJDOyb9elLVqqecnJyJpT5uoN1yON3auxB
         9zRPRO4bBf1JQ4mTQqQ0iyKIA8iV7ak5WWFnbgB13RSpqJfiUsrAOYX0sQBGS54VKNuZ
         1h9korPY7/0Rl+uKXm/+6vHCTuEhEYdKFTL5Xir1wmZbqSEI2I/fHWB3MLKcmNa4qwMb
         bQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acRXa3EbxjDyuWzNCvorzoeftSZn5YgHw3PgsDGMlh4=;
        b=cy/YH8p6bRDryBP/Krf4ozMmHzx87S+c6Sy9WDAmifSo6LEipX+Gn+DgYDytDgf0Dg
         n62JZojgQpnLW+e1xAnFe6hklrzFwtxLWrZkLrZzGKL14J4WlDScOSFZSYW310LCMtf5
         WKvG72EIi8U0pI45nqUFoz5+QlpcVO2fTUDxmGvdczH5llijrfwE3GZhaBVjWWDpzhpB
         j6cozTSnDurzf2Ppt3pXUPI5bXb9uNgesJ3Ewk1PIufJZ53MRtHNZZcMzCPqnIAXP3VN
         MMdRdfFaDTMAI2dHckdBi+ij011G6IJahvLdu/OAIlFtygyt9s+683CfJ2i+SdNHbZSO
         D3Iw==
X-Gm-Message-State: ACrzQf2rBMacNBazf/aDxR1Tr74yVx875yMOKf6TYjm0jUsvIIg7pHMY
        NFQwGyPwazSvadGofIO05z4=
X-Google-Smtp-Source: AMsMyM5Q6e6m8tHnLpJSYt1IEkbis6gB4v3Y0+Cot/ua6m2dEHtOxf18bWfz/yW4quBb9mKWTPnWZw==
X-Received: by 2002:a05:6000:1002:b0:22e:131c:4249 with SMTP id a2-20020a056000100200b0022e131c4249mr4738044wrx.50.1665174582783;
        Fri, 07 Oct 2022 13:29:42 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b0022cd6e852a2sm3564195wrz.45.2022.10.07.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:29:42 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Kconfig: Fix spelling mistake "accelearion" -> "acceleration"
Date:   Fri,  7 Oct 2022 21:29:41 +0100
Message-Id: <20221007202941.2756304-1-colin.i.king@gmail.com>
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
 drivers/staging/sm750fb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
index 8c0d8a873d5b..2101a6605efc 100644
--- a/drivers/staging/sm750fb/Kconfig
+++ b/drivers/staging/sm750fb/Kconfig
@@ -8,7 +8,7 @@ config FB_SM750
 	select FB_CFB_IMAGEBLIT
 	help
 	  Frame buffer driver for the Silicon Motion SM750 chip
-	  with 2D accelearion and dual head support.
+	  with 2D acceleration and dual head support.
 
 	  This driver is also available as a module. The module will be
 	  called sm750fb. If you want to compile it as a module, say M
-- 
2.37.3

