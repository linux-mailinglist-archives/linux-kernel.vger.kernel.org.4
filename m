Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5573EF21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjFZXVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFZXVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:21:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377FB173D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:21:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so5467172e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687821672; x=1690413672;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dO36VoJ4ufjlnHaPl++WtOzPlb780JRUZU8+ra09/tE=;
        b=nYRqyHRpGzJRswEo8vcl7HO7FYib8wgFhtYbKfdisTPyAmJvw1KFYuwunq9Rw5geGp
         Af09E+TdKs7cpB3IYRKC0xDhdt+pJbcU8K2wCaMki/ahiqRLfahDQN4DU9oDd+sMDXDt
         VoafBAqm3jwPqBxa/x8oH10ArJAbsz7c9iIYD03R4+CF1Qiwf938m0lpnnFKHX7uxc6r
         01Yu5IzI6oiOWZtifwmVo4hZ7ZLY8n4l88KaTTbPLLiy8re+j+RVI42kkqsfV4eolpwW
         gttInmU9czbrC1rM7OfxQQXnMgLwGTg72I41ubGSelais5ctjKXFWXW3R5JpnNpbigUM
         1Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687821672; x=1690413672;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO36VoJ4ufjlnHaPl++WtOzPlb780JRUZU8+ra09/tE=;
        b=gBpScCsoTsF4g58cxKT+eiL88y2h7up79f8ES3kOuwvxu/O9EMx9xhXYyvXdtGW1lx
         0w9pwIiOlE3kEdYTLSI44PNIm2uOoPdpt8iNUcScas7VD+6nyfIQsFx+miuLKbGE4qvv
         5jJc+m70pez3NSB0cXeAZaslAi/ZurLPAIaEE19tdxXqJe8sC5lDeXZ1e5sENcurnang
         6KZiuCebcOlsdG/4t16981OWcluJGwu3cWjhywjK4XQgmMMMtTICYsvVqM3tAuxe+llU
         9B5Zr1e7D3oraUm/K5yHwyqIooIJoI4E+XJLEYNiHW31MeTPUF7xmnt+T+PqctbNU/HO
         ZnvA==
X-Gm-Message-State: AC+VfDxKoCbZvZI5/SzUXOuEPvQKAcS1YO/s3UByjIWp2fqvKOj7EZKW
        PDmoNMRMear8/y4uCp/JggrgUGPUpxOc2v95xkg=
X-Google-Smtp-Source: ACHHUZ7Cv2XBucYM7n1tgRFXateYtdptFLZBe70Txyuya7SgQKvecM5YGPwgrDAjigbywqTH8Ep+FA==
X-Received: by 2002:a05:6512:239b:b0:4f7:6685:2c5f with SMTP id c27-20020a056512239b00b004f766852c5fmr20894873lfv.61.1687821672352;
        Mon, 26 Jun 2023 16:21:12 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25a02000000b004f122a378d4sm1299719lfn.163.2023.06.26.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 16:21:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 01:21:11 +0200
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_GPIO2_100K_PU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-adc-v1-1-c61581abffa3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGYdmmQC/x2NQQqEMAxFryJZG7CVseBVxEWMmTEgVVoVoXh3w
 yzf531egSxJJUNfFUhyadYtGri6Al4o/gR1Ngbf+LbpfMBj25WRZkYngQJ3ROI+YP5EWXBKFHm
 xRzzX1cY9yVfvf2AYn+cFnrs4/XAAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687821671; l=1130;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UDlTetGfDyeyuMzIZP4r8qi9yHbpwzwUVVjytgB8zSI=;
 b=rvfyAS73qOUfM/FiI0ncZNcvwaf6MDTOH+GbJCQ59fq86JZs/Q+8f262deZ1YaO4lUmY3Q3fl
 gpQtWe6iqyGBNXgeug8S+KiyeDNyAdYJrpFAQ1Krr2PxNFvvlZBnPXI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though it existed in bindings for the longest time,
ADC5_GPIO2_100K_PU was never assigned in the driver. Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 0a4fd3a46113..b6b612d733ff 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -555,6 +555,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_PM5_SMB_TEMP)
 	[ADC5_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_GPIO2_100K_PU]	= ADC5_CHAN_TEMP("gpio2_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_100k_pu", 0,

---
base-commit: 60e7c4a25da68cd826719b685babbd23e73b85b0
change-id: 20230627-topic-adc-1e7a7c6aae15

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

