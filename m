Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49E6BFFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCSHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCSHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:49:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738917CD9;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y2so9317181pjg.3;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679212151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v05rQQaGlo1pyl376I/VtsiDWSss2IkaTyB0UDJtjm0=;
        b=ciLgT5fY5cTZIJLgLAwox4Aa/6J1AK6tg44G4ZB0dGIjqjYFMKBK5Bk4beuTI0gyC0
         79gOIRQ5fU2fELyZ9bfu1K6eGx99f+TX2eYafwWCtl/jlcP67NR7ApMZkPXkYpKjh5P5
         M9JXdZtlU/FrQz2LJWxvXMDwzshLnN/jWzwT3Wu24sx0aq53n854TGo1hA3Bh53x3Ytd
         t2q4ItydT4gQX0rjB65C21LDpkBMRPG2vum4JAqBClXGVKoU3uh4Ikxbe2ufYZpVApYV
         utTZbY7ULSmQNR59uDTjY53KSKDkxNh9HPWHURfQrbm5W0pGlYtQ0GbmDa32igY4dSYk
         zGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679212151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v05rQQaGlo1pyl376I/VtsiDWSss2IkaTyB0UDJtjm0=;
        b=bpd6j2/UbhCM40mFIqBHv/rpoLQ3NQhXUx3L3dwZO959v+CorvK/kOTUDjyuN+0C8h
         FCDx3FOawalrkup13AR6d1rgwukZ/sx9LT0BgvnW2p44H4BU3yVhnDvMA25yrZsq9/Jw
         eKZ6QqclIa0BHtbOUSJVHKpwAEBWQVDs4nT6sLVlUNUxv6GJlWbykniXF7sCtd/UDKEv
         gTYrIijTrYGT6j8W1xqazZOaWSrjrWDeoeZdrhusm4HWl9zGOj4AAFRq6yN/DyAwwc5j
         85DdOHsaP41+bLEpUvRYIqjGLISWH5uuiEJjmOPwopF2w8ogWwUPbbKt5VoinRKUUsdW
         f31g==
X-Gm-Message-State: AO0yUKW7va6u8fJRLdunyuthKqKZgw9tpSs7TVEA00FxIwyThhd+lIJn
        P7uRgwjmLCqnlAY7vwTNAoQ=
X-Google-Smtp-Source: AK7set9Tg0zxbyUAYIOpLktcG+E6CTcXT48PPu0KmZnyA413iHs4uzzxBhLAT8t4aQgI8NimPdFm2g==
X-Received: by 2002:a05:6a20:1bdf:b0:d9:4c19:fe69 with SMTP id cv31-20020a056a201bdf00b000d94c19fe69mr588049pzb.25.1679212151098;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b0050bf6f246edsm4062983pgd.3.2023.03.19.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:49:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3F9B210667A; Sun, 19 Mar 2023 14:49:06 +0700 (WIB)
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
Subject: [PATCH 3/3] Documentation: leds: MT6370: Use bullet lists for timing variables
Date:   Sun, 19 Mar 2023 14:49:03 +0700
Message-Id: <20230319074903.13075-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230319074903.13075-1-bagasdotme@gmail.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=bagasdotme@gmail.com; h=from:subject; bh=Ho6JS/QsaewELgY3oj9F2/RDEMc+m0oRO+h4IFBGt1I=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCli+/Idutvs9ILKXzTH+c2Sb2KXPrQkNupbx4KdPBv3H Zz1j/9IRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbiHcnwz8D8CPfLs7vZTl+x 2By96GB8l9jLuGInr+LA951T8q/89mFkeKh1tlf6//VFFp2Lly17tv7be4YjnRMlO95l7/o8mf2 8PC8A
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

The timing description contains list of timing pattern variables, but it
uses code block without indentation instead. Switch to bullet list as it
is better fit for this purpose.

While at it, substitute "load" for "duty" because the variables control
timing for current load into the device.

Link: https://lore.kernel.org/oe-kbuild-all/202303182310.tB1mUzU7-lkp@intel.com/
Fixes: 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/leds/leds-mt6370-rgb.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/leds/leds-mt6370-rgb.rst b/Documentation/leds/leds-mt6370-rgb.rst
index ea782797a06df0..152a2e5921724b 100644
--- a/Documentation/leds/leds-mt6370-rgb.rst
+++ b/Documentation/leds/leds-mt6370-rgb.rst
@@ -45,17 +45,17 @@ Pattern diagram::
           +----------------------------------============------------> Time
           < Tr1><Tr2><   Ton    ><Tf1><Tf2 ><  Toff    >< Tr1><Tr2>
 
-Timing description::
+Timing description:
 
-Tr1:    First rising time for duty 0 to 30%.
-Tr2:    Second rising time for duty 31% to 100%.
-Ton:    On time for duty 100%.
-Tf1:    First falling time for duty 100% to 31%.
-Tf2:    Second falling time for duty 30% to 0%.
-Toff:   Off time for duty 0%.
+  * Tr1:    First rising time for 0% - 30% load.
+  * Tr2:    Second rising time for 31% - 100% load.
+  * Ton:    On time for 100% load.
+  * Tf1:    First falling time for 100% - 31% load.
+  * Tf2:    Second falling time for 30% to 0% load.
+  * Toff:   Off time for 0% load.
 
-Tr1/Tr2/Tf1/Tf2/Ton: 125ms to 3125ms, 200ms per step.
-Toff: 250ms to 6250ms, 400ms per step.
+  * Tr1/Tr2/Tf1/Tf2/Ton: 125ms to 3125ms, 200ms per step.
+  * Toff: 250ms to 6250ms, 400ms per step.
 
 Pattern example::
 
-- 
An old man doll... just what I always wanted! - Clara

