Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD46BE2CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjCQINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjCQINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:13:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE1CD679;
        Fri, 17 Mar 2023 01:12:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so17188557edb.6;
        Fri, 17 Mar 2023 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679040719;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMw3bVrnGcR3UGzni31zr568CiQtvl1Ofgs9bx9DY1g=;
        b=qVsuC/h2AQuc5Pxojy3yTCdlBkcPKQ0BUtA9FFw3078MRG+hk7AMBWowzKbQvG6RjU
         bHbzw8bM679UUW5BsI0aPkC+HthVTnOajGhLjhzg9XK4Z6061lkz1RFVPxJdXgSHoifJ
         RXAlcweJeoqY8LbwhfsWgNsJOvkQWg2RdlvZvV0zOakk3e9VWDyP1IQt4UJeuznxBQBi
         UkTFZhwC8Ky09YTIHQt5Bg8JItW6Yq7OFVH6ph3iPBFEPWASHP5p7i28eMvgbRTqgl2t
         hbROyMXvHoriDV14B5umi/Ad9DyX7ZRS/yF4StVHGchufo+Rc5Gnge9DFZ3+lxgvoqX8
         T+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040719;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMw3bVrnGcR3UGzni31zr568CiQtvl1Ofgs9bx9DY1g=;
        b=aTgB1Hiz/zQBxp2J7DUnfdJSn6gzAy8jGjMumeIO9I0U17Ll/qAYDCYlw8cZVmxbsJ
         b1FgBHY3cq+GAzumQDNG8TCdCGV0JyqGv8IZqDHIaumin7T6o+i14O22t/QSw3VBi9sn
         DZG/oiK+sBRBQOkY09/3wm/Ut715oAJtarzn+VICYe9L4wbIMqsIsPL9Ktmn1ZMypGvp
         Y3A7arqXG2FytLTKDJk1R2xF2BrbmSFtDs7KcD0m+CmU633heCEgP6/8XBfyFX3zWVb6
         yqyaP5CMWfoXl5F32SpbPCLFr/lHuOf+kX9kSlXJ2FLXVuhv0koZe6uaOJ+pnycHkn0i
         CrZw==
X-Gm-Message-State: AO0yUKU3SbLLOQwg1B69cn32Nl01UZbUAsdXyh6TjAaftXwx7dEnHMQP
        jKtrUXiucZHj5K59QIwqbzDCd/cwv2madg==
X-Google-Smtp-Source: AK7set/ftSNliYy3Vj4JFpPfT3EFFmpTe7BMfXpC62GVqkpT+TYR5AY7p1VKJDpRfo1tfiTYEaYldg==
X-Received: by 2002:a17:906:3582:b0:8b1:347c:85c8 with SMTP id o2-20020a170906358200b008b1347c85c8mr12412782ejb.17.1679040719306;
        Fri, 17 Mar 2023 01:11:59 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d59c:b746:d2ef:469])
        by smtp.gmail.com with ESMTPSA id ce6-20020a170906b24600b0092101bb66desm669076ejb.147.2023.03.17.01.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:11:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Russell King <linux@armlinux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ARM: mmp: remove obsolete config USB_EHCI_MV_U2O
Date:   Fri, 17 Mar 2023 09:11:56 +0100
Message-Id: <20230317081156.32337-1-lukas.bulwahn@gmail.com>
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

Commit 77acc85ce797 ("ARM: mmp: remove device definitions") and commit
06f11dfb5b75 ("ARM: mmp: remove all board files") remove mach-mmp's device
definitions and the board file for the Marvell PXA910-based TTC_DKB
Development Platform. With that removal, all references to the config
USB_EHCI_MV_U2O are gone. The config has no remaining effect and can be
deleted.

Remove the obsolete config USB_EHCI_MV_U2O.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please pick this minor clean-up patch as follow-up to your patches
mentioned above. Thanks.

 arch/arm/mach-mmp/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 85b0d9ddb7d8..8c1d4402fd69 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -76,10 +76,4 @@ config CPU_MMP2
 	help
 	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
 
-config USB_EHCI_MV_U2O
-        bool "EHCI support for PXA USB OTG controller"
-	depends on USB_EHCI_MV
-	help
-	  Enables support for OTG controller which can be switched to host mode.
-
 endif
-- 
2.17.1

