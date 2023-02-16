Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97B69923B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBPKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBPKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:51:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD79A55E49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:51:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id br9so2271674lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2skU52xYnO88MOQQej9qwovXl4uCZ1SRLC9dCn0g3F0=;
        b=w35RlwJY2q7CwCKYoYX3G+msGQGtbKbMqI6BWxsXKZOGy3eVZykH2f3iwb9JWOyPlU
         l7ilUC6Jks3WOTF9IbdFRzMIEEcY2jVFKGQAk+RWcOwn7aLdJZw0YKVnqNH5US6kYoiw
         pQi/lIlaOv0B+Vf3gHz6ygAF3nUndhuevp6uFIpys9g9sl25ejx6YVrFNwRLUgo0w6vW
         d4Xleh7jeFpITMQzYisytdhcpOMInRDlX224/9e0umOrXUJ54Xn0rleYfuYLPj0A1BNC
         28IB9om7hBCuK6ZVuVwPVf8+LlvVRTVpxnRed0rDERzNniYNzQyGNKUCsidke5yEwi1s
         w5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2skU52xYnO88MOQQej9qwovXl4uCZ1SRLC9dCn0g3F0=;
        b=JC/iZ6dB3CRjXoVpWWWNeeS4SAMMaesEbyna0osi3XnbuTqDfbFZeKj4UtBXoI4edI
         qV+sWXlZVqnigb8aR2QT5sw/wEo4asaiQHBf/mSp3x5VnO0swn705qGuqkyamIdRs16y
         0XcbnMF+iIbe2Xe8SUfbbHdKBirFvBjbxVKLz18o16dAPBjT6CmEnd9J2pP5XJQytUPM
         VQ//AMX/HrNHlt5LJXd/5oe0RIOW2321k/bJJ5pjyqswNJcD8LbM6ifPRjcrSdjF/sd7
         6tjm8IM7gjIityCp3+tM1TJdwp7FAwqsSZ6hqUGG45xcaBmOLCsvhDbhESr66R3YmcCL
         rSKQ==
X-Gm-Message-State: AO0yUKWVQLNEMHY16OjgVKwoYYrp6XwyRH7TldNrQS/btntPOnvgdwai
        CKjbeDPK19FS/5JDOv8wTO260x8ujSoY519J
X-Google-Smtp-Source: AK7set/Z1Pba3KSZc9/U8jKXhZy2f7jCxjKs2RBVTce+cckvI4cRhoYJ9ifcwsZbJO5kJy/uehXRqg==
X-Received: by 2002:ac2:4855:0:b0:4d6:d0c5:5c57 with SMTP id 21-20020ac24855000000b004d6d0c55c57mr1606852lfy.62.1676544704074;
        Thu, 16 Feb 2023 02:51:44 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id m11-20020a19520b000000b004cb34b81150sm249903lfb.282.2023.02.16.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:51:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: qcom-hw: Simplify counting frequency domains
Date:   Thu, 16 Feb 2023 11:51:40 +0100
Message-Id: <20230216105140.3938749-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

For quite some time, this driver has been performing some quite
low-level DT operations. Simplify that using platform_get_resource.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- remove stray newline near probe return
- s/doing performing/performing/

v1: https://lore.kernel.org/linux-arm-msm/20230216102956.3933639-1-konrad.dybcio@linaro.org/T/#u

 drivers/cpufreq/qcom-cpufreq-hw.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 2f581d2d617d..575a4461c25a 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -29,6 +29,8 @@
 
 #define GT_IRQ_STATUS			BIT(2)
 
+#define MAX_FREQ_DOMAINS		3
+
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;
 	u32 reg_domain_state;
@@ -651,10 +653,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &pdev->dev;
-	struct device_node *soc_node;
 	struct device *cpu_dev;
 	struct clk *clk;
-	int ret, i, num_domains, reg_sz;
+	int ret, i, num_domains;
 
 	clk = clk_get(dev, "xo");
 	if (IS_ERR(clk))
@@ -681,24 +682,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
-	soc_node = of_get_parent(dev->of_node);
-	if (!soc_node)
-		return -EINVAL;
-
-	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
-	if (ret)
-		goto of_exit;
-
-	ret = of_property_read_u32(soc_node, "#size-cells", &i);
-	if (ret)
-		goto of_exit;
-
-	reg_sz += i;
-
-	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
-	if (num_domains <= 0)
-		return num_domains;
+	for (num_domains = 0; num_domains < MAX_FREQ_DOMAINS; num_domains++)
+		if (!platform_get_resource(pdev, IORESOURCE_MEM, num_domains))
+			break;
 
 	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
 					 GFP_KERNEL);
@@ -762,9 +748,6 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	else
 		dev_dbg(dev, "QCOM CPUFreq HW driver initialized\n");
 
-of_exit:
-	of_node_put(soc_node);
-
 	return ret;
 }
 
-- 
2.39.1

