Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAEB5EF335
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiI2KP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiI2KOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDA52FF5;
        Thu, 29 Sep 2022 03:14:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l18so1390756wrw.9;
        Thu, 29 Sep 2022 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EUOeskYk8JSGzLRuR8c+yYpe0ox0eJPFTWhP4tD6WXc=;
        b=C9b4elgMc8A68/jlVF4cZZJ74vpGWrkLNuvpBV6K83WPdaL5abBmYbMAKJL5Gtq276
         67VgOKMfc8wrR4UZxgYJzQiGGVeKG+iqh+2/AzcQ520AglVrw8c03ak09Xfq6MHuGLEO
         IrIrO7r6aVHSrzCC98iC6GnhepMHLIcPIbqT7d3A2Gdb+HqDbNbap9mlSd3Wr3G0BctO
         RO8/vE5wUsZ4ltm8+MuuGIGAYXcoh6YjyMSiLwKecvFrlhqEPk7cPrrg3mI5qK4vydVS
         33Bp4ORsHX5/pZggqtM11bwOPQ7D6f6EwLO/I/Rivp7pstQxd8GbDhsbDep+8JaY6KEK
         DzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EUOeskYk8JSGzLRuR8c+yYpe0ox0eJPFTWhP4tD6WXc=;
        b=MMxDpzJfvsgh5PbNGyDJucuYJ4nMOHPlQCKxP22yx1LhNZgPpbtCKUCXLk4JqJjfcH
         Pl/40VN6kN0tkiAa2rov+Zysy85z7HK2guE1iN3JKjtwjyA6nlMu8Koe64y+rSeTkRLL
         rfmnv/KrUc3omLUdS8C+C1yDZ/U+FuTEMcW6qquROGVfVMqWq8sqQb+o2mMJPCD60Ejt
         5fZCD5TkEoaLraRoN/WseBfjI6hDftGLUE/LPd5jYLX1capSlVuhcxXMRpFMI9nhT5Ei
         t+vPnXCqq8Pdr6Dg5lPikp1eCsCv7HbxxpC5YPU4ypVy2d/xLSdVTY5ZKNdhWSnX7YT2
         N+NQ==
X-Gm-Message-State: ACrzQf1MJYuhjLbnCZDWibxdE1YyQktrWyGKV25JuFo8wOhuJA4Y4udu
        4dogkc+HkJw5ihaJ1wl2R/0xyEYP3vo=
X-Google-Smtp-Source: AMsMyM7ka5hhgO+UAxBsuRi9mcj0F2KSX+U7l5GUxi6f2CGtW0yXYYDeR7wDT5nN5UzYDLduvuAcDQ==
X-Received: by 2002:a5d:5b18:0:b0:22a:fb91:3d6b with SMTP id bx24-20020a5d5b18000000b0022afb913d6bmr1726000wrb.56.1664446487964;
        Thu, 29 Sep 2022 03:14:47 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id bh27-20020a05600c3d1b00b003b476bb2624sm3945786wmb.6.2022.09.29.03.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] loongarch: update config files
Date:   Thu, 29 Sep 2022 12:14:45 +0200
Message-Id: <20220929101445.32124-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
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
 arch/loongarch/configs/loongson3_defconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 3712552e18d3..2b4220778b66 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -108,14 +108,12 @@ CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_LOG_NETDEV=m
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_NETBIOS_NS=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
 CONFIG_NF_TABLES=m
-CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
@@ -329,7 +327,6 @@ CONFIG_PARPORT_PC_FIFO=y
 CONFIG_ZRAM=m
 CONFIG_ZRAM_DEF_COMP_ZSTD=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -505,7 +502,6 @@ CONFIG_ATH9K_HTC=m
 CONFIG_IWLWIFI=m
 CONFIG_IWLDVM=m
 CONFIG_IWLMVM=m
-CONFIG_IWLWIFI_BCAST_FILTERING=y
 CONFIG_HOSTAP=m
 CONFIG_MT7601U=m
 CONFIG_RT2X00=m
@@ -688,7 +684,6 @@ CONFIG_COMEDI_NI_PCIDIO=m
 CONFIG_COMEDI_NI_PCIMIO=m
 CONFIG_STAGING=y
 CONFIG_R8188EU=m
-# CONFIG_88EU_AP_MODE is not set
 CONFIG_PM_DEVFREQ=y
 CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
@@ -772,14 +767,12 @@ CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
-- 
2.17.1

