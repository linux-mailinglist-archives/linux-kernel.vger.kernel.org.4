Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398B5EF337
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiI2KPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiI2KPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:15:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA2FAC5A;
        Thu, 29 Sep 2022 03:15:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso2933197wma.1;
        Thu, 29 Sep 2022 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oFhFsnv2zFbHavDk5ukJ0f+cEtw334EZ3u9Befhxfgs=;
        b=nufnTRf6lPAcHyZM8cN9lE5yvSoo04rc/tpPJEI+waB6/5y9fy3scugiPC+U2Cn8is
         i+Nfu0zm/JupHrcLfkbK3W/ad64Lz7jcZ4DbhMf8U1WPxarVKVqaEf2AWCXHFZfzzTii
         InsbR3D4zoOP49z7Tr6buGSKxSUdOvI/S79ZDJ5IGxOMYekWizFPv8nPdSBao56aR+gT
         TJ4l+fJcmXaGsLnbumksiHTl+vDB4jqjizt+72skO/3F+JxWKZreg1A+3S6dmjFZI6Ke
         2BFUK8HJiOEVxsyNaUbgENkEAePLqFb/xhlfeM+XcUj1s4c0zxEoyhrh8XLGLjIYWQH1
         R12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oFhFsnv2zFbHavDk5ukJ0f+cEtw334EZ3u9Befhxfgs=;
        b=DjcjlLPaw7lkSX3aOItOIpbj8b+WPar6RW0+Vi1j64afjcoMyh1J16L3kF8g9Rv9jw
         Bd0H2ajJJrRuHvr/7a+d3UBOup3bWmLn4xEPmBjQGcJpCL74LVa9h1Yemu1IFRnyGHo5
         vL7tLpCv8ll7zJjgk5EFNjq9e2hJTtgBBIaU4KiEgzkHLfHp77oJJgeREuaIP10Q4D3P
         Q7XKAr4O8bwSF5K28nCvC9mYPniRhCefM9+SG2IEgH9fS2lI56MeA5aycYp8rNbEF2WR
         yeBI7btYiD/yBPB0Rofj/ohiAv5fntK0wrTp9NB5G6vZkBddtq7EzNGRmmmdu2/Id5Za
         WZXw==
X-Gm-Message-State: ACrzQf32qkK5G2pgmjLOltCaMFfnPoyyUbqEIqAtw+YcT49mhqLpIL6V
        dncbMXfW32fLTaE6n1275LyfG8A0gbA=
X-Google-Smtp-Source: AMsMyM57/sCbTU0OGubbQQa2Lp+0K2Ryy/WBkAAm2hYRkrNbxZBpv34hopRYrL6u2chDOy6cqL9w8Q==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id w12-20020a05600c474c00b003b4cbca5677mr1661579wmo.76.1664446498659;
        Thu, 29 Sep 2022 03:14:58 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id ca6-20020a056000088600b0022a293ab1e9sm6523543wrb.11.2022.09.29.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] nios2: update config files
Date:   Thu, 29 Sep 2022 12:14:54 +0200
Message-Id: <20220929101454.32333-1-lukas.bulwahn@gmail.com>
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
 arch/nios2/configs/10m50_defconfig | 3 ---
 arch/nios2/configs/3c120_defconfig | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
index 91c3fce4dc7f..e7ed52d55c94 100644
--- a/arch/nios2/configs/10m50_defconfig
+++ b/arch/nios2/configs/10m50_defconfig
@@ -29,9 +29,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
diff --git a/arch/nios2/configs/3c120_defconfig b/arch/nios2/configs/3c120_defconfig
index c42ad7e162a3..fa15db0c9ae4 100644
--- a/arch/nios2/configs/3c120_defconfig
+++ b/arch/nios2/configs/3c120_defconfig
@@ -31,9 +31,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
-- 
2.17.1

