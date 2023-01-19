Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D37F67305B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjASE37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASDm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:42:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF446D376
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k18so1119341pll.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tADwm89Gw7MGE41VA3P+RoXDG7EzxPQzvrjTbcPBP9M=;
        b=dapYXhKT5FyndeTczNL859WbBcWizNlJbh9DpcWLtxUgtOLj73xKfUsKBnNoI1vRAU
         WWAzaRhkUGgy+i5XKvcgo33JbIjnUk7AeikKq3dKOsa6OUWhcDedVJnPamj/miGDxZSs
         1v+0FAJ673xGFpN5eZG85PUsJ6VF0wk3n8TpnPYByVX2kZGupIXKDX7H70zhAunWZ/OH
         ll3rBFxVdifJrDAzb9dt9lVb5hDG3FJTRiQk5njsYahNHvvuDdRp7WbKH79OxT+v1SAK
         u3nV5W8XCpzegIV0r0UjD9AmQaAq851xBZgoey+fwtIDsoE7UsOkXLCMuwLIFnQ3usnB
         8Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tADwm89Gw7MGE41VA3P+RoXDG7EzxPQzvrjTbcPBP9M=;
        b=qg2xqAJQ9NOWndpG2RGhkUnhCyHaxpzGEdqadWhXW19eWOWJlW0aPds3rKnKWiQg46
         5iFdwaAA+zovDELoGu9ARo+NN6uNrpma2Muf30nyRzqXdKHkPeCrwmv1RZ3ptf27ydwl
         dQZUhxJUMzpIfDWSrVOM+LiGEMc9fYCiOmX+Boyl8lgISQSQEk+bjQRTAR/sf4GaSCY8
         Nr2kcy5x2f9oHh2smyhy2yz7TSKJlO3sJBQDONt9Lq58XtmNU1j2vN2LdugMsa3r1dkI
         WWd9vVBt7uZWGUEiP6SqGDPzNSI095WvrEqUEzXk4ItaNRTAD+2g8kV1MyBWPpF2mTDw
         /Bog==
X-Gm-Message-State: AFqh2ko2GvF8AYRx0TWICY5o+akM4VAEm4uuKNCtCZz/HrBmk3ZPjhpm
        lcJqXSjwc0rQJdv73DA0J0YXWQ==
X-Google-Smtp-Source: AMrXdXstRBZDywDfCAbI8z6KxCoyx1WFSjxph3DZedoj6AtU1vZKsc5JIUQghL8+EyRgu03FCOd29A==
X-Received: by 2002:a05:6a21:1690:b0:b8:e25f:e2a6 with SMTP id np16-20020a056a21169000b000b8e25fe2a6mr7509719pzb.57.1674099636710;
        Wed, 18 Jan 2023 19:40:36 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:36 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 07/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Wed, 18 Jan 2023 19:39:10 -0800
Message-Id: <20230119033918.44117-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..74eb977badb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1890,6 +1890,14 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun50i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/spi/spi-pensando-sr.c
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

