Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B569943F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBPMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjBPMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:25:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F92CFD7;
        Thu, 16 Feb 2023 04:25:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e12so1849606plh.6;
        Thu, 16 Feb 2023 04:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE7WxnAiIB7i2KDtpHqG2refvq1iHi/wQrOL9j6i0yk=;
        b=QfHdsO9CHPLRt+AgAY/jYgiWxy8Hl5uOAkVSHXo2QyUIV/hw+BnYYGFLEKFCwj+pCd
         80SLOOxz5oNpIZ52Tvm4edbNWQUEU3Lb0Rq3eZcBpArguzKWa0yYUBr2BENRJvFMWGM3
         QSte7j3/Z+nU3uGcZFiIaGB9HXCZxgs2BZp0WJgKaZ2abNMziwgq/Q2FGC5CclEsGfSl
         RsHuQc5ldLjijn344nzdQHZBj66gLS8mc6UTOHc9ri2+gqs2M3BMM/luYz3n2AXDPuJ4
         7f5Ha5J1pEAfZcmH5PtqYofp+78w8vG6aUQIJ4DTvH5/K35xs7WkKr2NPAipCVIGzamX
         OxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE7WxnAiIB7i2KDtpHqG2refvq1iHi/wQrOL9j6i0yk=;
        b=tvFubqhCfHlgISMMhh0p6BR6MFFIf3bc8kjFuvqaB/1cKB6KlV7hXSY8eoIh/mU967
         vPllcamtQp17P121GrEZ60sJP+/TlqX04s0WX5GZPjzH/rb16aSBEYvk5eQB23cB7ffd
         bwv12cA2YjZRdVikshYC/o8lQHd3AFigEayN5YkC2fesKMpyFmuaSSfqV+goTJn5HaHk
         +pr2DfI3Y3M5IP48dcf71ioAWLrcw39zwhrsWEn/F78EPsWyP4+eij/OjztGqz1DW2wX
         q1YfgqL4BBpzPQzrsXTlx6YvS8//kqIWm+um2B+nqzCYLgHz3v+5PfurFKI+uiG9W9P/
         DlEQ==
X-Gm-Message-State: AO0yUKX1Dk8jtx3F248t4Y7manJBBtDktM34L8cRGT4ndmFpGO/HsB5u
        S70SfodahJ4XCHIFGcZlqQY=
X-Google-Smtp-Source: AK7set9OEsRZnxHUomaKjKN7S84aMnUYsPCDdBCX+spqtR9R2KY3XbY9Kg+GOuR24bwxGBnULyyOhA==
X-Received: by 2002:a05:6a20:3b9b:b0:c7:3aa1:d528 with SMTP id b27-20020a056a203b9b00b000c73aa1d528mr773706pzh.37.1676550314089;
        Thu, 16 Feb 2023 04:25:14 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b005a909290425sm1224055pfn.172.2023.02.16.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:25:13 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v2 1/5] apple-gmux: use first bit to check switch state
Date:   Thu, 16 Feb 2023 23:23:39 +1100
Message-Id: <20230216122342.5918-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216122342.5918-1-orlandoch.dev@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On T2 Macs with MMIO gmux, when GMUX_PORT_SWITCH_DISPLAY is read, it can
have values of 2, 3, 4, and 5. Odd values correspond to the discrete gpu,
and even values correspond to the integrated gpu. The current logic is
that only 2 corresponds to IGD, but this doesn't work for T2 Macs.
Instead, check the first bit to determine the connected gpu.

As T2 Macs with gmux only can switch the internal display, it is
untested if this change (or a similar change) would be applicable
to GMUX_PORT_SWITCH_DDC and GMUX_PORT_SWITCH_EXTERNAL.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: no change
 drivers/platform/x86/apple-gmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9333f82cfa8a..ec99e05e532c 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -346,10 +346,10 @@ static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
 	else
 		gmux_data->switch_state_ddc = VGA_SWITCHEROO_DIS;
 
-	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) == 2)
-		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
-	else
+	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) & 1)
 		gmux_data->switch_state_display = VGA_SWITCHEROO_DIS;
+	else
+		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
 
 	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL) == 2)
 		gmux_data->switch_state_external = VGA_SWITCHEROO_IGD;
-- 
2.39.1

