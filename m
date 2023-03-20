Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32FD6C0BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCTIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCTIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:00:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B112CCA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:00:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so6989076pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679299233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y76s/7TZKYipqIGX6dfWBMjuej27Nnu4nm7IdQ4ODYY=;
        b=HOPeCt4ZCSi3Hr3eqqbUhIy/U8JBXz/aEuPOSI6qA+KF4a5RGoI7p/E40CtdGMYiKx
         o3HiKzdxk4jChC10/etrjMqiuyUO/RLOdK2xjlkqnRfQcqE/Xkj8QpkYZOlaSOcKecg2
         +BfruCGMBKT4ylzq2Q/vzd3/paPtEVENSemXq+fhQaUfAgndI7Ifn1bdxI4BtOvfX6PJ
         UlWRHsKNTnNdgxHBMx80X8SdVLTl5how0FYsNkLoz84QaBd/nqCl1RDFfn/duVlworDI
         DvOR4c8pvVr8zNkeoOkh0ipJnwVXXZQLqrd5S2NjGgGYqLiXdD8g/9IWP4sTq1nLzcie
         FA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679299233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y76s/7TZKYipqIGX6dfWBMjuej27Nnu4nm7IdQ4ODYY=;
        b=x033jfrYuLI/DPlZgR0Hf5bjmlAof/c7y/EsfaiX+f9ZXFWpFXGK07x+xsBBO6FK7Z
         LKs3rY8ZrMrnS9jGThuzRqUlx4zPZzrHa8FYfNCNicYUiSRMwJJzw+gZfwwvosOzjPAe
         IGlrF4degPnuH+ZEyaNcgAxdpLRKhq7YPppg7gM0t2MFg/hMtqk8++Qqh0RojPpTraFm
         2p1i+AJvetYxo15+vhn0aHu6uOAr2mdXkCXI9b1fzTPaAsZu5l0k/q/Jps+aak2Z00H7
         ygYa+/OpuhMz5QLJ2GctT9kXf6mxhVbhv4j7l6O7f07pvK665+GrQ4lSSR0sJcUaz124
         IWIg==
X-Gm-Message-State: AO0yUKWBu/f3T1dkMhidN8vzip2qYm57onljXyWGv1JntBNeFL4vvsuD
        /iThunAx/PoAq57MNsPU+w0=
X-Google-Smtp-Source: AK7set8XC6zuNWgR0plIjofK+YZ3FpO6theGa0DufFvPKzPlVg5PX3MqG+OvQAnKBtku3lQqFmAp+Q==
X-Received: by 2002:a17:90b:1a8c:b0:22c:59c3:8694 with SMTP id ng12-20020a17090b1a8c00b0022c59c38694mr18213964pjb.44.1679299232894;
        Mon, 20 Mar 2023 01:00:32 -0700 (PDT)
Received: from localhost.localdomain ([223.38.28.252])
        by smtp.gmail.com with ESMTPSA id ez9-20020a17090ae14900b0023cfdb24874sm5570164pjb.5.2023.03.20.01.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:00:32 -0700 (PDT)
From:   junghoonHyun <cjbtest001@gmail.com>
X-Google-Original-From: junghoonHyun <hyunjunghoon@melfas.com>
To:     dmitry.torokhov@gmail.com
Cc:     jeesw@melfas.com, rydberg@bitmath.org,
        linux-kernel@vger.kernel.org, kms2701@lgdisplay.com,
        hyunjunghoon@melfas.com, hbarnor@google.com,
        sstarkenburg@google.com, jbtech0701@daum.net
Subject: [PATCH] Staging: melfas_mip4: add palm sequence
Date:   Mon, 20 Mar 2023 17:00:12 +0900
Message-Id: <20230320080012.4053-1-hyunjunghoon@melfas.com>
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

add palm processing logic

Signed-off-by: JungHoon Hyun <hyunjunghoon@melfas.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index acdfbdea2b6e..311a6a1c0ac4 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -525,7 +525,11 @@ static void mip4_report_touch(struct mip4_ts *ts, u8 *packet)
 	} else if (state) {
 		/* Press or Move event */
 		input_mt_slot(ts->input, id);
-		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, true);
+		if (palm)
+			input_mt_report_slot_state(ts->input, MT_TOOL_PALM, true);
+		else
+			input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, true);
+
 		input_report_abs(ts->input, ABS_MT_POSITION_X, x);
 		input_report_abs(ts->input, ABS_MT_POSITION_Y, y);
 		input_report_abs(ts->input, ABS_MT_PRESSURE, pressure);
@@ -1483,6 +1487,9 @@ static int mip4_probe(struct i2c_client *client)
 	input->keycodesize = sizeof(*ts->key_code);
 	input->keycodemax = ts->key_num;
 
+	input_set_abs_params(input, ABS_MT_TOOL_TYPE,
+							0, MT_TOOL_PALM, 0, 0);
+
 	input_set_abs_params(input, ABS_MT_POSITION_X, 0, ts->max_x, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ts->max_y, 0, 0);
 	input_set_abs_params(input, ABS_MT_PRESSURE,
-- 
2.25.1

