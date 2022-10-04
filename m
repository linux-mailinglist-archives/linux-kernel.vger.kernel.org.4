Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDEA5F3DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJDIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJDIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874332F3B5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso10350865wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=S50Kn1ZeGQjmdqGP72J9i0JCYT1m65l5LDkFZpLnWg0=;
        b=UHWouWakO7eYHv7x/9YhTXzp4EbfNfMN3CapKv4zrEeVjaqIC0BLqhCg4WAFhIR4cX
         EGtI/p4IXzT8lUzIogbs9/pOu3cHKjem2xUYoVNYh6EMbLFEpQVGifO+6vRkifYi960E
         F/ZfUopbtQhcwLQSY175yeaNs9t46VXqpa8AMD5yMbWHB9PLOTHBNGkPW1H//vwGHWOp
         E6c9V1dN9xOmETogsbG27qdoghqEfY+dwP/zWUgZ8nu0/aCttCZIWcflOpRwSQ+gqmRl
         r/C7ISEKmFbOpKI8UrzKgqZTj3veHVqziTkhyknSjqI1v5LJ3BAsBFOq1b9HnLn+aWCo
         KgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S50Kn1ZeGQjmdqGP72J9i0JCYT1m65l5LDkFZpLnWg0=;
        b=vvqWR1zyMguJmhoQoPdiBsE3CScsQo2WyRRtNkTqpOLikY5UIUZn4nOla/c9SAEhf/
         bXox2BUADQNS7B49/wUboPLjEJ5K3vq660U3DFuUEJ3YiKNAui3Z60ij6UTC1CcbHzbt
         +K98OE+R1tvhCn5TCj1dy6fVO3agK9yS8fNN5+n6ipvwae79tOcU5hMk+6+cGXhNj8Bv
         k1CHuhFvrcxmj/hemUQSMdUgbJaaJz04W9dDa3Fwfw3pLNBK8cIJbvP+GWVscM62xDSF
         +/oMJT71WWthgCJ6gCeSyN8x3+c87lpnE2V6sA+jVnq/wh4YCZJVDHl/1FFQva88V2+Y
         y3tQ==
X-Gm-Message-State: ACrzQf0CCNcNg3PJdXmXMQKqOlsfwmoQd4VdVJX3cE6OXrgdmmom6CFy
        E8tJkIwW1Bp6RpkNIZqyEbYKuA==
X-Google-Smtp-Source: AMsMyM7BkAmAaWS1UCuRgUIYv/Vlu7YAkTsTZmhRAfq+aD94BQBJj0+MLRcqAty7VaCZwkURoKwpXQ==
X-Received: by 2002:a05:600c:1e24:b0:3b4:6c1e:8bb7 with SMTP id ay36-20020a05600c1e2400b003b46c1e8bb7mr9716726wmb.1.1664870913039;
        Tue, 04 Oct 2022 01:08:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:24 +0000
Subject: [PATCH v2 08/11] mfd: qcom-pm8xxx: drop unused PM8018 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-8-87fbeb4ae053@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8921 compatible is used as fallback when PM8018 is available,
then remove PM8018 compatible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 2f2734ba5273..601106580e2e 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -497,7 +497,6 @@ static const struct pm_irq_data pm8821_data = {
 };
 
 static const struct of_device_id pm8xxx_id_table[] = {
-	{ .compatible = "qcom,pm8018", .data = &pm8xxx_data},
 	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
 	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
 	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},

-- 
b4 0.10.0
