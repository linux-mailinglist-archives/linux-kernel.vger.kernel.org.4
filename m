Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B945F3DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJDIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJDIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2A3E76F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so355772wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=ERxwEO8S5KqgbZntEyE4toOX6bTMC2xS+dmaphaUMKA=;
        b=unqTmhZy8A+HDJaKdtS9xNPbiRKpxZ/qyJVjtzF+pammk/F5+/kfUAzats0+OEo3gU
         OO7KTF/SuFRod0+m+UCJUD4MUuyweTseK+L68JoSJJsJA/KuG7IzU8sWIlnTkcU21pPc
         R2WS1MknyWd7fgNvRUQ3dSFYPe+pITQ2cjjps39nUcG8ppr7+R2xhNdaSw2NyDf1CHgt
         Sld5iW/7jYP06PcR8GxwfSs1fc70v8ujr2wMFDffshU7/rCHZb5rtiu1wKh0xcOJJs91
         /d4zcZw9svfAA7RNhdkLfw4A3TxckzSiex1iORCM+gKYTjidxK75EIp2XGEZ7XS0T3Hc
         wvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ERxwEO8S5KqgbZntEyE4toOX6bTMC2xS+dmaphaUMKA=;
        b=rBk8h/LNMYjiW6rX7JDWXmKLyf8+l3O0W+jEYpwI3AcQagUOlrKoiUEyPMPvKXqxZZ
         /teUiYVz5peRvpNuCMnEVjgjflPM+lBRAt7EVl1HawZX8T4MK3iykpVIw6yMQejJSM3I
         OrakeYpwG21mD8Z0pl7Qz+sR8g2EmrSF7WbH7RLF+5HNp5cbgBUIHV9dYD7TwQ5E1Iq+
         h69zT9ESMpbq+VEqrFhwqM+3/nceemkG8C+lTLSkb0vEh4ZJHGQWzD4A195s83kaTTwQ
         +vOCB7y0/LdspfLNRoFD776Qgj+j35vvsLytHtS9mC7XJMNu+I/flH3EZFH5M3gGSw5M
         TJtA==
X-Gm-Message-State: ACrzQf2yweGXf8ZsLbinFJy9SILXvKy64q445sFy4DGeNZ2eFikEIL2b
        W+fRMpf+99gyBjge1wpxIKz23g==
X-Google-Smtp-Source: AMsMyM6aFDcSk++frPMO5CS7FqZcUSWmB3TRai5KAzNrnsiammXqMtCkG4/PaX3mc/O5UMVZ71r0gQ==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr9181043wmr.27.1664870914251;
        Tue, 04 Oct 2022 01:08:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:25 +0000
Subject: [PATCH v2 09/11] rtc: pm8xxx: drop unused pm8018 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-9-87fbeb4ae053@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8921 compatible is used as fallback when PM8018 is available,
then remove the PM8018 compatible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index dc6d1476baa5..716e5d9ad74d 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -461,7 +461,6 @@ static const struct pm8xxx_rtc_regs pmk8350_regs = {
  */
 static const struct of_device_id pm8xxx_id_table[] = {
 	{ .compatible = "qcom,pm8921-rtc", .data = &pm8921_regs },
-	{ .compatible = "qcom,pm8018-rtc", .data = &pm8921_regs },
 	{ .compatible = "qcom,pm8058-rtc", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8941-rtc", .data = &pm8941_regs },
 	{ .compatible = "qcom,pmk8350-rtc", .data = &pmk8350_regs },

-- 
b4 0.10.0
