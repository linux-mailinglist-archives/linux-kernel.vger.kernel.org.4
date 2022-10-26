Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1560E121
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiJZMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiJZMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:46:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972199381;
        Wed, 26 Oct 2022 05:45:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d6so28261443lfs.10;
        Wed, 26 Oct 2022 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCYS2MrhiyiJRqchJbvsfNWsp2c+i8O2FNVXcaDM2G4=;
        b=OCrv7IpWNVUMh2AO7e6i1IyrvD4QBaDHl9M/25FYN8pyuGhpeRH6kYbzWzzSnceI0c
         N4a2t56ENioRfRnjumaWnYNQen0MC47bXE3ZZVDFEuu2XWhWJdvJyU8AUDd3KsRcqlh+
         kHjrSSIHAlKCafM4UYmdwMxf0qeDdf8EMmOFFQqRobtLhiKPcItmnudZvpSiS6cTc23k
         +q/eRIT/IFKikBZBogYbxKkbGcesrxwg3SnVVJk/98giXNrMCdFm2qQg2Zp3/QOmmcbR
         jwHE9uR86dqDDhXLmwMBh+pSNamlPxqpPtwqHFBSovR9xvrylqtUOIrC3yJ7jMFIdFM/
         PnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCYS2MrhiyiJRqchJbvsfNWsp2c+i8O2FNVXcaDM2G4=;
        b=vMB9O1UKSuDOW4MbDRRhStiQTt5OjAB0e1oSjg28cEVgf5gttx0Jmkn/O950a2c/ZD
         zr4Ix5ZTjogiqkLIuURKTMSfx1WFWETorGPSXHLWHFCrolf0aPDdmaNuF21Y10vOUi76
         bt4L3s+Q01g+IpEGv3LHs0pOmAg+MKKy7LbJRd0JcWPnckDfSweQDwN4VzIvepNrgYoH
         qOtvwqPZLu8u1u/v9EGHGPBQ7n+4QZjuWcNalE4GoKyO25dS9R5y5j2nI0gEahL9X/dR
         FN2bXL5i5VPInrDazHVDxXzybt3MxJhvV+tXPws8W9gL38c2alGVU++3eWtpyxHXIbGT
         p8YQ==
X-Gm-Message-State: ACrzQf1GnRyPox6S4QaSDJOl3YFLuYxCSiZofVE3W/GkRk0cKZqZy4tW
        nbQ+luVqJrb9tDBCS95mb0q8HDPr3Ted0Q==
X-Google-Smtp-Source: AMsMyM7PmmfexehbTSLlEBJ85BUrVcVkxpZ12MjCwV8C0zdOptDhQ86sr76L1I0wSxNc5kzBjQ0OtA==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr15638176lfr.339.1666788356422;
        Wed, 26 Oct 2022 05:45:56 -0700 (PDT)
Received: from localhost (95-31-187-187.broadband.corbina.ru. [95.31.187.187])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0026c35c4720esm932661ljm.24.2022.10.26.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:45:55 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH] media: i2c: ov4689: code cleanup
Date:   Wed, 26 Oct 2022 15:45:51 +0300
Message-Id: <20221026124552.163172-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y1gl1FMAjhXCfCmk@paasikivi.fi.intel.com>
References: <Y1gl1FMAjhXCfCmk@paasikivi.fi.intel.com>
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

Fix minor nits from the last review round: extra {}, temporary
variables for ARRAYS_SIZE(), redundant check in ov4689_check_hwcfg.
No functional change intended.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 419ff7371ba8..c602e507d42b 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -623,9 +623,8 @@ static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
 
 	for (n = 0; n < ARRAY_SIZE(ov4689_gain_ranges); n++) {
 		if (logical_gain >= ov4689_gain_ranges[n].logical_min &&
-		    logical_gain <= ov4689_gain_ranges[n].logical_max) {
+		    logical_gain <= ov4689_gain_ranges[n].logical_max)
 			break;
-		}
 	}
 
 	if (n == ARRAY_SIZE(ov4689_gain_ranges)) {
@@ -815,23 +814,22 @@ static int ov4689_check_sensor_id(struct ov4689 *ov4689,
 
 static int ov4689_configure_regulators(struct ov4689 *ov4689)
 {
-	unsigned int supplies_count = ARRAY_SIZE(ov4689_supply_names);
 	unsigned int i;
 
-	for (i = 0; i < supplies_count; i++)
+	for (i = 0; i < ARRAY_SIZE(ov4689_supply_names); i++)
 		ov4689->supplies[i].supply = ov4689_supply_names[i];
 
-	return devm_regulator_bulk_get(&ov4689->client->dev, supplies_count,
+	return devm_regulator_bulk_get(&ov4689->client->dev,
+				       ARRAY_SIZE(ov4689_supply_names),
 				       ov4689->supplies);
 }
 
 static u64 ov4689_check_link_frequency(struct v4l2_fwnode_endpoint *ep)
 {
-	unsigned int freqs_count = ARRAY_SIZE(link_freq_menu_items);
 	const u64 *freqs = link_freq_menu_items;
 	unsigned int i, j;
 
-	for (i = 0; i < freqs_count; i++) {
+	for (i = 0; i < ARRAY_SIZE(link_freq_menu_items); i++) {
 		for (j = 0; j < ep->nr_of_link_frequencies; j++)
 			if (freqs[i] == ep->link_frequencies[j])
 				return freqs[i];
@@ -864,12 +862,6 @@ static int ov4689_check_hwcfg(struct device *dev)
 		goto out_free_bus_cfg;
 	}
 
-	if (!bus_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "No link frequencies defined\n");
-		ret = -EINVAL;
-		goto out_free_bus_cfg;
-	}
-
 	if (!ov4689_check_link_frequency(&bus_cfg)) {
 		dev_err(dev, "No supported link frequency found\n");
 		ret = -EINVAL;
-- 
2.38.1

