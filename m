Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228FA5FFA21
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJONE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJONEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:04:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D8D15A1A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:04:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso5698059wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmXoNNLDLDLD0P7pKCj+BHy21pHCA1aEV+oXYAOW2vk=;
        b=KD1l/z5JxEtz6VLtNyfLQRz5xjiZkc3OHsZofFSBtslzVUOZsPgvt54LTkB4AcV/Co
         7FnwYPJZxbnr/X3zoZcyV6GfZsbe1YZW88yyP/8uo064uQOH2NFMgXpiUCSTvNP5Iauf
         huN/oS9EO3pzWUQszcvZ1MODVNLMifR6DnN9AbluASxv1LMFA2wCxHp1taXME2PZYK6g
         Tf9SPdrLDzB74Adtj1pzy4IdnTp0DdJqc4MwuBzvoV6e6Jy8pFfnZFL4MGDD6sKRNtXi
         ofEmwPH7vhWHtAUTB63a9HnIkY8owgyWpvLxLw22djEpRsvqE1MzoMenTxAp1XqflmrX
         Yo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmXoNNLDLDLD0P7pKCj+BHy21pHCA1aEV+oXYAOW2vk=;
        b=2FtYT1pBLk54UrdXOGGCKd9E0aDAhmRNJokjHdUhYPt6Lr+QKEL6P2Da/+lFmM7EgQ
         62zWicG9rxwrCrndkWGOYZ+YGGoiLWatsYE2DmTzSW/A5qIdaMDsWzWdXFLqrufOnW9e
         HqYcq97Jand+muGzkQnOHUiBjRi1k2l92ONaHfcpz9XhiAnTK8TLCCBGZ6c67CAGgMb/
         dTDNTF/Lyv3EK3D574ZpzxgVqm7Cea9T8Op25eQpJVwwHDZDgOAgcy7cPWKwQs+JzciL
         20zlugjpzq0cVFzsi6HUMwVrasa4IzyJxi9RyBlpQP9X6if9ANJM83YOp9y/ajg0mSwW
         ItUQ==
X-Gm-Message-State: ACrzQf1QBkxsjTGJ1/QjxyckekiYq0P4/eUWwSjaMMiYunhmA+kPBN1R
        tCUCjitnYomcvd+lVKrmvJEA3Q==
X-Google-Smtp-Source: AMsMyM4D5O9gG9NOK+MSIiq2FONa1R7rk2mB1cW3AfzmQcENV/AmukHCqN+JdEhhPePrcvFp62wJUg==
X-Received: by 2002:a05:600c:3844:b0:3b4:becc:e43 with SMTP id s4-20020a05600c384400b003b4becc0e43mr13653476wmr.33.1665839082742;
        Sat, 15 Oct 2022 06:04:42 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b00225239d9265sm4151282wro.74.2022.10.15.06.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 06:04:42 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH v2 3/3] cpufreq: qcom: remove unused parameter in function definition
Date:   Sat, 15 Oct 2022 15:04:24 +0200
Message-Id: <20221015130424.1923706-3-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221015130424.1923706-1-fabien.parent@linaro.org>
References: <20221015130424.1923706-1-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The speedbin_nvmem parameter is not used for
get_krait_bin_format_{a,b}. Let's remove the parameter to make the code
cleaner.

Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---

V2: New patch

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 82e0339d7722..a154f03666fd 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -64,7 +64,7 @@ static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
 static void get_krait_bin_format_a(struct device *cpu_dev,
 					  int *speed, int *pvs, int *pvs_ver,
-					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+					  u8 *buf)
 {
 	u32 pte_efuse;
 
@@ -95,7 +95,7 @@ static void get_krait_bin_format_a(struct device *cpu_dev,
 
 static void get_krait_bin_format_b(struct device *cpu_dev,
 					  int *speed, int *pvs, int *pvs_ver,
-					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+					  u8 *buf)
 {
 	u32 pte_efuse, redundant_sel;
 
@@ -223,11 +223,11 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	switch (len) {
 	case 4:
 		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
-				       speedbin_nvmem, speedbin);
+				       speedbin);
 		break;
 	case 8:
 		get_krait_bin_format_b(cpu_dev, &speed, &pvs, &pvs_ver,
-				       speedbin_nvmem, speedbin);
+				       speedbin);
 		break;
 	default:
 		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
-- 
2.37.2

