Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6FF72CE50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjFLSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjFLSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:24:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07984113
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so5755073e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594281; x=1689186281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=PCvP9cs17qBaf62as9MDWOKExq7NCk5ON/MclnOAlvR4MUsiKiLbRegl6cuDGcfKQi
         T5tq69pg6qUlvK6kj5HEUzIYb6+tbp+02qYR8VHLqXm9g6ZqYwMPfgJjPUV+dQXgNOup
         h93xhIXi1A0Fet8PTwla8vBS2Bsf2e+PekPjeAakLX+eBGcr+Oop5UUiGwPTRCZ2Yb6X
         eBZ/4q5qAN4Hv8p+h96JUV6HHuFrwo2SV16vAuzYFHjIksSfERjY2KDR6ciIgcm58ER0
         xrEaatG2RNwHw8D+SofCr5C1tjArvG3vB1O7is3D9hHJnldAoVui7flfJG5v712gd70J
         oZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594281; x=1689186281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=ZtsLWyPIAuzspo5b80u1XR7KrRIba/7k0JfQgPmxcBk+MSYzFVPkxEDjQQFMLUsx07
         QLUcUN8wt3QhVTV3ZrkuWMO7XR/tnaK42oITegWQWhwwYwHVWgV2/GUWqBHpXDSFXyH+
         HMb7xvEqeZP3h/xC0sjZN7OxxwDP5Aw5KNL7J/4mN8kSK7rgi8QS1WD2RKdwyNDqys1m
         M2KTKu8KCWxz5w+DclKe24N/ztHeU0hYUL2WSgoEztYe2FNFzWEjpJxCDk4pvACKoFJW
         8lrfhHEtmLIu5o5bMvi24bcuheeUx7WTDVXeovhJJIKpD2T0K6gIX48e4UVF2dCaTPrV
         KoPA==
X-Gm-Message-State: AC+VfDwquejhCxdFF1/k2PAiwOjW/sEkl/1MZkmwC+lZvbmqLGGmfzMQ
        aSw+RzhDsqqyjZIV9YYg/CqlnA==
X-Google-Smtp-Source: ACHHUZ6PqidP4GLrAVRUdLTktHPgs8WgB/iWRzTjZRTImTQ2uKyXgb6jcmCiP+PXOFMPRVCwEalReQ==
X-Received: by 2002:a19:4357:0:b0:4f6:20a8:2656 with SMTP id m23-20020a194357000000b004f620a82656mr4018758lfj.29.1686594280772;
        Mon, 12 Jun 2023 11:24:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:19 +0200
Subject: [PATCH v3 02/23] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-2-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=664;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XHE1WQYZzaLo+c3xD4ALM/GRb1VwY7GuxNqpdL0mBnk=;
 b=UgnSsD/ZMCPV95S+X937A3q269KBqm/jPKgp4HLyljIdENs8MSPHoc98VlbXAKg+6mjm3UeWx
 SX3SBk8iMfaBtfRbHi3/sbsb+8X86VtsXx3bgt8nMvFePsn1CSjlbV2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a preprocessor define to indicate the number of RPM contexts/states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 2990f425fdef..e468f94fa323 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -6,6 +6,7 @@ struct qcom_smd_rpm;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE        0
 #define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_STATE_NUM		2
 
 /*
  * Constants used for addressing resources in the RPM.

-- 
2.41.0

