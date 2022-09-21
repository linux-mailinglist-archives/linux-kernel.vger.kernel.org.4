Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06DD5BF9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIUIrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiIUIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:47:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1CA89CDB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:46:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f9so8044803lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9XDmMSkErfJxFmN4ZvQmXQrGhNtHHsv05+YAnAlzpks=;
        b=PC8yTTvPRBQpgdJ31Yt4NsBPePaj0m09Ho5t1UiVzsRsiwcI48Xxecb0a3C5O6DriO
         LW4IsbyHiBfAifg6NDFeCswah8f1AlEgYVIf3ocXrYg8wN7gdSt7iRXt46PlnPehLsBP
         Nf8RzciXCNmfoHUL0UMQA4G0Icg2m57DCnIi48wK9ZkFTjy8P+cw+XPhJFuiNZtfPjF5
         HoQP+KFkTti1UwEuprNwo/dyhP3WklIR6a6YQB2GjpBUj7V3BzfEqshxdCorLdAB3Mkk
         5fzA+XnFE3c3fPFj7tKnPcFct+VMlqOh7U6FcoOY6dpzIctojWTp1DY6dpLOnC+UjXDs
         FWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9XDmMSkErfJxFmN4ZvQmXQrGhNtHHsv05+YAnAlzpks=;
        b=1DFmAzpO0zTNSjJGt6mH6zxlIaGz5lII1zWbSGXGxVs7n6a7Y5xInLDgOP0ADZRiMI
         6PlssuwrAsbWnT80Ytg5h0MIJpREuAl53nCQeDove1LRipNQIDXjEI4eNu7J2VjSQXyv
         72Mr4RZuc3ODy+CQDpRrZ1iXEiwfoOnAo79s+5d7EkpxKPN5oskr9iKrl0Tpwfkme6YV
         jVQsqk9Nm8B7Ry/QVhCh2EV4a1qF36ty6oKTlgcFrpDiy2kI1vdMfNxLV8wm7Ng3eQ3E
         YnMYgHduq1VrepYi4tWc0iZcOc7ummUuIBwKsnKXvS6RNtyIG2ckGhTkypk/HcJRoqGf
         WEzg==
X-Gm-Message-State: ACrzQf015xM2Wsp/WhsWwfCaStrZ1sfyhWwD7pDdXyG0ZiGI5oYlPQ6l
        BjSGfYq8Irk06KnuPgHmPmw/XMUCk9jYrA==
X-Google-Smtp-Source: AMsMyM4RB9R3GoHhkgWd/q4jSX09mjpDoHUp6y2OzcGRbdSNR5ZNtu32JNMZN/EivKSvm50+5Vs+qQ==
X-Received: by 2002:a05:6512:b17:b0:4a0:13c:9b3f with SMTP id w23-20020a0565120b1700b004a0013c9b3fmr375196lfu.91.1663750016500;
        Wed, 21 Sep 2022 01:46:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o12-20020a056512052c00b00497a41b3a42sm344715lfc.88.2022.09.21.01.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:46:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] usb: dwc3: qcom: drop unneeded compatibles
Date:   Wed, 21 Sep 2022 10:46:54 +0200
Message-Id: <20220921084654.118230-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

All Qualcomm SoC DWC3 USB devices have a qcom,dwc3 fallback, thus there
is no need to keep the list of compatibles growing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 9a94b1ab8f7a..7c40f3ffc054 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -1007,10 +1007,6 @@ static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
 
 static const struct of_device_id dwc3_qcom_of_match[] = {
 	{ .compatible = "qcom,dwc3" },
-	{ .compatible = "qcom,msm8996-dwc3" },
-	{ .compatible = "qcom,msm8998-dwc3" },
-	{ .compatible = "qcom,sdm660-dwc3" },
-	{ .compatible = "qcom,sdm845-dwc3" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
-- 
2.34.1

