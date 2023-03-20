Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A86C1287
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCTNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:02:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8210EE;
        Mon, 20 Mar 2023 06:02:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so46404082edb.6;
        Mon, 20 Mar 2023 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679317321;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c2sQm27Vp/HhAftIFTylROdy7YRt+aXlwqBwwRN7xc=;
        b=Gw/kM9iK38FS85c7Bhsi2I3/0vb0G7m0AGdGUQ7ve5Chf9VXT1Xbx6EeFf/iBr1h4L
         5Sh6I4yk3Q9FX9mvphR/SGVkc21Tcjbwsj40Ws2+SflPwjB69XoMRWwlqwWGQRaqIHll
         vHI7+I1OTHDehSAGqEZOHUo5RRW79QN09+wAqvFm/AvO9zDe1QvWJse/EP5wDoCdEdJs
         z4OymjGG1SkCnWKCq69xEq0Mgoj10g/Yl4Nd2vvK7vrZljhgC4AgRnzCiv8aspFdYKGT
         FBlI1D/naH7UwEUJWDj/3wxzmA9oC3YsRxwhHS/h3/AwHcxFiXM5Ivc9wiwt1Nh3rxpP
         H7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317321;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c2sQm27Vp/HhAftIFTylROdy7YRt+aXlwqBwwRN7xc=;
        b=7jAwnAGz80vFxd1vwabyKKT74EnByFHrfRoD3hEHsivrpi7M67okzL76OJcrN3TYcn
         42WJJI8GWcTcU5JIjOdCwNFfcs9DqPrfOrSshfUhN4y1wmgg2xmjl3IAzmC3uJPe5IIT
         M+SBmihnJrPVfr7NIjSlefEZYgb811myMCuSxyXyU4lKS/Y8XniFPjyFp3y8qUZ61IQp
         tG5s1vWLa65Uw9NUuDztvVO5aU8uSIHHk9YMoR10Cd7J8uYrg4T3CcQdBAu18GqKUWBA
         3qcFZbXo1Q3yTMi6khrMlO1o4lBSwgmdVh8B1uzH0ZxniOH1bsQikzF6+V5ww9wMk92h
         /qJw==
X-Gm-Message-State: AO0yUKWB1VOSReqIv0gdgyKajUmvalejsQBGDvqAqbi3242K1ycByDYG
        CkoY7ZegpTLF1UaKkdiG/V4=
X-Google-Smtp-Source: AK7set+1rtX0rl0Ssjz/WjGKPyvlO4Ny2whG20GaytLyE+jjEr8JawHoWubHAJcBnhM95g55DgJXng==
X-Received: by 2002:a50:fe81:0:b0:4fb:5a36:1539 with SMTP id d1-20020a50fe81000000b004fb5a361539mr11117966edt.25.1679317321551;
        Mon, 20 Mar 2023 06:02:01 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:394b:6c53:31d8:7b18])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090648c200b008ea8effe947sm4411441ejt.225.2023.03.20.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:02:01 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ARM: spear: remove obsolete config MACH_SPEAR600
Date:   Mon, 20 Mar 2023 14:01:59 +0100
Message-Id: <20230320130159.32316-1-lukas.bulwahn@gmail.com>
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

ARM: spear: remove obsolete config MACH_SPEAR600

Since commit ddb902cc3459 ("ARM: centralize common multi-platform kconfig
options"), the config MACH_SPEAR600 has no effect. Remove this config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-spear/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 1add7ee49b63..7108ad628f8d 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -81,12 +81,6 @@ config ARCH_SPEAR6XX
 	help
 	  Supports for ARM's SPEAR6XX family
 
-config MACH_SPEAR600
-	def_bool y
-	depends on ARCH_SPEAR6XX
-	help
-	  Supports ST SPEAr600 boards configured via the device-tree
-
 config ARCH_SPEAR_AUTO
 	bool
 	depends on !ARCH_SPEAR13XX && !ARCH_SPEAR6XX
-- 
2.17.1

