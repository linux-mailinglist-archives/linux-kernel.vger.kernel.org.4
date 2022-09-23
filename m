Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E05E7F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIWP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiIWP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:58:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E1914768D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c7so516043ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9pEICJNZ5nO4P1+qOCCLWpWUXxTuEVpFceB0baO81JE=;
        b=NxT9e5oCLYKT3a6UU77vYEEwrXRUDdJCwgbS+hOxcuLdlHIMlTMMxhSgdQnrZzyEly
         JHxvA7uR2vuZXCbjYsfLJ+AyHAJiFgQ1vFYG01HGsmhe/BN4RcBkH2iPXCgoN492oL+m
         ++JDv5Oy+UDcW3Ne7acj8VTsu7SavjAnbCTaZ1e/VREnOGufN1N9whgAGD87ZcOupuvF
         LVDjVzNcmPZ8TfenVaL/R3n7vmimEBiW7S070ZDPd8MdF9hddErFB14sjuNi2DsPa8os
         uIhn3RSCCCxjbwVQlx5094CsuZ8I77E5lmPFDmFyIdwsrXquoMGN4iLqfbZFhZppZpjc
         O00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9pEICJNZ5nO4P1+qOCCLWpWUXxTuEVpFceB0baO81JE=;
        b=Uozpve1onOSEGktthmb2COkR7oZ1fEbsCO79p27WEHkDiFvdKi51iwv3ga46jtKZcf
         NgShM3Vxc3PTFLkS1JGcvGbvSpAPH2a2Ana8LoTqV9+WtPUj9vOo67Ct92kgNNL3azrg
         s0CrTK8hxfd6+SiL2b3GsbysYAku6SISvM2Y4bLPXEDBLVHMIp15/bRvmTigeJt+hqV/
         OAxYJhI6AR4/Ik3Xw1yKzU51YS+HqM8R87+AVAwTlQVqvP/YHgWAAMykYXkd5cIIehPB
         uF+24xdtCXZZO/JCwAyOdvEQKoAYnCtfQe5LDNVqrBvkhl21/OuZLCoJraNcpPXlUdr+
         pAFQ==
X-Gm-Message-State: ACrzQf0It8/cX/xR76en013AwctdSD0tlNj3zy7NOexFBeU+ctaQCT4s
        B5yYgRyTdo3zjAkeQFNr/p/1Jw==
X-Google-Smtp-Source: AMsMyM5oOoFxS2EKXFonjqhk3x8OIxrbxXsljwIAKoZi/K/SCJqMWRX+2YH61wuqXvRvi2m8t9zeOg==
X-Received: by 2002:a2e:b889:0:b0:26c:22e0:71aa with SMTP id r9-20020a2eb889000000b0026c22e071aamr3188671ljp.501.1663948670392;
        Fri, 23 Sep 2022 08:57:50 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b0049a4862966fsm1502286lfb.146.2022.09.23.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:57:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] slimbus: qcom-ngd-ctrl: use devm_platform_get_and_ioremap_resource()
Date:   Fri, 23 Sep 2022 17:57:39 +0200
Message-Id: <20220923155740.422411-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
References: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
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

Simplify the code with devm_platform_get_and_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index cec11aa106bf..548dd7661334 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1522,7 +1522,6 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qcom_slim_ngd_ctrl *ctrl;
-	struct resource *res;
 	int ret;
 	struct pdr_service *pds;
 
@@ -1532,8 +1531,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, ctrl);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctrl->base = devm_ioremap_resource(dev, res);
+	ctrl->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-- 
2.34.1

