Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71A46B534D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjCJVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCJVq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:46:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C33147829
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ay14so25992123edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZbU6JKa/k4DgfL7v58YgYgRn8/rNVhugShDXDLr6H8=;
        b=pip1/vRUbCv0obVI3sVtYvTdBVyGH8Mv5pf3mEZeIEawtKi5xLTPd4/Gn11Htmmnt2
         wu6Jn95oek5LK3sxeqlf3yGr678RUhcTllknV+tDoXpHBPtcV0XYkbSd+4j1TkXE6eF/
         cdNpMseoihqZZPDt4dWkGu0YMIR7cykNuF7LLDUj70EAyO2nrnUn/NAAUMz8rWRacUhL
         5nb52JCdXsJXq5Z+SEt4m5PRrQgdR0jrz23Xlvu6JK2Hiwn1i24VMdcQ8oOQDsxrqj76
         /o5Y1TA3OW0Ty/cu6Ah4Hhef98D5+0dNSJ9FEZcY/MwZpk+BdOwwmeWXNdkx2B/P1pJL
         g8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZbU6JKa/k4DgfL7v58YgYgRn8/rNVhugShDXDLr6H8=;
        b=ecxDG+e30a21gtAT22Fb18vY6w0c8wCp+w12TvrpWHQ9vGbe0rzaSUgEm0U65Q9TZP
         Msq8B4EE+yE8nuAkI/0WNSIFK2cjp03Nsfv7vRTyoYLNmDHPjPZBp72u+U29yk5Rh2XM
         k+aX+Bxx+a95LEw33PHSCqXHzuDHllzwiCofwnfrIoPjPKhZQZY0nyB5Brx68O7voC3K
         PHuAAppZYC4XO7xKgZAOoxLm/WRrL4qcS8Kn/Z0mqtjhjfFrXEA31u7oY3KjUbdVR4uy
         LWowXSrqTip1Abh2YgqqQousT9sLdSk+GIcAKkgpctzI17f6pUJDLHexCs5ic4jE2X7m
         esxA==
X-Gm-Message-State: AO0yUKWlDMloPspBC3vL66et+A+goDmSdQU83xTYj9OSPI6rNigqUbai
        VzPAj1mPSadFsaLKSHaw3qjPVw==
X-Google-Smtp-Source: AK7set+M41NOJhBxOSf8ckFKjSGuqrMmQzRLYg9nu1ipvzp8ozAZGiNaAFXDSkFIqe3QD2VPb/0Hcw==
X-Received: by 2002:a17:906:dd7:b0:864:223:40b with SMTP id p23-20020a1709060dd700b008640223040bmr28847446eji.33.1678484656501;
        Fri, 10 Mar 2023 13:44:16 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id bg25-20020a170906a05900b00905a1abecbfsm333207ejb.47.2023.03.10.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:44:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] soc: qcom: gsbi: mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 22:44:13 +0100
Message-Id: <20230310214413.275054-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/soc/qcom/qcom_gsbi.c:117:34: error: ‘tcsr_dt_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/qcom_gsbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 290bdefbf28a..f1742e5bddb9 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -114,7 +114,7 @@ struct gsbi_info {
 	struct regmap *tcsr;
 };
 
-static const struct of_device_id tcsr_dt_match[] = {
+static const struct of_device_id tcsr_dt_match[] __maybe_unused = {
 	{ .compatible = "qcom,tcsr-ipq8064", .data = &config_ipq8064},
 	{ .compatible = "qcom,tcsr-apq8064", .data = &config_apq8064},
 	{ .compatible = "qcom,tcsr-msm8960", .data = &config_msm8960},
-- 
2.34.1

