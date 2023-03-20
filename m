Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FAA6C140E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCTNye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCTNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:54:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835BEAD3F;
        Mon, 20 Mar 2023 06:54:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so47090273edc.3;
        Mon, 20 Mar 2023 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679320461;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16y5d5Rt6zcSbbBqIK/cInxaZjo1u3aH/GTMRwIy6cY=;
        b=XTWoN8oaLXhZ2s+pzarkIGAfZKWYnGKd4KDknqEejQvH86AHLnixCMamYUMIsLfgbi
         fsFx0fDyV1OuE694lPVWqsxRbtK9I4o0oZrO5Z36uiRcmR/9tSYJQ1kr7uMj99Ow1Qwp
         x2QHOL/NZob1jJr50lje02fGt0u4MBcYltQxBp/ZqJFLWvkVOgHo+OXoJve9Rcz9k5Qd
         AyvqJwBXMDRK8MZWyL3ZWE9acwiTRwoR6VNVwInkTZ0TyOMylrrTjMzNf39vNgWmJDRc
         vaNIPp28mM12fcGm0kBleLkL/6j6XDMP+Zr5yA+H12Sn/+O2b13E2A+NK755HpXeyAme
         1xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679320461;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16y5d5Rt6zcSbbBqIK/cInxaZjo1u3aH/GTMRwIy6cY=;
        b=kYjX6uTgrr7xP73NmdYcG4tGQ7ijeFEr31flc4ia4lKShYUZIlNgeCacUuBl3CjyY7
         NdR1JyCFJoMZyWHnN4F6zSMHdlhIqiqfUWDvb79ATu++8gDGQe0+BixUz3gdzJPogwHo
         OBY4euiXtkmPJmxoTdNy50ym3BKYCKnuoN0UV/rMQ2tjfE4KL5ykmFT8ILiThcOOyg3I
         iVtmZTq+gC/6JgMkmkKELIlksg32GKK6CDQ1t/8P8Es4SLIiytwzx2fXZEKpGHGchCEw
         OQUfTdaPw3En8C+ps7y2j4d9fysFARZKGSsr9TvdwCS7eoYnQsE6mujoc7Z8Pze8w6JA
         QS6Q==
X-Gm-Message-State: AO0yUKVb1D3MRrM1OkL3eJGrjnRUthYyiA3gGxPlBNhh25jxYO9yylq1
        qCiGCKywIsx1E8+CvjLeq/fMK0chiDdhkQ==
X-Google-Smtp-Source: AK7set8LY7zhCmW4QIJuiybizB/4Y4m1b5cdh1HenN6WmOpQ1ZMufaYnRbJMHZ/ARfy1CIP2js768A==
X-Received: by 2002:a50:ff1a:0:b0:4fd:215e:b691 with SMTP id a26-20020a50ff1a000000b004fd215eb691mr12409939edu.4.1679320460965;
        Mon, 20 Mar 2023 06:54:20 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:394b:6c53:31d8:7b18])
        by smtp.gmail.com with ESMTPSA id i15-20020a50d74f000000b004fb1a83cb00sm4964839edj.75.2023.03.20.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:54:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] m68k: Kconfig.machine: remove obsolete configs ROMBASE and ROMSIZE
Date:   Mon, 20 Mar 2023 14:54:18 +0100
Message-Id: <20230320135418.2055-1-lukas.bulwahn@gmail.com>
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

The configs ROMBASE and ROMSIZE were used in arch/m68k/68360/head-ram.S,
which was removed with commit a3595962d824 ("m68knommu: remove obsolete
68360 support").

Remove the obsolete configs ROMBASE and ROMSIZE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/m68k/Kconfig.machine | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index e2f961208f18..255d50574065 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -439,15 +439,6 @@ config ROM
 	  that can be stored in flash, with possibly the text, and data
 	  regions being copied out to RAM at startup.
 
-config ROMBASE
-	hex "Address of the base of ROM device"
-	default "0"
-	depends on ROM
-	help
-	  Define the address that the ROM region starts at. Some platforms
-	  use this to set their chip select region accordingly for the boot
-	  device.
-
 config ROMVEC
 	hex "Address of the base of the ROM vectors"
 	default "0"
@@ -465,14 +456,6 @@ config ROMSTART
 	  Define the start address of the system image in ROM. Commonly this
 	  is strait after the ROM vectors.
 
-config ROMSIZE
-	hex "Size of the ROM device"
-	default "0x100000"
-	depends on ROM
-	help
-	  Size of the ROM device. On some platforms this is used to setup
-	  the chip select that controls the boot ROM device.
-
 choice
 	prompt "Kernel executes from"
 	help
-- 
2.17.1

