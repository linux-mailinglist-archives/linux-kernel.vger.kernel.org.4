Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647865EF33B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiI2KPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiI2KPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:15:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A65F23D;
        Thu, 29 Sep 2022 03:14:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h7so1385035wru.10;
        Thu, 29 Sep 2022 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RRPHFYR6JN9kGUvlnY0zJ0DYUx4yeQOFM8stN052HXQ=;
        b=I4bQ+utOBwqfTsrRH8e/4LFtEFqYOXN0L6hEcS3E3O9B5UThHFvwSxU4+B0/Gu3JHF
         f1c80HTA0Y5WV+j225TDbyJaWIpVBSITD0k4mfUt56bbfyPoMj4LsX5ihjhfiDSEXM4q
         ZzoJ72rUwwa3awPAY3ypWB2O1kE17PXjD9xOjBd6Dz/ICCXlHITxFIUD5/4Df45NJObg
         sQinjp5sg90kIBIrjVIiTGfLJ2/Ur2QpMXVXH1nN2qVvnBO1yjcJHBeosRjQv0Ft+pJq
         pJU9AmOeb3o+nL08uSr74rsIvqfSy9cgpSH5ORl+/JYruUXmdPSIR6DOJNtBl1iJOc8E
         0k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RRPHFYR6JN9kGUvlnY0zJ0DYUx4yeQOFM8stN052HXQ=;
        b=rU1uo5SFY4iL3onhyjL5n3tWrap6xocWdSo5W0356G/qek0P3J/kutfY8cIajD33zU
         eWmOgH+vMqjx38cCBPDT3KJ7W34k6d3W9caZinvjfxob8/B1mPo5zl0kF1PllQiQVI9o
         0SQoVl8nLN3onAWuWKLOPqoUyqJ/IS47Sqiv3X7mgKrP4WVtmUaRfQTYt4JIKApLQZ1f
         t9yIvXP/wIa6TXcoxyrc/07evyWJzTWMGFtZg5IOcyinEVfl6doz+K9PFWQTjXz2iOZP
         a7fmHRp7j+xDvTE1zZ8yiYTWQgLFbBNVnAEH6SK+6T1jvXs6N1KvyMRLbV15dsOtkRvq
         6WLg==
X-Gm-Message-State: ACrzQf29pvhTduJkdtQloxBMyUYVLFr7zWO55m+703wqinmPTpfbYdUl
        58PllE4lcI+0QY0u9unGhDtjkhbuEPE=
X-Google-Smtp-Source: AMsMyM60yiFsTgkqe3xikWUl32bklNuSbScxmAjkQNzLcLlXIew0AC1zw0sqWbw6L6LbxPmGe+BxgQ==
X-Received: by 2002:adf:d215:0:b0:228:6293:10ff with SMTP id j21-20020adfd215000000b00228629310ffmr1627402wrh.171.1664446491041;
        Thu, 29 Sep 2022 03:14:51 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003b47b80cec3sm4235919wmq.42.2022.09.29.03.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] m68k: update config files
Date:   Thu, 29 Sep 2022 12:14:48 +0200
Message-Id: <20220929101448.32177-1-lukas.bulwahn@gmail.com>
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
 arch/m68k/configs/amcore_defconfig   | 4 ----
 arch/m68k/configs/m5208evb_defconfig | 3 ---
 arch/m68k/configs/m5249evb_defconfig | 3 ---
 arch/m68k/configs/m5272c3_defconfig  | 3 ---
 arch/m68k/configs/m5275evb_defconfig | 3 ---
 arch/m68k/configs/m5307c3_defconfig  | 3 ---
 arch/m68k/configs/m5407c3_defconfig  | 3 ---
 7 files changed, 22 deletions(-)

diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 6d9ed2198170..041adcf6ecfc 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -27,9 +27,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 # CONFIG_UEVENT_HELPER is not set
@@ -85,7 +82,6 @@ CONFIG_ROMFS_FS=y
 CONFIG_ROMFS_BACKED_BY_BOTH=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/m68k/configs/m5208evb_defconfig b/arch/m68k/configs/m5208evb_defconfig
index 0ee3079f6ca9..31035a0b9247 100644
--- a/arch/m68k/configs/m5208evb_defconfig
+++ b/arch/m68k/configs/m5208evb_defconfig
@@ -21,9 +21,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/m68k/configs/m5249evb_defconfig b/arch/m68k/configs/m5249evb_defconfig
index f84f68c04065..5706d7a1daba 100644
--- a/arch/m68k/configs/m5249evb_defconfig
+++ b/arch/m68k/configs/m5249evb_defconfig
@@ -22,9 +22,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/m68k/configs/m5272c3_defconfig b/arch/m68k/configs/m5272c3_defconfig
index eca65020aae3..f02fe144f4ad 100644
--- a/arch/m68k/configs/m5272c3_defconfig
+++ b/arch/m68k/configs/m5272c3_defconfig
@@ -22,9 +22,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/m68k/configs/m5275evb_defconfig b/arch/m68k/configs/m5275evb_defconfig
index 9402c7a3e9c7..781f307ff330 100644
--- a/arch/m68k/configs/m5275evb_defconfig
+++ b/arch/m68k/configs/m5275evb_defconfig
@@ -22,9 +22,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/m68k/configs/m5307c3_defconfig b/arch/m68k/configs/m5307c3_defconfig
index bb8b0eb4bdfc..6eac482356ca 100644
--- a/arch/m68k/configs/m5307c3_defconfig
+++ b/arch/m68k/configs/m5307c3_defconfig
@@ -22,9 +22,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/m68k/configs/m5407c3_defconfig b/arch/m68k/configs/m5407c3_defconfig
index ce9ccf13c7c0..496dcccb1c18 100644
--- a/arch/m68k/configs/m5407c3_defconfig
+++ b/arch/m68k/configs/m5407c3_defconfig
@@ -23,9 +23,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
-- 
2.17.1

