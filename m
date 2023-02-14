Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1987F696716
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjBNOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjBNOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:38:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9A2B2AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d40so16453133eda.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CEkCZ6M0V0rHXdhyITLeseCr9Rsf6DFLsvzd46ANmM=;
        b=n1aeZTy4RMrg+Tgm5UPefjlZ3SkYZ64uuw44avuzcjWhCTmV8yAe23ueUB4bJGFDlb
         Q9tUOxHYuiOil4iVbBdIMWNlj4wNPWkCOBNYLPsFeWZBHos4qN8yGb0QAbGKtqwo988g
         7mXXYygMO3Od9lvS2jrVDch/qpr5JwYJ5TvVQE16bggIfDI7Q8z/+bz13TJVLpXX5zAm
         mtjjeAY+lFIPMDuqefLcFrIZUM9qGJcbCq5gbzzG5Ia03xzWriNuHS8Ih8hBDH8TrOqX
         LLJ6qPnCE9MtpZhQdWoO8q2bV6p3WJUPkowU9P/eWS089+UEaGCgwgQSX0MUt7oYJBJ8
         uUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CEkCZ6M0V0rHXdhyITLeseCr9Rsf6DFLsvzd46ANmM=;
        b=r664pP2+zrM/J06/oLwGoIV1OWw03EDxP6hcfvOXe9eQxFj4WQHNsI+RjlQWzzdc34
         9Im2OZywO6hi6G8dIdN3Y//vwJEdh8fZWYr/Br9iJNJXDxREHuMYssxAmO8H2/CYxoy0
         BHv/MxBY38qY6hxqA3iFGIpBQ8EZon96miMVMwHOssyd3TY8nf0fHhoA4RNtwY12FXzC
         bIH7F/CYJGOSWEW1HcYP8pflqfJtliRkCl/FI4LkkhMNYi2B9m0fhi73nclpcpt0RlGq
         PmblDdlTvsVTRoWz9WSjnThJKOxlraXUauSMIBwhz6MDTO6+6yLSGqhlIhkFYQiVGki4
         M/fw==
X-Gm-Message-State: AO0yUKX6zU416q+4DEWITTG6LOdnQwMcFaGU5q4apMNcBeoxFMWMsiX+
        HlGmguo3iEV89o+BE10xcIDjnQ==
X-Google-Smtp-Source: AK7set+Eaxs7wodwqIB4zDVySQzPvUzm9h+or6cuR9nyCbqpnBb1PZWk3UCQ2hcu8XGZ3a4NsGGUaw==
X-Received: by 2002:a50:9b03:0:b0:4aa:a9c7:4224 with SMTP id o3-20020a509b03000000b004aaa9c74224mr2981618edi.30.1676385492095;
        Tue, 14 Feb 2023 06:38:12 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/12] interconnect: qcom: msm8996: Promote to core_initcall
Date:   Tue, 14 Feb 2023 15:37:18 +0100
Message-Id: <20230214143720.2416762-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
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

The interconnect driver is (or soon will be) vital to many other
devices, as it's not a given that the bootloader will set up enough
bandwidth for us or that the values we come into are reasonable.

Promote the driver to core_initcall to ensure the consumers (i.e.
most "meaningful" parts of the SoC) can probe without deferrals.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 45eb8675fb11..0e0395328dc7 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -2109,7 +2109,17 @@ static struct platform_driver qnoc_driver = {
 		.sync_state = icc_sync_state,
 	}
 };
-module_platform_driver(qnoc_driver);
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
 
 MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
 MODULE_DESCRIPTION("Qualcomm MSM8996 NoC driver");
-- 
2.39.1

