Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1B5E7F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiIWP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiIWP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:58:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1A1147CFA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c7so515986ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VC1ShBinIqlUH1hwjZ0lvI11uSYreZCKq6nMNs4Lha8=;
        b=LUo2rWaB9RNZIuVN22URCpGUShqbj1RtLH4LDikewtvOqTAqfJXZ01/q3OA4cQFe2r
         rmUX/Io+HB42E1wsgx5NxXzKex2A/vixXIowzZLEWZjHCRloK5+O9EUhyfIX+/vNZb53
         lklZ7ezAUeV1hCBlHn6bRJlhOwCUNkLvsTB/O5c4RgPfhl9Y0upBqM2dhbvCDCtKrWzH
         GrDjXjpo6MnoBc6peM6sM28l5HVHBxTC4AwGz5i0xlIhVSIUOLfPgsr4IX3G6vgPqNG4
         U0BMxk37eVSn9j23UnDYMTdJjDhYnda4EXC0jnndchsujS//ZjuMAJ8d4SEL0PH5BalV
         LqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VC1ShBinIqlUH1hwjZ0lvI11uSYreZCKq6nMNs4Lha8=;
        b=i3bl08wzL19vkru3D84BDl6OnQPJkexJoiK7Cu1Ee3zgBl/W55HgisEin6tPlbHlub
         CG/t4LGBurtHiiibrUNT32+I9auuZBg/V8Cyc7hGKjkoYbi5T9BGk1CIX+TFSOauvZko
         nLknjq+19RTSktGhIRs8BxkajlodBsygN3408zQmMd01LsikPa0+tBqphzSKWYdBaD/D
         V7XQxhXi0K46/CVY/7J+H9QGP6ImqgybheSa5rNfdV2xbONcI+47AxX++fHNbGMgvptX
         O2CCVFtW0v/uCoC4z2DuP13lwA4g8IwKAcvDTV8wFzEvQWBl8UcyuC2XYqa89mBdf4UT
         7Qig==
X-Gm-Message-State: ACrzQf0c5k7axSog8UNwJYBzHIoWN4F46JbaOdKdl1wYNvscZYusahyS
        z+wMePMWJgRWfwugxuNlk164Fg==
X-Google-Smtp-Source: AMsMyM7NzE8WlaF6baserwi0wmCOiMlgLtJ9FQsC9L9lPmRslOyURxlpjODRw+Jo6rE4joL576SKYA==
X-Received: by 2002:a2e:a9a9:0:b0:26c:6ec5:290 with SMTP id x41-20020a2ea9a9000000b0026c6ec50290mr2944124ljq.186.1663948669439;
        Fri, 23 Sep 2022 08:57:49 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b0049a4862966fsm1502286lfb.146.2022.09.23.08.57.48
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
Subject: [PATCH 3/5] slimbus: qcom-ctrl: use devm_platform_ioremap_resource_byname()
Date:   Fri, 23 Sep 2022 17:57:38 +0200
Message-Id: <20220923155740.422411-3-krzysztof.kozlowski@linaro.org>
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

Simplify the code with devm_platform_ioremap_resource_byname().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index bb106eab8ae2..400b7b385a44 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -488,7 +488,6 @@ static int qcom_slim_probe(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl;
 	struct slim_controller *sctrl;
-	struct resource *slim_mem;
 	int ret, ver;
 
 	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
@@ -519,8 +518,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctrl);
 	dev_set_drvdata(ctrl->dev, ctrl);
 
-	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
+	ctrl->base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-- 
2.34.1

