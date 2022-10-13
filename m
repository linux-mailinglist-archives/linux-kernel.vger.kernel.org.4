Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330EB5FD3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJME20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJME2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:28:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136710D6B2;
        Wed, 12 Oct 2022 21:28:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 67so874482pfz.12;
        Wed, 12 Oct 2022 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKPx6vlubdTigHk3GNewjAYkgmjIp93aWrqtifhCjAQ=;
        b=HyV2TBOyvjR5yD61XuEVuUfU7521mdV4MT6qpQ1jGLbCRL3CdnE3xPtaNSlEeCcxS3
         FNTDQA7tob7bJI9qqxyWZP4/PKcl+aGEbnN0ufNLsiFcnh5S4J4gz3c9VFFXo34V6Wkz
         OOwvG3vHVhBXypck3ZDGXlkIxmxm8ZWnWcgIJZD5LYuUm1ULUrp/YoBrKt2cZJ6xeCQQ
         XVamBMr9yxsKcCD53CTJSQueA2VEV2yiR+tURzW96BeOEKdVCDsqf8b3G7ieciV13dKV
         OvLIr6enYjXAXmU9xORcrhBDTbTxC4tJGtp1170rKAaJAzIuF43IlfszAxHwibwl9EKe
         85aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKPx6vlubdTigHk3GNewjAYkgmjIp93aWrqtifhCjAQ=;
        b=SpLsOQBBVCayZicocM1CzW5wFJoPM2wr3+CrSU1mk/g3F7k5tk+NOY5ClXBmlYY3Nt
         F1MkGErvD+DweSFhLpaOmeDJLL0OwhfHfTGETbmuCMGxZ4sdkbcOFSaYj0MfTmZbo+Nk
         KO5o51WwhjD3TGM8HAVb1vMa8/p6jAZFZ9H7DNeQwSh03bs3NMvgb8B+VRddhWlwj/gA
         BhQ9UC5J1339vNMH1WXk8excxYhX2vtKPXlzxQgYjTLHIJm6Za74PzAGXJmthYFRWOXn
         2jjOB9j7q4yEW6njdgIQd4nCYFle+pO/rcKzgV3szbn1xUYuWIB6a0JPuN7i195PW+zd
         ABIA==
X-Gm-Message-State: ACrzQf1vlwvvZjfDLgyNnEOzUGFa01u0rB//n3fg8beOHtQAS2lx2a+z
        EPuWrlhsOoA5eUc/rphVoF6hoGQyHcRE8g==
X-Google-Smtp-Source: AMsMyM7pPOPEuOML6HcybrxWUtiMY5Tx4kqha5/MWW1mTWVXcQrFNEl3mn0A8rUBmroDwP0ARFxjuA==
X-Received: by 2002:aa7:9dcb:0:b0:565:89a8:c708 with SMTP id g11-20020aa79dcb000000b0056589a8c708mr9447333pfq.4.1665635287389;
        Wed, 12 Oct 2022 21:28:07 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:b6fa:b70b:65a4:a699:40c8])
        by smtp.googlemail.com with ESMTPSA id y9-20020a17090aca8900b001faafa42a9esm2192007pjt.26.2022.10.12.21.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:28:06 -0700 (PDT)
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
Subject: [PATCH v4 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
Date:   Thu, 13 Oct 2022 09:57:48 +0530
Message-Id: <20221013042749.104668-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013042749.104668-1-sireeshkodali1@gmail.com>
References: <20221013042749.104668-1-sireeshkodali1@gmail.com>
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
index 6afd0941e552..eff8d34d7f4b 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -948,6 +948,7 @@ static const struct adsp_data sm8450_mpss_resource = {
 
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
+	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
-- 
2.38.0

