Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049585F604F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJFEsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJFEsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:48:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD780511;
        Wed,  5 Oct 2022 21:48:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x6so655819pll.11;
        Wed, 05 Oct 2022 21:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aUKqsoczDPOBHc9UJMJ32o/8VoKU4i+itPLa1Q+iQ9Y=;
        b=My00ou+AKHyPe9NAz1nZo3iGRL7hgiRIWjz92R0G2pYaDLtAtgfvcmng+JFco7/ZMW
         TbTk2l566bSO4kXqHPeCAYbyr0/44aS9Lrf2Fv2N5T+6RyP9LkX5WeKh0DeHmxMmnI8x
         yyTzLh8ZWwDC9N7JV+of/fIGDL6xmAXZX5rtKbiuGUgS6qCMvNjAL1Q5dp9aBInK4jgn
         lWrXKXq23USDjq5cwTcI/3RigJF/dUQ1gkWlH3ffswNRfk8Ard22SzLQcM3OZvZkvy2R
         CBuGn0VuasFo3RUildDqHBybvDhMRgX4/otcC+JVYXbpt75I2/P3B6vZN3Vvlx9cx8XQ
         A3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aUKqsoczDPOBHc9UJMJ32o/8VoKU4i+itPLa1Q+iQ9Y=;
        b=Qj3BCTOLz++RvnNHVaU8udREnSU9X0wyKkrz+rpBuD1Pr96EuCs6qUD9k71WivAP2l
         OnhtEKOO2pQ6ue+kBzCwFj2v/6ywODl4JpZVsHY2QR5hHWL9xvHfP1VK5wohcOvTTn52
         yHrpWgSrffFVJqpxKTMMkItQoqKQwXZhgQ2R7wWVuI7jbTE7SCMZNwRaUi/Fi0harabJ
         89Ek8ZXtYSJVdhXZQq2JTkwtSgqlpmNgy6u0WLI3I2RzrS2jOnvhFd+XnRrhasnX2Q0/
         mvUMSMpzIHjjU/XjlnHq9iWFypZ0HXDYnx2kcol4+QXGdRqAakMLep5hJ1dG+OOpZH3n
         3Nww==
X-Gm-Message-State: ACrzQf3nLtugxIrYPDxuR6/5WCEClS/fIPzr/jv1pY9nFrraqWJLePL+
        M4FR+RjtRcFMiNgeBCiAFA7HKjUtEO10qQ==
X-Google-Smtp-Source: AMsMyM6ZmsL5nsfhUP+5fuYSKPDXe7bCHrVh6Q4pA9xJJGzp+y2exfSuSbiT8bA4+oD8/uwOdaONfQ==
X-Received: by 2002:a17:902:e5d1:b0:178:443b:3e76 with SMTP id u17-20020a170902e5d100b00178443b3e76mr2756726plf.153.1665031685721;
        Wed, 05 Oct 2022 21:48:05 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:350b:1ad7:ecfb:8fec])
        by smtp.googlemail.com with ESMTPSA id f7-20020aa79d87000000b0056232f5fba0sm2187448pfq.155.2022.10.05.21.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:48:05 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v2 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
Date:   Thu,  6 Oct 2022 10:17:44 +0530
Message-Id: <20221006044745.286264-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006044745.286264-1-sireeshkodali1@gmail.com>
References: <20221006044745.286264-1-sireeshkodali1@gmail.com>
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

Add support for the Audio DSP PIL found on the Qualcomm MSM8953
platform. The same configuration is used on all SoCs based on the
MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd0941e552..70b3a37c4814 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -950,6 +950,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
+	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
 	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},
-- 
2.37.3

