Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7C62EDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbiKRGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKRGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:39:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316B9A5F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so6838554wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6CxYHRM9Zn+3KcDKgeunTZ9HLvRKum2ivGbFC1vvMM=;
        b=wVDfywP+wfkvyvPtAy0+5GJ2Cxi5HyktVpg0OkJUNO3u3TMRv0okjrAWDf7YU5foNB
         0cCWQlcmIf9nqQjN5YyLmuExQdlCNxSHWWLXMYjkBQSDSE8KYb62LdNlVG2ETYD7XpXH
         GrLSb5YQkrmtyaodNSeW6nMD2/8424vLWm50pjZAqsu74SQTsyxHYmFoLdbx4D7Itx4F
         3/98567ellps41N4ECLKsveASgtSyxzTWq3lhZUpGWBlaCHf54mTUGjAWYPe440P9pMP
         8oVL0y8Bb4yudnvwrBdrEssbUc2IlDU3gNm1LW5vNQb8KlNgXSSD3t//SiCnux+AfbrR
         sSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6CxYHRM9Zn+3KcDKgeunTZ9HLvRKum2ivGbFC1vvMM=;
        b=eIlBKmfcF/SL0fhLIYX3L1oSOlmMfMNwNvs8+2IAhnUj+QjWDUPHZjUahTLzt8ndxH
         MPiqzfxL2aCfn0ZrajAxhAf90d6J7d8Tudfv/3htKrBgOxImfah6OW6ULhII7uyXCPd3
         G/HQBy+dGiDkcEURV3LrF6QzAmNYtboVUxrHhrJdzEPS14xr+G+MrUqMfg5dazYErS4b
         K8FwHmKyNPmS/JsPi82ij5dfEWSdFjMO3S2TFXGQTOCH+ICDK+t1V2iIIVYZHmqiAFN5
         7IwizrmAaQkuOM5ZKihjE86ezebrVVulLbAwaQfcLYnvrn8RE0mSnRcibhDJUm9QleWY
         JXkw==
X-Gm-Message-State: ANoB5plXzS2gdaGA7HXJhqWN600zJ1wOm/K1/I3Hsd3tW83Sug+luffe
        3Fdgc2sVoUqJ9pi7vbnEd2BYfA==
X-Google-Smtp-Source: AA0mqf6w+7ANgTGzcxjBRkdTfyYeB+65uofOtoagSpK1Orhrxl0MjoyDE7Ser07YytKKkuM24MtYRA==
X-Received: by 2002:a7b:ce8c:0:b0:3cf:8b2d:8cbc with SMTP id q12-20020a7bce8c000000b003cf8b2d8cbcmr3954223wmj.89.1668753563239;
        Thu, 17 Nov 2022 22:39:23 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003b4fdbb6319sm7853861wmi.21.2022.11.17.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] nvmem: lan9662-otp: Change return type of lan9662_otp_wait_flag_clear()
Date:   Fri, 18 Nov 2022 06:38:40 +0000
Message-Id: <20221118063840.6357-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
References: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
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

From: Horatiu Vultur <horatiu.vultur@microchip.com>

The blamed commit introduced the following smatch warning in the
function lan9662_otp_wait_flag_clear:
drivers/nvmem/lan9662-otpc.c:43 lan9662_otp_wait_flag_clear() warn: signedness bug returning '(-110)'

Fix this by changing the return type of the function
lan9662_otp_wait_flag_clear() to be int instead of bool.

Fixes: 9e8f208ad5229d ("nvmem: lan9662-otp: add support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/lan9662-otpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index 377bf34c2946..56fc19f092a7 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -36,7 +36,7 @@ struct lan9662_otp {
 	void __iomem *base;
 };
 
-static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
+static int lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
 {
 	u32 val;
 
-- 
2.25.1

