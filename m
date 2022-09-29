Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F25EF339
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiI2KQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiI2KPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:15:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB7121E44;
        Thu, 29 Sep 2022 03:15:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso2928990wmk.2;
        Thu, 29 Sep 2022 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lc6s8nTaNgkoD4GXAuKRr/e01vV82I0xCYG4ndZR8mE=;
        b=VdBznro6tQvY7Ra91sjpFkGp+23+ltMc0M1+HxUAvmurxDmHkN7xXAyapDHCQp2bYo
         IcOHjVcB8XjCdHPEr0405NHKsQYIhAy6v715IoylVtkLVAibALifEmoyafDO2Q3t6xFw
         Kwxpfc32BXs8sFIvB9JYqONOMyQKwWJ4SwQD98zGWDLyuLSi3zYSu4h2LIa0fLGBWfHN
         rq2n46ZMetA5bVrlMAIJvCqpESIEO4qs0rqf3HqAzJvg6o1HvfKu3CN4wm5o0R8soN5e
         1PMLSss+sDDLwNDP34n8rROTB0FJFJhXW2Cm5917WHeJnQ9AvzgKH+v+TpaIzvlYW2rp
         YOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lc6s8nTaNgkoD4GXAuKRr/e01vV82I0xCYG4ndZR8mE=;
        b=joTvENgOhCxoEHqWNdhu9+4Hl+zMksnjbSzVtn03XtKrLB/LnwQNgVHDRlXlTYdsJa
         EQobLwNyu8XP3iUzrNE1Fw1dz7PXqUtnmc+i59QQgIMZ/MLmPZzGdFe7dEhofF9qviEM
         C23vFddvWlTGSJBDg03jO9rYEZHCiBF/dhuYsIlEKbJ2h7vmkfQzA8HUvLfH9dQH1LSE
         OZt5k1g/Ayptbsiut3jFF23TwbcTf9zYFoDHUoeWAvXdOaZdhuw1BaHdAvvzIGiMT4pZ
         nF+pxpKv3DuVgt9LpPEpnGXjHvg2PDbiG/czBgCuuqx4DKwzV8JgqGwJMyaJlCbilCuS
         oGsQ==
X-Gm-Message-State: ACrzQf1vf+zfq7n7985Bc2LfXll0ysasv22lPXPxMdzBLJ7vg1VuGOiN
        d7Hi9zRK0qeVs2GiVtnMwp4l2wbGrzGh9Q==
X-Google-Smtp-Source: AMsMyM7FpPxLU4VpzfSVtrPr1gZyMHNeT29IKj9PKpbnj4eER3yeCC1DHIVY0fz/w9FO3cQ4tORCvA==
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id r5-20020a05600c320500b003b33813ae3fmr1777401wmp.158.1664446502451;
        Thu, 29 Sep 2022 03:15:02 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id m6-20020adfe946000000b0022af63bb6f2sm4163241wrn.113.2022.09.29.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:15:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] openrisc: update config files
Date:   Thu, 29 Sep 2022 12:14:58 +0200
Message-Id: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
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
 arch/openrisc/configs/or1ksim_defconfig    | 5 -----
 arch/openrisc/configs/simple_smp_defconfig | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 6e1e004047c7..af1164807206 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -19,9 +19,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -34,7 +31,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
-CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_ETHOC=y
 CONFIG_MICREL_PHY=y
@@ -52,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index ff49d868e040..84ca3203af9c 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -27,9 +27,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -60,5 +57,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_XZ_DEC=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_RCU_TRACE is not set
-- 
2.17.1

