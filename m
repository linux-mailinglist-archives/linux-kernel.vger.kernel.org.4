Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07EC624C90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiKJVHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKJVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:07:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AD58003
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:07:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so5391362lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvtGTG6LE4GEGs1AchnlqDEY3Rlxm7tdq2QY4j/LQZY=;
        b=hbJN5R7BtN1X1tg+Na/G+eFUTe/bxCrFMRJL381B80EP7pPSw9v6mor0Mz5hrfbVye
         5yUCuzRM9sQZGlJdvgp4kopXYB+azvC5pJwv0xB7+B6OeuI/M/rGVSqxkH0JxvfVG6Xo
         STJfzEO5OzSOiU7na+Z/pUjhVa9OboH9E/bNo3IObxT+txglj1UAl/0NnhLMqT43MBfX
         33DshX30cImF+GZPvGL6svUKH7GBIu6T0he7P2nOiMB7PSGen5GqfrnZFsXpbpd3YhDZ
         A+GwlUZ8pgihfTRDEdtBvJ2kmPmVdUoC03gx5I6L9me9xgIGmlui7y0IO4XgIHP1bKE3
         5dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvtGTG6LE4GEGs1AchnlqDEY3Rlxm7tdq2QY4j/LQZY=;
        b=PPm8/7BfbKB3VftpqmhisbtdDG4v/Vs28IkuvBrjhXxsUM4z9qIooj0Oej9j5N9nt9
         HSFby+9xhgUEHFL7gFheVxNBXxfzQNSQ1gbNbfXDRXlO2rKLtBNcSbiT014iajibNFlx
         2RmZNiZvFKRUT/loj+PVNlIm5VUjSW97JKud/xPqzlVINfQqnEs617NKtgu8ax6LqPgg
         7V4GvmZvZfogOyRolAlUQLmcTsP6TAN4a3EooU7AZvXVU6XbSDe2KcNXJLn8KvZFYLtk
         FYixw3zSfDUuFGPjewWiV5E/6vEdf/vkH7FPg4fl/mCWdw9Rl0ZWI97vjZHhfm5Rtuzb
         M2FQ==
X-Gm-Message-State: ACrzQf0dOq8i/YriC++OmfNgkSkU4tF8bji35LVU1HlnNDV2Q9WrPW1u
        iRhP9kvi7CifW0oI+mFrbWdsYw==
X-Google-Smtp-Source: AMsMyM51jSo18E8f3MA/XsXfaQTyNnMQLu0tc+kFO3HH7mnpyfDZK6qs+x9f5JercuefOPfQOuE1Uw==
X-Received: by 2002:a05:6512:984:b0:4a2:27d7:20c9 with SMTP id w4-20020a056512098400b004a227d720c9mr2067765lft.632.1668114445534;
        Thu, 10 Nov 2022 13:07:25 -0800 (PST)
Received: from localhost.localdomain (95.49.32.193.neoplus.adsl.tpnet.pl. [95.49.32.193])
        by smtp.gmail.com with ESMTPSA id be33-20020a05651c172100b0027730261350sm77477ljb.131.2022.11.10.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:07:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        satya priya <skakit@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: qcom-rpmh: Fix PMR735a S3 regulator spec
Date:   Thu, 10 Nov 2022 22:07:05 +0100
Message-Id: <20221110210706.80301-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
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

PMR735a has a wider range than previously defined. Fix it.

Fixes: c4e5aa3dbee5 ("regulator: qcom-rpmh: Add PM7325/PMR735A regulator support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 4158ff126a67..f90bcdeecea5 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1187,7 +1187,7 @@ static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
 static const struct rpmh_vreg_init_data pmr735a_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps520, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
-	RPMH_VREG("smps3",  "smp%s3",  &pmic5_hfsmps510, "vdd-s3"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_hfsmps515, "vdd-s3"),
 	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l2"),
 	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l1-l2"),
 	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
-- 
2.38.1

