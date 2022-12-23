Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09194654CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiLWHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:47:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94430F46;
        Thu, 22 Dec 2022 23:47:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v23so4275136pju.3;
        Thu, 22 Dec 2022 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YR55G9jjoRMMPsmodTNiLbx+TyjEdvtvdLYurZPfaN8=;
        b=o2QV5EjfyGwQymBw3MiEVEiXoA9BcDha8F88P5QvkSg0GlCM2Y3uo0JzqLAhVB2s+O
         5qOuTNMEdk8y8JioagUG7IRQoJhHf8OrwSSObO+dEW6uLf2W1Dy364CD10Zva7bZ7XGR
         Epam6lhOQuTDExs/R8NSV4MBwgvfwklMcu+CeR+8fNiQWlKQ/ndaEM4beM402UmSklbj
         u+KloBT+B8xQ3MqHzzQjZjc265cNLsD7Ra44FsJY9KX0oibk++Rx8yFjfqYR7QercVZv
         ATEfWNl6c6SK2C/t/azCvRA+uM+zcGMSw34/HXFIxml0c8uTPLw8LjSq4F8+y1dBUFCZ
         I1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YR55G9jjoRMMPsmodTNiLbx+TyjEdvtvdLYurZPfaN8=;
        b=EeYcBP1Z1rQCkoblkAFa9lZ0I6QcPTChDs/xmSDM7xEoVlJJbcRoM/c8EGPycYrg3r
         /LYHj+8lCsriqjA6X/EOxvM4k95kTrTkTPvPMzo2ptE7OLUViplEqixLHBebrm3b5fTC
         W18qQvlTFTLVC6xknxye6LGfcGxSFqrr0sTXKTh8u3F4QIBoBi3rGx4zAvGjQstVvJFC
         lhZ2/r3jgG237+UaeOlTc+5oOkVJoyP6KR/71xkdJYYrGgJwUnLlzlNBFBq5CFaoRzmy
         RsqOPYn/caDdQupuPYzp21vB9XjkGgKyZuOjtO7rtluxz6kNyEZL6zV5AXQwHyreSpad
         cLFw==
X-Gm-Message-State: AFqh2kpY9udMJvYvbf00IZMXhP9qPQ/5Xg1bjN0U650iGxa+stdWHwMH
        TY7am5Y96wwd/8F0Xgq76OouAgqInrDkkM35
X-Google-Smtp-Source: AMrXdXtL0LpOWA6q8EssuMIA2u9mczls2uCvJtiRIEW/JUe3R3Bcafg4y8eUESEbyyGQJw8FXA++Cg==
X-Received: by 2002:a17:90a:ce8d:b0:219:34cb:476c with SMTP id g13-20020a17090ace8d00b0021934cb476cmr9682964pju.9.1671781651605;
        Thu, 22 Dec 2022 23:47:31 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y15-20020a17090ad70f00b00218daa55e5fsm1699552pju.12.2022.12.22.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 23:47:31 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Rob Herring <robh@kernel.org>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] input: raspberrypi-ts: Fix refcount leak in rpi_ts_probe
Date:   Fri, 23 Dec 2022 11:46:53 +0400
Message-Id: <20221223074657.810346-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rpi_firmware_get() take reference, we need to release it in error paths
as well. Use devm_rpi_firmware_get() helper to handling the resources.
Also remove the existing rpi_firmware_put().

Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
Fixes: 3b8ddff780b7 ("input: raspberrypi-ts: Release firmware handle when not needed")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- use devm_rpi_firmware_get().
- remove rpi_firmware_put().
---
 drivers/input/touchscreen/raspberrypi-ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index 5000f5fd9ec3..45c575df994e 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -134,7 +134,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(fw_node);
+	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
 	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
@@ -160,7 +160,6 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	touchbuf = (u32)ts->fw_regs_phys;
 	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
 				      &touchbuf, sizeof(touchbuf));
-	rpi_firmware_put(fw);
 	if (error || touchbuf != 0) {
 		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
 		return error;
-- 
2.25.1

