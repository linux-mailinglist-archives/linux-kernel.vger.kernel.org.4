Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9166B0848
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCHNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:16:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2DCA244;
        Wed,  8 Mar 2023 05:13:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so2284149pjh.0;
        Wed, 08 Mar 2023 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfh0KN1ri+OTygQJZXMIKBpXa0FBqGE1v3ae9U34K4M=;
        b=QClyTe2I/hwZ33JYUtvcFvlYFCxqH6gGxddkb6Mw9ZaqpgFxBKcorhq8UJPzxRRUCi
         uTx2PAKgI7bZrF/lTreDTxx7yWj9FiMv/lcDOtBO4kTVWb/ldkZzPi74PN0iCcPzjL0u
         6IfzT1yMB1KmotWpnR50Ed/zp68QUvjkRw8+Z8BwLKfNv1LrRvjObQb5B0Mbo4meFOK8
         pcECmBt83D7aT32ermDtuFvqSky7Wq8yWGobn3Y0xiIaiPUEjNFzDHO0el2pOBUSYoSH
         Mv2TTNWc/3XsfxfV4UkiSb0e0ybIrlSQyVaF3kOWv1Hfuo0AKLaOHX+E5g3t/m8T/NGm
         OzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pfh0KN1ri+OTygQJZXMIKBpXa0FBqGE1v3ae9U34K4M=;
        b=lllP3brH++MGDGz/q2ahQweQz/5mCOcwi1g6kST1mZ4h2PdyAahnpbZyZAFrjiKKQd
         EN1n7m4jc4vAU8KcIcM1lgwj5vmFs65QbgeUN6nPy06Y1mMRJMew0xNSYXHILqdOUQ+N
         /Mgf7Bm/WzaMxwTFcEz/LInZ3BBKPhHGrEzh1L2/MjixAmzKSNlzVvVIvjy3keWNMh1c
         7ty2OXncaS/OEzDzHt54JxIKzURWI5oPtLyfuHgyPBrXSK+Hy6YQjxuiW7+Ou60JIpb1
         kkj2On0cYZZFMdDPbwe7cEi/IrvWuXWOWA9LkYs+Aw1B4bX1A9Qgonda0tTE3fYH6e6U
         mGtw==
X-Gm-Message-State: AO0yUKVtxHp8cBSRsIKZfE60t7bqyul7u5gRRMvRqOaOn8NFtJndETue
        S17cFb8vxBn45QC/Z0lLf7BfCIKroqY/TQ==
X-Google-Smtp-Source: AK7set8Bt/ATEsVpbspnSTejTRLMfyJ07DawX/2uXj17i/3EVlhdgHKR+73y098HVsKX1AP/1lQniw==
X-Received: by 2002:a05:6a20:8e05:b0:cb:c2a8:2c48 with SMTP id y5-20020a056a208e0500b000cbc2a82c48mr22265955pzj.17.1678281201203;
        Wed, 08 Mar 2023 05:13:21 -0800 (PST)
Received: from localhost.localdomain (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id i15-20020aa78b4f000000b0061ddff8c53dsm931038pfd.151.2023.03.08.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:13:20 -0800 (PST)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     mkorpershoek@baylibre.com, phoenix@emc.com.tw,
        josh.chen@emc.com.tw, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 RESEND 2/3] Input: elantech - Remove redundant field elantech_data::width
Date:   Wed,  8 Mar 2023 05:13:06 -0800
Message-Id: <20230308131307.13832-3-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308131307.13832-1-nyanpasu256@gmail.com>
References: <20230308131307.13832-1-nyanpasu256@gmail.com>
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

elantech_data::width is copied from elantech_device_info::width, and
neither is mutated after initialization. So remove the redundant
variable to prevent future bugs.

Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/mouse/elantech.c | 4 +---
 drivers/input/mouse/elantech.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 79e31611fc6e..263779c0313b 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -691,7 +691,7 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 	input_report_abs(dev, ABS_MT_PRESSURE, pres);
-	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, traces * etd->width);
+	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, traces * etd->info.width);
 	/* report this for backwards compatibility */
 	input_report_abs(dev, ABS_TOOL_WIDTH, traces);
 
@@ -1253,8 +1253,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
 	}
 
-	etd->width = width;
-
 	return 0;
 }
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 1ec004f72d13..fb093134ead7 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -180,7 +180,6 @@ struct elantech_data {
 	unsigned char reg_25;
 	unsigned char reg_26;
 	unsigned int single_finger_reports;
-	unsigned int width;
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
 	struct elantech_device_info info;
-- 
2.39.2

