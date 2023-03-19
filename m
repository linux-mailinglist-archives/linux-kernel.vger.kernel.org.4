Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE386BFFD9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCSHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCSHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:49:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD317CDE;
        Sun, 19 Mar 2023 00:49:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id le6so9470774plb.12;
        Sun, 19 Mar 2023 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679212152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZrlTZviMosYAdumBp1C/rmRwTbY5dbobt3fhT7ZNq4=;
        b=X+pg4c0mOXxK6FOIAMJ5fIB0gUD19QJRsJpkZldO9Lvj0mN7+oG+QuoGQFkwZzu0AE
         z6Pk40GIptJ47b76evr2q89mo1zasK44X2GEeyHo/DjnL/v+es7GMBIRMFNbiDLLd5RU
         TY6p58uv1vcDHdR+I5de5R33053JXpFEKFpv4vRwnBs7NDWQVW0X0sBcAxfT/OlLvEaU
         TqwT0dBWYoCuB2P0M9Vi69eyt0dMCTjS81umiOiHeZn8JJgfe39PbDe1+rmuuq4I0cjj
         RupnZ8ukauNxGZ69lbokRo0zrWGdqvYlKa72Js7wLe+wHfUB6KiqaT16y92CpMf7upfL
         /JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679212152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZrlTZviMosYAdumBp1C/rmRwTbY5dbobt3fhT7ZNq4=;
        b=18D1EzuRr++BFuAp1WbtzcYQ+tD2ErrqoopK3sy+UHgkgFu4HjvmHKDfR02hUl8M22
         bKM1YWe5ElThCbHZgHpcsZfEcLTaYFEKyqBsbUWQfWjoMfOr0eoOtiMKBh9RWioUbpje
         XWpmRSBx3oGmUZSk886BGXSK1G4QHnW3XPk4pRh3y1uwAYxiq0xs26o4goel9hVpnUn+
         yz25+jPkYYMc+a89O1kK0baTD1Ycv0UvU0a3OmZHNsqHfsv7Zuzj4JtdI9UuzF8f/znk
         PzwY/QpZ8j6XfAkpucbWHyEGtLI3vD7Q1V6NKWaa3iq2t7qaeKBLaSDfAXnWJSFw0RV8
         2eYA==
X-Gm-Message-State: AO0yUKUSKXwi6B/GhaFc+p9xot4/GgPlaCvP1dQ4/EeCBIVBFpkurkgH
        TX79frK8dCz+E1OerJWTUps=
X-Google-Smtp-Source: AK7set+WLYRvVX9PN/cMN/rjPLFOr21daQFrwvEIa9L6A5+kHYsJszqEgnUoW+fDdfm5HpJYypHBZQ==
X-Received: by 2002:a05:6a20:6a20:b0:d5:4ae5:b01c with SMTP id p32-20020a056a206a2000b000d54ae5b01cmr16518677pzk.8.1679212151856;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b00592eb6f239fsm4176967pfm.40.2023.03.19.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:49:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1EE99103593; Sun, 19 Mar 2023 14:49:06 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] Documentation: leds: MT6370: Properly wrap hw_pattern chart
Date:   Sun, 19 Mar 2023 14:49:02 +0700
Message-Id: <20230319074903.13075-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230319074903.13075-1-bagasdotme@gmail.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990; i=bagasdotme@gmail.com; h=from:subject; bh=swN8Gr8RwqV1p16l7dEo74K7Y92x/GvHgKTiCdSiseE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCli+/Kbpi1xN1Z88Inlx8HfUsJHkudlrbK7vitb+2pJV XYft0dSRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbCJcLIsIVb6NmFG2x9BVN1 ZX3ez9xnnVFy+Za290H+CN5ZzxJ+hTIynNw+86Ax40apCc7njojf3GlXniBcG33do7HBtu7FybJ dbAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern diagram (chart) of /sys/class/leds/<led>/hw_pattern is
wrapped in literal code block. However, the block indentation is
interrupted by Icurr axis label, hence below warnings:

Documentation/leds/leds-mt6370-rgb.rst:39: WARNING: Literal block ends without a blank line; unexpected unindent.
Documentation/leds/leds-mt6370-rgb.rst:41: WARNING: Line block ends without a blank line.
Documentation/leds/leds-mt6370-rgb.rst:46: WARNING: Unexpected indentation.
Documentation/leds/leds-mt6370-rgb.rst:44: WARNING: Inline substitution_reference start-string without end-string.

Fix the chart indentation by adding 4 more spaces so that the axis label
is in the code block.

Link: https://lore.kernel.org/oe-kbuild-all/202303182310.tB1mUzU7-lkp@intel.com/
Fixes: 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/leds/leds-mt6370-rgb.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/leds/leds-mt6370-rgb.rst b/Documentation/leds/leds-mt6370-rgb.rst
index abf739e448428e..ea782797a06df0 100644
--- a/Documentation/leds/leds-mt6370-rgb.rst
+++ b/Documentation/leds/leds-mt6370-rgb.rst
@@ -31,19 +31,19 @@ depending on the current brightness setting.
 
 Pattern diagram::
 
-     "0 Tr1 0 Tr2 0 Tf1 0 Tf2 0 Ton 0 Toff" --> '0' for dummy brightness code
+         "0 Tr1 0 Tr2 0 Tf1 0 Tf2 0 Ton 0 Toff" --> '0' for dummy brightness code
 
-      ^
-      |           ============
-      |          /            \                                /
-Icurr |         /              \                              /
-      |        /                \                            /
-      |       /                  \                          /   .....repeat
-      |      /                    \                        /
-      |   ---                      ---                  ---
-      |---                            ---            ---
-      +----------------------------------============------------> Time
-       < Tr1><Tr2><   Ton    ><Tf1><Tf2 ><  Toff    >< Tr1><Tr2>
+          ^
+          |           ============
+          |          /            \                                /
+    Icurr |         /              \                              /
+          |        /                \                            /
+          |       /                  \                          /   .....repeat
+          |      /                    \                        /
+          |   ---                      ---                  ---
+          |---                            ---            ---
+          +----------------------------------============------------> Time
+          < Tr1><Tr2><   Ton    ><Tf1><Tf2 ><  Toff    >< Tr1><Tr2>
 
 Timing description::
 
-- 
An old man doll... just what I always wanted! - Clara

