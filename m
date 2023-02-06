Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDF68BA3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjBFKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjBFK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28922A1D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10414023wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0RAZYB/XfMSgNVeIjbEr49M4Q3OadQw/L8K9G9Uq8k=;
        b=GT6D6ny5WboR71/3xog5IzP047p9OCCTCPTfFn+ejJeHf2tCRNPBPYzonrHYk5rBtv
         X6NMCW4NiV3P1odKqsaK9xcowNaKJ48t0gY0P3lI3zicaet2p0N19+9QunOw9YIhZMWZ
         RypHBKP3upxv1CedslUBKNWA0Z98slLZ5+mOOjUnKvtULxF5y18n4Af1j4dV/Rgsuhzo
         EK3HX2LqrcatFTFy9GuDgywet6tmPr4WEIXUJMTmWM4q3lj4lyAE16SP0u1KEe74Ytzb
         w8WTm3JO7qOcnz9b89MUmJir7BW3FKZDfNd3dk0XTaLIdGXSg+IebaTAF/v6r/o39i7H
         eMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0RAZYB/XfMSgNVeIjbEr49M4Q3OadQw/L8K9G9Uq8k=;
        b=oy2hCdVKpcz/ZLrCQkr3wyUp2Xp4dlS6rbZpSU+jyG8I3gwVplA66++J0gLmk8xypN
         yWwACZm4KQnSCk0tSuw5cublFlezTox6eOwcBaKpuGZZ4pL4aUMosftoR8NG9HGAb4yD
         HiaBgcvbNx8eKr8E8OPH8aqz9KEk26Twn0otZl7LcYoAjNFGSEf3WZtl9lLI7Rscm+/1
         +HbK3p0bLlb5OYpXgI+y1l6gi/wp6dPwyKbI0ysXLd1p4Y74K7hnAtJT75c0WtnK5Ehy
         WbneW9hyUEQJ3e4kG4buZWHqNU7M1EDtw63fmbV0WbwSZ0UF56EHWZ8TEPjAoxUwrxm6
         cIVw==
X-Gm-Message-State: AO0yUKUHFFyXXubuMbRBdQonZQ+MiWQDs0m1NKHwau8lN/2YNh+T4b0i
        irmUP582S3Z+W7SeIRTwh6h2DbdfF5xoOE5P
X-Google-Smtp-Source: AK7set8bSN7hoGcVGavjUKN992ANddB/oxCl8oZ0stAwdEwwzcrpH9iKX/dazlUtDPj/otZYWCYMRw==
X-Received: by 2002:a05:600c:1c20:b0:3dc:576c:ab07 with SMTP id j32-20020a05600c1c2000b003dc576cab07mr17855422wms.14.1675679337424;
        Mon, 06 Feb 2023 02:28:57 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 35/37] nvmem: qcom-spmi-sdam: register at device init time
Date:   Mon,  6 Feb 2023 10:27:57 +0000
Message-Id: <20230206102759.669838-36-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

There are currently no in-tree users of the Qualcomm SDAM nvmem driver
and there is generally no point in registering a driver that can be
built as a module at subsys init time.

Register the driver at the normal device init time instead and let
driver core sort out the probe order.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 8499892044b7..f822790db49e 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -175,18 +175,7 @@ static struct platform_driver sdam_driver = {
 	},
 	.probe		= sdam_probe,
 };
-
-static int __init sdam_init(void)
-{
-	return platform_driver_register(&sdam_driver);
-}
-subsys_initcall(sdam_init);
-
-static void __exit sdam_exit(void)
-{
-	return platform_driver_unregister(&sdam_driver);
-}
-module_exit(sdam_exit);
+module_platform_driver(sdam_driver);
 
 MODULE_DESCRIPTION("QCOM SPMI SDAM driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

