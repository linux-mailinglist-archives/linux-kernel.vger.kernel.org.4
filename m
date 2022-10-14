Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567C75FED15
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJNLQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJNLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:16:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9991108DCD;
        Fri, 14 Oct 2022 04:16:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so4485236pjf.5;
        Fri, 14 Oct 2022 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klUZYq5ksLhv5eYymOLtmPnXDmVH6nH7RiedGb7KOzQ=;
        b=Wf2TNy4U53GCBGVWKC77/xG0zteFRO7JD4TKgfuOfgFwMO0zVJulGC/kTMLN698A8e
         k8XR6nf90r4xo02Ic/C2OjtTVdvS9NYENarAXnJN1e7QtFP0agYGpl9wdaUoHRCWj9XX
         JtSY4g3KPqwlI1KtH7j8wm3Bs7f3ubJRUdmD+P2YU8NCK2nk8aQxLfam8yoSqyaYoNS7
         4uB6dR2RLoWUstZkGc2Z04bgJjvH0nAh6d0oZNhP5jGmiF9SvlkSkulFXydjRQPBEZn1
         IM656BHVsC0da0LU5ZVkn8XeUvxfOuvJ0VKGArtBxPe02nLMthfyo7wNJs6O26C6QryG
         Bp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klUZYq5ksLhv5eYymOLtmPnXDmVH6nH7RiedGb7KOzQ=;
        b=MGgHeJYxPO7AoschsJtPEkZ2IlKavKwyoFhMxbvsdSURuYpytiyo3iE90Iv+k0fgd/
         i0dAkymXIPzN5YMs21wGB9RqVoB/iwv0agk3J/vYqVyDnOhmqGpH4jzKiKNShL+hN6BR
         CvLlMaheAzUv/9g1JALgIPoAsHrp3wGLNGYUxLKm/0rMNtf+Qc4cNwK98Ga0lSU+rYD+
         jCgjeP0OIEGU/LFYEA7+U6Gm5u2qm9vUcuBfbgDl9GaCx+/cXH8hpm6EhCIK57+vfPZp
         irokt7+p13G1MwUDdqOBnirW0Ztjk0ddkc2AoSpDYrnXJdbTCiWa839wZ0LxsUPGi/Jc
         BUeQ==
X-Gm-Message-State: ACrzQf14lLCHGFbIMorotrCTahcdk2cG0iyNtegOb+ZYb71vBamjzkan
        Hgcl3XeefCVh6sLIaNG8qpFWKdcZG88AtA==
X-Google-Smtp-Source: AMsMyM4GC4EVDysdgbgQQS6S9dpU8HJQcMWBm7EFSFWboXdgiNjizCKDsgTRUrlO+ZhZSepbnXfg6g==
X-Received: by 2002:a17:902:e212:b0:178:5c:8248 with SMTP id u18-20020a170902e21200b00178005c8248mr4719120plb.102.1665746183652;
        Fri, 14 Oct 2022 04:16:23 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b001fd6066284dsm1304628pjq.6.2022.10.14.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:16:23 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 2/3] Input: elantech - Remove redundant field elantech_data::width
Date:   Fri, 14 Oct 2022 04:15:32 -0700
Message-Id: <20221014111533.908-3-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014111533.908-1-nyanpasu256@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
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
---
 drivers/input/mouse/elantech.c | 4 +---
 drivers/input/mouse/elantech.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 79e31611fc..263779c031 100644
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
index 1ec004f72d..fb093134ea 100644
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
2.38.0

