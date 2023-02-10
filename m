Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97880692099
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjBJOPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjBJOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:15:40 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67936FDB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:15:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be8so6591040plb.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw49d093iRE/lnieyMm9b69nRFPUDWb9NohvL5TWLf4=;
        b=Bp0iEg2FD2u90X20eb5Z/872M23FeqtYLvobjRkvIOPWEH/VcEthlotAlnYmrbjJEn
         He/4XAG+L27JVnPjIvRM8gP6G5qrbwumESeUjl14FQ2vLUbijZvaP0FfBYIBzE9C0poV
         zoD0HoqDRf4jDE2sypp7aDPKAorZC5J16fLflGR0SYXPJ2K7bFtbAFSaPurBg5Wf/f/y
         Tc9gWOZ3UfEf8CRCKbQvah4WGjTg9gOGiAUAQto2jNDfZOMp5LxhOSRjyQa1OcmRixUr
         kLVwfsfPK6ANBGgrD+/Bhq/OJTvKp2ylPqLgbQAQxA2kX4Vx05wdfP5+PVfIsYicWTgV
         nTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sw49d093iRE/lnieyMm9b69nRFPUDWb9NohvL5TWLf4=;
        b=SBXrg/VU1+J9b88kujLKK0qL91R2c+NQ/c3aENQDHcwVb1iC256cDV8FhVsR9kEOh9
         oVeWSx5VE/Ba/Dh91cBrlnzlrZjuWuK+HzEPDvbJXHPrMaMn+eOFCcrSClHTL2YjNMtk
         l3OXbPXqqKS4PPeaawuFR0ZiKdYQe5I286KsQVx5m1R8uDPZQC1NhaNGvQlycFgA1/H5
         xNB4fQ1db/IPf4W35CN7MfKqaTOA4BrjucimaovnE7I8uoEeuPhYethLwO7URgXd8+3G
         TCslD+bW4Dm3rhouZPyFS1AiIYzbd3C00rz8IYvDqnZ9oagdJCKCOUX6ie8nxRZrR6Qb
         T92A==
X-Gm-Message-State: AO0yUKVbGB7jKJ0kmgrjS2kgjHw5pnH6A3MBouV8u1SMOW0rVc7HY75u
        HXirW9EZV0mgkcTjk3zmKR3rhQ==
X-Google-Smtp-Source: AK7set9cV3+kLau/p0w64ulWvF8Q5ONN5Fal2jdunHIepYwrqsyuwJT7tCJgIyloDrYuJWHEvJuQwQ==
X-Received: by 2002:a17:902:e3c4:b0:189:6f76:9b61 with SMTP id r4-20020a170902e3c400b001896f769b61mr12536560ple.39.1676038538835;
        Fri, 10 Feb 2023 06:15:38 -0800 (PST)
Received: from localhost.localdomain ([199.101.192.157])
        by smtp.gmail.com with ESMTPSA id jl2-20020a170903134200b0019a6f32e6c1sm1737894plb.148.2023.02.10.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:15:38 -0800 (PST)
From:   Yongqin Liu <yongqin.liu@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, sumit.semwal@linaro.org, jstultz@google.com
Subject: [PATCH 1/1] thermal/drivers/hisi: Drop second sensor hi3660
Date:   Fri, 10 Feb 2023 22:15:07 +0800
Message-Id: <20230210141507.71014-1-yongqin.liu@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 74c8e6bffbe1 ("driver core: Add __alloc_size hint to devm
allocators") exposes a panic "BRK handler: Fatal exception" on the
hi3660_thermal_probe funciton.
This is because the function allocates memory for only one
sensors array entry, but tries to fill up a second one.

Fix this by removing the unneeded second access.

Fixes: 7d3a2a2bbadb ("thermal/drivers/hisi: Fix number of sensors on hi3660")
Signed-off-by: Yongqin Liu <yongqin.liu@linaro.org>
Link: https://lore.kernel.org/linux-mm/20221101223321.1326815-5-keescook@chromium.org/
---
 drivers/thermal/hisi_thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d6974db7aaf7..15af90f5c7d9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -427,10 +427,6 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	data->sensor[0].irq_name = "tsensor_a73";
 	data->sensor[0].data = data;
 
-	data->sensor[1].id = HI3660_LITTLE_SENSOR;
-	data->sensor[1].irq_name = "tsensor_a53";
-	data->sensor[1].data = data;
-
 	return 0;
 }
 
-- 
2.25.1

