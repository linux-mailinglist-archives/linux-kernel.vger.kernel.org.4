Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A41695EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBNJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBNJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:24:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817C10433;
        Tue, 14 Feb 2023 01:24:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so10509312wmp.2;
        Tue, 14 Feb 2023 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=az+YZuuI8dfSk3sN0dchfiJ8XRw3zhYvT0M8cnedGHg=;
        b=j7x1y+t+AH6T+OgAYBUmSfoAoEzNUTCJkIwSk1YSwaxIUuj8wpf9XmJUWp5OyQ7TJh
         j9HFBH9VUrBJNVAn2919Pa3EkwTagT5l4v2yw8DVIIxto4rrjVxC4OyHrw3OkxM7u672
         e9dvY36sedRbJmhwjdxuVnuIk2IBi23DelAtGchCFEjlNtn+kgu5C0idVxDx31Kh3TqB
         7TTeQmo45/kegdE7Z8ixQ/BRA3SdHeYpRGKhnQU0TpuRU99F0/TDTGMp2DWpqZWbVhk2
         tROLWqBoamIgy0b9i427MGmWeQtg4envNEr3aZDmk+0BGnHJL5d/hOJ9b78nAhS85Ntr
         jncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=az+YZuuI8dfSk3sN0dchfiJ8XRw3zhYvT0M8cnedGHg=;
        b=JFH5DfdyhKVlzHT/6IFsuD7clMZekBzBXSW3IUcCczQfJWYfH3XHdA4nGqDTKCcN0f
         iv8Wfs4ig4cgyDPnMcyg5vzT58dBr7upLm0uemTrITkG5iRezStNrQ0RMXJEd9uK7FvO
         B7pz9Xza6LEo7QKvMWPVzb/Pf15VRksoVpqjrvpy8x5F0wBkXYLLbdDFKLqD67GeftME
         ko2hU0M/3AWEUrBbbaVi7RHUWWitAI42DYRFiwmzlEAvNxegVtVsaypt89VQ6fZ6fsFZ
         kmIv3MPaDAPKRSNmHOmmtQFdIO92zvBDsoTzf0nJ07KDtufuwii3qJHCu92HG4ughTNj
         1liw==
X-Gm-Message-State: AO0yUKWptr1Q4QYV3JTuBtNIAV6kPCWn20RdQsxoc3t+w9qUZrCDcd/R
        /6BYygyqHRVfQFpeWvONtC/R/0sg7U0UqwRJ
X-Google-Smtp-Source: AK7set+bTCMslfxVd4eH0FtnW1/ifdYHdESNV+Zzh2I9ib4akegREMkhWuFuhHC4g/U7D1JOOyiTZA==
X-Received: by 2002:a05:600c:1695:b0:3dc:5deb:40a0 with SMTP id k21-20020a05600c169500b003dc5deb40a0mr1497591wmn.8.1676366666434;
        Tue, 14 Feb 2023 01:24:26 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003ddc781b1d4sm17683205wmq.33.2023.02.14.01.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:24:26 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: fix spelling mistake "charing" -> "charging"
Date:   Tue, 14 Feb 2023 09:24:25 +0000
Message-Id: <20230214092425.265553-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are spelling mistakes in dev_err_probe messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index ec31f887184f..5c2353241099 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1367,7 +1367,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
 		if (IS_ERR(battmgr->wls_psy))
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
-					     "failed to register wireless charing power supply\n");
+					     "failed to register wireless charging power supply\n");
 	} else {
 		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
 		if (IS_ERR(battmgr->bat_psy))
@@ -1382,7 +1382,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
 		if (IS_ERR(battmgr->wls_psy))
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
-					     "failed to register wireless charing power supply\n");
+					     "failed to register wireless charging power supply\n");
 	}
 
 	battmgr->client = devm_pmic_glink_register_client(dev,
-- 
2.30.2

