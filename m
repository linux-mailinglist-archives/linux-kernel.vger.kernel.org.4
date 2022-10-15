Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93E5FF7AE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJOArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJOAq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:46:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974279A7B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:46:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cl1so6260571pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQKr6gxcoyxbVjA/4utImOsMAnHB8ip1bwqG26rMhL0=;
        b=EWIIqrjn5mCAhLJM9VhfqrSQSfuHVkDTsVSgY/QN7vgNwzOFewGxxedSAVqzUWWaF5
         5WTBxM5EpiZ2+QfWi0l+6KNhgjao1+6+zW3Qm7lvVIr7TN5TfyZqnD7Mgm0dGXdiejKG
         Tyluw59VaUDWZG2fI3MirIJt19Y743wDnGfMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQKr6gxcoyxbVjA/4utImOsMAnHB8ip1bwqG26rMhL0=;
        b=3fwfDZRWuFKdoazqIVJsabggiR6PGPBBa2RHiQAmkDUBlEqJp/CH5N8z2WqlUTKwbl
         1bFtdCKaN+EQm3gQKNig1QWfwkvT4C2p0O33lEsrCxzarYu6mlpQB/bxAsW/tZj9v0Uq
         57jlY3pJpaLdmkHx39ESpw79qBIjZhi01vPXI2yJrO99JuEVoCj89Cp60AeOlHwdHpWC
         x5jkBoYyKuEATSulmC7uKsjSgUQw9JCWpkJFcVecWiuolUgdI/d9gf7ZSq8S4+pKgAFX
         4p7JL57m+Cw6KUGqaqj/IOs6iCSg1xUSgrUOLXuW2/ReLGTQVjrBMt1Fp6HsGt6+BxrL
         5idA==
X-Gm-Message-State: ACrzQf2H/BxwQe/hxX23TVzBONxqAvha8VNATId1JLHCi4rvmkFxAouy
        25UQR/2wVtPttCvyQCPQ7en4bA==
X-Google-Smtp-Source: AMsMyM7r29oBpMR7H67b79mXzxvDdQ1x+Np6mKFbOgC+l7l79oMFiIig5TI4oJF8rpKPcfykzgpfLw==
X-Received: by 2002:a17:90b:390c:b0:20d:a662:dac2 with SMTP id ob12-20020a17090b390c00b0020da662dac2mr12830551pjb.5.1665794818059;
        Fri, 14 Oct 2022 17:46:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:9d:2:9f6e:fc87:d13f:1fa6])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902bd4400b0016d72804664sm2230802plx.205.2022.10.14.17.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 17:46:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 2/2] soc: qcom: stats: Mark device as having no PM support
Date:   Fri, 14 Oct 2022 17:46:54 -0700
Message-Id: <20221015004654.3930122-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221015004654.3930122-1-swboyd@chromium.org>
References: <20221015004654.3930122-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver purely exposes information from memory to the kernel. Let's
mark it as not having any device PM functionality, so that during
suspend we skip even trying to call a suspend function on this device.
This clears up suspend logs more than anything else, but it also shaves
a few cycles off suspend.

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/qcom_stats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index d6bfd1bbdc2a..d89453a77408 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -217,6 +217,8 @@ static int qcom_stats_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, root);
 
+	device_set_pm_not_required(&pdev->dev);
+
 	return 0;
 }
 
-- 
https://chromeos.dev

