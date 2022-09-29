Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA25EF326
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiI2KPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiI2KOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E88275E7;
        Thu, 29 Sep 2022 03:14:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x15so909198wrv.1;
        Thu, 29 Sep 2022 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H/fjjauboM76AsKEJYN+l5mLtFMVtLVkrmfPN6VbpaE=;
        b=KkDI0lFljwhEBtPZ5YgOj5zul4ksZb6EPM03zfuGM0XXNNv5d4e4ZSCDs+AatqLGd5
         tT4CMHTpv28JLCvQHisqJqqAd0NdKRucuCWAJA33hnZS0OoDUeIOhWCpfWY8+oaPZwtg
         mR4vrIklX3FY0IkQOpjh+IRdKJEImtAKjLkZhmJ9lWjBUdRsIbgQqb/vJIVGLBtYMuBn
         3gUJINaH7Q1ZMElZRroQYHmltCyXjm4v193dRBJH8uVoeFE10JjIH+e/5fFKkjgvoKv0
         +VSewndZ/KaiG7p0kTc124EtAbXzmFYbYyka2hn69QSTeZ9OTCfG8EhNCBoDDkU0sAgA
         2anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H/fjjauboM76AsKEJYN+l5mLtFMVtLVkrmfPN6VbpaE=;
        b=5z8BaEw1dnKAKsbIN7Ax6eV2fi8fAbqRlT4Ep+aDvJa5KtS+gqlIf3FEcUbtdnLRpH
         tdne3Xh6e/4KDYB76f3dcxmeN18uYmjcaIMsW9BZjbVXwucqOVuSS1Xi9JnSElQpQUVj
         1ksa6f7utaeypWFYPHj7fCzwGRq09ADtr6o0kEpdY8v/l7136UFxuVAPy+VcYBjOoBOR
         x/GuYBoU2lNE8wJTUxzxGQVNhlugY5dffSyflchykBd9gUTVrQP5niudK8qEDDQXeE/r
         WLSdlqnp/t/H56OuqCbK2p69I7iwMv0eQe/l5rdiJSSRgihh+BrLcargBrqxCBubC8+a
         qpBg==
X-Gm-Message-State: ACrzQf125NT1o7scq13UvIvdIsycQzQyRscyrUfVXTuje2miyYtzXskf
        SAlTT1RWUwtcxN6sKkgVCXOksk7OZPY=
X-Google-Smtp-Source: AMsMyM7+ToFJI8DyFO+EjzdRBkK7+s9M9T9IdC+QRHCC0wtDPw+aWHrUzcUutNx9bCbxNvgpTnnf1A==
X-Received: by 2002:a05:6000:1acb:b0:22a:d11b:5eb9 with SMTP id i11-20020a0560001acb00b0022ad11b5eb9mr1664198wry.492.1664446481325;
        Thu, 29 Sep 2022 03:14:41 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id a7-20020adfe5c7000000b0022cd6e852a2sm1274122wrn.45.2022.09.29.03.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hexagon: update config files
Date:   Thu, 29 Sep 2022 12:14:37 +0200
Message-Id: <20220929101437.31902-1-lukas.bulwahn@gmail.com>
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
 arch/hexagon/configs/comet_defconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index 9b2b1cc0794a..59e3a128b897 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
-CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
@@ -25,9 +24,6 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_PHYLIB=y
-CONFIG_NET_ETHERNET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -40,14 +36,12 @@ CONFIG_SPI_DEBUG=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_QUOTA=y
@@ -63,10 +57,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CRYPTO_MD5=y
-- 
2.17.1

