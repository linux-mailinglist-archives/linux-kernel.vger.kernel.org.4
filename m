Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93637639BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK0RJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0RJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:09:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46761B1D6;
        Sun, 27 Nov 2022 09:09:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b12so13492898wrn.2;
        Sun, 27 Nov 2022 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1QFilVPmFH00I2BXKUa98ZsFBrMiZR3SWIp+utrFLRo=;
        b=lQ7HWKynjXFaYGklFa/JPbBitjsefIX9/kMgCUSbjqSpIP3nKivmY475bW+KE2D+rt
         2YLMaG7mLDpC8uU4YsWKOuqThSPmBzLmVdEW2SluD/nCEKFr9ZbZIJ8Tomg0ojHUbenK
         y7ZNhx0eflTXKPZvvVuagc80kDB8kIRfE7AqFaFd9hoKA3pVCOst8EsG0SGhTKujMonw
         qyqX5v0p/AANuUeMu7VvP6q6BRFNbd7JCMeTxQlmir4FhY+QaOhlttEfQOw/mTH1BDdf
         uDEp5e1ZdnEJfic2QVONpmjnpqbFuMGxHpOv2/V2IoaFsfQBmjKpnzd4AvDzSmbFK/9y
         NhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QFilVPmFH00I2BXKUa98ZsFBrMiZR3SWIp+utrFLRo=;
        b=VNNcvff3Xim05XRtWPJ3Ih9bOkd8r020ZuG9i/AMNJIk7aZaZOr1R+e0ByR7Jjt7wM
         ZoWaGsRiMYU02f43WbSHFELdCvh7KpMIF2jRzdOLvj7ccUdGR7FNlbnVTJ/PMKJmvo+U
         YVkli5pUpcSzgfTAOAhXBFQW0nI1uj2w+s7mcT197B4mdBtbOFTr8uJIHQsSIJKKQhhZ
         BccLbichDRe/d6SXsBTJTAl/TIGwCsyNo/4UVsspFHrodC9jn415GnNpJVI3v4k+Xk/L
         hkQubMPXAxRMryhUCJCrd9/bFYLebhleSlCs68DDtcZl1LhftNzQt+PRabPLqUgXI385
         xfpQ==
X-Gm-Message-State: ANoB5pmQqtdJmfmZKz7M9blFMRwdfcWRKs84WMTLyvl3jJW2ZhhZ/c03
        hQIUTPbI5dEs/7lwe+R7AjJ7CF/bcnrR49+RzNs=
X-Google-Smtp-Source: AA0mqf6B1j3etclnPMhFvr70xUwYSS76WGL4I7/HGfEmrfTItODTEzQBsqqokrDoPPgyJNzDxLC8sg==
X-Received: by 2002:adf:fa8d:0:b0:242:1264:776f with SMTP id h13-20020adffa8d000000b002421264776fmr2488120wrr.600.1669568947783;
        Sun, 27 Nov 2022 09:09:07 -0800 (PST)
Received: from david-ryuzu.fritz.box (ipbcc3aba7.dynamic.kabel-deutschland.de. [188.195.171.167])
        by smtp.googlemail.com with ESMTPSA id h17-20020a05600c315100b003cf483ee8e0sm17759967wmo.24.2022.11.27.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 09:09:07 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 0/3] arm64: dts: qcom: sm8250-lenovo-j716f: Add initial device tree
Date:   Sun, 27 Nov 2022 18:08:55 +0100
Message-Id: <20221127170858.440040-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

The Lenovo Xiaoxin Pad Pro 2021 is an Android tablet based on Qualcomm
SM8250. The downstream kernel sources have not been released by the
vendor.

Following features are working:
 - GPIO keys
 - SimpleFB
 - UFS
 - USB
 - Regulators
 - I2C

David Wronek (3):
  dt-bindings: arm: qcom: Document Lenovo Xiaoxin Pad Pro 2021
  arm64: dts: qcom: sm8250-lenovo-j716f: Add initial device tree
  arm64: dts: qcom: sm8250-lenovo-j716f: Enable ADSP/CDSP/SLPI

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8250-lenovo-j716f.dts     | 576 ++++++++++++++++++
 3 files changed, 578 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts

-- 
2.38.1

