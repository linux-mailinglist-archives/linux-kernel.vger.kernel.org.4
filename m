Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136845EF320
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiI2KO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiI2KOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42251497BB;
        Thu, 29 Sep 2022 03:14:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n10so1378644wrw.12;
        Thu, 29 Sep 2022 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+1jb+nfNrrfT47twFWxXKdVM9Wqmz0pwBbN3bVcD7Sc=;
        b=RMlq4j0v9c9V68QmGp8qPZAxlNF0r+I8ps9TEAfWeSlPwqYQmFZOHMNm9WKzaZpiqP
         BUIhBp8izAt+eC5a4STiG0cb+/G7vOoeb0iyb2Kc6HXq+NQ7fsfD3meT+CNgHhFWM89i
         wPpn6fiZC9ftYmg1ZuNZ2V5Bb260mXiEg6zuV/iSW0KpUXVX8UCOE/fj6PpAGFm3qRyb
         PjzHirM3LoRUVT1kiX87w9n0TzKpEnR0zqVwtve1amKwIDotfT2hVPcF3Z44+WAteO3u
         +M3stm9d/ZbwwsJ2ePE0FIy16K8mjCNT8L8Gm2+tR73iP6wUUoZhfVTTXna89fl+DPe8
         j7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+1jb+nfNrrfT47twFWxXKdVM9Wqmz0pwBbN3bVcD7Sc=;
        b=0D6p9Rkw/g8p48h6R6xJeqdQ1rSWoknkWqBInLMNr8C9+WYJ6lcELIN2otdHvUf3ht
         /x+GctBTexScldit9LEUoD4vEU19nib0QzbbqxN39gt/Ui7xpZH59D6o8eQLktauC2Tm
         7fMd0kNClHkG5Z1kfhB45v8nyHfpE9Ml/4m0q+hyION4jKI3CGDgEoX+k4gsaYM/jTM/
         aasrUgMJgZ1gRzombccRl3tR1qwvib+jIJr3APNpy7WBu6NWLPKAZubCWnXjrx5oLoIY
         lYuKnUcC1aaTIJF01z8pBHrR0Sya9Lzfc9gMyO5wkC7bU/nwB0d933pIzJ0/SKwQ64w9
         IiQA==
X-Gm-Message-State: ACrzQf1WFb9UUrjgQMVPi24yzjLd/sSD5ArPToBNUkEAkExT7zEINK6G
        c5dPrDdHCIn+Mr/Nl/BUzGy29mJQFD4=
X-Google-Smtp-Source: AMsMyM4a1ThGMdCDyv5qN2IGEoba4iQiJVnd/J0gYcyaFj6lXbzwvbWw0eoSyfdTgL9jGkocyMNbVg==
X-Received: by 2002:a05:6000:1c1c:b0:228:de40:986f with SMTP id ba28-20020a0560001c1c00b00228de40986fmr1688955wrb.212.1664446460813;
        Thu, 29 Sep 2022 03:14:20 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id g14-20020adfe40e000000b0022ae8b862a7sm6233187wrm.35.2022.09.29.03.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] alpha: update config files
Date:   Thu, 29 Sep 2022 12:13:29 +0200
Message-Id: <20220929101329.31036-1-lukas.bulwahn@gmail.com>
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

Clean up config files by:
  - removing configs that were deleted in the past
  - removing configs not in tree and without recently pending patches
  - adding new configs that are replacements for old configs in the file

For some detailed information, see Link.

Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/alpha/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 6a39fe8ce9e5..1816c1dc22b1 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -39,14 +39,12 @@ CONFIG_PATA_CYPRESS=y
 CONFIG_ATA_GENERIC=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
-CONFIG_NET_ETHERNET=y
 CONFIG_NET_VENDOR_3COM=y
 CONFIG_VORTEX=y
 CONFIG_NET_TULIP=y
 CONFIG_DE2104X=m
 CONFIG_TULIP=y
 CONFIG_TULIP_MMIO=y
-CONFIG_NET_PCI=y
 CONFIG_YELLOWFIN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.17.1

